package com.jiat.recovery.dto;

import java.time.LocalDate;

/**
 * DTO for payment reconciliation records.
 * Used to compare voucher_item vs student_batches.total_paid_amount data.
 * Note: Field names like spsdPaidTotal/spsdCount are kept for backward compatibility
 * but now contain student_batches data.
 */
public class PaymentReconciliationDTO {
    
    private Integer sId;
    private String nic;
    private String studentName;
    private Double voucherItemTotal;
    private Double spsdPaidTotal;
    private Double difference;
    private Integer voucherCount;
    private Integer spsdCount;
    private String status; // MATCH, VOUCHER_ONLY, SPSD_ONLY, MISMATCH
    private String voucherTypes; // Comma-separated voucher types
    
    public PaymentReconciliationDTO() {}
    
    public PaymentReconciliationDTO(Object[] row) {
        int i = 0;
        this.sId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.nic = (String) row[i]; i++;
        this.studentName = (String) row[i]; i++;
        this.voucherItemTotal = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.spsdPaidTotal = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.difference = row[i] != null ? ((Number) row[i]).doubleValue() : 0.0; i++;
        this.voucherCount = row[i] != null ? ((Number) row[i]).intValue() : 0; i++;
        this.spsdCount = row[i] != null ? ((Number) row[i]).intValue() : 0; i++;
        this.voucherTypes = row.length > i && row[i] != null ? (String) row[i] : "";
        
        // Determine status
        if (Math.abs(this.difference) <= 100) {
            this.status = "MATCH";
        } else if (this.voucherItemTotal > 0 && this.spsdPaidTotal == 0) {
            this.status = "VOUCHER_ONLY";
        } else if (this.voucherItemTotal == 0 && this.spsdPaidTotal > 0) {
            this.status = "SPSD_ONLY";
        } else if (this.difference > 0) {
            this.status = "VOUCHER_EXCESS";
        } else {
            this.status = "SPSD_EXCESS";
        }
    }
    
    // Getters and Setters
    public Integer getSId() { return sId; }
    public void setSId(Integer sId) { this.sId = sId; }
    
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
    
    public Double getVoucherItemTotal() { return voucherItemTotal; }
    public void setVoucherItemTotal(Double voucherItemTotal) { this.voucherItemTotal = voucherItemTotal; }
    
    public Double getSpsdPaidTotal() { return spsdPaidTotal; }
    public void setSpsdPaidTotal(Double spsdPaidTotal) { this.spsdPaidTotal = spsdPaidTotal; }
    
    public Double getDifference() { return difference; }
    public void setDifference(Double difference) { this.difference = difference; }
    
    public Integer getVoucherCount() { return voucherCount; }
    public void setVoucherCount(Integer voucherCount) { this.voucherCount = voucherCount; }
    
    public Integer getSpsdCount() { return spsdCount; }
    public void setSpsdCount(Integer spsdCount) { this.spsdCount = spsdCount; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getVoucherTypes() { return voucherTypes; }
    public void setVoucherTypes(String voucherTypes) { this.voucherTypes = voucherTypes; }
}
