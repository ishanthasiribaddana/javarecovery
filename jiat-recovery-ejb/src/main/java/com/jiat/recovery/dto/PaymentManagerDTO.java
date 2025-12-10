package com.jiat.recovery.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * DTO for payment manager record.
 * Represents payment entries from student_payment_manager table.
 */
public class PaymentManagerDTO {
    
    private Integer id;
    private LocalDate paidDate;
    private Double enteredAmount;
    private Double approvedAmount;
    private Integer isApproved;
    private String document;
    private LocalDateTime enteredDate;
    
    public PaymentManagerDTO() {}
    
    public PaymentManagerDTO(Object[] row) {
        int i = 0;
        this.id = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.paidDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.enteredAmount = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.approvedAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.isApproved = row[i] != null ? ((Number) row[i]).intValue() : 0; i++;
        this.document = (String) row[i]; i++;
        if (row.length > i && row[i] != null) {
            if (row[i] instanceof java.sql.Timestamp) {
                this.enteredDate = ((java.sql.Timestamp) row[i]).toLocalDateTime();
            }
        }
    }
    
    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public LocalDate getPaidDate() { return paidDate; }
    public void setPaidDate(LocalDate paidDate) { this.paidDate = paidDate; }
    
    public Double getEnteredAmount() { return enteredAmount; }
    public void setEnteredAmount(Double enteredAmount) { this.enteredAmount = enteredAmount; }
    
    public Double getApprovedAmount() { return approvedAmount; }
    public void setApprovedAmount(Double approvedAmount) { this.approvedAmount = approvedAmount; }
    
    public Integer getIsApproved() { return isApproved; }
    public void setIsApproved(Integer isApproved) { this.isApproved = isApproved; }
    
    public String getDocument() { return document; }
    public void setDocument(String document) { this.document = document; }
    
    public LocalDateTime getEnteredDate() { return enteredDate; }
    public void setEnteredDate(LocalDateTime enteredDate) { this.enteredDate = enteredDate; }
    
    // Helper method for status
    public String getStatus() {
        if (isApproved == null) return "PENDING";
        return isApproved == 1 ? "APPROVED" : "PENDING";
    }
}
