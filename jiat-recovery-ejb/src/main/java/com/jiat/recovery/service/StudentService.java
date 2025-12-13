package com.jiat.recovery.service;

import com.jiat.recovery.entity.readonly.Student;
import com.jiat.recovery.entity.readonly.UniversalPaymentManager;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import com.jiat.recovery.dto.InstallmentDTO;
import com.jiat.recovery.dto.OverdueStudentDTO;
import com.jiat.recovery.dto.PaymentHistoryDTO;
import com.jiat.recovery.dto.PaymentManagerDTO;
import com.jiat.recovery.dto.PaymentReconciliationDTO;
import com.jiat.recovery.dto.PaymentScheduleDTO;
import com.jiat.recovery.dto.PendingInstallmentDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * EJB Service for student-related operations.
 * Read-only access to student data from ijts_system.
 */
@Stateless
public class StudentService {

    private static final Logger logger = LoggerFactory.getLogger(StudentService.class);

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Find student by internal ID (s_id).
     */
    public Optional<Student> findById(Integer sId) {
        try {
            Student student = em.find(Student.class, sId);
            return Optional.ofNullable(student);
        } catch (Exception e) {
            logger.error("Error finding student by ID: {}", sId, e);
            return Optional.empty();
        }
    }

    /**
     * Find student by student ID (e.g., "200300102947").
     */
    public Optional<Student> findByStudentId(String studentId) {
        try {
            TypedQuery<Student> query = em.createNamedQuery("Student.findByStudentId", Student.class);
            query.setParameter("studentId", studentId);
            List<Student> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding student by studentId: {}", studentId, e);
            return Optional.empty();
        }
    }

    /**
     * Find student by SCN number.
     */
    public Optional<Student> findByScnNo(String scnNo) {
        try {
            TypedQuery<Student> query = em.createNamedQuery("Student.findByScnNo", Student.class);
            query.setParameter("scnNo", scnNo);
            List<Student> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding student by SCN: {}", scnNo, e);
            return Optional.empty();
        }
    }

    /**
     * Search students by name (partial match).
     */
    public List<Student> searchByName(String name, int maxResults) {
        try {
            TypedQuery<Student> query = em.createNamedQuery("Student.searchByName", Student.class);
            query.setParameter("name", "%" + name + "%");
            query.setMaxResults(maxResults);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error searching students by name: {}", name, e);
            return List.of();
        }
    }

    /**
     * Find students by course.
     */
    public List<Student> findByCourse(Integer courseCid) {
        try {
            TypedQuery<Student> query = em.createNamedQuery("Student.findByCourse", Student.class);
            query.setParameter("courseCid", courseCid);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error finding students by course: {}", courseCid, e);
            return List.of();
        }
    }

    /**
     * Find students by intake.
     */
    public List<Student> findByIntake(Integer intakeId) {
        try {
            TypedQuery<Student> query = em.createNamedQuery("Student.findByIntake", Student.class);
            query.setParameter("intakeId", intakeId);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error finding students by intake: {}", intakeId, e);
            return List.of();
        }
    }

    /**
     * Get payment manager for a student.
     */
    public Optional<UniversalPaymentManager> getPaymentManager(Integer gupId) {
        try {
            TypedQuery<UniversalPaymentManager> query = em.createNamedQuery(
                "UniversalPaymentManager.findByGupId", UniversalPaymentManager.class);
            query.setParameter("gupId", gupId);
            List<UniversalPaymentManager> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding payment manager for GUP ID: {}", gupId, e);
            return Optional.empty();
        }
    }

    /**
     * Get payment manager for a student by student ID.
     */
    public Optional<UniversalPaymentManager> getPaymentManagerByStudentId(Integer sId) {
        Optional<Student> student = findById(sId);
        if (student.isPresent() && student.get().getGeneralUserProfileGupId() != null) {
            return getPaymentManager(student.get().getGeneralUserProfileGupId());
        }
        return Optional.empty();
    }

