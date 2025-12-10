package com.jiat.recovery.service;

import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.entity.RecoveryAuditLog;
import com.jiat.recovery.entity.enums.CaseStatus;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.List;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * EJB Service for recovery case management.
 */
@Stateless
public class RecoveryCaseService {

    private static final Logger logger = LoggerFactory.getLogger(RecoveryCaseService.class);

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    /**
     * Create a new recovery case for a student.
     */
    public RecoveryCase createCase(Integer studentSId, Long createdBy) {
        // Check if case already exists
        Optional<RecoveryCase> existing = findByStudentId(studentSId);
        if (existing.isPresent()) {
            logger.warn("Recovery case already exists for student: {}", studentSId);
            return existing.get();
        }

        RecoveryCase recoveryCase = new RecoveryCase();
        recoveryCase.setStudentSId(studentSId);
        recoveryCase.setCaseNumber(generateCaseNumber());
        recoveryCase.setStatus(CaseStatus.OPEN);
        recoveryCase.setCreatedBy(createdBy);

        em.persist(recoveryCase);
        
        // Audit log
        logAudit(createdBy, "CASE_CREATED", "recovery_case", recoveryCase.getId(), 
                "Created recovery case " + recoveryCase.getCaseNumber());

        logger.info("Created recovery case {} for student {}", recoveryCase.getCaseNumber(), studentSId);
        return recoveryCase;
    }

    /**
     * Find recovery case by ID.
     */
    public Optional<RecoveryCase> findById(Long id) {
        try {
            RecoveryCase recoveryCase = em.find(RecoveryCase.class, id);
            return Optional.ofNullable(recoveryCase);
        } catch (Exception e) {
            logger.error("Error finding recovery case by ID: {}", id, e);
            return Optional.empty();
        }
    }

