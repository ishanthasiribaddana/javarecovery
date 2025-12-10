package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.GenerationStatus;
import com.jiat.recovery.entity.enums.ReportOutputFormat;
import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Report generation log entity - tracks generated reports.
 */
@Entity
@Table(name = "recovery_report_log")
@NamedQueries({
    @NamedQuery(name = "RecoveryReportLog.findByTemplateId", 
                query = "SELECT l FROM RecoveryReportLog l WHERE l.reportTemplateId = :templateId AND l.isActive = true ORDER BY l.createdAt DESC"),
    @NamedQuery(name = "RecoveryReportLog.findByUserId", 
                query = "SELECT l FROM RecoveryReportLog l WHERE l.generatedBy = :userId AND l.isActive = true ORDER BY l.createdAt DESC"),
    @NamedQuery(name = "RecoveryReportLog.findByStatus", 
                query = "SELECT l FROM RecoveryReportLog l WHERE l.generationStatus = :status AND l.isActive = true ORDER BY l.createdAt DESC"),
    @NamedQuery(name = "RecoveryReportLog.findPending", 
                query = "SELECT l FROM RecoveryReportLog l WHERE l.generationStatus IN ('PENDING', 'PROCESSING') AND l.isActive = true ORDER BY l.createdAt ASC")
})
public class RecoveryReportLog extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "report_template_id", nullable = false)
    private Long reportTemplateId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "report_template_id", insertable = false, updatable = false)
    private RecoveryReportTemplate reportTemplate;

    @Column(name = "generated_by", nullable = false)
    private Long generatedBy;

    @Column(name = "parameters_json", columnDefinition = "TEXT")
    private String parametersJson;

    @Enumerated(EnumType.STRING)
    @Column(name = "output_format")
    private ReportOutputFormat outputFormat = ReportOutputFormat.PDF;

    @Column(name = "output_file_path", length = 500)
    private String outputFilePath;

    @Enumerated(EnumType.STRING)
    @Column(name = "generation_status")
    private GenerationStatus generationStatus = GenerationStatus.PENDING;

    @Column(name = "error_message", columnDefinition = "TEXT")
    private String errorMessage;

    @Column(name = "generation_started_at")
    private LocalDateTime generationStartedAt;

    @Column(name = "generation_completed_at")
    private LocalDateTime generationCompletedAt;

    @Column(name = "file_size_bytes")
    private Long fileSizeBytes;

    @Column(name = "download_count")
    private Integer downloadCount = 0;

    @Column(name = "last_downloaded_at")
    private LocalDateTime lastDownloadedAt;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getReportTemplateId() {
        return reportTemplateId;
    }

    public void setReportTemplateId(Long reportTemplateId) {
        this.reportTemplateId = reportTemplateId;
    }

    public RecoveryReportTemplate getReportTemplate() {
        return reportTemplate;
    }

    public void setReportTemplate(RecoveryReportTemplate reportTemplate) {
        this.reportTemplate = reportTemplate;
        if (reportTemplate != null) {
            this.reportTemplateId = reportTemplate.getId();
        }
    }

    public Long getGeneratedBy() {
        return generatedBy;
    }

    public void setGeneratedBy(Long generatedBy) {
        this.generatedBy = generatedBy;
    }

    public String getParametersJson() {
        return parametersJson;
    }

    public void setParametersJson(String parametersJson) {
        this.parametersJson = parametersJson;
    }

    public ReportOutputFormat getOutputFormat() {
        return outputFormat;
    }

    public void setOutputFormat(ReportOutputFormat outputFormat) {
        this.outputFormat = outputFormat;
    }

    public String getOutputFilePath() {
        return outputFilePath;
    }

    public void setOutputFilePath(String outputFilePath) {
        this.outputFilePath = outputFilePath;
    }

    public GenerationStatus getGenerationStatus() {
        return generationStatus;
    }

    public void setGenerationStatus(GenerationStatus generationStatus) {
        this.generationStatus = generationStatus;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public LocalDateTime getGenerationStartedAt() {
        return generationStartedAt;
    }

    public void setGenerationStartedAt(LocalDateTime generationStartedAt) {
        this.generationStartedAt = generationStartedAt;
    }

    public LocalDateTime getGenerationCompletedAt() {
        return generationCompletedAt;
    }

    public void setGenerationCompletedAt(LocalDateTime generationCompletedAt) {
        this.generationCompletedAt = generationCompletedAt;
    }

    public Long getFileSizeBytes() {
        return fileSizeBytes;
    }

    public void setFileSizeBytes(Long fileSizeBytes) {
        this.fileSizeBytes = fileSizeBytes;
    }

    public Integer getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(Integer downloadCount) {
        this.downloadCount = downloadCount;
    }

    public LocalDateTime getLastDownloadedAt() {
        return lastDownloadedAt;
    }

    public void setLastDownloadedAt(LocalDateTime lastDownloadedAt) {
        this.lastDownloadedAt = lastDownloadedAt;
    }

    // Helper methods
    public void startGeneration() {
        this.generationStatus = GenerationStatus.PROCESSING;
        this.generationStartedAt = LocalDateTime.now();
    }

    public void completeGeneration(String filePath, Long fileSize) {
        this.generationStatus = GenerationStatus.COMPLETED;
        this.generationCompletedAt = LocalDateTime.now();
        this.outputFilePath = filePath;
        this.fileSizeBytes = fileSize;
    }

    public void failGeneration(String errorMessage) {
        this.generationStatus = GenerationStatus.FAILED;
        this.generationCompletedAt = LocalDateTime.now();
        this.errorMessage = errorMessage;
    }

    public void recordDownload() {
        this.downloadCount = (this.downloadCount != null ? this.downloadCount : 0) + 1;
        this.lastDownloadedAt = LocalDateTime.now();
    }

    public Long getGenerationDurationMs() {
        if (generationStartedAt != null && generationCompletedAt != null) {
            return java.time.Duration.between(generationStartedAt, generationCompletedAt).toMillis();
        }
        return null;
    }
}
