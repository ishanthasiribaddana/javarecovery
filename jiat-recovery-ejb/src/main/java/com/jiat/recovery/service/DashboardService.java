package com.jiat.recovery.service;

import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.entity.RecoveryGrievance;
import com.jiat.recovery.entity.RecoveryBankStatementImport;
import com.jiat.recovery.entity.enums.CaseStatus;
import com.jiat.recovery.entity.enums.GrievanceStatus;
import com.jiat.recovery.dto.DashboardStats;
import com.jiat.recovery.dto.MonthlyTrendData;
import com.jiat.recovery.dto.CourseOutstandingData;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.util.*;

/**
 * EJB Service for dashboard statistics and KPIs.
 */
@Stateless
public class DashboardService {

    private static final Logger logger = LoggerFactory.getLogger(DashboardService.class);

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Get comprehensive dashboard statistics.
     */
    public DashboardStats getDashboardStats() {
        DashboardStats stats = new DashboardStats();

        // Case counts by status
        stats.setOpenCases(countCasesByStatus(CaseStatus.OPEN));
        stats.setInProgressCases(countCasesByStatus(CaseStatus.IN_PROGRESS));
        stats.setDisputedCases(countCasesByStatus(CaseStatus.DISPUTED));
        stats.setResolvedCases(countCasesByStatus(CaseStatus.RESOLVED));
        stats.setClosedCases(countCasesByStatus(CaseStatus.CLOSED));

        // Total outstanding
        stats.setTotalOutstanding(getTotalOutstanding());

        // This month's collection
        stats.setThisMonthCollected(getMonthlyCollection(YearMonth.now()));
        stats.setLastMonthCollected(getMonthlyCollection(YearMonth.now().minusMonths(1)));

        // Recovery rate
        double totalRecoverable = stats.getTotalOutstanding() + stats.getThisMonthCollected();
        if (totalRecoverable > 0) {
            stats.setRecoveryRate((stats.getThisMonthCollected() / totalRecoverable) * 100);
        }

        // Average resolution time
        stats.setAvgResolutionDays(getAverageResolutionDays());

        // Pending grievances
        stats.setPendingGrievances(countPendingGrievances());

        // Unmatched deposits
        stats.setUnmatchedDeposits(countUnmatchedDeposits());

        return stats;
    }