    /**
     * Find recovery case by case number.
     */
    public Optional<RecoveryCase> findByCaseNumber(String caseNumber) {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery("RecoveryCase.findByCaseNumber", RecoveryCase.class);
            query.setParameter("caseNumber", caseNumber);
            List<RecoveryCase> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding recovery case by number: {}", caseNumber, e);
            return Optional.empty();
        }
    }

    /**
     * Find recovery case by student ID.
     */
    public Optional<RecoveryCase> findByStudentId(Integer studentSId) {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery("RecoveryCase.findByStudentId", RecoveryCase.class);
            query.setParameter("studentSId", studentSId);
            List<RecoveryCase> results = query.getResultList();
            return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
        } catch (Exception e) {
            logger.error("Error finding recovery case by student ID: {}", studentSId, e);
            return Optional.empty();
        }
    }

    /**
     * Find all open cases.
     */
    public List<RecoveryCase> findOpenCases() {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery("RecoveryCase.findOpenCases", RecoveryCase.class);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error finding open cases", e);
            return List.of();
        }
    }

    /**
     * Find cases by status.
     */
    public List<RecoveryCase> findByStatus(CaseStatus status) {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery("RecoveryCase.findByStatus", RecoveryCase.class);
            query.setParameter("status", status);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error finding cases by status: {}", status, e);
            return List.of();
        }
    }

    /**
     * Find cases assigned to an officer.
     */
    public List<RecoveryCase> findByOfficer(Long officerId) {
        try {
            TypedQuery<RecoveryCase> query = em.createNamedQuery("RecoveryCase.findByOfficer", RecoveryCase.class);
            query.setParameter("officerId", officerId);
            return query.getResultList();
        } catch (Exception e) {
            logger.error("Error finding cases by officer: {}", officerId, e);
            return List.of();
        }
    }

    /**
     * Update case status.
     */
    public RecoveryCase updateStatus(Long caseId, CaseStatus newStatus, Long updatedBy) {
        RecoveryCase recoveryCase = em.find(RecoveryCase.class, caseId);
        if (recoveryCase == null) {
            throw new IllegalArgumentException("Recovery case not found: " + caseId);
        }

        CaseStatus oldStatus = recoveryCase.getStatus();
        recoveryCase.setStatus(newStatus);
        recoveryCase.setUpdatedBy(updatedBy);

        em.merge(recoveryCase);

        // Audit log
        logAudit(updatedBy, "STATUS_CHANGED", "recovery_case", caseId,
                "Status changed from " + oldStatus + " to " + newStatus);

        logger.info("Updated case {} status from {} to {}", recoveryCase.getCaseNumber(), oldStatus, newStatus);
        return recoveryCase;
    }

    /**
     * Assign case to an officer.
     */
    public RecoveryCase assignToOfficer(Long caseId, Long officerId, Long assignedBy) {
        RecoveryCase recoveryCase = em.find(RecoveryCase.class, caseId);
        if (recoveryCase == null) {
            throw new IllegalArgumentException("Recovery case not found: " + caseId);
        }

        Long previousOfficer = recoveryCase.getAssignedOfficerId();
        recoveryCase.setAssignedOfficerId(officerId);
        recoveryCase.setUpdatedBy(assignedBy);

        if (recoveryCase.getStatus() == CaseStatus.OPEN) {
            recoveryCase.setStatus(CaseStatus.IN_PROGRESS);
        }

        em.merge(recoveryCase);

        // Audit log
        logAudit(assignedBy, "CASE_ASSIGNED", "recovery_case", caseId,
                "Assigned to officer " + officerId + " (was: " + previousOfficer + ")");

        logger.info("Assigned case {} to officer {}", recoveryCase.getCaseNumber(), officerId);
        return recoveryCase;
    }

    /**
     * Update calculated due amount.
     */
    public RecoveryCase updateCalculatedDue(Long caseId, Double calculatedDue, Long updatedBy) {
        RecoveryCase recoveryCase = em.find(RecoveryCase.class, caseId);
        if (recoveryCase == null) {
            throw new IllegalArgumentException("Recovery case not found: " + caseId);
        }

        recoveryCase.setCurrentCalculatedDue(calculatedDue);
        recoveryCase.setLastCalculationDate(LocalDateTime.now());
        recoveryCase.setUpdatedBy(updatedBy);

        em.merge(recoveryCase);

        logger.info("Updated case {} calculated due to {}", recoveryCase.getCaseNumber(), calculatedDue);
        return recoveryCase;
    }

    /**
     * Add notes to a case.
     */
    public RecoveryCase addNotes(Long caseId, String notes, Long updatedBy) {
        RecoveryCase recoveryCase = em.find(RecoveryCase.class, caseId);
        if (recoveryCase == null) {
            throw new IllegalArgumentException("Recovery case not found: " + caseId);
        }

        String existingNotes = recoveryCase.getNotes();
        String timestamp = LocalDateTime.now().toString();
        String newNotes = (existingNotes != null ? existingNotes + "\n\n" : "") 
                + "[" + timestamp + "] " + notes;
        
        recoveryCase.setNotes(newNotes);
        recoveryCase.setUpdatedBy(updatedBy);

        em.merge(recoveryCase);

        logger.info("Added notes to case {}", recoveryCase.getCaseNumber());
        return recoveryCase;
    }

    /**
     * Generate unique case number.
     */
    private String generateCaseNumber() {
        int year = Year.now().getValue();
        
        // Get current max sequence for this year
        String prefix = "REC-" + year + "-";
        TypedQuery<String> query = em.createQuery(
            "SELECT r.caseNumber FROM RecoveryCase r WHERE r.caseNumber LIKE :prefix ORDER BY r.caseNumber DESC",
            String.class);
        query.setParameter("prefix", prefix + "%");
        query.setMaxResults(1);
        
        List<String> results = query.getResultList();
        long sequence = 1;
        
        if (!results.isEmpty()) {
            String lastNumber = results.get(0);
            String seqStr = lastNumber.substring(prefix.length());
            try {
                sequence = Long.parseLong(seqStr) + 1;
            } catch (NumberFormatException e) {
                logger.warn("Could not parse sequence from: {}", lastNumber);
            }
        }
        
        return RecoveryCase.generateCaseNumber(year, sequence);
    }

    /**
     * Log audit entry.
     */
    private void logAudit(Long userId, String action, String entityType, Long entityId, String description) {
        try {
            RecoveryAuditLog log = RecoveryAuditLog.create(userId, null, action, entityType, entityId, description);
            em.persist(log);
        } catch (Exception e) {
            logger.error("Failed to create audit log", e);
        }
    }
}
