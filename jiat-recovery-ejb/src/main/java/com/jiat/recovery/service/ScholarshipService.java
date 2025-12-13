package com.jiat.recovery.service;

import jakarta.ejb.Stateless;
import jakarta.ejb.Schedule;
import jakarta.ejb.Timer;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * EJB Service for scholarship management and auto-downgrade functionality.
 * Handles 90-day payment deadline tracking and automatic scholarship reduction.
 */
@Stateless
public class ScholarshipService {

    private static final Logger logger = LoggerFactory.getLogger(ScholarshipService.class);

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Scheduled job that runs daily at midnight to check and downgrade scholarships.
     * Students who haven't made any payment within 90 days of release_date
     * will have their scholarship_value reduced to semester_payment_value.
     */
    @Schedule(hour = "0", minute = "0", second = "0", persistent = false)
    public void processScholarshipDowngrades(Timer timer) {
        logger.info("Starting daily scholarship downgrade check...");
        
        try {
            List<Map<String, Object>> studentsToDowngrade = findStudentsForDowngrade();
            int downgradeCount = 0;
            
            for (Map<String, Object> student : studentsToDowngrade) {
                try {
                    Integer spsId = (Integer) student.get("id");
                    Double oldPercentage = (Double) student.get("scholarship_value");
                    Double newPercentage = (Double) student.get("semester_payment_value");
                    
                    // Update scholarship_value to semester_payment_value
                    updateScholarshipValue(spsId, newPercentage);
                    
                    // Record in history
                    insertScholarshipHistory(spsId, oldPercentage, newPercentage, 
                        "90-day payment delay - auto downgrade", null);
                    
                    downgradeCount++;
                    logger.info("Downgraded scholarship for SPS ID: {} from {}% to {}%", 
                        spsId, oldPercentage, newPercentage);
                } catch (Exception e) {
                    logger.error("Error downgrading scholarship for student: {}", student, e);
                }
            }
            
            logger.info("Scholarship downgrade check completed. {} students downgraded.", downgradeCount);
        } catch (Exception e) {
            logger.error("Error in scholarship downgrade scheduled job", e);
        }
    }

