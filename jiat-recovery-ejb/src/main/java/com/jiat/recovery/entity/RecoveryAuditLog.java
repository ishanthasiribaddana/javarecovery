package com.jiat.recovery.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Audit log entity - tracks all recovery actions.
 */
@Entity
@Table(name = "recovery_audit_log")
@NamedQueries({
    @NamedQuery(name = "RecoveryAuditLog.findByUserId", 
                query = "SELECT a FROM RecoveryAuditLog a WHERE a.userId = :userId ORDER BY a.createdAt DESC"),
    @NamedQuery(name = "RecoveryAuditLog.findByAction", 
                query = "SELECT a FROM RecoveryAuditLog a WHERE a.action = :action ORDER BY a.createdAt DESC"),
    @NamedQuery(name = "RecoveryAuditLog.findByEntity", 
                query = "SELECT a FROM RecoveryAuditLog a WHERE a.entityType = :entityType AND a.entityId = :entityId ORDER BY a.createdAt DESC"),
    @NamedQuery(name = "RecoveryAuditLog.findByDateRange", 
                query = "SELECT a FROM RecoveryAuditLog a WHERE a.createdAt BETWEEN :startDate AND :endDate ORDER BY a.createdAt DESC")
})
public class RecoveryAuditLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "username", length = 100)
    private String username;

    @Column(name = "action", nullable = false, length = 100)
    private String action;

    @Column(name = "entity_type", length = 100)
    private String entityType;

    @Column(name = "entity_id")
    private Long entityId;

    @Column(name = "old_values_json", columnDefinition = "TEXT")
    private String oldValuesJson;

    @Column(name = "new_values_json", columnDefinition = "TEXT")
    private String newValuesJson;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "ip_address", length = 50)
    private String ipAddress;

    @Column(name = "user_agent", columnDefinition = "TEXT")
    private String userAgent;

    @Column(name = "request_url", length = 500)
    private String requestUrl;

    @Column(name = "request_method", length = 10)
    private String requestMethod;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getEntityType() {
        return entityType;
    }

    public void setEntityType(String entityType) {
        this.entityType = entityType;
    }

    public Long getEntityId() {
        return entityId;
    }

    public void setEntityId(Long entityId) {
        this.entityId = entityId;
    }

    public String getOldValuesJson() {
        return oldValuesJson;
    }

    public void setOldValuesJson(String oldValuesJson) {
        this.oldValuesJson = oldValuesJson;
    }

    public String getNewValuesJson() {
        return newValuesJson;
    }

    public void setNewValuesJson(String newValuesJson) {
        this.newValuesJson = newValuesJson;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }

    public String getRequestUrl() {
        return requestUrl;
    }

    public void setRequestUrl(String requestUrl) {
        this.requestUrl = requestUrl;
    }

    public String getRequestMethod() {
        return requestMethod;
    }

    public void setRequestMethod(String requestMethod) {
        this.requestMethod = requestMethod;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Create an audit log entry.
     */
    public static RecoveryAuditLog create(Long userId, String username, String action, 
            String entityType, Long entityId, String description) {
        RecoveryAuditLog log = new RecoveryAuditLog();
        log.setUserId(userId);
        log.setUsername(username);
        log.setAction(action);
        log.setEntityType(entityType);
        log.setEntityId(entityId);
        log.setDescription(description);
        return log;
    }
}
