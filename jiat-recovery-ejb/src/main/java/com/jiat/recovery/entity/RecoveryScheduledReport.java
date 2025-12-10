package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.ReportOutputFormat;
import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Scheduled report entity - for automated report generation.
 */
@Entity
@Table(name = "recovery_scheduled_report")
@NamedQueries({
    @NamedQuery(name = "RecoveryScheduledReport.findByTemplateId", 
                query = "SELECT s FROM RecoveryScheduledReport s WHERE s.reportTemplateId = :templateId AND s.isActive = true"),
    @NamedQuery(name = "RecoveryScheduledReport.findEnabled", 
                query = "SELECT s FROM RecoveryScheduledReport s WHERE s.isEnabled = true AND s.isActive = true"),
    @NamedQuery(name = "RecoveryScheduledReport.findDueForExecution", 
                query = "SELECT s FROM RecoveryScheduledReport s WHERE s.isEnabled = true AND s.isActive = true AND (s.nextRunAt IS NULL OR s.nextRunAt <= :now) ORDER BY s.nextRunAt ASC")
})
public class RecoveryScheduledReport extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "report_template_id", nullable = false)
    private Long reportTemplateId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "report_template_id", insertable = false, updatable = false)
    private RecoveryReportTemplate reportTemplate;

    @Column(name = "schedule_name", nullable = false)
    private String scheduleName;

    @Column(name = "cron_expression", length = 100)
    private String cronExpression;

    @Column(name = "parameters_json", columnDefinition = "TEXT")
    private String parametersJson;

    @Enumerated(EnumType.STRING)
    @Column(name = "output_format")
    private ReportOutputFormat outputFormat = ReportOutputFormat.PDF;

    @Column(name = "email_recipients", columnDefinition = "TEXT")
    private String emailRecipients;

    @Column(name = "email_subject")
    private String emailSubject;

    @Column(name = "email_body", columnDefinition = "TEXT")
    private String emailBody;

    @Column(name = "last_run_at")
    private LocalDateTime lastRunAt;

    @Column(name = "last_run_status")
    private String lastRunStatus; // SUCCESS, FAILED

    @Column(name = "last_error_message", columnDefinition = "TEXT")
    private String lastErrorMessage;

    @Column(name = "next_run_at")
    private LocalDateTime nextRunAt;

    @Column(name = "run_count")
    private Integer runCount = 0;

    @Column(name = "is_enabled")
    private Boolean isEnabled = true;

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

    public String getScheduleName() {
        return scheduleName;
    }

    public void setScheduleName(String scheduleName) {
        this.scheduleName = scheduleName;
    }

    public String getCronExpression() {
        return cronExpression;
    }

    public void setCronExpression(String cronExpression) {
        this.cronExpression = cronExpression;
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

    public String getEmailRecipients() {
        return emailRecipients;
    }

    public void setEmailRecipients(String emailRecipients) {
        this.emailRecipients = emailRecipients;
    }

    public String getEmailSubject() {
        return emailSubject;
    }

    public void setEmailSubject(String emailSubject) {
        this.emailSubject = emailSubject;
    }

    public String getEmailBody() {
        return emailBody;
    }

    public void setEmailBody(String emailBody) {
        this.emailBody = emailBody;
    }

    public LocalDateTime getLastRunAt() {
        return lastRunAt;
    }

    public void setLastRunAt(LocalDateTime lastRunAt) {
        this.lastRunAt = lastRunAt;
    }

    public String getLastRunStatus() {
        return lastRunStatus;
    }

    public void setLastRunStatus(String lastRunStatus) {
        this.lastRunStatus = lastRunStatus;
    }

    public String getLastErrorMessage() {
        return lastErrorMessage;
    }

    public void setLastErrorMessage(String lastErrorMessage) {
        this.lastErrorMessage = lastErrorMessage;
    }

    public LocalDateTime getNextRunAt() {
        return nextRunAt;
    }

    public void setNextRunAt(LocalDateTime nextRunAt) {
        this.nextRunAt = nextRunAt;
    }

    public Integer getRunCount() {
        return runCount;
    }

    public void setRunCount(Integer runCount) {
        this.runCount = runCount;
    }

    public Boolean getIsEnabled() {
        return isEnabled;
    }

    public void setIsEnabled(Boolean isEnabled) {
        this.isEnabled = isEnabled;
    }

    // Helper methods
    public void recordSuccessfulRun(LocalDateTime nextRun) {
        this.lastRunAt = LocalDateTime.now();
        this.lastRunStatus = "SUCCESS";
        this.lastErrorMessage = null;
        this.nextRunAt = nextRun;
        this.runCount = (this.runCount != null ? this.runCount : 0) + 1;
    }

    public void recordFailedRun(String errorMessage, LocalDateTime nextRun) {
        this.lastRunAt = LocalDateTime.now();
        this.lastRunStatus = "FAILED";
        this.lastErrorMessage = errorMessage;
        this.nextRunAt = nextRun;
        this.runCount = (this.runCount != null ? this.runCount : 0) + 1;
    }

    public String[] getEmailRecipientsArray() {
        if (emailRecipients == null || emailRecipients.trim().isEmpty()) {
            return new String[0];
        }
        return emailRecipients.split(",");
    }
}
