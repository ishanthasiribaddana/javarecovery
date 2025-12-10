package com.jiat.recovery.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

/**
 * Fee configuration entity - UK Awards, Convocation, Portal fees.
 */
@Entity
@Table(name = "recovery_fee_config")
@NamedQueries({
    @NamedQuery(name = "RecoveryFeeConfig.findByCode", 
                query = "SELECT f FROM RecoveryFeeConfig f WHERE f.feeCode = :feeCode AND f.isActive = true"),
    @NamedQuery(name = "RecoveryFeeConfig.findEffective", 
                query = "SELECT f FROM RecoveryFeeConfig f WHERE f.isActive = true AND (f.effectiveFrom IS NULL OR f.effectiveFrom <= :date) AND (f.effectiveTo IS NULL OR f.effectiveTo >= :date)"),
    @NamedQuery(name = "RecoveryFeeConfig.findByCurrency", 
                query = "SELECT f FROM RecoveryFeeConfig f WHERE f.currencyTypeId = :currencyTypeId AND f.isActive = true"),
    @NamedQuery(name = "RecoveryFeeConfig.findMandatory", 
                query = "SELECT f FROM RecoveryFeeConfig f WHERE f.isMandatory = true AND f.isActive = true")
})
public class RecoveryFeeConfig extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "fee_code", unique = true, nullable = false, length = 50)
    private String feeCode;

    @Column(name = "fee_name", nullable = false)
    private String feeName;

    @Column(name = "amount", nullable = false)
    private Double amount;

    @Column(name = "currency_type_id")
    private Integer currencyTypeId = 1; // Default LKR

    @Column(name = "effective_from")
    private LocalDate effectiveFrom;

    @Column(name = "effective_to")
    private LocalDate effectiveTo;

    @Column(name = "is_mandatory")
    private Boolean isMandatory = true;

    @Column(name = "applies_to")
    private String appliesTo = "ALL"; // ALL, GRADUATING, SPECIFIC_COURSE

    @Column(name = "course_cid")
    private Integer courseCid;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFeeCode() {
        return feeCode;
    }

    public void setFeeCode(String feeCode) {
        this.feeCode = feeCode;
    }

    public String getFeeName() {
        return feeName;
    }

    public void setFeeName(String feeName) {
        this.feeName = feeName;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Integer getCurrencyTypeId() {
        return currencyTypeId;
    }

    public void setCurrencyTypeId(Integer currencyTypeId) {
        this.currencyTypeId = currencyTypeId;
    }

    public LocalDate getEffectiveFrom() {
        return effectiveFrom;
    }

    public void setEffectiveFrom(LocalDate effectiveFrom) {
        this.effectiveFrom = effectiveFrom;
    }

    public LocalDate getEffectiveTo() {
        return effectiveTo;
    }

    public void setEffectiveTo(LocalDate effectiveTo) {
        this.effectiveTo = effectiveTo;
    }

    public Boolean getIsMandatory() {
        return isMandatory;
    }

    public void setIsMandatory(Boolean isMandatory) {
        this.isMandatory = isMandatory;
    }

    public String getAppliesTo() {
        return appliesTo;
    }

    public void setAppliesTo(String appliesTo) {
        this.appliesTo = appliesTo;
    }

    public Integer getCourseCid() {
        return courseCid;
    }

    public void setCourseCid(Integer courseCid) {
        this.courseCid = courseCid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Check if this fee is effective on a given date.
     */
    public boolean isEffectiveOn(LocalDate date) {
        if (effectiveFrom != null && date.isBefore(effectiveFrom)) {
            return false;
        }
        if (effectiveTo != null && date.isAfter(effectiveTo)) {
            return false;
        }
        return true;
    }

    /**
     * Check if this is a GBP fee.
     */
    public boolean isGbpFee() {
        return currencyTypeId != null && currencyTypeId == 2; // Assuming 2 = GBP
    }
}
