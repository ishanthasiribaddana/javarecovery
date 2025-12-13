package com.jiat.recovery.dto;

import java.time.LocalDate;

/**
 * DTO for detailed student profile used in recovery operations.
 */
public class StudentProfileDTO {
    
    // Student table fields
    private Integer sId;
    private String studentId;
    private String nameOnCertificate;
    private String scnNo;
    private String school;
    private Integer academicYear;
    private Double courseFeeTotalDueAmount;
    
    // General User Profile fields
    private Integer gupId;
    private String nic;
    private String firstName;
    private String lastName;
    private String email;
    private String mobilePhone;
    private String homePhone;
    private String officePhone;
    private String whatsapp;
    private String address1;
    private String address2;
    private String address3;
    private String postalCode;
    private LocalDate dob;
    private String gender;
    private String occupation;
    private String company;
    private LocalDate profileCreatedDate;
    private String nationality;
    
    // Related entities
    private String courseTitle;
    private Integer courseId;
    private String branchName;
    private String intakeName;
    private LocalDate firstPaymentDate;
    
    // Payment option
    private Integer paymentOptionId;
    private String paymentOptionName;
    
    // Scholarship info from scholarship_payment_scheduler
    private Double scholarshipPercentage; // Based on selected payment option (current, may be downgraded)
    private Double originalScholarshipPercentage; // Original scholarship before any downgrade
    private Double totalCourseFee;
    private Double payableCourseFee;
    private Double scholarshipAmount; // Calculated: totalCourseFee × scholarshipPercentage
    
    // Offer info from student_offer, offer_manager, offer_name
    private Double offerDiscountPercentage;
    private Double offerDiscountAmount;
    private LocalDate offerValidUntil;
    private String offerName;
    private Boolean offerApplied;
    private Double offerValue; // Calculated offer discount value
    private Double finalPayable; // Payable after scholarship + offer
    
    // Guardian info from student_guardian
    private String guardianName;
    private String guardianContact;
    private String guardianRelationship;
    
    // International/University Payment info based on branch (BCU/IIC/CHO/NONE)
    private Integer studentBranchId;
    private String internationalPaymentType; // BCU, IIC, CHO, NONE
    private Double intlFeeAmount;
    private Double intlPaidAmount;
    private Double intlDueAmount;
    
    // BCU Payment info - Students in BCU batches (course_cid 360 or 424)
    private Boolean isBcuStudent;
    private Double bcuStandardFee; // standard_fee from course table for c_id 360/424
    private Double bcuPaidAmount;  // Total paid from voucher_item for BCU courses
    private Double bcuDueAmount;   // Calculated: bcuStandardFee - bcuPaidAmount
    private Integer bcuCourseId;   // 360 or 424
    
    // Last payment info
    private LocalDate lastPaymentDate;
    private Integer daysSinceLastPayment;
    
    // Payment schedule (set separately via setter)
    private PaymentScheduleDTO paymentSchedule;
    
    // Computed fields
    private String fullName;
    private String fullAddress;
    private String status;

    public StudentProfileDTO() {}

    public StudentProfileDTO(Object[] row) {
        int i = 0;
        this.sId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.studentId = (String) row[i++];
        this.nameOnCertificate = (String) row[i++];
        this.scnNo = (String) row[i++];
        this.school = (String) row[i++];
        this.academicYear = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.courseFeeTotalDueAmount = row[i] != null ? ((Number) row[i]).doubleValue() : null; i++;
        
        this.gupId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.nic = (String) row[i++];
        this.firstName = (String) row[i++];
        this.lastName = (String) row[i++];
        this.email = (String) row[i++];
        this.mobilePhone = (String) row[i++];
        this.homePhone = (String) row[i++];
        this.officePhone = (String) row[i++];
        this.whatsapp = (String) row[i++];
        this.address1 = (String) row[i++];
        this.address2 = (String) row[i++];
        this.address3 = (String) row[i++];
        this.postalCode = (String) row[i++];
        
        if (row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.dob = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.dob = (LocalDate) row[i];
            }
        }
        i++;
        
        this.gender = (String) row[i++];
        this.occupation = (String) row[i++];
        this.company = (String) row[i++];
        
