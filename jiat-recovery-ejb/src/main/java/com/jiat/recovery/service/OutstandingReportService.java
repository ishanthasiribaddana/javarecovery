package com.jiat.recovery.service;

import com.jiat.recovery.dto.OutstandingReportRow;
import com.jiat.recovery.dto.OutstandingReportResponse;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service for generating outstanding report from scholarship_payment_scheduler.
 */
@Stateless
public class OutstandingReportService {

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Get paginated outstanding report with search.
     * Uses student table with course_fee_total_due_amount field:
     * - Links to general_user_profile for student details (NIC, name)
     * - Links to course for course fee
     * - Uses course_fee_total_due_amount as balance due
     */
    public OutstandingReportResponse getOutstandingReport(int page, int size, String search) {
        // Build the query using student table with course_fee_total_due_amount
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.s_id, gup.nic, ");
        sql.append("CONCAT(COALESCE(gup.first_name, ''), ' ', COALESCE(gup.last_name, '')) as student_name, ");
        sql.append("0 as scholarship_percentage, ");
        sql.append("COALESCE(c.standard_fee, 0) as course_fee, ");
        sql.append("COALESCE(c.standard_fee, 0) as payable_amount, ");
        sql.append("COALESCE(c.standard_fee, 0) - COALESCE(s.course_fee_total_due_amount, 0) as paid_amount, ");
        sql.append("COALESCE(s.course_fee_total_due_amount, 0) as balance_due ");
        sql.append("FROM student s ");
        sql.append("JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id ");
        sql.append("LEFT JOIN course c ON s.coursecid = c.cid ");
        sql.append("WHERE s.is_active = 1 ");
        sql.append("AND s.course_fee_total_due_amount > 0 ");
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (gup.nic LIKE :search OR gup.first_name LIKE :search OR gup.last_name LIKE :search) ");
        }
        
        sql.append("ORDER BY balance_due DESC ");

        // Count query - count students with outstanding balance
        StringBuilder countSql = new StringBuilder();
        countSql.append("SELECT COUNT(*) FROM student s ");
        countSql.append("JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id ");
        countSql.append("WHERE s.is_active = 1 ");
        countSql.append("AND s.course_fee_total_due_amount > 0 ");
        
        if (search != null && !search.trim().isEmpty()) {
            countSql.append("AND (gup.nic LIKE :search OR gup.first_name LIKE :search OR gup.last_name LIKE :search) ");
        }

        Query countQuery = em.createNativeQuery(countSql.toString());
        if (search != null && !search.trim().isEmpty()) {
            countQuery.setParameter("search", "%" + search.trim() + "%");
        }
        long totalElements = ((Number) countQuery.getSingleResult()).longValue();

        // Data query with pagination
        Query dataQuery = em.createNativeQuery(sql.toString());
        if (search != null && !search.trim().isEmpty()) {
            dataQuery.setParameter("search", "%" + search.trim() + "%");
        }
        dataQuery.setFirstResult(page * size);
        dataQuery.setMaxResults(size);

        @SuppressWarnings("unchecked")
        List<Object[]> results = dataQuery.getResultList();

        List<OutstandingReportRow> rows = new ArrayList<>();
        for (Object[] row : results) {
            OutstandingReportRow reportRow = new OutstandingReportRow();
            reportRow.setId(((Number) row[0]).longValue());
            reportRow.setNic((String) row[1]);
            reportRow.setStudentName((String) row[2]);
            reportRow.setScholarshipPercentage(row[3] != null ? ((Number) row[3]).doubleValue() : 0.0);
            reportRow.setCourseFee(row[4] != null ? ((Number) row[4]).doubleValue() : 0.0);
            reportRow.setPayableAmount(row[5] != null ? ((Number) row[5]).doubleValue() : 0.0);
            reportRow.setPaidAmount(row[6] != null ? ((Number) row[6]).doubleValue() : 0.0);
            reportRow.setBalanceDue(row[7] != null ? ((Number) row[7]).doubleValue() : 0.0);
            rows.add(reportRow);
        }

        // Get summary
        Map<String, Double> summary = getSummary();

        return new OutstandingReportResponse(rows, page, size, totalElements, summary);
    }

    /**
     * Get summary totals from student table.
     */
    public Map<String, Double> getSummary() {
        String sql = "SELECT " +
                "SUM(COALESCE(s.course_fee_total_due_amount, 0)) as total_outstanding, " +
                "SUM(COALESCE(c.standard_fee, 0) - COALESCE(s.course_fee_total_due_amount, 0)) as total_paid, " +
                "SUM(COALESCE(c.standard_fee, 0)) as total_payable " +
                "FROM student s " +
                "LEFT JOIN course c ON s.coursecid = c.cid " +
                "WHERE s.is_active = 1 AND s.course_fee_total_due_amount > 0";

        Object[] result = (Object[]) em.createNativeQuery(sql).getSingleResult();

        Map<String, Double> summary = new HashMap<>();
        summary.put("totalOutstanding", result[0] != null ? ((Number) result[0]).doubleValue() : 0.0);
        summary.put("totalPaid", result[1] != null ? ((Number) result[1]).doubleValue() : 0.0);
        summary.put("totalPayable", result[2] != null ? ((Number) result[2]).doubleValue() : 0.0);

        return summary;
    }

    /**
     * Get total outstanding amount (for dashboard) from student table.
     */
    public double getTotalOutstanding() {
        String sql = "SELECT SUM(COALESCE(course_fee_total_due_amount, 0)) " +
                "FROM student WHERE is_active = 1";
        Object result = em.createNativeQuery(sql).getSingleResult();
        return result != null ? ((Number) result).doubleValue() : 0.0;
    }
}
