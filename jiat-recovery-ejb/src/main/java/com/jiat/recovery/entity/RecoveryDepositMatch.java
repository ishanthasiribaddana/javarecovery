package com.jiat.recovery.entity;

import com.jiat.recovery.entity.enums.MatchType;
import jakarta.persistence.*;
import java.time.LocalDateTime;

/**
 * Deposit match entity - links bank imports to students.
 */
@Entity
@Table(name = "recovery_deposit_match")
@NamedQueries({
    @NamedQuery(name = "RecoveryDepositMatch.findByImportId", 
                query = "SELECT m FROM RecoveryDepositMatch m WHERE m.bankStatementImportId = :importId AND m.isActive = true"),
    @NamedQuery(name = "RecoveryDepositMatch.findByStudentId", 
                query = "SELECT m FROM RecoveryDepositMatch m WHERE m.studentSId = :studentSId AND m.isActive = true"),
    @NamedQuery(name = "RecoveryDepositMatch.findByCaseId", 
                query = "SELECT m FROM RecoveryDepositMatch m WHERE m.recoveryCaseId = :caseId AND m.isActive = true"),
    @NamedQuery(name = "RecoveryDepositMatch.findUnverified", 
                query = "SELECT m FROM RecoveryDepositMatch m WHERE m.verified = false AND m.isActive = true"),
    @NamedQuery(name = "RecoveryDepositMatch.findVerifiedByStudentId", 
                query = "SELECT m FROM RecoveryDepositMatch m WHERE m.studentSId = :studentSId AND m.verified = true AND m.isActive = true")
})
public class RecoveryDepositMatch extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "bank_statement_import_id", nullable = false)
    private Long bankStatementImportId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "bank_statement_import_id", insertable = false, updatable = false)
    private RecoveryBankStatementImport bankStatementImport;

    @Column(name = "student_s_id", nullable = false)
    private Integer studentSId;

    @Column(name = "recovery_case_id")
    private Long recoveryCaseId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "recovery_case_id", insertable = false, updatable = false)
    private RecoveryCase recoveryCase;

    @Enumerated(EnumType.STRING)
    @Column(name = "match_type")
    private MatchType matchType = MatchType.MANUAL;

    @Column(name = "match_confidence")
    private Double matchConfidence;

    @Column(name = "verified")
    private Boolean verified = false;

    @Column(name = "verified_by")
    private Long verifiedBy;

    @Column(name = "verified_date")
    private LocalDateTime verifiedDate;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getBankStatementImportId() {
        return bankStatementImportId;
    }

    public void setBankStatementImportId(Long bankStatementImportId) {
        this.bankStatementImportId = bankStatementImportId;
    }

    public RecoveryBankStatementImport getBankStatementImport() {
        return bankStatementImport;
    }

    public void setBankStatementImport(RecoveryBankStatementImport bankStatementImport) {
        this.bankStatementImport = bankStatementImport;
        if (bankStatementImport != null) {
            this.bankStatementImportId = bankStatementImport.getId();
        }
    }

    public Integer getStudentSId() {
        return studentSId;
    }

    public void setStudentSId(Integer studentSId) {
        this.studentSId = studentSId;
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

    public MatchType getMatchType() {
        return matchType;
    }

    public void setMatchType(MatchType matchType) {
        this.matchType = matchType;
    }

    public Double getMatchConfidence() {
        return matchConfidence;
    }

    public void setMatchConfidence(Double matchConfidence) {
        this.matchConfidence = matchConfidence;
    }

    public Boolean getVerified() {
        return verified;
    }

    public void setVerified(Boolean verified) {
        this.verified = verified;
    }

    public Long getVerifiedBy() {
        return verifiedBy;
    }

    public void setVerifiedBy(Long verifiedBy) {
        this.verifiedBy = verifiedBy;
    }

    public LocalDateTime getVerifiedDate() {
        return verifiedDate;
    }

    public void setVerifiedDate(LocalDateTime verifiedDate) {
        this.verifiedDate = verifiedDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    /**
     * Verify this match.
     */
    public void verify(Long verifierId) {
        this.verified = true;
        this.verifiedBy = verifierId;
        this.verifiedDate = LocalDateTime.now();
    }

    /**
     * Unverify this match.
     */
    public void unverify() {
        this.verified = false;
        this.verifiedBy = null;
        this.verifiedDate = null;
    }
}
