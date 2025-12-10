package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing universal_payment_manager table.
 * This is the central payment tracking table per student.
 */
@Entity
@Table(name = "universal_payment_manager")
@NamedQueries({
    @NamedQuery(name = "UniversalPaymentManager.findByGupId", 
                query = "SELECT u FROM UniversalPaymentManager u WHERE u.generalUserProfileGupId = :gupId AND u.isActive = true"),
    @NamedQuery(name = "UniversalPaymentManager.findWithDue", 
                query = "SELECT u FROM UniversalPaymentManager u WHERE u.totalDue > 0 AND u.isActive = true")
})
public class UniversalPaymentManager implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "scholarship")
    private Double scholarship;

    @Column(name = "full_payment")
    private Double fullPayment;

    @Column(name = "payable_amount")
    private Double payableAmount;

    @Column(name = "total_due")
    private Double totalDue;

    @Column(name = "paid_amount")
    private Double paidAmount;

    @Column(name = "general_user_profile_gup_id")
    private Integer generalUserProfileGupId;

    @Column(name = "scholarship_released_date")
    private LocalDate scholarshipReleasedDate;

    @Column(name = "is_portal_paid")
    private Boolean isPortalPaid;

    @Column(name = "is_id_card_paid")
    private Boolean isIdCardPaid;

    @Column(name = "is_university_paid")
    private Boolean isUniversityPaid;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "loan_started_date")
    private LocalDate loanStartedDate;

    @Column(name = "payment_option_id")
    private Integer paymentOptionId;

    @Column(name = "payment_option_type_id")
    private Integer paymentOptionTypeId;

    @Column(name = "payment_option_comment")
    private String paymentOptionComment;

    @Column(name = "branch_bid")
    private Integer branchBid;

    @Column(name = "paying_amount1")
    private Double payingAmount1;

    @Column(name = "paying_amount2")
    private Double payingAmount2;

    @Column(name = "paying_amount3")
    private Double payingAmount3;

    @Column(name = "scholarship_groups_id")
    private Integer scholarshipGroupsId;

    @Column(name = "student_payment_method_id")
    private Integer studentPaymentMethodId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Relationships
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "general_user_profile_gup_id", insertable = false, updatable = false)
    private GeneralUserProfile generalUserProfile;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payment_option_id", insertable = false, updatable = false)
    private PaymentOption paymentOption;

    // Getters only (read-only entity)
    public Integer getId() {
        return id;
    }

    public Double getScholarship() {
        return scholarship;
    }

    public Double getFullPayment() {
        return fullPayment;
    }

    public Double getPayableAmount() {
        return payableAmount;
    }

    public Double getTotalDue() {
        return totalDue;
    }

    public Double getPaidAmount() {
        return paidAmount;
    }

    public Integer getGeneralUserProfileGupId() {
        return generalUserProfileGupId;
    }

    public LocalDate getScholarshipReleasedDate() {
        return scholarshipReleasedDate;
    }

    public Boolean getIsPortalPaid() {
        return isPortalPaid;
    }

    public Boolean getIsIdCardPaid() {
        return isIdCardPaid;
    }

    public Boolean getIsUniversityPaid() {
        return isUniversityPaid;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public LocalDate getLoanStartedDate() {
        return loanStartedDate;
    }

    public Integer getPaymentOptionId() {
        return paymentOptionId;
    }

    public Integer getPaymentOptionTypeId() {
        return paymentOptionTypeId;
    }

    public String getPaymentOptionComment() {
        return paymentOptionComment;
    }

    public Integer getBranchBid() {
        return branchBid;
    }

    public Double getPayingAmount1() {
        return payingAmount1;
    }

    public Double getPayingAmount2() {
        return payingAmount2;
    }

    public Double getPayingAmount3() {
        return payingAmount3;
    }

    public Integer getScholarshipGroupsId() {
        return scholarshipGroupsId;
    }

    public Integer getStudentPaymentMethodId() {
        return studentPaymentMethodId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public GeneralUserProfile getGeneralUserProfile() {
        return generalUserProfile;
    }

    public PaymentOption getPaymentOption() {
        return paymentOption;
    }

    /**
     * Get scholarship percentage.
     */
    public Double getScholarshipPercentage() {
        return scholarship;
    }

    /**
     * Calculate balance due.
     */
    public Double getBalanceDue() {
        double payable = payableAmount != null ? payableAmount : 0.0;
        double paid = paidAmount != null ? paidAmount : 0.0;
        return payable - paid;
    }
}
