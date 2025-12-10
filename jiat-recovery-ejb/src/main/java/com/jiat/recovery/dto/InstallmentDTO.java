package com.jiat.recovery.dto;

import java.time.LocalDate;

/**
 * DTO for individual installment data in payment schedule.
 * Contains both raw data from database and calculated fields.
 */
public class InstallmentDTO {
    
    // Database fields
    private Integer id;
    private Integer installmentNumber;
    private LocalDate dateToBePaid;
    private Double toBePaidAmount;
    private Double paidAmount;
    private Double dueAmount;
    private Double discount;
    
    // Calculated fields
    private String description;        // e.g., "Year 1 - Installment 2"
    private Integer daysOverdue;       // null if not overdue
    private Integer daysUntilDue;      // null if overdue
    private Boolean showCountdown;     // Based on payment option logic
    
    // Default constructor
    public InstallmentDTO() {
    }
    
    // Constructor from database row
    public InstallmentDTO(Object[] row, int paymentOptionId, int installmentNumber, LocalDate today) {
        int i = 0;
        
        // id
        if (row[i] != null) {
            this.id = ((Number) row[i]).intValue();
        }
        i++;
        
        // date_to_be_paid
        if (row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.dateToBePaid = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.dateToBePaid = (LocalDate) row[i];
            }
        }
        i++;
        
        // to_be_paid_amount
        if (row[i] != null) {
            this.toBePaidAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // paid_amount
        if (row[i] != null) {
            this.paidAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // due_amount
        if (row[i] != null) {
            this.dueAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // discount
        if (row.length > i && row[i] != null) {
            this.discount = ((Number) row[i]).doubleValue();
        }
        
        // Set installment number
        this.installmentNumber = installmentNumber;
        
        // Generate description based on payment option
        this.description = generateDescription(paymentOptionId, installmentNumber);
        
        // Calculate days overdue or days until due
        if (this.dateToBePaid != null && today != null) {
            long daysDiff = java.time.temporal.ChronoUnit.DAYS.between(this.dateToBePaid, today);
            
            if (daysDiff > 0) {
                // Overdue
                this.daysOverdue = (int) daysDiff;
                this.daysUntilDue = null;
                this.showCountdown = false;
            } else {
                // Upcoming
                this.daysOverdue = null;
                this.daysUntilDue = (int) Math.abs(daysDiff);
                
                // Determine if countdown should be shown
                // Full Payment (1): Always show countdown
                // Yearly (2) / Semester (3): Show countdown only within 14 days
                if (paymentOptionId == 1) {
                    this.showCountdown = true;
                } else {
                    this.showCountdown = this.daysUntilDue <= 14;
                }
            }
        }
    }
    
    /**
     * Generate installment description based on payment option.
     * Full Payment: "Installment 1", "Installment 2"
     * Yearly: "Year 1", "Year 2", "Year 3", "Year 4"
     * Semester: "Semester 1", "Semester 2", ... "Semester 8"
     */
    private String generateDescription(int paymentOptionId, int installmentNumber) {
        switch (paymentOptionId) {
            case 1: // Full Payment
                return "Installment " + installmentNumber;
            case 2: // Yearly Payment
                return "Year " + installmentNumber;
            case 3: // Semester Payment
                return "Semester " + installmentNumber;
            default:
                return "Installment " + installmentNumber;
        }
    }
    
    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getInstallmentNumber() {
        return installmentNumber;
    }

    public void setInstallmentNumber(Integer installmentNumber) {
        this.installmentNumber = installmentNumber;
    }

    public LocalDate getDateToBePaid() {
        return dateToBePaid;
    }

    public void setDateToBePaid(LocalDate dateToBePaid) {
        this.dateToBePaid = dateToBePaid;
    }

    public Double getToBePaidAmount() {
        return toBePaidAmount;
    }

    public void setToBePaidAmount(Double toBePaidAmount) {
        this.toBePaidAmount = toBePaidAmount;
    }

    public Double getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(Double paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Double getDueAmount() {
        return dueAmount;
    }

    public void setDueAmount(Double dueAmount) {
        this.dueAmount = dueAmount;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getDaysOverdue() {
        return daysOverdue;
    }

    public void setDaysOverdue(Integer daysOverdue) {
        this.daysOverdue = daysOverdue;
    }

    public Integer getDaysUntilDue() {
        return daysUntilDue;
    }

    public void setDaysUntilDue(Integer daysUntilDue) {
        this.daysUntilDue = daysUntilDue;
    }

    public Boolean getShowCountdown() {
        return showCountdown;
    }

    public void setShowCountdown(Boolean showCountdown) {
        this.showCountdown = showCountdown;
    }
}
