package com.jiat.recovery.service;

import com.jiat.recovery.entity.SyncLog;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Service for synchronizing financial data from Java Institute API.
 */
@Stateless
@TransactionAttribute(TransactionAttributeType.REQUIRED)
public class FinanceSyncService {

    private static final Logger LOGGER = Logger.getLogger(FinanceSyncService.class.getName());

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    @EJB
    private JavaInstituteApiClient apiClient;

    /**
     * Perform a full sync from Java Institute API.
     * This fetches all data and updates local database.
     */
    public Map<String, Object> performFullSync(String triggeredBy) {
        long startTime = System.currentTimeMillis();

        Map<String, Object> result = new HashMap<>();
        result.put("syncType", "FULL");
        result.put("triggeredBy", triggeredBy);
        result.put("startTime", LocalDateTime.now().toString());

        try {
            // Call full sync endpoint
            JsonObject response = apiClient.fullSync();

            if (!apiClient.isSuccess(response)) {
                throw new RuntimeException("API returned unsuccessful response");
            }

            JsonObject data = response.getJsonObject("data");
            JsonObject counts = response.getJsonObject("counts");

            // Process students
            int studentsCount = processStudents(data.getJsonArray("students"));

            // Process enrollments
            int enrollmentsCount = processEnrollments(data.getJsonArray("enrollments"));

            // Process fee structures
            int feeStructuresCount = processFeeStructures(data.getJsonArray("fee_structures"));

            // Process payments
            int paymentsCount = processPayments(data.getJsonArray("payments"));

            // Process offers
            int offersCount = processOffers(data.getJsonArray("offers"));

            int totalRecords = studentsCount + enrollmentsCount + feeStructuresCount + paymentsCount + offersCount;

            result.put("status", "SUCCESS");
            result.put("studentsCount", studentsCount);
            result.put("enrollmentsCount", enrollmentsCount);
            result.put("feeStructuresCount", feeStructuresCount);
            result.put("paymentsCount", paymentsCount);
            result.put("offersCount", offersCount);
            result.put("totalRecords", totalRecords);

            LOGGER.info("Full sync completed successfully. Total records: " + totalRecords);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Full sync failed", e);
            result.put("status", "FAILED");
            result.put("error", e.getMessage());
        } finally {
            long duration = System.currentTimeMillis() - startTime;
            result.put("durationMs", duration);
            result.put("endTime", LocalDateTime.now().toString());
        }

        return result;
    }

    /**
     * Perform incremental sync - only fetch data since last successful sync.
     */
    public Map<String, Object> performIncrementalSync(String triggeredBy) {
        long startTime = System.currentTimeMillis();

        Map<String, Object> result = new HashMap<>();
        result.put("syncType", "INCREMENTAL");
        result.put("triggeredBy", triggeredBy);
        result.put("startTime", LocalDateTime.now().toString());

        try {
            // For now, just do a full sync from API
            JsonObject response = apiClient.fullSync();

            if (!apiClient.isSuccess(response)) {
                throw new RuntimeException("API returned unsuccessful response");
            }

            JsonObject data = response.getJsonObject("data");

            // Process only payments for incremental (most critical)
            int paymentsCount = processPayments(data.getJsonArray("payments"));

            // Process fee structures (for updated due amounts)
            int feeStructuresCount = processFeeStructures(data.getJsonArray("fee_structures"));

            int totalRecords = paymentsCount + feeStructuresCount;

            result.put("status", "SUCCESS");
            result.put("paymentsCount", paymentsCount);
            result.put("feeStructuresCount", feeStructuresCount);
            result.put("totalRecords", totalRecords);

            LOGGER.info("Incremental sync completed. Records: " + totalRecords);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Incremental sync failed", e);
            result.put("status", "FAILED");
            result.put("error", e.getMessage());
        } finally {
            long duration = System.currentTimeMillis() - startTime;
            result.put("durationMs", duration);
            result.put("endTime", LocalDateTime.now().toString());
        }

        return result;
    }

    /**
     * Check API health status.
     */
    public Map<String, Object> checkApiHealth() {
        Map<String, Object> result = new HashMap<>();
        try {
            JsonObject response = apiClient.healthCheck();
            result.put("status", "UP");
            result.put("apiUrl", apiClient.getApiBaseUrl());
            result.put("message", response.getString("message", "API is running"));
            result.put("timestamp", response.getString("timestamp", LocalDateTime.now().toString()));
        } catch (Exception e) {
            result.put("status", "DOWN");
            result.put("apiUrl", apiClient.getApiBaseUrl());
            result.put("error", e.getMessage());
        }
        return result;
    }

    /**
     * Get sync history.
     */
    public List<SyncLog> getSyncHistory(int limit) {
        return em.createNamedQuery("SyncLog.findAll", SyncLog.class)
                .setMaxResults(limit)
                .getResultList();
    }

