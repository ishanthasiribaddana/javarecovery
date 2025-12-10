package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.CaseStatus;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Recovery case entity - main tracking table for each student's recovery.
 */
@Entity
@Table(name = "recovery_case")
@NamedQueries({
    @NamedQuery(name = "RecoveryCase.findByStudentId", 
                query = "SELECT r FROM RecoveryCase r WHERE r.studentSId = :studentSId AND r.isActive = true"),
    @NamedQuery(name = "RecoveryCase.findByCaseNumber", 
                query = "SELECT r FROM RecoveryCase r WHERE r.caseNumber = :caseNumber AND r.isActive = true"),
    @NamedQuery(name = "RecoveryCase.findByStatus", 
                query = "SELECT r FROM RecoveryCase r WHERE r.status = :status AND r.isActive = true"),
    @NamedQuery(name = "RecoveryCase.findByOfficer", 
                query = "SELECT r FROM RecoveryCase r WHERE r.assignedOfficerId = :officerId AND r.isActive = true"),
    @NamedQuery(name = "RecoveryCase.findOpenCases", 
                query = "SELECT r FROM RecoveryCase r WHERE r.status IN ('OPEN', 'IN_PROGRESS', 'DISPUTED') AND r.isActive = true"),
    @NamedQuery(name = "RecoveryCase.countByStatus", 
                query = "SELECT r.status, COUNT(r) FROM RecoveryCase r WHERE r.isActive = true GROUP BY r.status")
})
public class RecoveryCase extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "student_s_id", nullable = false)
    private Integer studentSId;

    @Column(name = "case_number", unique = true, length = 50)
    private String caseNumber;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private CaseStatus status = CaseStatus.OPEN;

    @Column(name = "assigned_officer_id")
    private Long assignedOfficerId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "assigned_officer_id", insertable = false, updatable = false)
    private RecoverySystemUser assignedOfficer;

    @Column(name = "original_payment_option_id")
    private Integer originalPaymentOptionId;

    @Column(name = "original_scholarship_percentage")
    private Double originalScholarshipPercentage;

    @Column(name = "original_payable_amount")
    private Double originalPayableAmount;

    @Column(name = "current_calculated_due")
    private Double currentCalculatedDue;

    @Column(name = "last_calculation_date")
    private LocalDateTime lastCalculationDate;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @OneToMany(mappedBy = "recoveryCase", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RecoveryCalculation> calculations = new ArrayList<>();

    @OneToMany(mappedBy = "recoveryCase", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RecoveryGrievance> grievances = new ArrayList<>();

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getStudentSId() {
        return studentSId;
    }

    public void setStudentSId(Integer studentSId) {
        this.studentSId = studentSId;
    }

    public String getCaseNumber() {
        return caseNumber;
    }

    public void setCaseNumber(String caseNumber) {
        this.caseNumber = caseNumber;
    }

    public CaseStatus getStatus() {
        return status;
    }

    public void setStatus(CaseStatus status) {
        this.status = status;
    }

    public Long getAssignedOfficerId() {
        return assignedOfficerId;
    }

    public void setAssignedOfficerId(Long assignedOfficerId) {
        this.assignedOfficerId = assignedOfficerId;
    }

    public RecoverySystemUser getAssignedOfficer() {
        return assignedOfficer;
    }

    public void setAssignedOfficer(RecoverySystemUser assignedOfficer) {
        this.assignedOfficer = assignedOfficer;
    }

    public Integer getOriginalPaymentOptionId() {
        return originalPaymentOptionId;
    }

    public void setOriginalPaymentOptionId(Integer originalPaymentOptionId) {
        this.originalPaymentOptionId = originalPaymentOptionId;
    }

    public Double getOriginalScholarshipPercentage() {
        return originalScholarshipPercentage;
    }

    public void setOriginalScholarshipPercentage(Double originalScholarshipPercentage) {
        this.originalScholarshipPercentage = originalScholarshipPercentage;
    }

    public Double getOriginalPayableAmount() {
        return originalPayableAmount;
    }

    public void setOriginalPayableAmount(Double originalPayableAmount) {
        this.originalPayableAmount = originalPayableAmount;
    }

    public Double getCurrentCalculatedDue() {
        return currentCalculatedDue;
    }

    public void setCurrentCalculatedDue(Double currentCalculatedDue) {
        this.currentCalculatedDue = currentCalculatedDue;
    }

    public LocalDateTime getLastCalculationDate() {
        return lastCalculationDate;
    }

    public void setLastCalculationDate(LocalDateTime lastCalculationDate) {
        this.lastCalculationDate = lastCalculationDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public List<RecoveryCalculation> getCalculations() {
        return calculations;
    }

    public void setCalculations(List<RecoveryCalculation> calculations) {
        this.calculations = calculations;
    }

    public List<RecoveryGrievance> getGrievances() {
        return grievances;
    }

    public void setGrievances(List<RecoveryGrievance> grievances) {
        this.grievances = grievances;
    }

    // Helper methods
    public void addCalculation(RecoveryCalculation calculation) {
        calculations.add(calculation);
        calculation.setRecoveryCase(this);
    }

    public void addGrievance(RecoveryGrievance grievance) {
        grievances.add(grievance);
        grievance.setRecoveryCase(this);
    }

    /**
     * Generate case number in format REC-YYYY-NNNNN
     */
    public static String generateCaseNumber(int year, long sequence) {
        return String.format("REC-%d-%05d", year, sequence);
    }
}
