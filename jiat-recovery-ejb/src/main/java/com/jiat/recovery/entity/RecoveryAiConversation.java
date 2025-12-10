package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.MessageRole;
import jakarta.persistence.*;

/**
 * AI conversation history entity.
 */
@Entity
@Table(name = "recovery_ai_conversation")
@NamedQueries({
    @NamedQuery(name = "RecoveryAiConversation.findBySessionId", 
                query = "SELECT c FROM RecoveryAiConversation c WHERE c.sessionId = :sessionId AND c.isActive = true ORDER BY c.createdAt ASC"),
    @NamedQuery(name = "RecoveryAiConversation.findByStudentId", 
                query = "SELECT c FROM RecoveryAiConversation c WHERE c.studentSId = :studentSId AND c.isActive = true ORDER BY c.createdAt DESC"),
    @NamedQuery(name = "RecoveryAiConversation.findByUserId", 
                query = "SELECT c FROM RecoveryAiConversation c WHERE c.userId = :userId AND c.isActive = true ORDER BY c.createdAt DESC"),
    @NamedQuery(name = "RecoveryAiConversation.findByCaseId", 
                query = "SELECT c FROM RecoveryAiConversation c WHERE c.recoveryCaseId = :caseId AND c.isActive = true ORDER BY c.createdAt DESC"),
    @NamedQuery(name = "RecoveryAiConversation.findRecentSessions", 
                query = "SELECT DISTINCT c.sessionId FROM RecoveryAiConversation c WHERE c.isActive = true ORDER BY c.createdAt DESC")
})
public class RecoveryAiConversation extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "session_id", length = 100)
    private String sessionId;

    @Column(name = "student_s_id")
    private Integer studentSId;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "recovery_case_id")
    private Long recoveryCaseId;

    @Enumerated(EnumType.STRING)
    @Column(name = "role", nullable = false)
    private MessageRole role;

    @Column(name = "message", columnDefinition = "TEXT", nullable = false)
    private String message;

    @Column(name = "context_json", columnDefinition = "TEXT")
    private String contextJson;

    @Column(name = "tokens_used")
    private Integer tokensUsed;

    @Column(name = "model_used", length = 50)
    private String modelUsed;

    @Column(name = "response_time_ms")
    private Integer responseTimeMs;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public Integer getStudentSId() {
        return studentSId;
    }

    public void setStudentSId(Integer studentSId) {
        this.studentSId = studentSId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getRecoveryCaseId() {
        return recoveryCaseId;
    }

    public void setRecoveryCaseId(Long recoveryCaseId) {
        this.recoveryCaseId = recoveryCaseId;
    }

    public MessageRole getRole() {
        return role;
    }

    public void setRole(MessageRole role) {
        this.role = role;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getContextJson() {
        return contextJson;
    }

    public void setContextJson(String contextJson) {
        this.contextJson = contextJson;
    }

    public Integer getTokensUsed() {
        return tokensUsed;
    }

    public void setTokensUsed(Integer tokensUsed) {
        this.tokensUsed = tokensUsed;
    }

    public String getModelUsed() {
        return modelUsed;
    }

    public void setModelUsed(String modelUsed) {
        this.modelUsed = modelUsed;
    }

    public Integer getResponseTimeMs() {
        return responseTimeMs;
    }

    public void setResponseTimeMs(Integer responseTimeMs) {
        this.responseTimeMs = responseTimeMs;
    }

    /**
     * Create a user message.
     */
    public static RecoveryAiConversation createUserMessage(String sessionId, String message, Integer studentSId) {
        RecoveryAiConversation conv = new RecoveryAiConversation();
        conv.setSessionId(sessionId);
        conv.setRole(MessageRole.USER);
        conv.setMessage(message);
        conv.setStudentSId(studentSId);
        return conv;
    }

    /**
     * Create an assistant message.
     */
    public static RecoveryAiConversation createAssistantMessage(String sessionId, String message, 
            Integer tokensUsed, String modelUsed, Integer responseTimeMs) {
        RecoveryAiConversation conv = new RecoveryAiConversation();
        conv.setSessionId(sessionId);
        conv.setRole(MessageRole.ASSISTANT);
        conv.setMessage(message);
        conv.setTokensUsed(tokensUsed);
        conv.setModelUsed(modelUsed);
        conv.setResponseTimeMs(responseTimeMs);
        return conv;
    }
}
