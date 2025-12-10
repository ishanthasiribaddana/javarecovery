package com.jiat.recovery.dto;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 * DTO for pending installment.
 * Represents an unpaid or partially paid installment.
 */
public class PendingInstallmentDTO {
    
    private Integer installmentId;
    private LocalDate dueDate;
    private Double toBePaidAmount;
    private Double paidAmount;
    private Double dueAmount;
    private String status; // OVERDUE, PARTIAL, PENDING
    private Integer daysOverdue;
    
    public PendingInstallmentDTO() {}
    
    public PendingInstallmentDTO(Object[] row) {
        int i = 0;
        this.installmentId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.dueDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.toBePaidAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.paidAmount = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.dueAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null;
        
        // Calculate status and days overdue
        LocalDate today = LocalDate.now();
        if (this.dueAmount != null && this.dueAmount > 0) {
            if (this.dueDate != null && this.dueDate.isBefore(today)) {
                this.daysOverdue = (int) ChronoUnit.DAYS.between(this.dueDate, today);
                this.status = this.paidAmount > 0 ? "PARTIAL" : "OVERDUE";
            } else {
                this.daysOverdue = 0;
                this.status = "PENDING";
            }
        } else {
            this.daysOverdue = 0;
            this.status = "PAID";
        }
    }
    
    // Getters and Setters
    public Integer getInstallmentId() { return installmentId; }
    public void setInstallmentId(Integer installmentId) { this.installmentId = installmentId; }
    
    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }
    
    public Double getToBePaidAmount() { return toBePaidAmount; }
    public void setToBePaidAmount(Double toBePaidAmount) { this.toBePaidAmount = toBePaidAmount; }
    
    public Double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(Double paidAmount) { this.paidAmount = paidAmount; }
    
    public Double getDueAmount() { return dueAmount; }
    public void setDueAmount(Double dueAmount) { this.dueAmount = dueAmount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Integer getDaysOverdue() { return daysOverdue; }
    public void setDaysOverdue(Integer daysOverdue) { this.daysOverdue = daysOverdue; }
}
