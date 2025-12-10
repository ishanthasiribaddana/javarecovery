package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.GrievanceStatus;
import com.jiat.recovery.entity.enums.Priority;
import com.jiat.recovery.entity.enums.SubmissionChannel;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Recovery grievance entity - student disputes and complaints.
 */
@Entity
@Table(name = "recovery_grievance")
@NamedQueries({
    @NamedQuery(name = "RecoveryGrievance.findByStudentId", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.studentSId = :studentSId AND g.isActive = true ORDER BY g.createdAt DESC"),
    @NamedQuery(name = "RecoveryGrievance.findByCaseId", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.recoveryCaseId = :caseId AND g.isActive = true ORDER BY g.createdAt DESC"),
    @NamedQuery(name = "RecoveryGrievance.findByGrievanceNumber", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.grievanceNumber = :grievanceNumber AND g.isActive = true"),
    @NamedQuery(name = "RecoveryGrievance.findByStatus", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.status = :status AND g.isActive = true ORDER BY g.createdAt DESC"),
    @NamedQuery(name = "RecoveryGrievance.findByAssignedTo", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.assignedTo = :assignedTo AND g.isActive = true ORDER BY g.priority DESC, g.createdAt ASC"),
    @NamedQuery(name = "RecoveryGrievance.findPending", 
                query = "SELECT g FROM RecoveryGrievance g WHERE g.status IN ('SUBMITTED', 'UNDER_REVIEW') AND g.isActive = true ORDER BY g.priority DESC, g.createdAt ASC"),
    @NamedQuery(name = "RecoveryGrievance.countByStatus", 
                query = "SELECT g.status, COUNT(g) FROM RecoveryGrievance g WHERE g.isActive = true GROUP BY g.status")
})
public class RecoveryGrievance extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "recovery_case_id")
    private Long recoveryCaseId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recovery_case_id", insertable = false, updatable = false)
    private RecoveryCase recoveryCase;

    @Column(name = "student_s_id", nullable = false)
    private Integer studentSId;

    @Column(name = "grievance_number", unique = true, length = 50)
    private String grievanceNumber;

    @Column(name = "subject")
    private String subject;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    @Column(name = "status")
    private GrievanceStatus status = GrievanceStatus.SUBMITTED;

    @Enumerated(EnumType.STRING)
    @Column(name = "priority")
    private Priority priority = Priority.MEDIUM;

    @Column(name = "assigned_to")
    private Long assignedTo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "assigned_to", insertable = false, updatable = false)
    private RecoverySystemUser assignedUser;

    @Column(name = "resolution", columnDefinition = "TEXT")
    private String resolution;

    @Column(name = "resolved_by")
    private Long resolvedBy;

    @Column(name = "resolved_date")
    private LocalDateTime resolvedDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "submitted_via")
    private SubmissionChannel submittedVia = SubmissionChannel.WEB;

    @OneToMany(mappedBy = "recoveryGrievance", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<RecoveryGrievanceAttachment> attachments = new ArrayList<>();

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRecoveryCaseId() {
        return recoveryCaseId;
    }

    public void setRecoveryCaseId(Long recoveryCaseId) {
        this.recoveryCaseId = recoveryCaseId;
    }

    public RecoveryCase getRecoveryCase() {
        return recoveryCase;
    }

    public void setRecoveryCase(RecoveryCase recoveryCase) {
        this.recoveryCase = recoveryCase;
        if (recoveryCase != null) {
            this.recoveryCaseId = recoveryCase.getId();
        }
    }

    public Integer getStudentSId() {
        return studentSId;
    }

    public void setStudentSId(Integer studentSId) {
        this.studentSId = studentSId;
    }

    public String getGrievanceNumber() {
        return grievanceNumber;
    }

    public void setGrievanceNumber(String grievanceNumber) {
        this.grievanceNumber = grievanceNumber;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public GrievanceStatus getStatus() {
        return status;
    }

    public void setStatus(GrievanceStatus status) {
        this.status = status;
    }

    public Priority getPriority() {
        return priority;
    }

    public void setPriority(Priority priority) {
        this.priority = priority;
    }

    public Long getAssignedTo() {
        return assignedTo;
    }

    public void setAssignedTo(Long assignedTo) {
        this.assignedTo = assignedTo;
    }

    public RecoverySystemUser getAssignedUser() {
        return assignedUser;
    }

    public void setAssignedUser(RecoverySystemUser assignedUser) {
        this.assignedUser = assignedUser;
    }

    public String getResolution() {
        return resolution;
    }

    public void setResolution(String resolution) {
        this.resolution = resolution;
    }

    public Long getResolvedBy() {
        return resolvedBy;
    }

    public void setResolvedBy(Long resolvedBy) {
        this.resolvedBy = resolvedBy;
    }

    public LocalDateTime getResolvedDate() {
        return resolvedDate;
    }

    public void setResolvedDate(LocalDateTime resolvedDate) {
        this.resolvedDate = resolvedDate;
    }

    public SubmissionChannel getSubmittedVia() {
        return submittedVia;
    }

    public void setSubmittedVia(SubmissionChannel submittedVia) {
        this.submittedVia = submittedVia;
    }

    public List<RecoveryGrievanceAttachment> getAttachments() {
        return attachments;
    }

    public void setAttachments(List<RecoveryGrievanceAttachment> attachments) {
        this.attachments = attachments;
    }

    // Helper methods
    public void addAttachment(RecoveryGrievanceAttachment attachment) {
        attachments.add(attachment);
        attachment.setRecoveryGrievance(this);
    }

    /**
     * Resolve this grievance.
     */
    public void resolve(String resolution, Long resolverId) {
        this.status = GrievanceStatus.RESOLVED;
        this.resolution = resolution;
        this.resolvedBy = resolverId;
        this.resolvedDate = LocalDateTime.now();
    }

    /**
     * Reject this grievance.
     */
    public void reject(String reason, Long resolverId) {
        this.status = GrievanceStatus.REJECTED;
        this.resolution = reason;
        this.resolvedBy = resolverId;
        this.resolvedDate = LocalDateTime.now();
    }

    /**
     * Generate grievance number in format GRV-YYYY-NNNNN
     */
    public static String generateGrievanceNumber(int year, long sequence) {
        return String.format("GRV-%d-%05d", year, sequence);
    }
}
