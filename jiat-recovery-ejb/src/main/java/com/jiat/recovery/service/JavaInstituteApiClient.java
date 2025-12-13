package com.jiat.recovery.service;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Stateless;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import java.io.StringReader;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * HTTP Client for Java Institute API.
 * Handles all communication with the external Java Institute system.
 */
@Stateless
public class JavaInstituteApiClient {

    private static final Logger LOGGER = Logger.getLogger(JavaInstituteApiClient.class.getName());
    
    // Configuration - can be externalized to properties file
    private String apiBaseUrl = "http://localhost:8081/api/v1";
    private String apiKey = "JIAT-MOCK-API-KEY-2025";
    private int timeoutSeconds = 30;
    
    private HttpClient httpClient;

    @PostConstruct
    public void init() {
        httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(timeoutSeconds))
                .build();
        LOGGER.info("JavaInstituteApiClient initialized with base URL: " + apiBaseUrl);
    }

    /**
     * Get all students from Java Institute.
     */
    public JsonObject getStudents() throws Exception {
        return makeGetRequest("/students");
    }

    /**
     * Get student by NIC.
     */
    public JsonObject getStudentByNic(String nic) throws Exception {
        return makeGetRequest("/students/" + nic);
    }

    /**
     * Get all enrollments.
     */
    public JsonObject getEnrollments() throws Exception {
        return makeGetRequest("/enrollments");
    }

    /**
     * Get enrollments by student NIC.
     */
    public JsonObject getEnrollmentsByNic(String nic) throws Exception {
        return makeGetRequest("/enrollments?nic=" + nic);
    }

    /**
     * Get all fee structures.
     */
    public JsonObject getFeeStructures() throws Exception {
        return makeGetRequest("/fee-structure");
    }

    /**
     * Get fee structure by student NIC.
     */
    public JsonObject getFeeStructureByNic(String nic) throws Exception {
        return makeGetRequest("/fee-structure/" + nic);
    }

    /**
     * Get all payments.
     */
    public JsonObject getPayments() throws Exception {
        return makeGetRequest("/payments");
    }

    /**
     * Get payments since a specific timestamp.
     */
    public JsonObject getPaymentsSince(String since) throws Exception {
        return makeGetRequest("/payments?since=" + since);
    }

    /**
     * Get payments by student NIC.
     */
    public JsonObject getPaymentsByNic(String nic) throws Exception {
        return makeGetRequest("/payments?nic=" + nic);
    }

    /**
     * Get all offers.
     */
    public JsonObject getOffers() throws Exception {
        return makeGetRequest("/offers");
    }

    /**
     * Get offers by student NIC.
     */
    public JsonObject getOffersByNic(String nic) throws Exception {
        return makeGetRequest("/offers?nic=" + nic);
    }

    /**
     * Full sync endpoint - gets all data.
     */
    public JsonObject fullSync() throws Exception {
        return makeGetRequest("/sync");
    }

    /**
     * Incremental sync - gets data since timestamp.
     */
    public JsonObject incrementalSync(String since) throws Exception {
        return makeGetRequest("/sync?since=" + since);
    }

    /**
     * Health check endpoint.
     */
    public JsonObject healthCheck() throws Exception {
        return makeGetRequest("/health", false);
    }

    /**
     * Make a GET request to the API.
     */
    private JsonObject makeGetRequest(String endpoint) throws Exception {
        return makeGetRequest(endpoint, true);
    }

    /**
     * Make a GET request to the API.
     */
    private JsonObject makeGetRequest(String endpoint, boolean requiresAuth) throws Exception {
        String url = apiBaseUrl + endpoint;
        LOGGER.info("Making GET request to: " + url);

        HttpRequest.Builder requestBuilder = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .timeout(Duration.ofSeconds(timeoutSeconds))
                .header("Content-Type", "application/json")
                .GET();

        if (requiresAuth) {
            requestBuilder.header("X-API-Key", apiKey);
        }

        HttpRequest request = requestBuilder.build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        LOGGER.info("Response status: " + response.statusCode());

        if (response.statusCode() != 200) {
            throw new RuntimeException("API request failed with status: " + response.statusCode() + ", body: " + response.body());
        }

        try (JsonReader reader = Json.createReader(new StringReader(response.body()))) {
            return reader.readObject();
        }
    }

    /**
     * Extract data array from API response.
     */
    public JsonArray extractDataArray(JsonObject response) {
        if (response.containsKey("data") && response.get("data") instanceof JsonArray) {
            return response.getJsonArray("data");
        }
        return Json.createArrayBuilder().build();
    }

    /**
     * Check if API response was successful.
     */
    public boolean isSuccess(JsonObject response) {
        return response.getBoolean("success", false);
    }

    // Setters for configuration (can be called from external config)
    public void setApiBaseUrl(String apiBaseUrl) {
        this.apiBaseUrl = apiBaseUrl;
    }

    public void setApiKey(String apiKey) {
        this.apiKey = apiKey;
    }

    public void setTimeoutSeconds(int timeoutSeconds) {
        this.timeoutSeconds = timeoutSeconds;
    }

    public String getApiBaseUrl() {
        return apiBaseUrl;
    }
}
