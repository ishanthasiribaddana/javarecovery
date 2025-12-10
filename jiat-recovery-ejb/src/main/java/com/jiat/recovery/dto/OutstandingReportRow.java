package com.jiat.recovery.dto;

import java.io.Serializable;

/**
 * DTO for outstanding report row data.
 */
public class OutstandingReportRow implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;
    private String nic;
    private String studentName;
    private Double scholarshipPercentage;
    private Double courseFee;
    private Double payableAmount;
    private Double paidAmount;
    private Double balanceDue;

    public OutstandingReportRow() {}

    public OutstandingReportRow(Long id, String nic, String studentName, Double scholarshipPercentage,
                                 Double courseFee, Double payableAmount, Double paidAmount, Double balanceDue) {
        this.id = id;
        this.nic = nic;
        this.studentName = studentName;
        this.scholarshipPercentage = scholarshipPercentage;
        this.courseFee = courseFee;
        this.payableAmount = payableAmount;
        this.paidAmount = paidAmount;
        this.balanceDue = balanceDue;
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public Double getScholarshipPercentage() { return scholarshipPercentage; }
    public void setScholarshipPercentage(Double scholarshipPercentage) { this.scholarshipPercentage = scholarshipPercentage; }

    public Double getCourseFee() { return courseFee; }
    public void setCourseFee(Double courseFee) { this.courseFee = courseFee; }

    public Double getPayableAmount() { return payableAmount; }
    public void setPayableAmount(Double payableAmount) { this.payableAmount = payableAmount; }

    public Double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(Double paidAmount) { this.paidAmount = paidAmount; }

    public Double getBalanceDue() { return balanceDue; }
    public void setBalanceDue(Double balanceDue) { this.balanceDue = balanceDue; }
}
