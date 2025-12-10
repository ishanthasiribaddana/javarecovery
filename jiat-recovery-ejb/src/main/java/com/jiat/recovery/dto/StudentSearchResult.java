package com.jiat.recovery.dto;

import java.io.Serializable;

/**
 * DTO for student search results with details from multiple tables.
 */
public class StudentSearchResult implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer sId;
    private String studentId;
    private String nameOnCertificate;
    private String nic;
    private String firstName;
    private String lastName;
    private String courseTitle;
    private Double courseFeeTotalDueAmount;
    private Double totalDue;
    private Double paidAmount;
    private Double scholarship;

    public StudentSearchResult() {}

    public StudentSearchResult(Object[] row) {
        this.sId = row[0] != null ? ((Number) row[0]).intValue() : null;
        this.studentId = row[1] != null ? row[1].toString() : null;
        this.nameOnCertificate = row[2] != null ? row[2].toString() : null;
        this.nic = row[3] != null ? row[3].toString() : null;
        this.firstName = row[4] != null ? row[4].toString() : null;
        this.lastName = row[5] != null ? row[5].toString() : null;
        this.courseTitle = row[6] != null ? row[6].toString() : null;
        this.courseFeeTotalDueAmount = row[7] != null ? ((Number) row[7]).doubleValue() : null;
        this.totalDue = row[8] != null ? ((Number) row[8]).doubleValue() : null;
        this.paidAmount = row[9] != null ? ((Number) row[9]).doubleValue() : null;
        this.scholarship = row[10] != null ? ((Number) row[10]).doubleValue() : null;
    }

    // Getters and Setters
    public Integer getSId() { return sId; }
    public void setSId(Integer sId) { this.sId = sId; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getNameOnCertificate() { return nameOnCertificate; }
    public void setNameOnCertificate(String nameOnCertificate) { this.nameOnCertificate = nameOnCertificate; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }

    public Double getCourseFeeTotalDueAmount() { return courseFeeTotalDueAmount; }
    public void setCourseFeeTotalDueAmount(Double courseFeeTotalDueAmount) { this.courseFeeTotalDueAmount = courseFeeTotalDueAmount; }

    public Double getTotalDue() { return totalDue; }
    public void setTotalDue(Double totalDue) { this.totalDue = totalDue; }

    public Double getPaidAmount() { return paidAmount; }
    public void setPaidAmount(Double paidAmount) { this.paidAmount = paidAmount; }

    public Double getScholarship() { return scholarship; }
    public void setScholarship(Double scholarship) { this.scholarship = scholarship; }

    // Computed field for display name
    public String getDisplayName() {
        if (nameOnCertificate != null && !nameOnCertificate.isEmpty()) {
            return nameOnCertificate;
        }
        StringBuilder name = new StringBuilder();
        if (firstName != null) name.append(firstName);
        if (lastName != null) {
            if (name.length() > 0) name.append(" ");
            name.append(lastName);
        }
        return name.length() > 0 ? name.toString() : "N/A";
    }

    // Computed field for due amount (prefer totalDue from UPM, fallback to courseFeeTotalDueAmount)
    public Double getDueAmount() {
        if (totalDue != null && totalDue > 0) return totalDue;
        if (courseFeeTotalDueAmount != null && courseFeeTotalDueAmount > 0) return courseFeeTotalDueAmount;
        return 0.0;
    }
}
