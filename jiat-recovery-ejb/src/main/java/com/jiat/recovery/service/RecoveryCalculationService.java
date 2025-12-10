package com.jiat.recovery.service;

import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.entity.RecoveryCalculation;
import com.jiat.recovery.entity.RecoveryFeeConfig;
import com.jiat.recovery.entity.RecoveryExchangeRate;
import com.jiat.recovery.entity.RecoveryDepositMatch;
import com.jiat.recovery.entity.enums.CalculationType;
import com.jiat.recovery.entity.readonly.Student;
import com.jiat.recovery.entity.readonly.UniversalPaymentManager;
import com.jiat.recovery.entity.readonly.Voucher;
import com.jiat.recovery.entity.readonly.CourseFeeChangedHistory;
import com.jiat.recovery.dto.CalculationResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * EJB Service for recovery calculation operations.
 * Core business logic for calculating student dues.
 */
@Stateless
public class RecoveryCalculationService {

    private static final Logger logger = LoggerFactory.getLogger(RecoveryCalculationService.class);
    
    // Scholarship percentages by payment option
    private static final double FULL_PAYMENT_SCHOLARSHIP = 70.0;
    private static final double YEARLY_PAYMENT_SCHOLARSHIP = 65.0;
    private static final double SEMESTER_PAYMENT_SCHOLARSHIP = 60.0;
    
    // Default course fee (Rs. 3,000,000)
    private static final double DEFAULT_COURSE_FEE = 3000000.0;

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    @EJB
    private StudentService studentService;

    @EJB
    private RecoveryCaseService recoveryCaseService;

    private final ObjectMapper objectMapper;

    public RecoveryCalculationService() {
        this.objectMapper = new ObjectMapper();
        this.objectMapper.registerModule(new JavaTimeModule());
    }

    /**
     * Calculate dues for a student and create a calculation record.
     */
    public RecoveryCalculation calculateDues(Long recoveryCaseId, CalculationType calculationType, Long calculatedBy) {
        RecoveryCase recoveryCase = em.find(RecoveryCase.class, recoveryCaseId);
        if (recoveryCase == null) {
            throw new IllegalArgumentException("Recovery case not found: " + recoveryCaseId);
        }

        Integer studentSId = recoveryCase.getStudentSId();
        Optional<Student> studentOpt = studentService.findById(studentSId);
        if (studentOpt.isEmpty()) {
            throw new IllegalArgumentException("Student not found: " + studentSId);
        }

        Student student = studentOpt.get();
        CalculationResult result = performCalculation(student, recoveryCase, calculationType);

        // Create calculation record
        RecoveryCalculation calculation = new RecoveryCalculation();
        calculation.setRecoveryCaseId(recoveryCaseId);
        calculation.setCalculationType(calculationType);
        calculation.setBaseCourseFee(result.getBaseCourseFee());
        calculation.setScholarshipPercentage(result.getScholarshipPercentage());
        calculation.setDiscountedAmount(result.getDiscountedAmount());
        calculation.setTotalPaymentsDb(result.getTotalPaymentsDb());
        calculation.setTotalPaymentsBank(result.getTotalPaymentsBank());
        calculation.setTotalDue(result.getTotalDue());
        calculation.setUkAwardsDueGbp(result.getUkAwardsDueGbp());
        calculation.setConvocationDue(result.getConvocationDue());
        calculation.setPortalIdCardDue(result.getPortalIdCardDue());
        calculation.setCalculatedBy(calculatedBy);
        calculation.setCalculationDate(LocalDateTime.now());

        // Store detailed breakdown as JSON
        try {
            calculation.setCalculationJson(objectMapper.writeValueAsString(result.getBreakdown()));
        } catch (Exception e) {
            logger.error("Failed to serialize calculation breakdown", e);
        }

        em.persist(calculation);

        // Update recovery case with latest calculation
        recoveryCaseService.updateCalculatedDue(recoveryCaseId, result.getTotalDue(), calculatedBy);

        logger.info("Created calculation for case {} with total due: {}", 
                recoveryCase.getCaseNumber(), result.getTotalDue());

        return calculation;
    }

