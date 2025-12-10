package com.jiat.recovery.dto;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * DTO for calculation results.
 */
public class CalculationResult implements Serializable {

    private static final long serialVersionUID = 1L;

    private Double baseCourseFee;
    private Double scholarshipPercentage;
    private Double discountedAmount;
    private Double totalPaymentsDb;
    private Double totalPaymentsBank;
    private Double totalDue;
    private Double ukAwardsDueGbp;
    private Double convocationDue;
    private Double portalIdCardDue;
    private Map<String, Object> breakdown = new HashMap<>();

    // Getters and Setters
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

    public Map<String, Object> getBreakdown() {
        return breakdown;
    }

    public void setBreakdown(Map<String, Object> breakdown) {
        this.breakdown = breakdown;
    }

    /**
     * Get total payments from all sources.
     */
    public Double getTotalPayments() {
        double db = totalPaymentsDb != null ? totalPaymentsDb : 0.0;
        double bank = totalPaymentsBank != null ? totalPaymentsBank : 0.0;
        return db + bank;
    }

    /**
     * Get grand total due (LKR + GBP converted).
     */
    public Double getGrandTotalDue(Double gbpToLkrRate) {
        double lkrDue = totalDue != null ? totalDue : 0.0;
        double gbpDue = ukAwardsDueGbp != null ? ukAwardsDueGbp : 0.0;
        double gbpInLkr = gbpDue * (gbpToLkrRate != null ? gbpToLkrRate : 0.0);
        return lkrDue + gbpInLkr;
    }
}
