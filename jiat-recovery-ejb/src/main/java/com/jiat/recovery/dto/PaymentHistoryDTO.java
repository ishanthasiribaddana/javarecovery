package com.jiat.recovery.dto;

import java.time.LocalDate;

/**
 * DTO for payment history record.
 * Represents payment data from voucher_item table via student_batches -> voucher -> voucher_item path.
 * Only includes Invoice, Receipt, Sales Invoice voucher types.
 */
public class PaymentHistoryDTO {
    
    private String voucherItemId;
    private LocalDate dueDate;
    private String description;
    private Double paidAmount;
    private Double dueAmount;
    private Double discount;
    private Double lkrEquivalent; // For GBP payments, this is the LKR equivalent amount
    private boolean isInternational; // True if this is a GBP/international payment
    private Integer courseId; // Course ID from student_batches
    private Double gbpEquivalent; // LKR amount converted to GBP using exchange rate on payment date
    private Double exchangeRateUsed; // The GBP-LKR exchange rate used for conversion
    
    public PaymentHistoryDTO() {}
    
    public PaymentHistoryDTO(Object[] row) {
        int i = 0;
        this.voucherItemId = row[i] != null ? row[i].toString() : null; i++;
        this.dueDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.description = row[i] != null ? row[i].toString().trim() : null; i++;
        this.paidAmount = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.dueAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.discount = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.lkrEquivalent = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.courseId = row[i] != null ? ((Number) row[i]).intValue() : null;
        // If lkrEquivalent is set OR courseId is 410 (International University Payment), this is an international payment
        this.isInternational = (this.lkrEquivalent != null && this.lkrEquivalent > 0) || (this.courseId != null && this.courseId == 410);
    }
    
    // Getters and Setters
    public String getVoucherItemId() { return voucherItemId; }
    public void setVoucherItemId(String voucherItemId) { this.voucherItemId = voucherItemId; }
    
    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(Double paidAmount) { this.paidAmount = paidAmount; }
    
    public Double getDueAmount() { return dueAmount; }
    public void setDueAmount(Double dueAmount) { this.dueAmount = dueAmount; }
    
    public Double getDiscount() { return discount; }
    public void setDiscount(Double discount) { this.discount = discount; }
    
    public Double getLkrEquivalent() { return lkrEquivalent; }
    public void setLkrEquivalent(Double lkrEquivalent) { this.lkrEquivalent = lkrEquivalent; }
    
    public boolean isInternational() { return isInternational; }
    public void setInternational(boolean international) { isInternational = international; }
    
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    
    public Double getGbpEquivalent() { return gbpEquivalent; }
    public void setGbpEquivalent(Double gbpEquivalent) { this.gbpEquivalent = gbpEquivalent; }
    
    public Double getExchangeRateUsed() { return exchangeRateUsed; }
    public void setExchangeRateUsed(Double exchangeRateUsed) { this.exchangeRateUsed = exchangeRateUsed; }
}
