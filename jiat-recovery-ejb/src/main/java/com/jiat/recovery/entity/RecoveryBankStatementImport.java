package com.jiat.recovery.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Bank statement import entity - for CSV/Excel imports.
 */
@Entity
@Table(name = "recovery_bank_statement_import")
@NamedQueries({
    @NamedQuery(name = "RecoveryBankStatementImport.findByBatchId", 
                query = "SELECT b FROM RecoveryBankStatementImport b WHERE b.importBatchId = :batchId AND b.isActive = true"),
    @NamedQuery(name = "RecoveryBankStatementImport.findByReference", 
                query = "SELECT b FROM RecoveryBankStatementImport b WHERE b.referenceNumber = :reference AND b.isActive = true"),
    @NamedQuery(name = "RecoveryBankStatementImport.findUnmatched", 
                query = "SELECT b FROM RecoveryBankStatementImport b WHERE b.isMatched = false AND b.isActive = true ORDER BY b.transactionDate DESC"),
    @NamedQuery(name = "RecoveryBankStatementImport.findByDateRange", 
                query = "SELECT b FROM RecoveryBankStatementImport b WHERE b.transactionDate BETWEEN :startDate AND :endDate AND b.isActive = true ORDER BY b.transactionDate DESC"),
    @NamedQuery(name = "RecoveryBankStatementImport.findByStudentId", 
                query = "SELECT b FROM RecoveryBankStatementImport b WHERE b.matchedStudentSId = :studentSId AND b.isActive = true ORDER BY b.transactionDate DESC")
})
public class RecoveryBankStatementImport extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "import_batch_id", length = 50)
    private String importBatchId;

    @Column(name = "bank_account_ba_id")
    private Integer bankAccountBaId;

    @Column(name = "transaction_date")
    private LocalDate transactionDate;

    @Column(name = "reference_number", length = 100)
    private String referenceNumber;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "currency_type_id")
    private Integer currencyTypeId = 1; // Default LKR

    @Column(name = "is_matched")
    private Boolean isMatched = false;

    @Column(name = "matched_student_s_id")
    private Integer matchedStudentSId;

    @Column(name = "matched_by")
    private Long matchedBy;

    @Column(name = "matched_date")
    private LocalDateTime matchedDate;

    @Column(name = "import_file_name")
    private String importFileName;

    @Column(name = "import_date")
    private LocalDateTime importDate;

    @Column(name = "imported_by")
    private Long importedBy;

    @PrePersist
    @Override
    protected void onCreate() {
        super.onCreate();
        if (this.importDate == null) {
            this.importDate = LocalDateTime.now();
        }
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getImportBatchId() {
        return importBatchId;
    }

    public void setImportBatchId(String importBatchId) {
        this.importBatchId = importBatchId;
    }

    public Integer getBankAccountBaId() {
        return bankAccountBaId;
    }

    public void setBankAccountBaId(Integer bankAccountBaId) {
        this.bankAccountBaId = bankAccountBaId;
    }

    public LocalDate getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    public String getReferenceNumber() {
        return referenceNumber;
    }

    public void setReferenceNumber(String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Integer getCurrencyTypeId() {
        return currencyTypeId;
    }

    public void setCurrencyTypeId(Integer currencyTypeId) {
        this.currencyTypeId = currencyTypeId;
    }

    public Boolean getIsMatched() {
        return isMatched;
    }

    public void setIsMatched(Boolean isMatched) {
        this.isMatched = isMatched;
    }

    public Integer getMatchedStudentSId() {
        return matchedStudentSId;
    }

    public void setMatchedStudentSId(Integer matchedStudentSId) {
        this.matchedStudentSId = matchedStudentSId;
    }

    public Long getMatchedBy() {
        return matchedBy;
    }

    public void setMatchedBy(Long matchedBy) {
        this.matchedBy = matchedBy;
    }

    public LocalDateTime getMatchedDate() {
        return matchedDate;
    }

    public void setMatchedDate(LocalDateTime matchedDate) {
        this.matchedDate = matchedDate;
    }

    public String getImportFileName() {
        return importFileName;
    }

    public void setImportFileName(String importFileName) {
        this.importFileName = importFileName;
    }

    public LocalDateTime getImportDate() {
        return importDate;
    }

    public void setImportDate(LocalDateTime importDate) {
        this.importDate = importDate;
    }

    public Long getImportedBy() {
        return importedBy;
    }

    public void setImportedBy(Long importedBy) {
        this.importedBy = importedBy;
    }

    /**
     * Mark this deposit as matched to a student.
     */
    public void markAsMatched(Integer studentSId, Long matchedByUserId) {
        this.isMatched = true;
        this.matchedStudentSId = studentSId;
        this.matchedBy = matchedByUserId;
        this.matchedDate = LocalDateTime.now();
    }

    /**
     * Unmatch this deposit.
     */
    public void unmatch() {
        this.isMatched = false;
        this.matchedStudentSId = null;
        this.matchedBy = null;
        this.matchedDate = null;
    }
}