    /**
     * Find students who need scholarship downgrade:
     * - release_date + 90 days < today
     * - No voucher_item records at all (excludes students with any payment history)
     * - scholarship_value != semester_payment_value (not already downgraded)
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> findStudentsForDowngrade() {
        String sql = """
            SELECT sps.id, sps.general_user_profile_gup_id, sps.scholarship_value, 
                   sps.semester_payment_value, sps.release_date,
                   gup.nic, CONCAT(gup.first_name, ' ', gup.last_name) as name
            FROM scholarship_payment_scheduler sps
            JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
            WHERE sps.release_date IS NOT NULL
              AND DATE_ADD(sps.release_date, INTERVAL 90 DAY) < CURDATE()
              AND sps.scholarship_value != sps.semester_payment_value
              AND NOT EXISTS (
                  SELECT 1 FROM voucher v
                  JOIN voucher_item vi ON vi.vouchervid = v.vid
                  WHERE v.general_user_profilegup_id = sps.general_user_profile_gup_id
              )
            """;
        
        Query query = em.createNativeQuery(sql);
        List<Object[]> results = query.getResultList();
        List<Map<String, Object>> students = new ArrayList<>();
        
        for (Object[] row : results) {
            Map<String, Object> student = new HashMap<>();
            student.put("id", row[0]);
            student.put("general_user_profile_gup_id", row[1]);
            student.put("scholarship_value", row[2]);
            student.put("semester_payment_value", row[3]);
            student.put("release_date", row[4]);
            student.put("nic", row[5]);
            student.put("name", row[6]);
            students.add(student);
        }
        
        return students;
    }

    /**
     * Get scholarship warning status for a student.
     * Returns countdown info for UI display.
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> getScholarshipWarningStatus(Integer gupId) {
        String sql = """
            SELECT sps.id, sps.scholarship_value, sps.semester_payment_value, 
                   sps.release_date, 
                   DATEDIFF(DATE_ADD(sps.release_date, INTERVAL 90 DAY), CURDATE()) as days_remaining,
                   (SELECT COUNT(*) FROM voucher v
                    JOIN voucher_item vi ON vi.vouchervid = v.vid
                    WHERE v.general_user_profilegup_id = sps.general_user_profile_gup_id
                   ) as total_voucher_items
            FROM scholarship_payment_scheduler sps
            WHERE sps.general_user_profile_gup_id = :gupId
              AND sps.release_date IS NOT NULL
            ORDER BY sps.release_date DESC
            LIMIT 1
            """;
        
        Query query = em.createNativeQuery(sql);
        query.setParameter("gupId", gupId);
        
        List<Object[]> results = query.getResultList();
        Map<String, Object> status = new HashMap<>();
        
        if (results.isEmpty()) {
            status.put("hasScholarship", false);
            return status;
        }
        
        Object[] row = results.get(0);
        Integer daysRemaining = row[4] != null ? ((Number) row[4]).intValue() : null;
        Integer totalVoucherItems = row[5] != null ? ((Number) row[5]).intValue() : 0;
        
        status.put("hasScholarship", true);
        status.put("spsId", row[0]);
        status.put("currentPercentage", row[1]);
        status.put("semesterPercentage", row[2]);
        status.put("releaseDate", row[3]);
        status.put("daysRemaining", daysRemaining);
        status.put("hasVoucherItems", totalVoucherItems > 0);
        
        // Determine warning level - exclude students with any voucher_item records
        if (totalVoucherItems > 0) {
            status.put("warningLevel", "SAFE");
            status.put("message", "Payment received - scholarship secured");
        } else if (daysRemaining != null && daysRemaining <= 0) {
            status.put("warningLevel", "EXPIRED");
            status.put("message", "Scholarship expired - pending downgrade to " + row[2] + "%");
        } else if (daysRemaining != null && daysRemaining <= 14) {
            status.put("warningLevel", "CRITICAL");
            status.put("message", daysRemaining + " days remaining to secure scholarship");
        } else if (daysRemaining != null && daysRemaining <= 90) {
            status.put("warningLevel", "WARNING");
            status.put("message", daysRemaining + " days remaining");
        } else {
            status.put("warningLevel", "OK");
            status.put("message", "Scholarship active");
        }
        
        return status;
    }

    /**
     * Get all students with scholarship warnings (for alert board).
     * Includes both warning (0-14 days remaining) and expired (negative days) students.
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getStudentsWithWarnings() {
        String sql = """
            SELECT sps.id, sps.general_user_profile_gup_id, 
                   gup.nic, CONCAT(gup.first_name, ' ', gup.last_name) as name,
                   sps.scholarship_value, sps.semester_payment_value, 
                   sps.release_date,
                   DATEDIFF(DATE_ADD(sps.release_date, INTERVAL 90 DAY), CURDATE()) as days_remaining
            FROM scholarship_payment_scheduler sps
            JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
            WHERE sps.release_date IS NOT NULL
              AND sps.scholarship_value != sps.semester_payment_value
              AND DATEDIFF(DATE_ADD(sps.release_date, INTERVAL 90 DAY), CURDATE()) <= 14
              AND NOT EXISTS (
                  SELECT 1 FROM voucher v
                  JOIN voucher_item vi ON vi.vouchervid = v.vid
                  WHERE v.general_user_profilegup_id = sps.general_user_profile_gup_id
              )
            ORDER BY days_remaining ASC
            """;
        
        Query query = em.createNativeQuery(sql);
        List<Object[]> results = query.getResultList();
        List<Map<String, Object>> warnings = new ArrayList<>();
        
        for (Object[] row : results) {
            Map<String, Object> warning = new HashMap<>();
            warning.put("spsId", row[0]);
            warning.put("gupId", row[1]);
            warning.put("nic", row[2]);
            warning.put("name", row[3]);
            warning.put("currentPercentage", row[4]);
            warning.put("semesterPercentage", row[5]);
            warning.put("releaseDate", row[6]);
            warning.put("daysRemaining", row[7] != null ? ((Number) row[7]).intValue() : 0);
            warnings.add(warning);
        }
        
        return warnings;
    }

    /**
     * Get scholarship history for a student.
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getScholarshipHistory(Integer spsId) {
        String sql = """
            SELECT id, old_percentage, new_percentage, change_date, change_reason, changed_by
            FROM scholarship_history
            WHERE scholarship_payment_scheduler_id = :spsId
            ORDER BY change_date DESC
            """;
        
        Query query = em.createNativeQuery(sql);
        query.setParameter("spsId", spsId);
        
        List<Object[]> results = query.getResultList();
        List<Map<String, Object>> history = new ArrayList<>();
        
        for (Object[] row : results) {
            Map<String, Object> record = new HashMap<>();
            record.put("id", row[0]);
            record.put("oldPercentage", row[1]);
            record.put("newPercentage", row[2]);
            record.put("changeDate", row[3]);
            record.put("changeReason", row[4]);
            record.put("changedBy", row[5]);
            history.add(record);
        }
        
        return history;
    }

    /**
     * Update scholarship_value in scholarship_payment_scheduler.
     */
    private void updateScholarshipValue(Integer spsId, Double newValue) {
        String sql = "UPDATE scholarship_payment_scheduler SET scholarship_value = :newValue WHERE id = :spsId";
        Query query = em.createNativeQuery(sql);
        query.setParameter("newValue", newValue);
        query.setParameter("spsId", spsId);
        query.executeUpdate();
    }

    /**
     * Insert record into scholarship_history.
     */
    private void insertScholarshipHistory(Integer spsId, Double oldPercentage, Double newPercentage,
                                          String reason, Integer changedBy) {
        String sql = """
            INSERT INTO scholarship_history 
            (scholarship_payment_scheduler_id, old_percentage, new_percentage, change_date, change_reason, changed_by)
            VALUES (:spsId, :oldPct, :newPct, :changeDate, :reason, :changedBy)
            """;
        Query query = em.createNativeQuery(sql);
        query.setParameter("spsId", spsId);
        query.setParameter("oldPct", oldPercentage);
        query.setParameter("newPct", newPercentage);
        query.setParameter("changeDate", LocalDateTime.now());
        query.setParameter("reason", reason);
        query.setParameter("changedBy", changedBy);
        query.executeUpdate();
    }

    /**
     * Manually trigger scholarship downgrade check (for testing/admin use).
     */
    public int runManualDowngradeCheck() {
        List<Map<String, Object>> studentsToDowngrade = findStudentsForDowngrade();
        int downgradeCount = 0;
        
        for (Map<String, Object> student : studentsToDowngrade) {
            try {
                Integer spsId = (Integer) student.get("id");
                Double oldPercentage = (Double) student.get("scholarship_value");
                Double newPercentage = (Double) student.get("semester_payment_value");
                
                updateScholarshipValue(spsId, newPercentage);
                insertScholarshipHistory(spsId, oldPercentage, newPercentage, 
                    "30-day payment delay - auto downgrade", null);
                
                downgradeCount++;
            } catch (Exception e) {
                logger.error("Error downgrading scholarship for student: {}", student, e);
            }
        }
        
        return downgradeCount;
    }
}