    /**
     * Get last successful sync time.
     */
    private String getLastSyncTime() {
        try {
            List<SyncLog> lastSync = em.createNamedQuery("SyncLog.findLastSuccessful", SyncLog.class)
                    .setMaxResults(1)
                    .getResultList();
            if (!lastSync.isEmpty()) {
                LocalDateTime syncTime = lastSync.get(0).getSyncTime();
                return syncTime.format(DateTimeFormatter.ISO_DATE_TIME);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Could not get last sync time", e);
        }
        return null;
    }

    /**
     * Process students data from API.
     * For now, just logs - actual implementation would update local tables.
     */
    private int processStudents(JsonArray students) {
        if (students == null) return 0;
        
        int count = 0;
        for (int i = 0; i < students.size(); i++) {
            JsonObject student = students.getJsonObject(i);
            String nic = student.getString("nic", "");
            String firstName = student.getString("first_name", "");
            String lastName = student.getString("last_name", "");
            
            // Log for now - actual implementation would upsert to general_user_profile
            LOGGER.fine("Processing student: " + nic + " - " + firstName + " " + lastName);
            count++;
        }
        
        LOGGER.info("Processed " + count + " students");
        return count;
    }

    /**
     * Process enrollments data from API.
     */
    private int processEnrollments(JsonArray enrollments) {
        if (enrollments == null) return 0;
        
        int count = 0;
        for (int i = 0; i < enrollments.size(); i++) {
            JsonObject enrollment = enrollments.getJsonObject(i);
            String nic = enrollment.getString("student_nic", "");
            int courseId = enrollment.getInt("course_id", 0);
            String status = enrollment.getString("status", "");
            
            // Log for now - actual implementation would upsert to student_batches
            LOGGER.fine("Processing enrollment: " + nic + " -> Course " + courseId + " (" + status + ")");
            count++;
        }
        
        LOGGER.info("Processed " + count + " enrollments");
        return count;
    }

    /**
     * Process fee structures data from API.
     * This updates scholarship and due amounts.
     */
    private int processFeeStructures(JsonArray feeStructures) {
        if (feeStructures == null) return 0;
        
        int count = 0;
        for (int i = 0; i < feeStructures.size(); i++) {
            JsonObject fee = feeStructures.getJsonObject(i);
            String nic = fee.getString("student_nic", "");
            double totalDueFee = fee.getJsonNumber("total_due_fee").doubleValue();
            double scholarshipPct = fee.getJsonNumber("scholarship_percentage").doubleValue();
            
            // Update student_batches.total_due_fee based on NIC
            try {
                int updated = em.createNativeQuery(
                    "UPDATE student_batches sb " +
                    "JOIN general_user_profile gup ON sb.gup_id = gup.gup_id " +
                    "SET sb.total_due_fee = :totalDue " +
                    "WHERE gup.nic = :nic")
                    .setParameter("totalDue", totalDueFee)
                    .setParameter("nic", nic)
                    .executeUpdate();
                
                if (updated > 0) {
                    LOGGER.fine("Updated due fee for " + nic + ": " + totalDueFee);
                }
            } catch (Exception e) {
                LOGGER.warning("Failed to update fee for " + nic + ": " + e.getMessage());
            }
            
            count++;
        }
        
        LOGGER.info("Processed " + count + " fee structures");
        return count;
    }

    /**
     * Process payments data from API.
     * This is the most critical sync - updates voucher records.
     */
    private int processPayments(JsonArray payments) {
        if (payments == null) return 0;
        
        int count = 0;
        for (int i = 0; i < payments.size(); i++) {
            JsonObject payment = payments.getJsonObject(i);
            int voucherId = payment.getInt("voucher_id", 0);
            String receiptNumber = payment.getString("receipt_number", "");
            String nic = payment.getString("student_nic", "");
            double amount = payment.getJsonNumber("amount").doubleValue();
            String paymentType = payment.getString("payment_type", "");
            
            // Log payment - actual implementation would check if voucher exists and update
            LOGGER.fine("Processing payment: " + receiptNumber + " - " + nic + " - " + amount + " (" + paymentType + ")");
            
            // Check if this payment already exists in our system
            // If not, we might want to flag it or create a record
            
            count++;
        }
        
        LOGGER.info("Processed " + count + " payments");
        return count;
    }

    /**
     * Process offers data from API.
     */
    private int processOffers(JsonArray offers) {
        if (offers == null) return 0;
        
        int count = 0;
        for (int i = 0; i < offers.size(); i++) {
            JsonObject offer = offers.getJsonObject(i);
            String nic = offer.getString("student_nic", "");
            String offerName = offer.getString("offer_name", "");
            double discountAmount = offer.getJsonNumber("discount_amount").doubleValue();
            
            // Log for now - actual implementation would update offer_manager
            LOGGER.fine("Processing offer: " + nic + " - " + offerName + " - " + discountAmount);
            count++;
        }
        
        LOGGER.info("Processed " + count + " offers");
        return count;
    }
}
