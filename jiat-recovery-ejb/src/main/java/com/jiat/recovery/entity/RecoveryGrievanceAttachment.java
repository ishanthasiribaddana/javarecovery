package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.AttachmentType;
import jakarta.persistence.*;

/**
 * Recovery grievance attachment entity.
 */
@Entity
@Table(name = "recovery_grievance_attachment")
@NamedQueries({
    @NamedQuery(name = "RecoveryGrievanceAttachment.findByGrievanceId", 
                query = "SELECT a FROM RecoveryGrievanceAttachment a WHERE a.recoveryGrievanceId = :grievanceId AND a.isActive = true")
})
public class RecoveryGrievanceAttachment extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "recovery_grievance_id", nullable = false)
    private Long recoveryGrievanceId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recovery_grievance_id", insertable = false, updatable = false)
    private RecoveryGrievance recoveryGrievance;

    @Column(name = "document_manager_id")
    private Integer documentManagerId;

    @Column(name = "file_path", length = 500)
    private String filePath;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_type", length = 50)
    private String fileType;

    @Column(name = "file_size_bytes")
    private Long fileSizeBytes;

    @Enumerated(EnumType.STRING)
    @Column(name = "attachment_type")
    private AttachmentType attachmentType = AttachmentType.OTHER;

    @Column(name = "description")
    private String description;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getRecoveryGrievanceId() {
        return recoveryGrievanceId;
    }

    public void setRecoveryGrievanceId(Long recoveryGrievanceId) {
        this.recoveryGrievanceId = recoveryGrievanceId;
    }

    public RecoveryGrievance getRecoveryGrievance() {
        return recoveryGrievance;
    }

    public void setRecoveryGrievance(RecoveryGrievance recoveryGrievance) {
        this.recoveryGrievance = recoveryGrievance;
        if (recoveryGrievance != null) {
            this.recoveryGrievanceId = recoveryGrievance.getId();
        }
    }

    public Integer getDocumentManagerId() {
        return documentManagerId;
    }

    public void setDocumentManagerId(Integer documentManagerId) {
        this.documentManagerId = documentManagerId;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public Long getFileSizeBytes() {
        return fileSizeBytes;
    }

    public void setFileSizeBytes(Long fileSizeBytes) {
        this.fileSizeBytes = fileSizeBytes;
    }

    public AttachmentType getAttachmentType() {
        return attachmentType;
    }

    public void setAttachmentType(AttachmentType attachmentType) {
        this.attachmentType = attachmentType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
