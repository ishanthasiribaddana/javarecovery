package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.CalculationType;
import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Recovery calculation entity - stores AI-generated calculations with audit trail.
 */
@Entity
@Table(name = "recovery_calculation")
@NamedQueries({
    @NamedQuery(name = "RecoveryCalculation.findByCaseId", 
                query = "SELECT c FROM RecoveryCalculation c WHERE c.recoveryCaseId = :caseId AND c.isActive = true ORDER BY c.calculationDate DESC"),
    @NamedQuery(name = "RecoveryCalculation.findLatestByCaseId", 
                query = "SELECT c FROM RecoveryCalculation c WHERE c.recoveryCaseId = :caseId AND c.isActive = true ORDER BY c.calculationDate DESC"),
    @NamedQuery(name = "RecoveryCalculation.findApprovedByCaseId", 
                query = "SELECT c FROM RecoveryCalculation c WHERE c.recoveryCaseId = :caseId AND c.isApproved = true AND c.isActive = true"),
    @NamedQuery(name = "RecoveryCalculation.findPendingApproval", 
                query = "SELECT c FROM RecoveryCalculation c WHERE c.isApproved = false AND c.isActive = true ORDER BY c.calculationDate DESC")
})
public class RecoveryCalculation extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "recovery_case_id", nullable = false)
    private Long recoveryCaseId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recovery_case_id", insertable = false, updatable = false)
    private RecoveryCase recoveryCase;

    @Enumerated(EnumType.STRING)
    @Column(name = "calculation_type", nullable = false)
    private CalculationType calculationType;

    @Column(name = "base_course_fee")
    private Double baseCourseFee;

    @Column(name = "scholarship_percentage")
    private Double scholarshipPercentage;

    @Column(name = "discounted_amount")
    private Double discountedAmount;

    @Column(name = "total_payments_db")
    private Double totalPaymentsDb;

    @Column(name = "total_payments_bank")
    private Double totalPaymentsBank;

    @Column(name = "total_due")
    private Double totalDue;

    @Column(name = "uk_awards_due_gbp")
    private Double ukAwardsDueGbp;

    @Column(name = "convocation_due")
    private Double convocationDue;

    @Column(name = "portal_id_card_due")
    private Double portalIdCardDue;

    @Column(name = "calculation_json", columnDefinition = "TEXT")
    private String calculationJson;

    @Column(name = "ai_explanation", columnDefinition = "TEXT")
    private String aiExplanation;

    @Column(name = "calculated_by")
    private Long calculatedBy;

    @Column(name = "calculation_date")
    private LocalDateTime calculationDate;

    @Column(name = "is_approved")
    private Boolean isApproved = false;

    @Column(name = "approved_by")
    private Long approvedBy;

    @Column(name = "approved_date")
    private LocalDateTime approvedDate;

    @PrePersist
    @Override
    protected void onCreate() {
        super.onCreate();
        if (this.calculationDate == null) {
            this.calculationDate = LocalDateTime.now();
        }
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRecoveryCaseId() {
        return recoveryCaseId;
    }

    public void setRecoveryCaseId(Long recoveryCaseId) {
        this.recoveryCaseId = recoveryCaseId;
    }

    public RecoveryCase getRecoveryCase() {
        return recoveryCase;
    }

    public void setRecoveryCase(RecoveryCase recoveryCase) {
        this.recoveryCase = recoveryCase;
        if (recoveryCase != null) {
            this.recoveryCaseId = recoveryCase.getId();
        }
    }

    public CalculationType getCalculationType() {
        return calculationType;
    }

    public void setCalculationType(CalculationType calculationType) {
        this.calculationType = calculationType;
    }

    public Double getBaseCourseFee() {
        return baseCourseFee;
    }

    public void setBaseCourseFee(Double baseCourseFee) {
        this.baseCourseFee = baseCourseFee;
    }

    public Double getScholarshipPercentage() {
        return scholarshipPercentage;
    }

    public void setScholarshipPercentage(Double scholarshipPercentage) {
        this.scholarshipPercentage = scholarshipPercentage;
    }

    public Double getDiscountedAmount() {
        return discountedAmount;
    }

    public void setDiscountedAmount(Double discountedAmount) {
        this.discountedAmount = discountedAmount;
    }

    public Double getTotalPaymentsDb() {
        return totalPaymentsDb;
    }

    public void setTotalPaymentsDb(Double totalPaymentsDb) {
        this.totalPaymentsDb = totalPaymentsDb;
    }

    public Double getTotalPaymentsBank() {
        return totalPaymentsBank;
    }

    public void setTotalPaymentsBank(Double totalPaymentsBank) {
        this.totalPaymentsBank = totalPaymentsBank;
    }

    public Double getTotalDue() {
        return totalDue;
    }

    public void setTotalDue(Double totalDue) {
        this.totalDue = totalDue;
    }

    public Double getUkAwardsDueGbp() {
        return ukAwardsDueGbp;
    }

    public void setUkAwardsDueGbp(Double ukAwardsDueGbp) {
        this.ukAwardsDueGbp = ukAwardsDueGbp;
    }

    public Double getConvocationDue() {
        return convocationDue;
    }

    public void setConvocationDue(Double convocationDue) {
        this.convocationDue = convocationDue;
    }

    public Double getPortalIdCardDue() {
        return portalIdCardDue;
    }

    public void setPortalIdCardDue(Double portalIdCardDue) {
        this.portalIdCardDue = portalIdCardDue;
    }

    public String getCalculationJson() {
        return calculationJson;
    }

    public void setCalculationJson(String calculationJson) {
        this.calculationJson = calculationJson;
    }

    public String getAiExplanation() {
        return aiExplanation;
    }

    public void setAiExplanation(String aiExplanation) {
        this.aiExplanation = aiExplanation;
    }

    public Long getCalculatedBy() {
        return calculatedBy;
    }

    public void setCalculatedBy(Long calculatedBy) {
        this.calculatedBy = calculatedBy;
    }

    public LocalDateTime getCalculationDate() {
        return calculationDate;
    }

    public void setCalculationDate(LocalDateTime calculationDate) {
        this.calculationDate = calculationDate;
    }

    public Boolean getIsApproved() {
        return isApproved;
    }

    public void setIsApproved(Boolean isApproved) {
        this.isApproved = isApproved;
    }

    public Long getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(Long approvedBy) {
        this.approvedBy = approvedBy;
    }

    public LocalDateTime getApprovedDate() {
        return approvedDate;
    }

    public void setApprovedDate(LocalDateTime approvedDate) {
        this.approvedDate = approvedDate;
    }

    /**
     * Calculate total payments from all sources.
     */
    public Double getTotalPayments() {
        double dbPayments = totalPaymentsDb != null ? totalPaymentsDb : 0.0;
        double bankPayments = totalPaymentsBank != null ? totalPaymentsBank : 0.0;
        return dbPayments + bankPayments;
    }

    /**
     * Approve this calculation.
     */
    public void approve(Long approverId) {
        this.isApproved = true;
        this.approvedBy = approverId;
        this.approvedDate = LocalDateTime.now();
    }
}
