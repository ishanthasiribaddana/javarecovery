package com.jiat.recovery.dto;

import java.time.LocalDate;

/**
 * DTO for Overdue Students Report.
 * Contains student payment information for recovery tracking.
 */
public class OverdueStudentDTO {
    
    private Integer sId;
    private String nic;
    private String studentName;
    private String branchName;
    private String paymentOption;
    private Double scholarshipPercentage;
    private Boolean offerTaken;
    private Double offerPercentage;
    private Double totalPayable;
    private Double totalPaid;
    private Double totalDue;
    private Integer totalDelayDays;
    private LocalDate firstPaymentDate;
    private LocalDate lastPaymentDate;
    private LocalDate oldestOverdueDate;
    private Double recoverableAmount; // Amount to recover if offer is revoked
    
    public OverdueStudentDTO() {}
    
    /**
     * Constructor from native query result.
     * Expected column order:
     * 0: s_id, 1: nic, 2: student_name, 3: branch_name, 4: payment_option,
     * 5: scholarship_pct, 6: offer_taken, 7: offer_pct, 8: total_payable,
     * 9: total_paid, 10: total_due, 11: total_delay_days, 12: first_payment_date,
     * 13: last_payment_date, 14: oldest_overdue_date, 15: recoverable_amount
     */
    public OverdueStudentDTO(Object[] row) {
        int i = 0;
        this.sId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.nic = (String) row[i]; i++;
        this.studentName = (String) row[i]; i++;
        this.branchName = (String) row[i]; i++;
        this.paymentOption = (String) row[i]; i++;
        this.scholarshipPercentage = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.offerTaken = row[i] != null && (row[i] instanceof Boolean ? (Boolean) row[i] : ((Number) row[i]).intValue() == 1); i++;
        this.offerPercentage = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.totalPayable = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.totalPaid = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.totalDue = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        this.totalDelayDays = row[i] != null ? ((Number) row[i]).intValue() : 0; i++;
        this.firstPaymentDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.lastPaymentDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.oldestOverdueDate = row[i] != null ? ((java.sql.Date) row[i]).toLocalDate() : null; i++;
        this.recoverableAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null;
    }
    
    // Getters and Setters
    public Integer getSId() { return sId; }
    public void setSId(Integer sId) { this.sId = sId; }
    
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public String getBranchName() { return branchName; }
    public void setBranchName(String branchName) { this.branchName = branchName; }
    
    public String getPaymentOption() { return paymentOption; }
    public void setPaymentOption(String paymentOption) { this.paymentOption = paymentOption; }
    
    public Double getScholarshipPercentage() { return scholarshipPercentage; }
    public void setScholarshipPercentage(Double scholarshipPercentage) { this.scholarshipPercentage = scholarshipPercentage; }
    
    public Boolean getOfferTaken() { return offerTaken; }
    public void setOfferTaken(Boolean offerTaken) { this.offerTaken = offerTaken; }
    
    public Double getOfferPercentage() { return offerPercentage; }
    public void setOfferPercentage(Double offerPercentage) { this.offerPercentage = offerPercentage; }
    
    public Double getTotalPayable() { return totalPayable; }
    public void setTotalPayable(Double totalPayable) { this.totalPayable = totalPayable; }
    
    public Double getTotalPaid() { return totalPaid; }
    public void setTotalPaid(Double totalPaid) { this.totalPaid = totalPaid; }
    
    public Double getTotalDue() { return totalDue; }
    public void setTotalDue(Double totalDue) { this.totalDue = totalDue; }
    
    public Integer getTotalDelayDays() { return totalDelayDays; }
    public void setTotalDelayDays(Integer totalDelayDays) { this.totalDelayDays = totalDelayDays; }
    
    public LocalDate getFirstPaymentDate() { return firstPaymentDate; }
    public void setFirstPaymentDate(LocalDate firstPaymentDate) { this.firstPaymentDate = firstPaymentDate; }
    
    public LocalDate getLastPaymentDate() { return lastPaymentDate; }
    public void setLastPaymentDate(LocalDate lastPaymentDate) { this.lastPaymentDate = lastPaymentDate; }
    
    public LocalDate getOldestOverdueDate() { return oldestOverdueDate; }
    public void setOldestOverdueDate(LocalDate oldestOverdueDate) { this.oldestOverdueDate = oldestOverdueDate; }
    
    public Double getRecoverableAmount() { return recoverableAmount; }
    public void setRecoverableAmount(Double recoverableAmount) { this.recoverableAmount = recoverableAmount; }
}