    /**
     * Perform the actual calculation logic.
     */
    private CalculationResult performCalculation(Student student, RecoveryCase recoveryCase, CalculationType calculationType) {
        CalculationResult result = new CalculationResult();
        Map<String, Object> breakdown = new HashMap<>();

        // 1. Get base course fee
        double baseCourseFee = getCourseFee(student);
        result.setBaseCourseFee(baseCourseFee);
        breakdown.put("baseCourseFee", baseCourseFee);

        // 2. Determine scholarship percentage
        double scholarshipPercentage = determineScholarshipPercentage(student, recoveryCase, calculationType);
        result.setScholarshipPercentage(scholarshipPercentage);
        breakdown.put("scholarshipPercentage", scholarshipPercentage);

        // 3. Calculate discounted amount (after scholarship)
        double discountedAmount = baseCourseFee * (1 - scholarshipPercentage / 100);
        result.setDiscountedAmount(discountedAmount);
        breakdown.put("discountedAmount", discountedAmount);

        // 4. Get total payments from database
        double totalPaymentsDb = getTotalPaymentsFromDb(student);
        result.setTotalPaymentsDb(totalPaymentsDb);
        breakdown.put("totalPaymentsDb", totalPaymentsDb);

        // 5. Get total payments from bank reconciliation
        double totalPaymentsBank = getTotalPaymentsFromBank(student.getSId());
        result.setTotalPaymentsBank(totalPaymentsBank);
        breakdown.put("totalPaymentsBank", totalPaymentsBank);

        // 6. Calculate course fee due
        double courseFeeDue = discountedAmount - totalPaymentsDb - totalPaymentsBank;
        if (courseFeeDue < 0) courseFeeDue = 0;
        breakdown.put("courseFeeDue", courseFeeDue);

        // 7. Calculate additional fees
        double ukAwardsDue = calculateUkAwardsDue(student);
        result.setUkAwardsDueGbp(ukAwardsDue);
        breakdown.put("ukAwardsDueGbp", ukAwardsDue);

        double convocationDue = calculateConvocationDue(student);
        result.setConvocationDue(convocationDue);
        breakdown.put("convocationDue", convocationDue);

        double portalIdCardDue = calculatePortalIdCardDue(student);
        result.setPortalIdCardDue(portalIdCardDue);
        breakdown.put("portalIdCardDue", portalIdCardDue);

        // 8. Calculate total due (LKR only, UK Awards in GBP separate)
        double totalDue = courseFeeDue + convocationDue + portalIdCardDue;
        result.setTotalDue(totalDue);
        breakdown.put("totalDueLkr", totalDue);

        result.setBreakdown(breakdown);
        return result;
    }

    /**
     * Get course fee for student (considering historical changes).
     */
    private double getCourseFee(Student student) {
        if (student.getCourseFeeTotalDueAmount() != null && student.getCourseFeeTotalDueAmount() > 0) {
            return student.getCourseFeeTotalDueAmount();
        }

        // Try to get from course fee history
        if (student.getCourseCid() != null && student.getCreatedAt() != null) {
            TypedQuery<CourseFeeChangedHistory> query = em.createNamedQuery(
                "CourseFeeChangedHistory.findEffectiveOnDate", CourseFeeChangedHistory.class);
            query.setParameter("courseCid", student.getCourseCid());
            query.setParameter("date", student.getCreatedAt());
            query.setMaxResults(1);
            
            List<CourseFeeChangedHistory> results = query.getResultList();
            if (!results.isEmpty()) {
                return results.get(0).getAmount();
            }
        }

        return DEFAULT_COURSE_FEE;
    }

    /**
     * Determine scholarship percentage based on payment option and calculation type.
     */
    private double determineScholarshipPercentage(Student student, RecoveryCase recoveryCase, CalculationType calculationType) {
        // If default reversion, use full payment scholarship (highest)
        if (calculationType == CalculationType.DEFAULT_REVERSION) {
            return FULL_PAYMENT_SCHOLARSHIP;
        }

        // Try to get from recovery case (original scholarship)
        if (recoveryCase.getOriginalScholarshipPercentage() != null) {
            return recoveryCase.getOriginalScholarshipPercentage();
        }

        // Try to get from universal payment manager
        Optional<UniversalPaymentManager> upmOpt = studentService.getPaymentManagerByStudentId(student.getSId());
        if (upmOpt.isPresent() && upmOpt.get().getScholarship() != null) {
            return upmOpt.get().getScholarship();
        }

        // Default to semester payment scholarship
        return SEMESTER_PAYMENT_SCHOLARSHIP;
    }

