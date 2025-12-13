package com.jiat.recovery.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Entity to track synchronization status with Java Institute API.
 */
@Entity
@Table(name = "sync_log")
@NamedQueries({
    @NamedQuery(name = "SyncLog.findAll", query = "SELECT s FROM SyncLog s ORDER BY s.syncTime DESC"),
    @NamedQuery(name = "SyncLog.findLastSuccessful", query = "SELECT s FROM SyncLog s WHERE s.status = 'SUCCESS' ORDER BY s.syncTime DESC"),
    @NamedQuery(name = "SyncLog.findByType", query = "SELECT s FROM SyncLog s WHERE s.syncType = :syncType ORDER BY s.syncTime DESC")
})
public class SyncLog implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Column(name = "sync_type", nullable = false, length = 50)
    private String syncType; // FULL, INCREMENTAL, MANUAL

    @Column(name = "sync_time", nullable = false)
    private LocalDateTime syncTime;

    @Column(name = "status", nullable = false, length = 20)
    private String status; // SUCCESS, FAILED, IN_PROGRESS

    @Column(name = "records_synced")
    private Integer recordsSynced;

    @Column(name = "students_synced")
    private Integer studentsSynced;

    @Column(name = "payments_synced")
    private Integer paymentsSynced;

    @Column(name = "enrollments_synced")
    private Integer enrollmentsSynced;

    @Column(name = "fee_structures_synced")
    private Integer feeStructuresSynced;

    @Column(name = "offers_synced")
    private Integer offersSynced;

    @Column(name = "error_message", length = 1000)
    private String errorMessage;

    @Column(name = "duration_ms")
    private Long durationMs;

    @Column(name = "triggered_by", length = 100)
    private String triggeredBy; // SCHEDULER, MANUAL, WEBHOOK

    @Column(name = "api_response_code")
    private Integer apiResponseCode;

    // Constructors
    public SyncLog() {
    }

    public SyncLog(String syncType, String triggeredBy) {
        this.syncType = syncType;
        this.triggeredBy = triggeredBy;
        this.syncTime = LocalDateTime.now();
        this.status = "IN_PROGRESS";
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSyncType() {
        return syncType;
    }

    public void setSyncType(String syncType) {
        this.syncType = syncType;
    }

    public LocalDateTime getSyncTime() {
        return syncTime;
    }

    public void setSyncTime(LocalDateTime syncTime) {
        this.syncTime = syncTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getRecordsSynced() {
        return recordsSynced;
    }

    public void setRecordsSynced(Integer recordsSynced) {
        this.recordsSynced = recordsSynced;
    }

    public Integer getStudentsSynced() {
        return studentsSynced;
    }

    public void setStudentsSynced(Integer studentsSynced) {
        this.studentsSynced = studentsSynced;
    }

    public Integer getPaymentsSynced() {
        return paymentsSynced;
    }

    public void setPaymentsSynced(Integer paymentsSynced) {
        this.paymentsSynced = paymentsSynced;
    }

    public Integer getEnrollmentsSynced() {
        return enrollmentsSynced;
    }

    public void setEnrollmentsSynced(Integer enrollmentsSynced) {
        this.enrollmentsSynced = enrollmentsSynced;
    }

    public Integer getFeeStructuresSynced() {
        return feeStructuresSynced;
    }

    public void setFeeStructuresSynced(Integer feeStructuresSynced) {
        this.feeStructuresSynced = feeStructuresSynced;
    }

    public Integer getOffersSynced() {
        return offersSynced;
    }

    public void setOffersSynced(Integer offersSynced) {
        this.offersSynced = offersSynced;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public Long getDurationMs() {
        return durationMs;
    }

    public void setDurationMs(Long durationMs) {
        this.durationMs = durationMs;
    }

    public String getTriggeredBy() {
        return triggeredBy;
    }

    public void setTriggeredBy(String triggeredBy) {
        this.triggeredBy = triggeredBy;
    }

    public Integer getApiResponseCode() {
        return apiResponseCode;
    }

    public void setApiResponseCode(Integer apiResponseCode) {
        this.apiResponseCode = apiResponseCode;
    }

    // Helper methods
    public void markSuccess(int totalRecords) {
        this.status = "SUCCESS";
        this.recordsSynced = totalRecords;
    }

    public void markFailed(String error) {
        this.status = "FAILED";
        this.errorMessage = error;
    }
}