    /**
     * Count cases by status.
     */
    private long countCasesByStatus(CaseStatus status) {
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(c) FROM RecoveryCase c WHERE c.status = :status",
                Long.class);
            query.setParameter("status", status);
            return query.getSingleResult();
        } catch (Exception e) {
            logger.error("Error counting cases by status: {}", status, e);
            return 0;
        }
    }

    /**
     * Get total outstanding amount from student table.
     */
    private double getTotalOutstanding() {
        try {
            String sql = "SELECT SUM(COALESCE(course_fee_total_due_amount, 0)) " +
                    "FROM student WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).doubleValue() : 0.0;
        } catch (Exception e) {
            logger.error("Error getting total outstanding", e);
            return 0.0;
        }
    }

    /**
     * Get monthly collection amount.
     */
    private double getMonthlyCollection(YearMonth month) {
        try {
            LocalDateTime startOfMonth = month.atDay(1).atStartOfDay();
            LocalDateTime endOfMonth = month.atEndOfMonth().atTime(23, 59, 59);

            TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(b.amount), 0) FROM RecoveryBankStatementImport b " +
                "JOIN RecoveryDepositMatch m ON m.bankStatementImportId = b.id " +
                "WHERE m.verified = true AND b.transactionDate BETWEEN :start AND :end",
                Double.class);
            query.setParameter("start", startOfMonth);
            query.setParameter("end", endOfMonth);
            Double result = query.getSingleResult();
            return result != null ? result : 0.0;
        } catch (Exception e) {
            logger.error("Error getting monthly collection for: {}", month, e);
            return 0.0;
        }
    }

    /**
     * Get average case resolution time in days.
     */
    private double getAverageResolutionDays() {
        try {
            // Calculate average days between creation and resolution for resolved cases
            TypedQuery<Double> query = em.createQuery(
                "SELECT AVG(FUNCTION('DATEDIFF', c.updatedAt, c.createdAt)) FROM RecoveryCase c " +
                "WHERE c.status = :status",
                Double.class);
            query.setParameter("status", CaseStatus.RESOLVED);
            Double result = query.getSingleResult();
            return result != null ? result : 0.0;
        } catch (Exception e) {
            logger.error("Error getting average resolution days", e);
            return 0.0;
        }
    }

    /**
     * Count pending grievances.
     */
    private long countPendingGrievances() {
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(g) FROM RecoveryGrievance g WHERE g.status IN (:statuses)",
                Long.class);
            query.setParameter("statuses", List.of(GrievanceStatus.SUBMITTED, GrievanceStatus.UNDER_REVIEW));
            return query.getSingleResult();
        } catch (Exception e) {
            logger.error("Error counting pending grievances", e);
            return 0;
        }
    }

    /**
     * Count unmatched bank deposits.
     */
    private long countUnmatchedDeposits() {
        try {
            TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(b) FROM RecoveryBankStatementImport b " +
                "WHERE b.isActive = true AND b.isMatched = false",
                Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            logger.error("Error counting unmatched deposits", e);
            return 0;
        }
    }

    /**
     * Get monthly trend data for the last 6 months.
     */
    public List<MonthlyTrendData> getMonthlyTrend() {
        List<MonthlyTrendData> trend = new ArrayList<>();
        YearMonth current = YearMonth.now();

        for (int i = 5; i >= 0; i--) {
            YearMonth month = current.minusMonths(i);
            MonthlyTrendData data = new MonthlyTrendData();
            data.setMonth(month.getMonth().toString().substring(0, 3));
            data.setCollected(getMonthlyCollection(month));
            data.setTarget(getMonthlyTarget(month));
            trend.add(data);
        }

        return trend;
    }

    /**
     * Get monthly target (can be configured or calculated).
     */
    private double getMonthlyTarget(YearMonth month) {
        // Default target - can be made configurable
        return 3500000.0;
    }

    /**
     * Get outstanding amounts by course.
     */
    public List<CourseOutstandingData> getOutstandingByCourse() {
        try {
            TypedQuery<Object[]> query = em.createQuery(
                "SELECT s.course.courseTitle, SUM(c.currentCalculatedDue) " +
                "FROM RecoveryCase c " +
                "JOIN Student s ON s.sId = c.studentSId " +
                "WHERE c.status IN (:statuses) " +
                "GROUP BY s.course.courseTitle " +
                "ORDER BY SUM(c.currentCalculatedDue) DESC",
                Object[].class);
            query.setParameter("statuses", List.of(CaseStatus.OPEN, CaseStatus.IN_PROGRESS, CaseStatus.DISPUTED));
            query.setMaxResults(5);

            List<Object[]> results = query.getResultList();
            List<CourseOutstandingData> data = new ArrayList<>();

            for (Object[] row : results) {
                CourseOutstandingData item = new CourseOutstandingData();
                item.setCourseName((String) row[0]);
                item.setAmount(((Number) row[1]).doubleValue());
                data.add(item);
            }

            return data;
        } catch (Exception e) {
            logger.error("Error getting outstanding by course", e);
            return List.of();
        }
    }

    /**
     * Get cases assigned to a specific officer.
     */
    public List<RecoveryCase> getAssignedCases(Long officerId) {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery(
                "RecoveryCase.findByOfficer", RecoveryCase.class);
            query.setParameter("officerId", officerId);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error getting assigned cases for officer: {}", officerId, e);
            return List.of();
        }
    }

    /**
     * Get recent activity log.
     */
    public List<Map<String, Object>> getRecentActivity(int limit) {
        try {
            TypedQuery<Object[]> query = em.createQuery(
                "SELECT a.action, a.entityType, a.entityId, a.description, a.createdAt " +
                "FROM RecoveryAuditLog a " +
                "ORDER BY a.createdAt DESC",
                Object[].class);
            query.setMaxResults(limit);

            List<Object[]> results = query.getResultList();
            List<Map<String, Object>> activities = new ArrayList<>();

            for (Object[] row : results) {
                Map<String, Object> activity = new HashMap<>();
                activity.put("action", row[0]);
                activity.put("entityType", row[1]);
                activity.put("entityId", row[2]);
                activity.put("description", row[3]);
                activity.put("timestamp", row[4]);
                activities.add(activity);
            }

            return activities;
        } catch (Exception e) {
            logger.error("Error getting recent activity", e);
            return List.of();
        }
    }
}
