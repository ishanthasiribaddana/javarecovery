package com.jiat.recovery.dto;

import java.util.ArrayList;
import java.util.List;

/**
 * DTO for payment schedule summary.
 * Contains payment option info, overdue summary, and installment lists.
 */
public class PaymentScheduleDTO {
    
    // Payment Option Info
    private Integer paymentOptionId;
    private String paymentOptionName;
    
    // Overdue Summary
    private Double totalOverdueAmount;
    private Integer totalDelayDays;
    private Integer overdueCount;
    
    // Upcoming Summary
    private Double totalUpcomingAmount;
    private Integer upcomingCount;
    
    // Installment Lists
    private List<InstallmentDTO> overdueInstallments;
    private List<InstallmentDTO> upcomingInstallments;
    
    // Payment History and Pending Installments
    private List<PaymentHistoryDTO> paymentHistory;
    private List<PendingInstallmentDTO> pendingInstallments;
    
    // Payment Manager History (for comparison)
    private List<PaymentManagerDTO> paymentManagerHistory;
    
    // Default constructor
    public PaymentScheduleDTO() {
        this.overdueInstallments = new ArrayList<>();
        this.upcomingInstallments = new ArrayList<>();
        this.paymentHistory = new ArrayList<>();
        this.pendingInstallments = new ArrayList<>();
        this.paymentManagerHistory = new ArrayList<>();
        this.totalOverdueAmount = 0.0;
        this.totalDelayDays = 0;
        this.overdueCount = 0;
        this.totalUpcomingAmount = 0.0;
        this.upcomingCount = 0;
    }
    
    // Constructor with payment option
    public PaymentScheduleDTO(Integer paymentOptionId, String paymentOptionName) {
        this();
        this.paymentOptionId = paymentOptionId;
        this.paymentOptionName = paymentOptionName;
    }
    
    /**
     * Add an overdue installment and update summary.
     */
    public void addOverdueInstallment(InstallmentDTO installment) {
        this.overdueInstallments.add(installment);
        this.overdueCount++;
        
        if (installment.getDueAmount() != null) {
            this.totalOverdueAmount += installment.getDueAmount();
        }
        
        if (installment.getDaysOverdue() != null) {
            this.totalDelayDays += installment.getDaysOverdue();
        }
    }
    
    /**
     * Add an upcoming installment and update summary.
     */
    public void addUpcomingInstallment(InstallmentDTO installment) {
        this.upcomingInstallments.add(installment);
        this.upcomingCount++;
        
        if (installment.getDueAmount() != null) {
            this.totalUpcomingAmount += installment.getDueAmount();
        }
    }
    
    // Getters and Setters
    public Integer getPaymentOptionId() {
        return paymentOptionId;
    }

    public void setPaymentOptionId(Integer paymentOptionId) {
        this.paymentOptionId = paymentOptionId;
    }

    public String getPaymentOptionName() {
        return paymentOptionName;
    }

    public void setPaymentOptionName(String paymentOptionName) {
        this.paymentOptionName = paymentOptionName;
    }

    public Double getTotalOverdueAmount() {
        return totalOverdueAmount;
    }

    public void setTotalOverdueAmount(Double totalOverdueAmount) {
        this.totalOverdueAmount = totalOverdueAmount;
    }

    public Integer getTotalDelayDays() {
        return totalDelayDays;
    }

    public void setTotalDelayDays(Integer totalDelayDays) {
        this.totalDelayDays = totalDelayDays;
    }

    public Integer getOverdueCount() {
        return overdueCount;
    }

    public void setOverdueCount(Integer overdueCount) {
        this.overdueCount = overdueCount;
    }

    public Double getTotalUpcomingAmount() {
        return totalUpcomingAmount;
    }

    public void setTotalUpcomingAmount(Double totalUpcomingAmount) {
        this.totalUpcomingAmount = totalUpcomingAmount;
    }

    public Integer getUpcomingCount() {
        return upcomingCount;
    }

    public void setUpcomingCount(Integer upcomingCount) {
        this.upcomingCount = upcomingCount;
    }

    public List<InstallmentDTO> getOverdueInstallments() {
        return overdueInstallments;
    }

    public void setOverdueInstallments(List<InstallmentDTO> overdueInstallments) {
        this.overdueInstallments = overdueInstallments;
    }

    public List<InstallmentDTO> getUpcomingInstallments() {
        return upcomingInstallments;
    }

    public void setUpcomingInstallments(List<InstallmentDTO> upcomingInstallments) {
        this.upcomingInstallments = upcomingInstallments;
    }
    
    public List<PaymentHistoryDTO> getPaymentHistory() {
        return paymentHistory;
    }

    public void setPaymentHistory(List<PaymentHistoryDTO> paymentHistory) {
        this.paymentHistory = paymentHistory;
    }

    public List<PendingInstallmentDTO> getPendingInstallments() {
        return pendingInstallments;
    }

    public void setPendingInstallments(List<PendingInstallmentDTO> pendingInstallments) {
        this.pendingInstallments = pendingInstallments;
    }
    
    public List<PaymentManagerDTO> getPaymentManagerHistory() {
        return paymentManagerHistory;
    }

    public void setPaymentManagerHistory(List<PaymentManagerDTO> paymentManagerHistory) {
        this.paymentManagerHistory = paymentManagerHistory;
    }
}