    /**
     * Get total payments from database (vouchers).
     */
    private double getTotalPaymentsFromDb(Student student) {
        if (student.getGeneralUserProfileGupId() == null) {
            return 0.0;
        }

        try {
            TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(v.totalPaid), 0) FROM Voucher v " +
                "WHERE v.generalUserProfileGupId = :gupId AND v.isActive = 1",
                Double.class);
            query.setParameter("gupId", student.getGeneralUserProfileGupId());
            Double result = query.getSingleResult();
            return result != null ? result : 0.0;
        } catch (Exception e) {
            logger.error("Error getting total payments from DB for student: {}", student.getSId(), e);
            return 0.0;
        }
    }

    /**
     * Get total payments from bank reconciliation.
     */
    private double getTotalPaymentsFromBank(Integer studentSId) {
        try {
            TypedQuery<Double> query = em.createQuery(
                "SELECT COALESCE(SUM(b.amount), 0) FROM RecoveryBankStatementImport b " +
                "JOIN RecoveryDepositMatch m ON m.bankStatementImportId = b.id " +
                "WHERE m.studentSId = :studentSId AND m.verified = true AND b.isActive = true",
                Double.class);
            query.setParameter("studentSId", studentSId);
            Double result = query.getSingleResult();
            return result != null ? result : 0.0;
        } catch (Exception e) {
            logger.error("Error getting total payments from bank for student: {}", studentSId, e);
            return 0.0;
        }
    }

    /**
     * Calculate UK Awards due (in GBP).
     */
    private double calculateUkAwardsDue(Student student) {
        // Get UK Awards fee configurations
        List<RecoveryFeeConfig> ukFees = em.createQuery(
            "SELECT f FROM RecoveryFeeConfig f WHERE f.feeCode LIKE 'UK_AWARDS%' AND f.isActive = true",
            RecoveryFeeConfig.class).getResultList();

        double totalDue = 0.0;
        for (RecoveryFeeConfig fee : ukFees) {
            // TODO: Check if student has paid this level
            // For now, return total UK Awards fees
            totalDue += fee.getAmount();
        }

        return totalDue;
    }

    /**
     * Calculate convocation fee due.
     */
    private double calculateConvocationDue(Student student) {
        // Check if student is eligible for convocation
        // TODO: Implement eligibility check
        
        Optional<RecoveryFeeConfig> convocationFee = findFeeConfig("CONVOCATION");
        if (convocationFee.isPresent()) {
            // TODO: Check if already paid
            return convocationFee.get().getAmount();
        }
        return 0.0;
    }

    /**
     * Calculate portal and ID card fees due.
     */
    private double calculatePortalIdCardDue(Student student) {
        double totalDue = 0.0;

        // Check portal payment
        Optional<UniversalPaymentManager> upmOpt = studentService.getPaymentManagerByStudentId(student.getSId());
        if (upmOpt.isPresent()) {
            UniversalPaymentManager upm = upmOpt.get();
            
            // Portal fee (4 years)
            if (!Boolean.TRUE.equals(upm.getIsPortalPaid())) {
                Optional<RecoveryFeeConfig> portalFee = findFeeConfig("PORTAL_YEARLY");
                if (portalFee.isPresent()) {
                    totalDue += portalFee.get().getAmount() * 4; // 4 years
                }
            }

            // ID Card fee
            if (!Boolean.TRUE.equals(upm.getIsIdCardPaid())) {
                Optional<RecoveryFeeConfig> idCardFee = findFeeConfig("ID_CARD");
                if (idCardFee.isPresent()) {
                    totalDue += idCardFee.get().getAmount();
                }
            }
        }

        return totalDue;
    }

    /**
     * Find fee configuration by code.
     */
    private Optional<RecoveryFeeConfig> findFeeConfig(String feeCode) {
        try {
            TypedQuery<RecoveryFeeConfig> query = em.createNamedQuery(
                "RecoveryFeeConfig.findByCode", RecoveryFeeConfig.class);
            query.setParameter("feeCode", feeCode);
            List<RecoveryFeeConfig> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding fee config: {}", feeCode, e);
            return Optional.empty();
        }
    }

    /**
     * Get latest exchange rate for GBP to LKR.
     */
    public Optional<RecoveryExchangeRate> getLatestGbpToLkrRate() {
        try {
            TypedQuery<RecoveryExchangeRate> query = em.createNamedQuery(
                "RecoveryExchangeRate.findLatest", RecoveryExchangeRate.class);
            query.setParameter("fromCurrencyId", 2); // GBP
            query.setParameter("toCurrencyId", 1);   // LKR
            query.setMaxResults(1);
            List<RecoveryExchangeRate> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error getting latest exchange rate", e);
            return Optional.empty();
        }
    }

    /**
     * Approve a calculation.
     */
    public RecoveryCalculation approveCalculation(Long calculationId, Long approvedBy) {
        RecoveryCalculation calculation = em.find(RecoveryCalculation.class, calculationId);
        if (calculation == null) {
            throw new IllegalArgumentException("Calculation not found: " + calculationId);
        }

        calculation.approve(approvedBy);
        em.merge(calculation);

        logger.info("Approved calculation {}", calculationId);
        return calculation;
    }

    /**
     * Find calculations by case ID.
     */
    public List<RecoveryCalculation> findByCaseId(Long caseId) {
        TypedQuery<RecoveryCalculation> query = em.createNamedQuery(
            "RecoveryCalculation.findByCaseId", RecoveryCalculation.class);
        query.setParameter("caseId", caseId);
        return query.getResultList();
    }

    /**
     * Find latest calculation for a case.
     */
    public Optional<RecoveryCalculation> findLatestByCaseId(Long caseId) {
        TypedQuery<RecoveryCalculation> query = em.createNamedQuery(
            "RecoveryCalculation.findLatestByCaseId", RecoveryCalculation.class);
        query.setParameter("caseId", caseId);
        query.setMaxResults(1);
        List<RecoveryCalculation> results = query.getResultList();
        return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
    }
}