        if (row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.profileCreatedDate = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.profileCreatedDate = (LocalDate) row[i];
            }
        }
        i++;
        
        this.nationality = (String) row[i++];
        this.courseTitle = (String) row[i++];
        this.courseId = row[i] != null ? ((Number) row[i]).intValue() : null; i++;
        this.branchName = (String) row[i++];
        this.intakeName = (String) row[i++];
        
        // First payment date (used to derive academic year)
        if (row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.firstPaymentDate = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.firstPaymentDate = (LocalDate) row[i];
            }
        }
        i++;
        
        // Payment option (from student_payment_scheduler)
        if (row.length > i) {
            this.paymentOptionId = row[i] != null ? ((Number) row[i]).intValue() : null;
            i++;
            this.paymentOptionName = row.length > i ? (String) row[i++] : null;
        }
        
        // Scholarship info (from scholarship_payment_scheduler or universal_bucket_manager fallback)
        // Scholarship percentage based on payment option (already calculated in SQL CASE with COALESCE)
        if (row.length > i && row[i] != null) {
            this.scholarshipPercentage = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // Total course fee from scholarship_payment_scheduler (defaults to 3,000,000 in SQL)
        if (row.length > i && row[i] != null) {
            this.totalCourseFee = ((Number) row[i]).doubleValue();
        } else {
            this.totalCourseFee = 3000000.0; // Default fallback
        }
        i++;
        
        // Always calculate payableCourseFee from scholarshipPercentage to ensure consistency
        // The discounted_fee from database may be outdated if scholarship percentage changed
        // Skip the discounted_fee column but still increment index
        i++; // Skip discounted_fee column
        
        // Original scholarship percentage (from scholarship_history - first downgrade record)
        if (row.length > i && row[i] != null) {
            this.originalScholarshipPercentage = ((Number) row[i]).doubleValue();
        }
        i++;
        
        if (this.scholarshipPercentage != null && this.scholarshipPercentage > 0) {
            // Calculate from percentage: payable = totalFee * (1 - scholarshipPercentage/100)
            this.scholarshipAmount = this.totalCourseFee * (this.scholarshipPercentage / 100.0);
            this.payableCourseFee = this.totalCourseFee - this.scholarshipAmount;
        } else {
            // No scholarship
            this.scholarshipAmount = 0.0;
            this.payableCourseFee = this.totalCourseFee;
        }
        
        // Offer info (from student_offer, offer_manager, offer_name)
        // offer_discount_percentage
        if (row.length > i && row[i] != null) {
            this.offerDiscountPercentage = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // offer_discount_amount
        if (row.length > i && row[i] != null) {
            this.offerDiscountAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // offer_valid_until
        if (row.length > i && row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.offerValidUntil = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.offerValidUntil = (LocalDate) row[i];
            }
        }
        i++;
        
        // offer_name
        if (row.length > i && row[i] != null) {
            this.offerName = (String) row[i];
        }
        i++;
        
        // offer_is_taken (can be Boolean or Number depending on DB driver)
        if (row.length > i && row[i] != null) {
            if (row[i] instanceof Boolean) {
                this.offerApplied = (Boolean) row[i];
            } else if (row[i] instanceof Number) {
                this.offerApplied = ((Number) row[i]).intValue() == 1;
            }
        }
        i++;
        
        // Guardian info
        if (row.length > i && row[i] != null) {
            this.guardianName = row[i].toString().trim();
        }
        i++;
        
        if (row.length > i && row[i] != null) {
            this.guardianContact = row[i].toString().trim();
        }
        i++;
        
        if (row.length > i && row[i] != null) {
            this.guardianRelationship = row[i].toString().trim();
        }
        i++;
        
        // International/University Payment info based on branch
        // student_branch_id
        if (row.length > i && row[i] != null) {
            this.studentBranchId = ((Number) row[i]).intValue();
        }
        i++;
        
        // international_payment_type (BCU, IIC, CHO, NONE)
        if (row.length > i && row[i] != null) {
            this.internationalPaymentType = row[i].toString().trim();
        } else {
            this.internationalPaymentType = "NONE";
        }
        i++;
        
        // intl_fee_amount
        if (row.length > i && row[i] != null) {
            this.intlFeeAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // intl_paid_amount
        if (row.length > i && row[i] != null) {
            this.intlPaidAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // intl_due_amount
        if (row.length > i && row[i] != null) {
            this.intlDueAmount = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // BCU Payment info - Students in BCU batches (course_cid 360 or 424)
        // is_bcu_student
        if (row.length > i && row[i] != null) {
            this.isBcuStudent = ((Number) row[i]).intValue() == 1;
        } else {
            this.isBcuStudent = false;
        }
        i++;
        
        // bcu_standard_fee (from course.standard_fee for c_id 360/424)
        if (row.length > i && row[i] != null) {
            this.bcuStandardFee = ((Number) row[i]).doubleValue();
        }
        i++;
        
        // bcu_paid_amount (sum of voucher_item amounts for BCU courses)
        if (row.length > i && row[i] != null) {
            this.bcuPaidAmount = ((Number) row[i]).doubleValue();
        } else {
            this.bcuPaidAmount = 0.0;
        }
        i++;
        
        // bcu_course_id (360 or 424)
        if (row.length > i && row[i] != null) {
            this.bcuCourseId = ((Number) row[i]).intValue();
        }
        i++;
        
        // Calculate BCU due amount
        if (this.isBcuStudent != null && this.isBcuStudent && this.bcuStandardFee != null) {
            this.bcuDueAmount = Math.max(0, this.bcuStandardFee - (this.bcuPaidAmount != null ? this.bcuPaidAmount : 0));
        }
        
        // Last payment date
        if (row.length > i && row[i] != null) {
            if (row[i] instanceof java.sql.Date) {
                this.lastPaymentDate = ((java.sql.Date) row[i]).toLocalDate();
            } else if (row[i] instanceof LocalDate) {
                this.lastPaymentDate = (LocalDate) row[i];
            }
        }
        i++;
        
        // Days since last payment
        if (row.length > i && row[i] != null) {
            this.daysSinceLastPayment = ((Number) row[i]).intValue();
        }
        i++;
        
        // Calculate offer value and final payable
        if (this.payableCourseFee != null) {
            // Calculate offer value based on percentage or fixed amount
            if (this.offerDiscountPercentage != null && this.offerDiscountPercentage > 0) {
                this.offerValue = this.payableCourseFee * (this.offerDiscountPercentage / 100.0);
            } else if (this.offerDiscountAmount != null && this.offerDiscountAmount > 0) {
                this.offerValue = this.offerDiscountAmount;
            } else {
                this.offerValue = 0.0;
            }
            
            // Final payable = payable after scholarship - offer value
            this.finalPayable = this.payableCourseFee - (this.offerValue != null ? this.offerValue : 0.0);
        }
        
        // Compute full name
        StringBuilder name = new StringBuilder();
        if (firstName != null && !firstName.isEmpty()) {
            name.append(firstName);
        }
        if (lastName != null && !lastName.isEmpty()) {
            if (name.length() > 0) name.append(" ");
            name.append(lastName);
        }
        this.fullName = name.length() > 0 ? name.toString() : nameOnCertificate;
        
        // Compute full address
        StringBuilder addr = new StringBuilder();
        if (address1 != null && !address1.isEmpty()) addr.append(address1);
        if (address2 != null && !address2.isEmpty()) {
            if (addr.length() > 0) addr.append(", ");
            addr.append(address2);
        }
        if (address3 != null && !address3.isEmpty()) {
            if (addr.length() > 0) addr.append(", ");
            addr.append(address3);
        }
        if (postalCode != null && !postalCode.isEmpty()) {
            if (addr.length() > 0) addr.append(" ");
            addr.append(postalCode);
        }
        this.fullAddress = addr.toString();
        
        // Set status
        this.status = "Active";
    }

    // Getters and Setters
    public Integer getSId() { return sId; }
    public void setSId(Integer sId) { this.sId = sId; }
    
    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    
    public String getNameOnCertificate() { return nameOnCertificate; }
    public void setNameOnCertificate(String nameOnCertificate) { this.nameOnCertificate = nameOnCertificate; }
    
    public String getScnNo() { return scnNo; }
    public void setScnNo(String scnNo) { this.scnNo = scnNo; }
    
    public String getSchool() { return school; }
    public void setSchool(String school) { this.school = school; }
    
    public Integer getAcademicYear() { return academicYear; }
    public void setAcademicYear(Integer academicYear) { this.academicYear = academicYear; }
    
    public Double getCourseFeeTotalDueAmount() { return courseFeeTotalDueAmount; }
    public void setCourseFeeTotalDueAmount(Double courseFeeTotalDueAmount) { this.courseFeeTotalDueAmount = courseFeeTotalDueAmount; }
    
    public Integer getGupId() { return gupId; }
    public void setGupId(Integer gupId) { this.gupId = gupId; }
    
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getMobilePhone() { return mobilePhone; }
    public void setMobilePhone(String mobilePhone) { this.mobilePhone = mobilePhone; }
    
    public String getHomePhone() { return homePhone; }
    public void setHomePhone(String homePhone) { this.homePhone = homePhone; }
    
    public String getOfficePhone() { return officePhone; }
    public void setOfficePhone(String officePhone) { this.officePhone = officePhone; }
    
    public String getWhatsapp() { return whatsapp; }
    public void setWhatsapp(String whatsapp) { this.whatsapp = whatsapp; }
    
    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }
    
    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }
    
    public String getAddress3() { return address3; }
    public void setAddress3(String address3) { this.address3 = address3; }
    
    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }
    
    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }
    
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    
    public String getOccupation() { return occupation; }
    public void setOccupation(String occupation) { this.occupation = occupation; }
    
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    
    public LocalDate getProfileCreatedDate() { return profileCreatedDate; }
    public void setProfileCreatedDate(LocalDate profileCreatedDate) { this.profileCreatedDate = profileCreatedDate; }
    
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
    
    public String getCourseTitle() { return courseTitle; }
    public void setCourseTitle(String courseTitle) { this.courseTitle = courseTitle; }
    
    public Integer getCourseId() { return courseId; }
    public void setCourseId(Integer courseId) { this.courseId = courseId; }
    
    public String getBranchName() { return branchName; }
    public void setBranchName(String branchName) { this.branchName = branchName; }
    
    public String getIntakeName() { return intakeName; }
    public void setIntakeName(String intakeName) { this.intakeName = intakeName; }
    
    public LocalDate getFirstPaymentDate() { return firstPaymentDate; }
    public void setFirstPaymentDate(LocalDate firstPaymentDate) { this.firstPaymentDate = firstPaymentDate; }
    
    public Integer getPaymentOptionId() { return paymentOptionId; }
    public void setPaymentOptionId(Integer paymentOptionId) { this.paymentOptionId = paymentOptionId; }
    
    public String getPaymentOptionName() { return paymentOptionName; }
    public void setPaymentOptionName(String paymentOptionName) { this.paymentOptionName = paymentOptionName; }
    
    public Double getScholarshipPercentage() { return scholarshipPercentage; }
    public void setScholarshipPercentage(Double scholarshipPercentage) { this.scholarshipPercentage = scholarshipPercentage; }
    
    public Double getOriginalScholarshipPercentage() { return originalScholarshipPercentage; }
    public void setOriginalScholarshipPercentage(Double originalScholarshipPercentage) { this.originalScholarshipPercentage = originalScholarshipPercentage; }
    
    public Double getTotalCourseFee() { return totalCourseFee; }
    public void setTotalCourseFee(Double totalCourseFee) { this.totalCourseFee = totalCourseFee; }
    
    public Double getPayableCourseFee() { return payableCourseFee; }
    public void setPayableCourseFee(Double payableCourseFee) { this.payableCourseFee = payableCourseFee; }
    
    public Double getScholarshipAmount() { return scholarshipAmount; }
    public void setScholarshipAmount(Double scholarshipAmount) { this.scholarshipAmount = scholarshipAmount; }
    
    public Double getOfferDiscountPercentage() { return offerDiscountPercentage; }
    public void setOfferDiscountPercentage(Double offerDiscountPercentage) { this.offerDiscountPercentage = offerDiscountPercentage; }
    
    public Double getOfferDiscountAmount() { return offerDiscountAmount; }
    public void setOfferDiscountAmount(Double offerDiscountAmount) { this.offerDiscountAmount = offerDiscountAmount; }
    
    public LocalDate getOfferValidUntil() { return offerValidUntil; }
    public void setOfferValidUntil(LocalDate offerValidUntil) { this.offerValidUntil = offerValidUntil; }
    
    public String getOfferName() { return offerName; }
    public void setOfferName(String offerName) { this.offerName = offerName; }
    
    public Boolean getOfferApplied() { return offerApplied; }
    public void setOfferApplied(Boolean offerApplied) { this.offerApplied = offerApplied; }
    
    public Double getOfferValue() { return offerValue; }
    public void setOfferValue(Double offerValue) { this.offerValue = offerValue; }
    
    public Double getFinalPayable() { return finalPayable; }
    public void setFinalPayable(Double finalPayable) { this.finalPayable = finalPayable; }
    
    public String getGuardianName() { return guardianName; }
    public void setGuardianName(String guardianName) { this.guardianName = guardianName; }
    
    public String getGuardianContact() { return guardianContact; }
    public void setGuardianContact(String guardianContact) { this.guardianContact = guardianContact; }
    
    public String getGuardianRelationship() { return guardianRelationship; }
    public void setGuardianRelationship(String guardianRelationship) { this.guardianRelationship = guardianRelationship; }
    
    public Integer getStudentBranchId() { return studentBranchId; }
    public void setStudentBranchId(Integer studentBranchId) { this.studentBranchId = studentBranchId; }
    
    public String getInternationalPaymentType() { return internationalPaymentType; }
    public void setInternationalPaymentType(String internationalPaymentType) { this.internationalPaymentType = internationalPaymentType; }
    
    public Double getIntlFeeAmount() { return intlFeeAmount; }
    public void setIntlFeeAmount(Double intlFeeAmount) { this.intlFeeAmount = intlFeeAmount; }
    
    public Double getIntlPaidAmount() { return intlPaidAmount; }
    public void setIntlPaidAmount(Double intlPaidAmount) { this.intlPaidAmount = intlPaidAmount; }
    
    public Double getIntlDueAmount() { return intlDueAmount; }
    public void setIntlDueAmount(Double intlDueAmount) { this.intlDueAmount = intlDueAmount; }
    
    public Boolean getIsBcuStudent() { return isBcuStudent; }
    public void setIsBcuStudent(Boolean isBcuStudent) { this.isBcuStudent = isBcuStudent; }
    
    public Double getBcuStandardFee() { return bcuStandardFee; }
    public void setBcuStandardFee(Double bcuStandardFee) { this.bcuStandardFee = bcuStandardFee; }
    
    public Double getBcuPaidAmount() { return bcuPaidAmount; }
    public void setBcuPaidAmount(Double bcuPaidAmount) { this.bcuPaidAmount = bcuPaidAmount; }
    
    public Double getBcuDueAmount() { return bcuDueAmount; }
    public void setBcuDueAmount(Double bcuDueAmount) { this.bcuDueAmount = bcuDueAmount; }
    
    public Integer getBcuCourseId() { return bcuCourseId; }
    public void setBcuCourseId(Integer bcuCourseId) { this.bcuCourseId = bcuCourseId; }
    
    public LocalDate getLastPaymentDate() { return lastPaymentDate; }
    public void setLastPaymentDate(LocalDate lastPaymentDate) { this.lastPaymentDate = lastPaymentDate; }
    
    public Integer getDaysSinceLastPayment() { return daysSinceLastPayment; }
    public void setDaysSinceLastPayment(Integer daysSinceLastPayment) { this.daysSinceLastPayment = daysSinceLastPayment; }
    
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    
    public String getFullAddress() { return fullAddress; }
    public void setFullAddress(String fullAddress) { this.fullAddress = fullAddress; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public PaymentScheduleDTO getPaymentSchedule() { return paymentSchedule; }
    public void setPaymentSchedule(PaymentScheduleDTO paymentSchedule) { this.paymentSchedule = paymentSchedule; }
}
