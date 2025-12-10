package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing voucher table.
 * Vouchers represent payment transactions.
 */
@Entity
@Table(name = "voucher")
@NamedQueries({
    @NamedQuery(name = "Voucher.findByGupId", 
                query = "SELECT v FROM Voucher v WHERE v.generalUserProfileGupId = :gupId AND v.isActive = 1 ORDER BY v.date DESC"),
    @NamedQuery(name = "Voucher.findByDateRange", 
                query = "SELECT v FROM Voucher v WHERE v.date BETWEEN :startDate AND :endDate AND v.isActive = 1 ORDER BY v.date DESC")
})
public class Voucher implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "vid")
    private Integer vid;

    @Column(name = "id")
    private String voucherId;

    @Column(name = "description")
    private String description;

    @Column(name = "date")
    private LocalDate date;

    @Column(name = "voucher_total")
    private Double voucherTotal;

    @Column(name = "general_user_profilegup_id")
    private Integer generalUserProfileGupId;

    @Column(name = "voucher_typevt_id")
    private Integer voucherTypeVtId;

    @Column(name = "branch_bid")
    private Integer branchBid;

    @Column(name = "is_active")
    private Integer isActive;

    @Column(name = "payment_date")
    private LocalDate paymentDate;

    @Column(name = "due")
    private Double due;

    @Column(name = "total_paid")
    private Double totalPaid;

    @Column(name = "is_completed")
    private Boolean isCompleted;

    @Column(name = "payment_mode_payment_mode_id")
    private Integer paymentModeId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters only
    public Integer getVid() {
        return vid;
    }

    public String getVoucherId() {
        return voucherId;
    }

    public String getDescription() {
        return description;
    }

    public LocalDate getDate() {
        return date;
    }

    public Double getVoucherTotal() {
        return voucherTotal;
    }

    public Integer getGeneralUserProfileGupId() {
        return generalUserProfileGupId;
    }

    public Integer getVoucherTypeVtId() {
        return voucherTypeVtId;
    }

    public Integer getBranchBid() {
        return branchBid;
    }

    public Integer getIsActive() {
        return isActive;
    }

    public LocalDate getPaymentDate() {
        return paymentDate;
    }

    public Double getDue() {
        return due;
    }

    public Double getTotalPaid() {
        return totalPaid;
    }

    public Boolean getIsCompleted() {
        return isCompleted;
    }

    public Integer getPaymentModeId() {
        return paymentModeId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }
}
