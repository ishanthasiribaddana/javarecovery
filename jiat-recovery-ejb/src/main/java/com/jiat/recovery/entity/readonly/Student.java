package com.jiat.recovery.entity.readonly;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing student table.
 * This entity maps to the ijts_system.student table.
 */
@Entity
@Table(name = "student")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler", "course", "generalUserProfile"})
@NamedQueries({
    @NamedQuery(name = "Student.findByStudentId", 
                query = "SELECT s FROM Student s WHERE s.studentId = :studentId AND s.isActive = true"),
    @NamedQuery(name = "Student.findByScnNo", 
                query = "SELECT s FROM Student s WHERE s.scnNo = :scnNo AND s.isActive = true"),
    @NamedQuery(name = "Student.findByCourse", 
                query = "SELECT s FROM Student s WHERE s.courseCid = :courseCid AND s.isActive = true"),
    @NamedQuery(name = "Student.findByIntake", 
                query = "SELECT s FROM Student s WHERE s.intakeId = :intakeId AND s.isActive = true"),
    @NamedQuery(name = "Student.searchByName", 
                query = "SELECT s FROM Student s WHERE s.profileName LIKE :name AND s.isActive = true")
})
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "s_id")
    private Integer sId;

    @Column(name = "student_id")
    private String studentId;

    @Column(name = "scn_no")
    private String scnNo;

    @Column(name = "current_study")
    private String currentStudy;

    @Column(name = "iq_marks")
    private Double iqMarks;

    @Column(name = "school")
    private String school;

    @Column(name = "name_on_certificate")
    private String nameOnCertificate;

    @Column(name = "academic_year")
    private Integer academicYear;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "interview_statusis_id")
    private Integer interviewStatusIsId;

    @Column(name = "student_introduced_bysc_id")
    private Integer studentIntroducedByScId;

    @Column(name = "coursecid")
    private Integer courseCid;

    @Column(name = "general_user_profilegup_id")
    private Integer generalUserProfileGupId;

    @Column(name = "branch_bid")
    private Integer branchBid;

    @Column(name = "general_organization_profile_id_gop")
    private Integer generalOrganizationProfileIdGop;

    @Column(name = "no_of_Installment")
    private String noOfInstallment;

    @Column(name = "course_fee_total_due_amount")
    private Double courseFeeTotalDueAmount;

    @Column(name = "intake_id")
    private Integer intakeId;

    @Column(name = "student_entry_stream_id")
    private Integer studentEntryStreamId;

    @Column(name = "profile_name")
    private String profileName;

    @Column(name = "bcu_id")
    private String bcuId;

    @Column(name = "uk_award_id")
    private String ukAwardId;

    @Column(name = "created_at")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updatedAt;

    // Relationships (Lazy loaded)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "coursecid", insertable = false, updatable = false)
    private Course course;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "general_user_profilegup_id", insertable = false, updatable = false)
    private GeneralUserProfile generalUserProfile;

    // Getters only (read-only entity)
    public Integer getSId() {
        return sId;
    }

    public String getStudentId() {
        return studentId;
    }

    public String getScnNo() {
        return scnNo;
    }

    public String getCurrentStudy() {
        return currentStudy;
    }

    public Double getIqMarks() {
        return iqMarks;
    }

    public String getSchool() {
        return school;
    }

    public String getNameOnCertificate() {
        return nameOnCertificate;
    }

    public Integer getAcademicYear() {
        return academicYear;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public Integer getInterviewStatusIsId() {
        return interviewStatusIsId;
    }

    public Integer getStudentIntroducedByScId() {
        return studentIntroducedByScId;
    }

    public Integer getCourseCid() {
        return courseCid;
    }

    public Integer getGeneralUserProfileGupId() {
        return generalUserProfileGupId;
    }

    public Integer getBranchBid() {
        return branchBid;
    }

    public Integer getGeneralOrganizationProfileIdGop() {
        return generalOrganizationProfileIdGop;
    }

    public String getNoOfInstallment() {
        return noOfInstallment;
    }

    public Double getCourseFeeTotalDueAmount() {
        return courseFeeTotalDueAmount;
    }

    public Integer getIntakeId() {
        return intakeId;
    }

    public Integer getStudentEntryStreamId() {
        return studentEntryStreamId;
    }

    public String getProfileName() {
        return profileName;
    }

    public String getBcuId() {
        return bcuId;
    }

    public String getUkAwardId() {
        return ukAwardId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public Course getCourse() {
        return course;
    }

    public GeneralUserProfile getGeneralUserProfile() {
        return generalUserProfile;
    }

    /**
     * Get display name (profile name or name on certificate).
     */
    public String getDisplayName() {
        if (profileName != null && !profileName.trim().isEmpty()) {
            return profileName;
        }
        return nameOnCertificate;
    }
}