    /**
     * Count total students.
     */
    public long countStudents() {
        try {
            String sql = "SELECT COUNT(*) FROM student WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting students", e);
            return 0;
        }
    }

    /**
     * Search student by NIC (from general_user_profile).
     */
    public List<Student> searchByNic(String nic, int maxResults) {
        try {
            String sql = "SELECT s.* FROM student s " +
                    "JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "WHERE gup.nic LIKE :nic AND s.is_active = 1";
            @SuppressWarnings("unchecked")
            List<Student> results = em.createNativeQuery(sql, Student.class)
                    .setParameter("nic", "%" + nic + "%")
                    .setMaxResults(maxResults)
                    .getResultList();
            return results;
        } catch (Exception e) {
            logger.error("Error searching students by NIC: {}", nic, e);
            return List.of();
        }
    }

    /**
     * Count records in student_payment_scheduler_dates table.
     */
    public long countPaymentSchedulerDates() {
        try {
            String sql = "SELECT COUNT(*) FROM student_payment_scheduler_dates WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting payment scheduler dates", e);
            return 0;
        }
    }

    /**
     * Count records in student_payment_scheduler table.
     */
    public long countPaymentScheduler() {
        try {
            String sql = "SELECT COUNT(*) FROM student_payment_scheduler WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting payment scheduler", e);
            return 0;
        }
    }

    /**
     * Count students with non-null course_fee_total_due_amount.
     */
    public long countStudentsWithDue() {
        try {
            String sql = "SELECT COUNT(*) FROM student WHERE is_active = 1 AND course_fee_total_due_amount IS NOT NULL AND course_fee_total_due_amount > 0";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting students with due", e);
            return 0;
        }
    }

    /**
     * Count records in universal_payment_manager table.
     */
    public long countUniversalPaymentManager() {
        try {
            String sql = "SELECT COUNT(*) FROM universal_payment_manager WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting universal payment manager", e);
            return 0;
        }
    }

    /**
     * Count records in universal_payment_manager with total_due > 0.
     */
    public long countUniversalPaymentManagerWithDue() {
        try {
            String sql = "SELECT COUNT(*) FROM universal_payment_manager WHERE is_active = 1 AND total_due > 0";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting universal payment manager with due", e);
            return 0;
        }
    }

    /**
     * Search students by student ID, name, or NIC with pagination.
     * Returns student details including NIC from general_user_profile.
     */
    @SuppressWarnings("unchecked")
    public List<Object[]> searchStudentsWithDetails(String searchTerm, int page, int size) {
        try {
            String sql = "SELECT s.s_id, s.student_id, s.name_on_certificate, " +
                    "gup.nic, gup.first_name, gup.last_name, " +
                    "c.course_title, s.course_fee_total_due_amount, " +
                    "upm.total_due, upm.paid_amount, upm.scholarship " +
                    "FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN universal_payment_manager upm ON gup.gup_id = upm.general_user_profile_gup_id " +
                    "WHERE s.is_active = 1 " +
                    "AND (s.student_id LIKE :search " +
                    "OR s.name_on_certificate LIKE :search " +
                    "OR gup.nic LIKE :search " +
                    "OR gup.first_name LIKE :search " +
                    "OR gup.last_name LIKE :search) " +
                    "ORDER BY s.s_id DESC";
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setParameter("search", "%" + searchTerm + "%")
                    .setFirstResult(page * size)
                    .setMaxResults(size)
                    .getResultList();
            return results;
        } catch (Exception e) {
            logger.error("Error searching students with details: {}", searchTerm, e);
            return List.of();
        }
    }

    /**
     * Count students matching search criteria.
     */
    public long countSearchResults(String searchTerm) {
        try {
            String sql = "SELECT COUNT(*) FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "WHERE s.is_active = 1 " +
                    "AND (s.student_id LIKE :search " +
                    "OR s.name_on_certificate LIKE :search " +
                    "OR gup.nic LIKE :search " +
                    "OR gup.first_name LIKE :search " +
                    "OR gup.last_name LIKE :search)";
            
            Object result = em.createNativeQuery(sql)
                    .setParameter("search", "%" + searchTerm + "%")
                    .getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting search results: {}", searchTerm, e);
            return 0;
        }
    }

    /**
     * Get all students with pagination (no search filter).
     * Returns student details including NIC from general_user_profile and name from student table.
     */
    @SuppressWarnings("unchecked")
    public List<Object[]> getAllStudentsWithDetails(int page, int size) {
        try {
            String sql = "SELECT s.s_id, s.student_id, s.name_on_certificate, " +
                    "gup.nic, gup.first_name, gup.last_name, " +
                    "c.course_title, s.course_fee_total_due_amount, " +
                    "upm.total_due, upm.paid_amount, upm.scholarship " +
                    "FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN universal_payment_manager upm ON gup.gup_id = upm.general_user_profile_gup_id " +
                    "WHERE s.is_active = 1 " +
                    "ORDER BY s.s_id DESC";
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setFirstResult(page * size)
                    .setMaxResults(size)
                    .getResultList();
            return results;
        } catch (Exception e) {
            logger.error("Error getting all students with details", e);
            return List.of();
        }
    }

    /**
     * Count all active students.
     */
    public long countAllStudents() {
        try {
            String sql = "SELECT COUNT(*) FROM student WHERE is_active = 1";
            Object result = em.createNativeQuery(sql).getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting all students", e);
            return 0;
        }
    }

    /**
     * Search students by name or NIC with pagination.
     * Searches in first_name, last_name from general_user_profile and NIC.
     */
    @SuppressWarnings("unchecked")
    public List<Object[]> searchStudentsByNameOrNic(String searchTerm, int page, int size) {
        try {
            String sql = "SELECT s.s_id, s.student_id, s.name_on_certificate, " +
                    "gup.nic, gup.first_name, gup.last_name, " +
                    "c.course_title, s.course_fee_total_due_amount, " +
                    "upm.total_due, upm.paid_amount, upm.scholarship " +
                    "FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN universal_payment_manager upm ON gup.gup_id = upm.general_user_profile_gup_id " +
                    "WHERE s.is_active = 1 " +
                    "AND (gup.nic LIKE :search " +
                    "OR gup.first_name LIKE :search " +
                    "OR gup.last_name LIKE :search " +
                    "OR CONCAT(gup.first_name, ' ', gup.last_name) LIKE :search) " +
                    "ORDER BY s.s_id DESC";
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setParameter("search", "%" + searchTerm + "%")
                    .setFirstResult(page * size)
                    .setMaxResults(size)
                    .getResultList();
            return results;
        } catch (Exception e) {
            logger.error("Error searching students by name or NIC: {}", searchTerm, e);
            return List.of();
        }
    }

    /**
     * Count students matching name or NIC search.
     */
    public long countSearchByNameOrNic(String searchTerm) {
        try {
            String sql = "SELECT COUNT(*) FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "WHERE s.is_active = 1 " +
                    "AND (gup.nic LIKE :search " +
                    "OR gup.first_name LIKE :search " +
                    "OR gup.last_name LIKE :search " +
                    "OR CONCAT(gup.first_name, ' ', gup.last_name) LIKE :search)";
            
            Object result = em.createNativeQuery(sql)
                    .setParameter("search", "%" + searchTerm + "%")
                    .getSingleResult();
            return result != null ? ((Number) result).longValue() : 0;
        } catch (Exception e) {
            logger.error("Error counting search by name or NIC: {}", searchTerm, e);
            return 0;
        }
    }

    /**
     * Get detailed student profile for recovery purposes.
     * Includes personal details from general_user_profile and student tables.
     * Academic year is derived from the first payment date in voucher table.
     */
    @SuppressWarnings("unchecked")
    public Object[] getStudentProfileDetails(Integer sId) {
        try {
            String sql = "SELECT " +
                    "s.s_id, s.student_id, s.name_on_certificate, s.scn_no, " +
                    "s.school, " +
                    "COALESCE(YEAR((SELECT MIN(v.date) FROM voucher v WHERE v.general_user_profilegup_id = gup.gup_id)), s.academic_year) as academic_year, " +
                    "s.course_fee_total_due_amount, " +
                    "gup.gup_id, gup.nic, gup.first_name, gup.last_name, gup.email, " +
                    "gup.mobile_phone, gup.home_phone, gup.office_phone, gup.whatsapp, " +
                    "gup.address1, gup.address2, gup.address3, gup.postal_code, " +
                    "gup.dob, gup.gender, gup.occupation, gup.company, " +
                    "gup.profile_created_date, gup.nationality, " +
                    "c.course_title, c.cid, " +
                    "b.name as branch_name, " +
                    "i.name as intake_name, " +
                    "(SELECT MIN(v.date) FROM voucher v WHERE v.general_user_profilegup_id = gup.gup_id) as first_payment_date " +
                    "FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN branch b ON s.branch_bid = b.bid " +
                    "LEFT JOIN intake i ON s.intake_id = i.id " +
                    "WHERE s.s_id = :sId AND s.is_active = 1";
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setParameter("sId", sId)
                    .getResultList();
            
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            logger.error("Error getting student profile details for sId: {}", sId, e);
            return null;
        }
    }

    /**
     * Search and get detailed student profile by NIC or name.
     * Academic year is derived from the first payment date in voucher table.
     * Payment option is fetched from student_payment_scheduler.
     */
    @SuppressWarnings("unchecked")
    public Object[] searchStudentProfileByNicOrName(String searchTerm) {
        try {
            String sql = "SELECT " +
                    "s.s_id, s.student_id, s.name_on_certificate, s.scn_no, " +
                    "s.school, " +
                    "COALESCE(YEAR((SELECT MIN(v.date) FROM voucher v WHERE v.general_user_profilegup_id = gup.gup_id)), s.academic_year) as academic_year, " +
                    "s.course_fee_total_due_amount, " +
                    "gup.gup_id, gup.nic, gup.first_name, gup.last_name, gup.email, " +
                    "gup.mobile_phone, gup.home_phone, gup.office_phone, gup.whatsapp, " +
                    "gup.address1, gup.address2, gup.address3, gup.postal_code, " +
                    "gup.dob, gup.gender, gup.occupation, gup.company, " +
                    "gup.profile_created_date, gup.nationality, " +
                    "COALESCE(sps_course.course_title, c.course_title) as course_title, COALESCE(sps2.course_cid, c.cid) as cid, " +
                    "b.name as branch_name, " +
                    "CONCAT(" +
                    "  COALESCE(SUBSTRING_INDEX(s.student_id, '/', 5), ''), " +
                    "  ' - ', " +
                    "  COALESCE((SELECT bat.title FROM student_batches sb " +
                    "    JOIN batches bat ON sb.batchesb_id = bat.b_id " +
                    "    WHERE sb.students_id = s.s_id AND sb.is_active != 0 " +
                    "    ORDER BY sb.sb_id DESC LIMIT 1), 'N/A')" +
                    ") as intake_name, " +
                    "(SELECT MIN(v.date) FROM voucher v WHERE v.general_user_profilegup_id = gup.gup_id) as first_payment_date, " +
                    "po.id as payment_option_id, " +
                    "po.name as payment_option_name, " +
                    "COALESCE(" +
                    "  CASE " +
                    "    WHEN po.id = 1 THEN sps2.scholarship_value " +
                    "    WHEN po.id = 2 THEN sps2.year_payment_value " +
                    "    WHEN po.id = 3 THEN sps2.semester_payment_value " +
                    "    WHEN po.id = 4 THEN sps2.semester_payment_value - 5 " +
                    "    ELSE sps2.scholarship_value " +
                    "  END, " +
                    "  ubm.scholarship" +
                    ") as scholarship_percentage, " +
                    "COALESCE(sps2.course_fee, 3000000) as total_course_fee, " +
                    "sps2.discounted_fee as discounted_fee, " +
                    "(SELECT sh.old_percentage FROM scholarship_history sh " +
                    "  WHERE sh.scholarship_payment_scheduler_id = sps2.id " +
                    "  ORDER BY sh.change_date ASC LIMIT 1) as original_scholarship_percentage, " +
                    "om.discount_percentage as offer_discount_percentage, " +
                    "om.discount_amount as offer_discount_amount, " +
                    "om.date_to as offer_valid_until, " +
                    "oname.name as offer_name, " +
                    "so.is_taken as offer_is_taken, " +
                    "(SELECT CONCAT(g_gup.first_name, ' ', COALESCE(g_gup.last_name, '')) FROM student_guardian sg " +
                    "  JOIN general_user_profile g_gup ON sg.guardian = g_gup.gup_id " +
                    "  WHERE sg.student = s.s_id LIMIT 1) as guardian_name, " +
                    "(SELECT g_gup.mobile_phone FROM student_guardian sg " +
                    "  JOIN general_user_profile g_gup ON sg.guardian = g_gup.gup_id " +
                    "  WHERE sg.student = s.s_id LIMIT 1) as guardian_contact, " +
                    "(SELECT gr.relationship FROM student_guardian sg " +
                    "  JOIN guardian_relationship gr ON sg.guardian_relationshipid_gt = gr.id_gt " +
                    "  WHERE sg.student = s.s_id LIMIT 1) as guardian_relationship, " +
                    // International/University Payment Info based on branch
                    // BCU branch = BCU payment, IIC branch = IIC payment, Colombo Head Office = no payment
                    "b.bid as student_branch_id, " +
                    "CASE " +
                    "  WHEN b.name LIKE '%BCU%' THEN 'BCU' " +
                    "  WHEN b.name LIKE '%IIC%' THEN 'IIC' " +
                    "  WHEN b.name LIKE '%Colombo%Head%Office%' THEN 'CHO' " +
                    "  ELSE 'NONE' " +
                    "END as international_payment_type, " +
                    // Get payment info from student_batches + batches for BCU/IIC
                    // student_batches columns: course_fee, total_paid_amount, total_due_fee
                    // batches columns: title (for BCU/IIC identification)
                    "(SELECT sb.course_fee FROM student_batches sb " +
                    "  JOIN batches bat ON sb.batchesb_id = bat.b_id " +
                    "  WHERE sb.students_id = s.s_id AND sb.is_active != 0 " +
                    "  AND ((b.name LIKE '%BCU%' AND bat.title LIKE '%BCU%') " +
                    "       OR (b.name LIKE '%IIC%' AND bat.title LIKE '%IIC%')) LIMIT 1) as intl_fee_amount, " +
                    "(SELECT sb.total_paid_amount FROM student_batches sb " +
                    "  JOIN batches bat ON sb.batchesb_id = bat.b_id " +
                    "  WHERE sb.students_id = s.s_id AND sb.is_active != 0 " +
                    "  AND ((b.name LIKE '%BCU%' AND bat.title LIKE '%BCU%') " +
                    "       OR (b.name LIKE '%IIC%' AND bat.title LIKE '%IIC%')) LIMIT 1) as intl_paid_amount, " +
                    "(SELECT sb.total_due_fee FROM student_batches sb " +
                    "  JOIN batches bat ON sb.batchesb_id = bat.b_id " +
                    "  WHERE sb.students_id = s.s_id AND sb.is_active != 0 " +
                    "  AND ((b.name LIKE '%BCU%' AND bat.title LIKE '%BCU%') " +
                    "       OR (b.name LIKE '%IIC%' AND bat.title LIKE '%IIC%')) LIMIT 1) as intl_due_amount, " +
                    // BCU Payment Info - Students in BCU batches (course_cid 360 or 424)
                    // standard_fee from course table is the applicable fee for BCU payments
                    "(SELECT 1 FROM student_batches sb_bcu " +
                    "  WHERE sb_bcu.students_id = s.s_id AND sb_bcu.is_active != 0 " +
                    "  AND sb_bcu.course_cid IN (360, 424) LIMIT 1) as is_bcu_student, " +
                    "(SELECT sb_bcu.course_fee FROM student_batches sb_bcu " +
                    "  WHERE sb_bcu.students_id = s.s_id AND sb_bcu.is_active != 0 " +
                    "  AND sb_bcu.course_cid IN (360, 424) LIMIT 1) as bcu_standard_fee, " +
                    "(SELECT SUM(vi_bcu.amount) FROM voucher_item vi_bcu " +
                    "  JOIN voucher v_bcu ON vi_bcu.vouchervid = v_bcu.vid " +
                    "  WHERE v_bcu.general_user_profilegup_id = gup.gup_id " +
                    "  AND vi_bcu.voucher_typevt_id = 43) as bcu_paid_amount, " +
                    "(SELECT sb_bcu.course_cid FROM student_batches sb_bcu " +
                    "  WHERE sb_bcu.students_id = s.s_id AND sb_bcu.is_active != 0 " +
                    "  AND sb_bcu.course_cid IN (360, 424) LIMIT 1) as bcu_course_id, " +
                    // Last payment date and days since last payment
                    "(SELECT MAX(v_last.date) FROM voucher v_last " +
                    "  JOIN voucher_item vi_last ON vi_last.vouchervid = v_last.vid " +
                    "  WHERE v_last.general_user_profilegup_id = gup.gup_id) as last_payment_date, " +
                    "(SELECT DATEDIFF(CURDATE(), MAX(v_last.date)) FROM voucher v_last " +
                    "  JOIN voucher_item vi_last ON vi_last.vouchervid = v_last.vid " +
                    "  WHERE v_last.general_user_profilegup_id = gup.gup_id) as days_since_last_payment " +
                    "FROM general_user_profile gup " +
                    "LEFT JOIN student s ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN branch b ON s.branch_bid = b.bid " +
                    "LEFT JOIN intake i ON s.intake_id = i.id " +
                    "LEFT JOIN student_payment_scheduler sps ON s.s_id = sps.student_s_id AND sps.is_active = 1 " +
                    "LEFT JOIN payment_option po ON sps.payment_option_id = po.id " +
                    "LEFT JOIN scholarship_payment_scheduler sps2 ON gup.gup_id = sps2.general_user_profile_gup_id " +
                    "LEFT JOIN course sps_course ON sps2.course_cid = sps_course.cid " +
                    "LEFT JOIN universal_bucket_manager ubm ON gup.gup_id = ubm.general_user_profile_gup_id " +
                    "LEFT JOIN student_offer so ON s.s_id = so.student_s_id AND so.is_taken = 1 " +
                    "LEFT JOIN offer_manager om ON so.offer_manager_id = om.id " +
                    "LEFT JOIN offer_name oname ON om.offer_name_id = oname.id " +
                    "WHERE (gup.nic = :exactSearch " +
                    "OR gup.nic LIKE :search " +
                    "OR gup.first_name LIKE :search " +
                    "OR gup.last_name LIKE :search " +
                    "OR CONCAT(gup.first_name, ' ', gup.last_name) LIKE :search) " +
                    "ORDER BY CASE WHEN gup.nic = :exactSearch THEN 0 ELSE 1 END, COALESCE(s.is_active, 0) DESC, COALESCE(s.s_id, 0) DESC " +
                    "LIMIT 1";
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setParameter("exactSearch", searchTerm.trim())
                    .setParameter("search", "%" + searchTerm.trim() + "%")
                    .getResultList();
            
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            logger.error("Error searching student profile by NIC or name: {}", searchTerm, e);
            return null;
        }
    }
    
    /**
     * Get payment schedule for a student.
     * Returns overdue and upcoming installments with calculated fields.
     * 
     * @param studentSId The student's s_id
     * @return PaymentScheduleDTO with installment lists, or null if no schedule found
     */
    public PaymentScheduleDTO getPaymentSchedule(Integer studentSId) {
        try {
            // First, get the payment option for this student
            String optionSql = "SELECT sps.payment_option_id, po.name " +
                    "FROM student_payment_scheduler sps " +
                    "JOIN payment_option po ON sps.payment_option_id = po.id " +
                    "WHERE sps.student_s_id = :studentSId AND sps.is_active = 1 " +
                    "LIMIT 1";
            
            List<Object[]> optionResults = em.createNativeQuery(optionSql)
                    .setParameter("studentSId", studentSId)
                    .getResultList();
            
            PaymentScheduleDTO schedule;
            if (optionResults.isEmpty()) {
                logger.info("No payment scheduler found for student: {}, creating empty schedule for payment history", studentSId);
                schedule = new PaymentScheduleDTO();
            } else {
                Object[] optionRow = optionResults.get(0);
                Integer paymentOptionId = ((Number) optionRow[0]).intValue();
                String paymentOptionName = (String) optionRow[1];
                schedule = new PaymentScheduleDTO(paymentOptionId, paymentOptionName);
            }
            
            // Get all installments with due_amount > 0 (pending payments)
            String installmentSql = "SELECT spsd.id, spsd.date_to_be_paid, spsd.to_be_paid_amount, " +
                    "spsd.paid_amount, spsd.due_amount, spsd.discount " +
                    "FROM student_payment_scheduler_dates spsd " +
                    "JOIN student_payment_scheduler sps ON spsd.student_payment_scheduler_id = sps.id " +
                    "WHERE sps.student_s_id = :studentSId " +
                    "AND sps.is_active = 1 " +
                    "AND spsd.due_amount > 0 " +
                    "ORDER BY spsd.date_to_be_paid ASC";
            
            List<Object[]> installmentResults = em.createNativeQuery(installmentSql)
                    .setParameter("studentSId", studentSId)
                    .getResultList();
            
            LocalDate today = LocalDate.now();
            int installmentNumber = 1;
            
            for (Object[] row : installmentResults) {
                InstallmentDTO installment = new InstallmentDTO(row, schedule.getPaymentOptionId(), installmentNumber, today);
                
                if (installment.getDaysOverdue() != null && installment.getDaysOverdue() > 0) {
                    // Overdue installment
                    schedule.addOverdueInstallment(installment);
                } else {
                    // Upcoming installment
                    schedule.addUpcomingInstallment(installment);
                }
                
                installmentNumber++;
            }
            
            // Fetch payment history from voucher_item via student_batches -> voucher -> voucher_item path
            String paymentHistorySql = """
                SELECT vi.id, vi.date, COALESCE(NULLIF(TRIM(vi.description), ''), v.description) as description,
                       vi.amount as paid_amount, vi.due_amount, 
                       COALESCE(vi.discount_value, 0) as discount,
                       vi.other_currency_amount as lkr_equivalent,
                       sb.course_cid as course_id
                FROM student_batches sb
                JOIN voucher_item vi ON vi.vouchervid = sb.vouchervid
                JOIN voucher v ON v.vid = sb.vouchervid
                JOIN voucher_type vt ON v.voucher_typevt_id = vt.vt_id
                WHERE sb.students_id = :studentSId
                AND sb.is_active != 0
                AND vi.amount > 0
                AND vi.amount < 10000000
                AND vt.name IN ('Invoice', 'Receipt', 'Sales Invoice')
                ORDER BY vi.date ASC
                """;
            
            List<Object[]> paymentHistoryResults = em.createNativeQuery(paymentHistorySql)
                    .setParameter("studentSId", studentSId)
                    .getResultList();
            
            for (Object[] row : paymentHistoryResults) {
                PaymentHistoryDTO payment = new PaymentHistoryDTO(row);
                
                // For BCU payments (course 360/424), calculate GBP equivalent using exchange rate on payment date
                // paidAmount is in LKR, we need to convert to GBP
                if (payment.getCourseId() != null && 
                    (payment.getCourseId() == 360 || payment.getCourseId() == 424) &&
                    payment.getPaidAmount() != null && payment.getPaidAmount() > 0 &&
                    payment.getDueDate() != null) {
                    
                    // Get exchange rate for the payment date (GBP to LKR)
                    Double exchangeRate = getExchangeRateForDate(payment.getDueDate());
                    if (exchangeRate != null && exchangeRate > 0) {
                        // Convert LKR to GBP: gbpAmount = lkrAmount / exchangeRate
                        payment.setGbpEquivalent(payment.getPaidAmount() / exchangeRate);
                        payment.setExchangeRateUsed(exchangeRate);
                    }
                }
                
                schedule.getPaymentHistory().add(payment);
            }
            
            // Fetch pending installments - calculate due_amount as (to_be_paid_amount - paid_amount)
            String pendingInstallmentsSql = """
                SELECT spsd.id, spsd.date_to_be_paid, spsd.to_be_paid_amount, 
                       spsd.paid_amount, 
                       (spsd.to_be_paid_amount - COALESCE(spsd.paid_amount, 0)) as calculated_due
                FROM student_payment_scheduler_dates spsd
                JOIN student_payment_scheduler sps ON spsd.student_payment_scheduler_id = sps.id
                WHERE sps.student_s_id = :studentSId
                AND sps.is_active = 1
                AND (spsd.to_be_paid_amount - COALESCE(spsd.paid_amount, 0)) > 0
                ORDER BY spsd.date_to_be_paid ASC
                """;
            
            List<Object[]> pendingResults = em.createNativeQuery(pendingInstallmentsSql)
                    .setParameter("studentSId", studentSId)
                    .getResultList();
            
            for (Object[] row : pendingResults) {
                schedule.getPendingInstallments().add(new PendingInstallmentDTO(row));
            }
            
            // Fetch payment manager history (from student_payment_manager table)
            String paymentManagerSql = """
                SELECT spm.id, spm.paid_date, spm.entered_amount, spm.approved_amount, 
                       spm.is_approved, spm.doc, spm.entered_date
                FROM student_payment_manager spm
                WHERE spm.student_s_id = :studentSId
                AND spm.is_active = 1
                ORDER BY spm.paid_date DESC
                """;
            
            List<Object[]> paymentManagerResults = em.createNativeQuery(paymentManagerSql)
                    .setParameter("studentSId", studentSId)
                    .getResultList();
            
            for (Object[] row : paymentManagerResults) {
                schedule.getPaymentManagerHistory().add(new PaymentManagerDTO(row));
            }
            
            return schedule;
            
        } catch (Exception e) {
            logger.error("Error getting payment schedule for student: {}", studentSId, e);
            return null;
        }
    }
    
    /**
     * Get overdue students report.
     * Returns students with overdue payments who have made at least one payment,
     * with first payment date >= 2020-01-01.
     * 
     * @param branchId Optional branch filter (null for all)
     * @param paymentOptionId Optional payment option filter (null for all)
     * @param offerFilter Optional offer filter: "all", "yes", "no" (null for all)
     * @return List of OverdueStudentDTO
     */
    public List<OverdueStudentDTO> getOverdueStudentsReport(Integer branchId, Integer paymentOptionId, String offerFilter) {
        try {
            String sql = """
                SELECT 
                    s.s_id,
                    gup.nic,
                    CONCAT(gup.first_name, ' ', COALESCE(gup.last_name, '')) as student_name,
                    b.name as branch_name,
                    po.name as payment_option,
                    CASE 
                        WHEN po.id = 1 THEN sps2.scholarship_value
                        WHEN po.id = 2 THEN sps2.year_payment_value
                        WHEN po.id = 3 THEN sps2.semester_payment_value
                        ELSE sps2.scholarship_value
                    END as scholarship_pct,
                    CASE WHEN so.is_taken = 1 THEN 1 ELSE 0 END as offer_taken,
                    om.discount_percentage as offer_pct,
                    SUM(spsd.to_be_paid_amount) as total_payable,
                    SUM(spsd.paid_amount) as total_paid,
                    SUM(spsd.due_amount) as total_due,
                    DATEDIFF(CURDATE(), MIN(CASE WHEN spsd.date_to_be_paid < CURDATE() AND spsd.due_amount > 0 
                        THEN spsd.date_to_be_paid ELSE NULL END)) as total_delay_days,
                    MIN(spsd.date_to_be_paid) as first_payment_date,
                    (SELECT MAX(spsd2.date_to_be_paid) 
                     FROM student_payment_scheduler_dates spsd2 
                     JOIN student_payment_scheduler sps_inner ON spsd2.student_payment_scheduler_id = sps_inner.id
                     WHERE sps_inner.student_s_id = s.s_id AND sps_inner.is_active = 1 AND spsd2.paid_amount > 0) as last_payment_date,
                    MIN(CASE WHEN spsd.date_to_be_paid < CURDATE() AND spsd.due_amount > 0 
                        THEN spsd.date_to_be_paid ELSE NULL END) as oldest_overdue_date,
                    CASE WHEN so.is_taken = 1 AND om.discount_percentage IS NOT NULL 
                        THEN (3000000 * om.discount_percentage / 100) ELSE 0 END as recoverable_amount
                FROM student s
                JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id
                JOIN branch b ON s.branch_bid = b.bid
                JOIN student_payment_scheduler sps ON s.s_id = sps.student_s_id AND sps.is_active = 1
                JOIN payment_option po ON sps.payment_option_id = po.id
                JOIN student_payment_scheduler_dates spsd ON sps.id = spsd.student_payment_scheduler_id
                LEFT JOIN scholarship_payment_scheduler sps2 ON gup.gup_id = sps2.general_user_profile_gup_id
                LEFT JOIN student_offer so ON s.s_id = so.student_s_id
                LEFT JOIN offer_manager om ON so.offer_manager_id = om.id
                WHERE s.is_active = 1
                -- Has overdue payments
                AND s.s_id IN (
                    SELECT DISTINCT sps3.student_s_id 
                    FROM student_payment_scheduler sps3
                    JOIN student_payment_scheduler_dates spsd3 ON sps3.id = spsd3.student_payment_scheduler_id
                    WHERE sps3.is_active = 1 
                    AND spsd3.date_to_be_paid < CURDATE() 
                    AND spsd3.due_amount > 0
                )
                -- First payment date >= 2020-01-01
                AND s.s_id IN (
                    SELECT sps4.student_s_id 
                    FROM student_payment_scheduler sps4
                    JOIN student_payment_scheduler_dates spsd4 ON sps4.id = spsd4.student_payment_scheduler_id
                    WHERE sps4.is_active = 1
                    GROUP BY sps4.student_s_id
                    HAVING MIN(spsd4.date_to_be_paid) >= '2020-01-01'
                )
                """;
            
            // Add optional filters
            if (branchId != null) {
                sql += " AND b.bid = :branchId";
            }
            if (paymentOptionId != null) {
                sql += " AND po.id = :paymentOptionId";
            }
            if ("yes".equalsIgnoreCase(offerFilter)) {
                sql += " AND so.is_taken = 1";
            } else if ("no".equalsIgnoreCase(offerFilter)) {
                sql += " AND (so.is_taken IS NULL OR so.is_taken = 0)";
            }
            
            sql += """
                GROUP BY s.s_id, gup.nic, gup.first_name, gup.last_name, b.name, po.name, po.id,
                         sps2.scholarship_value, sps2.year_payment_value, sps2.semester_payment_value,
                         so.is_taken, om.discount_percentage
                HAVING SUM(spsd.paid_amount) > 0
                ORDER BY total_delay_days DESC
                """;
            
            var query = em.createNativeQuery(sql);
            
            if (branchId != null) {
                query.setParameter("branchId", branchId);
            }
            if (paymentOptionId != null) {
                query.setParameter("paymentOptionId", paymentOptionId);
            }
            
            List<Object[]> results = query.getResultList();
            
            return results.stream()
                    .map(OverdueStudentDTO::new)
                    .toList();
                    
        } catch (Exception e) {
            logger.error("Error getting overdue students report", e);
            return List.of();
        }
    }
    
    /**
     * Get payment reconciliation report.
     * Compares voucher_item totals vs student_batches.total_paid_amount.
     * 
     * @param statusFilter Optional filter: "all", "match", "mismatch", "voucher_only", "spsd_only"
     * @return List of PaymentReconciliationDTO
     */
    @SuppressWarnings("unchecked")
    public List<PaymentReconciliationDTO> getPaymentReconciliation(String statusFilter) {
        try {
            String sql = """
                SELECT 
                    s.s_id,
                    gup.nic,
                    CONCAT(gup.first_name, ' ', COALESCE(gup.last_name, '')) as student_name,
                    COALESCE(vi_total.voucher_total, 0) as voucher_item_total,
                    COALESCE(sb_total.batches_total, 0) as student_batches_total,
                    COALESCE(vi_total.voucher_total, 0) - COALESCE(sb_total.batches_total, 0) as difference,
                    COALESCE(vi_total.voucher_count, 0) as voucher_count,
                    COALESCE(sb_total.batch_count, 0) as batch_count,
                    COALESCE(vi_total.voucher_types, '') as voucher_types
                FROM student s
                JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id
                LEFT JOIN (
                    SELECT s2.s_id, 
                           SUM(vi.amount) as voucher_total, 
                           COUNT(*) as voucher_count,
                           GROUP_CONCAT(DISTINCT vt.name ORDER BY vt.name SEPARATOR ', ') as voucher_types
                    FROM voucher_item vi
                    JOIN voucher v ON vi.vouchervid = v.vid
                    JOIN voucher_type vt ON v.voucher_typevt_id = vt.vt_id
                    JOIN student s2 ON v.general_user_profilegup_id = s2.general_user_profilegup_id
                    WHERE vi.amount > 0 
                    AND vi.amount < 10000000
                    AND vt.name IN ('Invoice', 'Receipt', 'Sales Invoice')
                    AND vi.date >= '2020-01-01'
                    GROUP BY s2.s_id
                ) vi_total ON s.s_id = vi_total.s_id
                LEFT JOIN (
                    SELECT sb.students_id as s_id, 
                           SUM(sb.total_paid_amount) as batches_total, 
                           COUNT(*) as batch_count
                    FROM student_batches sb
                    WHERE sb.is_active != 0
                    GROUP BY sb.students_id
                ) sb_total ON s.s_id = sb_total.s_id
                WHERE s.is_active = 1
                AND (vi_total.voucher_total IS NOT NULL OR sb_total.batches_total IS NOT NULL)
                ORDER BY ABS(COALESCE(vi_total.voucher_total, 0) - COALESCE(sb_total.batches_total, 0)) DESC
                """;
            
            List<Object[]> results = em.createNativeQuery(sql).getResultList();
            
            List<PaymentReconciliationDTO> allRecords = results.stream()
                    .map(PaymentReconciliationDTO::new)
                    .toList();
            
            // Apply status filter if provided
            if (statusFilter != null && !statusFilter.equalsIgnoreCase("all")) {
                return allRecords.stream()
                        .filter(r -> r.getStatus().equalsIgnoreCase(statusFilter) ||
                                    (statusFilter.equalsIgnoreCase("mismatch") && 
                                     !r.getStatus().equals("MATCH")))
                        .toList();
            }
            
            return allRecords;
                    
        } catch (Exception e) {
            logger.error("Error getting payment reconciliation report", e);
            return List.of();
        }
    }
    
    /**
     * Get payment reconciliation summary statistics.
     * Compares voucher_item totals vs student_batches.total_paid_amount.
     */
    @SuppressWarnings("unchecked")
    public Object getPaymentReconciliationSummary() {
        try {
            String sql = """
                SELECT 
                    COUNT(*) as total_students,
                    SUM(CASE WHEN ABS(COALESCE(vi_total.voucher_total, 0) - COALESCE(sb_total.batches_total, 0)) <= 100 THEN 1 ELSE 0 END) as matched,
                    SUM(CASE WHEN COALESCE(vi_total.voucher_total, 0) > 0 AND COALESCE(sb_total.batches_total, 0) = 0 THEN 1 ELSE 0 END) as voucher_only,
                    SUM(CASE WHEN COALESCE(vi_total.voucher_total, 0) = 0 AND COALESCE(sb_total.batches_total, 0) > 0 THEN 1 ELSE 0 END) as batches_only,
                    SUM(CASE WHEN ABS(COALESCE(vi_total.voucher_total, 0) - COALESCE(sb_total.batches_total, 0)) > 100 
                             AND COALESCE(vi_total.voucher_total, 0) > 0 
                             AND COALESCE(sb_total.batches_total, 0) > 0 THEN 1 ELSE 0 END) as mismatched,
                    SUM(COALESCE(vi_total.voucher_total, 0)) as total_voucher_amount,
                    SUM(COALESCE(sb_total.batches_total, 0)) as total_batches_amount
                FROM student s
                JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id
                LEFT JOIN (
                    SELECT s2.s_id, SUM(vi.amount) as voucher_total
                    FROM voucher_item vi
                    JOIN voucher v ON vi.vouchervid = v.vid
                    JOIN voucher_type vt ON v.voucher_typevt_id = vt.vt_id
                    JOIN student s2 ON v.general_user_profilegup_id = s2.general_user_profilegup_id
                    WHERE vi.amount > 0 
                    AND vi.amount < 10000000
                    AND vt.name IN ('Invoice', 'Receipt', 'Sales Invoice')
                    AND vi.date >= '2020-01-01'
                    GROUP BY s2.s_id
                ) vi_total ON s.s_id = vi_total.s_id
                LEFT JOIN (
                    SELECT sb.students_id as s_id, SUM(sb.total_paid_amount) as batches_total
                    FROM student_batches sb
                    WHERE sb.is_active != 0
                    GROUP BY sb.students_id
                ) sb_total ON s.s_id = sb_total.s_id
                WHERE s.is_active = 1
                AND (vi_total.voucher_total IS NOT NULL OR sb_total.batches_total IS NOT NULL)
                """;
            
            Object[] result = (Object[]) em.createNativeQuery(sql).getSingleResult();
            
            return new java.util.HashMap<String, Object>() {{
                put("totalStudents", result[0] != null ? ((Number) result[0]).intValue() : 0);
                put("matched", result[1] != null ? ((Number) result[1]).intValue() : 0);
                put("voucherOnly", result[2] != null ? ((Number) result[2]).intValue() : 0);
                put("spsdOnly", result[3] != null ? ((Number) result[3]).intValue() : 0);
                put("mismatched", result[4] != null ? ((Number) result[4]).intValue() : 0);
                put("totalVoucherAmount", result[5] != null ? ((Number) result[5]).doubleValue() : 0.0);
                put("totalSpsdAmount", result[6] != null ? ((Number) result[6]).doubleValue() : 0.0);
            }};
                    
        } catch (Exception e) {
            logger.error("Error getting payment reconciliation summary", e);
            return new java.util.HashMap<String, Object>();
        }
    }

    /**
     * Get scholarship diagnostic report - students with outstanding dues
     * to identify potential scholarship calculation mismatches.
     * Shows all students with dues, comparing stored discounted_fee vs calculated payable.
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getScholarshipDiagnosticReport() {
        try {
            String sql = "SELECT " +
                    "s.s_id, " +
                    "s.student_id, " +
                    "CONCAT(gup.first_name, ' ', COALESCE(gup.last_name, '')) as student_name, " +
                    "gup.nic, " +
                    "c.course_title, " +
                    "b.name as branch_name, " +
                    "po.id as payment_option_id, " +
                    "po.name as payment_option, " +
                    "COALESCE(sps2.course_fee, 3000000) as course_fee, " +
                    "sps2.discounted_fee, " +
                    "COALESCE(sps2.scholarship_value, ubm.scholarship, 0) as scholarship_value, " +
                    "COALESCE(sps2.year_payment_value, ubm.scholarship, 0) as year_payment_value, " +
                    "COALESCE(sps2.semester_payment_value, ubm.scholarship, 0) as semester_payment_value, " +
                    "s.course_fee_total_due_amount, " +
                    "COALESCE(" +
                    "  CASE " +
                    "    WHEN po.id = 1 THEN sps2.scholarship_value " +
                    "    WHEN po.id = 2 THEN sps2.year_payment_value " +
                    "    WHEN po.id = 3 THEN sps2.semester_payment_value " +
                    "    ELSE sps2.scholarship_value " +
                    "  END, " +
                    "  ubm.scholarship, 0" +
                    ") as applicable_scholarship_pct, " +
                    "ROUND(COALESCE(sps2.course_fee, 3000000) * (1 - COALESCE(" +
                    "  CASE " +
                    "    WHEN po.id = 1 THEN sps2.scholarship_value " +
                    "    WHEN po.id = 2 THEN sps2.year_payment_value " +
                    "    WHEN po.id = 3 THEN sps2.semester_payment_value " +
                    "    ELSE sps2.scholarship_value " +
                    "  END, " +
                    "  ubm.scholarship, 0" +
                    ")/100), 2) as calculated_payable, " +
                    "CASE " +
                    "  WHEN sps2.discounted_fee IS NOT NULL AND " +
                    "       ABS(sps2.discounted_fee - " +
                    "           COALESCE(sps2.course_fee, 3000000) * (1 - COALESCE(" +
                    "             CASE " +
                    "               WHEN po.id = 1 THEN sps2.scholarship_value " +
                    "               WHEN po.id = 2 THEN sps2.year_payment_value " +
                    "               WHEN po.id = 3 THEN sps2.semester_payment_value " +
                    "               ELSE sps2.scholarship_value " +
                    "             END, " +
                    "             ubm.scholarship, 0" +
                    "           )/100)" +
                    "       ) > 1 THEN 'MISMATCH' " +
                    "  WHEN sps2.discounted_fee IS NULL THEN 'NO_DISCOUNTED_FEE' " +
                    "  ELSE 'OK' " +
                    "END as status " +
                    "FROM student s " +
                    "LEFT JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "LEFT JOIN course c ON s.coursecid = c.cid " +
                    "LEFT JOIN branch b ON s.branch_bid = b.bid " +
                    "LEFT JOIN student_payment_scheduler sps ON s.s_id = sps.student_s_id AND sps.is_active = 1 " +
                    "LEFT JOIN payment_option po ON sps.payment_option_id = po.id " +
                    "LEFT JOIN scholarship_payment_scheduler sps2 ON gup.gup_id = sps2.general_user_profile_gup_id " +
                    "LEFT JOIN universal_bucket_manager ubm ON gup.gup_id = ubm.general_user_profile_gup_id " +
                    "WHERE s.is_active = 1 " +
                    "AND s.course_fee_total_due_amount > 0 " +
                    "ORDER BY " +
                    "  CASE " +
                    "    WHEN sps2.discounted_fee IS NOT NULL AND " +
                    "         ABS(sps2.discounted_fee - " +
                    "             COALESCE(sps2.course_fee, 3000000) * (1 - COALESCE(" +
                    "               CASE " +
                    "                 WHEN po.id = 1 THEN sps2.scholarship_value " +
                    "                 WHEN po.id = 2 THEN sps2.year_payment_value " +
                    "                 WHEN po.id = 3 THEN sps2.semester_payment_value " +
                    "                 ELSE sps2.scholarship_value " +
                    "               END, " +
                    "               ubm.scholarship, 0" +
                    "             )/100)" +
                    "         ) > 1 THEN 0 " +
                    "    ELSE 1 " +
                    "  END, " +
                    "  s.course_fee_total_due_amount DESC";
            
            List<Object[]> results = em.createNativeQuery(sql).getResultList();
            List<Map<String, Object>> report = new java.util.ArrayList<>();
            
            for (Object[] row : results) {
                Map<String, Object> record = new java.util.HashMap<>();
                int i = 0;
                record.put("sId", row[i] != null ? ((Number) row[i]).intValue() : null); i++;
                record.put("studentId", row[i]); i++;
                record.put("studentName", row[i]); i++;
                record.put("nic", row[i]); i++;
                record.put("courseTitle", row[i]); i++;
                record.put("branchName", row[i]); i++;
                record.put("paymentOptionId", row[i] != null ? ((Number) row[i]).intValue() : null); i++;
                record.put("paymentOption", row[i]); i++;
                record.put("courseFee", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("discountedFee", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("scholarshipValue", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("yearPaymentValue", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("semesterPaymentValue", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("dueAmount", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("applicableScholarshipPct", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("calculatedPayable", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("status", row[i]); i++;
                report.add(record);
            }
            
            return report;
        } catch (Exception e) {
            logger.error("Error getting scholarship diagnostic report", e);
            return new java.util.ArrayList<>();
        }
    }

    /**
     * Get IIC students for testing - finds students in IIC batches with their payment status.
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getIicStudentsForTesting() {
        try {
            String sql = "SELECT " +
                    "s.s_id, " +
                    "gup.nic, " +
                    "CONCAT(gup.first_name, ' ', COALESCE(gup.last_name, '')) as student_name, " +
                    "bat.name as batch_name, " +
                    "sb.amount as iic_fee, " +
                    "sb.paid as iic_paid, " +
                    "sb.due as iic_due, " +
                    "CASE " +
                    "  WHEN sb.due > 0 THEN 'HAS_DUE' " +
                    "  WHEN sb.paid >= sb.amount THEN 'FULLY_PAID' " +
                    "  ELSE 'NO_PAYMENT' " +
                    "END as payment_status " +
                    "FROM student_batches sb " +
                    "JOIN student s ON sb.students_id = s.s_id " +
                    "JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id " +
                    "JOIN batches bat ON sb.batches_id = bat.id " +
                    "WHERE bat.name LIKE '%IIC%' " +
                    "AND s.is_active = 1 " +
                    "ORDER BY sb.due DESC, sb.paid DESC " +
                    "LIMIT 20";
            
            List<Object[]> results = em.createNativeQuery(sql).getResultList();
            List<Map<String, Object>> testCases = new java.util.ArrayList<>();
            
            for (Object[] row : results) {
                Map<String, Object> record = new java.util.HashMap<>();
                int i = 0;
                record.put("sId", row[i] != null ? ((Number) row[i]).intValue() : null); i++;
                record.put("nic", row[i]); i++;
                record.put("studentName", row[i]); i++;
                record.put("batchName", row[i]); i++;
                record.put("iicFee", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("iicPaid", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("iicDue", row[i] != null ? ((Number) row[i]).doubleValue() : null); i++;
                record.put("paymentStatus", row[i]); i++;
                testCases.add(record);
            }
            
            return testCases;
        } catch (Exception e) {
            logger.error("Error getting IIC students for testing", e);
            return new java.util.ArrayList<>();
        }
    }
    
    /**
     * Get student recovery report - 100 students registered after 2020-12-31 with payment details.
     * Returns: NIC, Name, Phone, Scholarship %, Payable Fee, Paid Amount, Due Amount
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getStudentRecoveryReport(int limit) {
        try {
            String sql = """
                SELECT 
                    gup.nic,
                    s.student_id,
                    CONCAT(gup.first_name, ' ', COALESCE(gup.last_name, '')) as student_name,
                    gup.mobile_phone as phone,
                    upm.scholarship as scholarship_percentage,
                    upm.payable_amount as payable_fee,
                    upm.paid_amount as paid_amount,
                    upm.total_due as due_amount,
                    MIN(vi.date) as first_payment_date
                FROM student s 
                JOIN general_user_profile gup ON s.general_user_profilegup_id = gup.gup_id 
                JOIN universal_payment_manager upm ON upm.general_user_profile_gup_id = gup.gup_id 
                JOIN voucher v ON v.general_user_profilegup_id = gup.gup_id 
                JOIN voucher_item vi ON vi.vouchervid = v.vid 
                WHERE vi.date > '2020-12-31' 
                AND gup.nic IS NOT NULL 
                AND gup.nic != '' 
                AND s.is_active = 1
                GROUP BY s.s_id 
                ORDER BY first_payment_date ASC
                LIMIT :limit
                """;
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .setParameter("limit", limit)
                    .getResultList();
            
            List<Map<String, Object>> report = new java.util.ArrayList<>();
            
            for (Object[] row : results) {
                Map<String, Object> record = new java.util.HashMap<>();
                int i = 0;
                record.put("nic", row[i]); i++;
                record.put("studentId", row[i]); i++;
                record.put("studentName", row[i]); i++;
                record.put("phone", row[i]); i++;
                record.put("scholarshipPercentage", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("payableFee", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("paidAmount", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("dueAmount", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("firstPaymentDate", row[i] != null ? row[i].toString() : null); i++;
                report.add(record);
            }
            
            return report;
        } catch (Exception e) {
            logger.error("Error getting student recovery report", e);
            return new java.util.ArrayList<>();
        }
    }

    /**
     * Get the GBP to LKR exchange rate for a specific date.
     * Looks up the recovery_exchange_rate table for the closest rate on or before the given date.
     * Falls back to a default rate if no rate is found.
     * 
     * @param date The date to get the exchange rate for
     * @return The exchange rate (GBP to LKR), or default 380.0 if not found
     */
    private Double getExchangeRateForDate(java.time.LocalDate date) {
        try {
            // GBP = currency_id 2, LKR = currency_id 1
            String sql = """
                SELECT rate FROM recovery_exchange_rate 
                WHERE from_currency_id = 2 AND to_currency_id = 1 
                AND rate_date <= :targetDate AND is_active = 1
                ORDER BY rate_date DESC 
                LIMIT 1
                """;
            
            List<?> results = em.createNativeQuery(sql)
                    .setParameter("targetDate", java.sql.Date.valueOf(date))
                    .getResultList();
            
            if (!results.isEmpty() && results.get(0) != null) {
                return ((Number) results.get(0)).doubleValue();
            }
            
            // Fallback: try to get the latest rate regardless of date
            String fallbackSql = """
                SELECT rate FROM recovery_exchange_rate 
                WHERE from_currency_id = 2 AND to_currency_id = 1 AND is_active = 1
                ORDER BY rate_date DESC 
                LIMIT 1
                """;
            
            List<?> fallbackResults = em.createNativeQuery(fallbackSql).getResultList();
            if (!fallbackResults.isEmpty() && fallbackResults.get(0) != null) {
                return ((Number) fallbackResults.get(0)).doubleValue();
            }
            
            // Default exchange rate if no data found (approximate GBP to LKR)
            return 380.0;
        } catch (Exception e) {
            logger.warn("Error getting exchange rate for date {}: {}", date, e.getMessage());
            return 380.0; // Default fallback
        }
    }
    
    /**
     * Get course-specific overdue report.
     * Returns students enrolled in courses 321, 328, 331, 340 
     * where student_batches.total_due_fee != 0.
     */
    public List<java.util.Map<String, Object>> getCourseOverdueReport(int courseId) {
        try {
            String sql = """
                SELECT 
                    ROW_NUMBER() OVER (ORDER BY due_amount DESC) as row_num,
                    nic,
                    student_name,
                    contact_number,
                    course_fee,
                    scholarship_pct,
                    payable_fee,
                    total_paid,
                    due_amount,
                    (payable_fee - total_paid) as calculated_balance,
                    last_payment_date,
                    days_overdue,
                    course_name
                FROM (
                    SELECT 
                        gup.nic,
                        CONCAT(COALESCE(gup.first_name, ''), ' ', COALESCE(gup.last_name, '')) as student_name,
                        gup.mobile_phone as contact_number,
                        MAX(sps.course_fee) as course_fee,
                        MAX(sps.scholarship_value) as scholarship_pct,
                        MAX(sps.discounted_fee) as payable_fee,
                        COALESCE(MAX(paid.total_paid), 0) as total_paid,
                        MAX(due.total_due) as due_amount,
                        MAX(last_payment.last_date) as last_payment_date,
                        MAX(DATEDIFF(CURDATE(), COALESCE(last_payment.last_date, sps.release_date))) as days_overdue,
                        MAX(c.course_title) as course_name
                    FROM scholarship_payment_scheduler sps
                    JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
                    JOIN student s ON s.general_user_profilegup_id = gup.gup_id
                    JOIN course c ON sps.course_cid = c.cid
                    JOIN (
                        SELECT sb.students_id, sb.course_cid, sb.total_due_fee as total_due
                        FROM student_batches sb
                        WHERE sb.total_due_fee != 0
                        AND sb.course_cid IN (321, 328, 331, 340)
                        AND sb.is_active != 0
                    ) due ON due.students_id = s.s_id AND due.course_cid = sps.course_cid
                    LEFT JOIN (
                        SELECT v.general_user_profilegup_id, SUM(vi.amount) as total_paid
                        FROM voucher v
                        JOIN voucher_item vi ON vi.vouchervid = v.vid
                        GROUP BY v.general_user_profilegup_id
                    ) paid ON paid.general_user_profilegup_id = gup.gup_id
                    LEFT JOIN (
                        SELECT v.general_user_profilegup_id, MAX(v.date) as last_date
                        FROM voucher v
                        JOIN voucher_item vi ON vi.vouchervid = v.vid
                        GROUP BY v.general_user_profilegup_id
                    ) last_payment ON last_payment.general_user_profilegup_id = gup.gup_id
                    WHERE sps.course_cid IN (321, 328, 331, 340)
                    GROUP BY gup.nic, gup.first_name, gup.last_name, gup.mobile_phone
                ) grouped
                ORDER BY due_amount DESC
                """;
            
            List<Object[]> results = em.createNativeQuery(sql)
                    .getResultList();
            
            List<java.util.Map<String, Object>> report = new java.util.ArrayList<>();
            for (Object[] row : results) {
                java.util.Map<String, Object> record = new java.util.LinkedHashMap<>();
                int i = 0;
                record.put("index", row[i] != null ? ((Number) row[i]).intValue() : 0); i++;
                record.put("nic", row[i]); i++;
                record.put("studentName", row[i]); i++;
                record.put("contactNumber", row[i]); i++;
                record.put("courseFee", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("scholarshipPct", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("payableFee", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("totalPaid", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("dueAmount", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("calculatedBalance", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("lastPaymentDate", row[i] != null ? row[i].toString() : null); i++;
                record.put("daysOverdue", row[i] != null ? ((Number) row[i]).intValue() : 0); i++;
                record.put("courseName", row[i] != null ? row[i].toString() : null); i++;
                report.add(record);
            }
            
            return report;
        } catch (Exception e) {
            logger.error("Error getting course overdue report for courseId: {}", courseId, e);
            return new java.util.ArrayList<>();
        }
    }
    
    /**
     * Get count of student_batches records with specific total_due_fee value.
     */
    public Long getStudentBatchesCountByDueFee(Double dueFee) {
        try {
            String sql = "SELECT COUNT(*) FROM student_batches WHERE total_due_fee = :dueFee";
            Object result = em.createNativeQuery(sql)
                    .setParameter("dueFee", dueFee)
                    .getSingleResult();
            return ((Number) result).longValue();
        } catch (Exception e) {
            logger.error("Error getting student_batches count for dueFee: {}", dueFee, e);
            return 0L;
        }
    }
    
    /**
     * Get count of inactive student_batches records that would appear in the overdue report.
     */
    public java.util.Map<String, Object> getInactiveBatchesInOverdueReport() {
        try {
            // Count total records in current overdue report query (without is_active filter)
            String totalSql = """
                SELECT COUNT(DISTINCT gup.nic)
                FROM scholarship_payment_scheduler sps
                JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
                JOIN student s ON s.general_user_profilegup_id = gup.gup_id
                JOIN student_batches sb ON sb.students_id = s.s_id AND sb.course_cid = sps.course_cid
                WHERE sps.course_cid IN (321, 328, 331, 340)
                AND sb.total_due_fee != 0
                """;
            
            // Count records from inactive batches only
            String inactiveSql = """
                SELECT COUNT(DISTINCT gup.nic)
                FROM scholarship_payment_scheduler sps
                JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
                JOIN student s ON s.general_user_profilegup_id = gup.gup_id
                JOIN student_batches sb ON sb.students_id = s.s_id AND sb.course_cid = sps.course_cid
                WHERE sps.course_cid IN (321, 328, 331, 340)
                AND sb.total_due_fee != 0
                AND sb.is_active = 0
                """;
            
            // Count records from active batches only
            String activeSql = """
                SELECT COUNT(DISTINCT gup.nic)
                FROM scholarship_payment_scheduler sps
                JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
                JOIN student s ON s.general_user_profilegup_id = gup.gup_id
                JOIN student_batches sb ON sb.students_id = s.s_id AND sb.course_cid = sps.course_cid
                WHERE sps.course_cid IN (321, 328, 331, 340)
                AND sb.total_due_fee != 0
                AND sb.is_active != 0
                """;
            
            Long total = ((Number) em.createNativeQuery(totalSql).getSingleResult()).longValue();
            Long inactive = ((Number) em.createNativeQuery(inactiveSql).getSingleResult()).longValue();
            Long active = ((Number) em.createNativeQuery(activeSql).getSingleResult()).longValue();
            
            java.util.Map<String, Object> result = new java.util.LinkedHashMap<>();
            result.put("totalRecords", total);
            result.put("fromInactiveBatches", inactive);
            result.put("fromActiveBatches", active);
            return result;
        } catch (Exception e) {
            logger.error("Error getting inactive batches count in overdue report", e);
            java.util.Map<String, Object> result = new java.util.LinkedHashMap<>();
            result.put("error", e.getMessage());
            return result;
        }
    }
    
    public List<java.util.Map<String, Object>> analyzeOverpaidStudents() {
        try {
            String sql = """
                SELECT 
                    gup.nic,
                    CONCAT(COALESCE(gup.first_name, ''), ' ', COALESCE(gup.last_name, '')) as student_name,
                    MAX(sps.discounted_fee) as payable_fee,
                    COALESCE(MAX(paid.total_paid), 0) as total_paid,
                    MAX(sb.total_due_fee) as total_due_fee_in_db,
                    (MAX(sps.discounted_fee) - COALESCE(MAX(paid.total_paid), 0)) as calculated_balance
                FROM scholarship_payment_scheduler sps
                JOIN general_user_profile gup ON sps.general_user_profile_gup_id = gup.gup_id
                JOIN student s ON s.general_user_profilegup_id = gup.gup_id
                JOIN student_batches sb ON sb.students_id = s.s_id AND sb.course_cid = sps.course_cid
                LEFT JOIN (
                    SELECT v.general_user_profilegup_id, SUM(vi.amount) as total_paid
                    FROM voucher v
                    JOIN voucher_item vi ON vi.vouchervid = v.vid
                    GROUP BY v.general_user_profilegup_id
                ) paid ON paid.general_user_profilegup_id = gup.gup_id
                WHERE sps.course_cid IN (321, 328, 331, 340)
                AND sb.total_due_fee != 0
                AND sb.is_active != 0
                GROUP BY gup.nic, gup.first_name, gup.last_name
                HAVING (MAX(sps.discounted_fee) - COALESCE(MAX(paid.total_paid), 0)) < 0
                ORDER BY calculated_balance ASC
                LIMIT 50
                """;
            
            List<Object[]> results = em.createNativeQuery(sql).getResultList();
            
            List<java.util.Map<String, Object>> report = new java.util.ArrayList<>();
            for (Object[] row : results) {
                java.util.Map<String, Object> record = new java.util.LinkedHashMap<>();
                int i = 0;
                record.put("nic", row[i++]);
                record.put("studentName", row[i++]);
                record.put("payableFee", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("totalPaid", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("totalDueFeeInDb", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                record.put("calculatedBalance", row[i] != null ? ((Number) row[i]).doubleValue() : 0.0); i++;
                report.add(record);
            }
            
            return report;
        } catch (Exception e) {
            logger.error("Error analyzing overpaid students", e);
            return new java.util.ArrayList<>();
        }
    }
}
