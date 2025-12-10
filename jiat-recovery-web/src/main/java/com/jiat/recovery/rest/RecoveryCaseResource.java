package com.jiat.recovery.rest;

import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.entity.RecoveryCalculation;
import com.jiat.recovery.entity.enums.CaseStatus;
import com.jiat.recovery.entity.enums.CalculationType;
import com.jiat.recovery.service.RecoveryCaseService;
import com.jiat.recovery.service.RecoveryCalculationService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;

/**
 * REST Resource for recovery case operations.
 */
@Path("/cases")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class RecoveryCaseResource {

    @Inject
    private RecoveryCaseService caseService;

    @Inject
    private RecoveryCalculationService calculationService;

    /**
     * Create a new recovery case.
     */
    @POST
    public Response createCase(CreateCaseRequest request) {
        try {
            RecoveryCase recoveryCase = caseService.createCase(
                    request.studentSId, request.createdBy);
            return Response.status(Response.Status.CREATED)
                    .entity(recoveryCase)
                    .build();
        } catch (Exception e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * Get recovery case by ID.
     */
    @GET
    @Path("/{id}")
    public Response getById(@PathParam("id") Long id) {
        Optional<RecoveryCase> recoveryCase = caseService.findById(id);
        if (recoveryCase.isPresent()) {
            return Response.ok(recoveryCase.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Recovery case not found\"}")
                .build();
    }

    /**
     * Get recovery case by case number.
     */
    @GET
    @Path("/by-number/{caseNumber}")
    public Response getByCaseNumber(@PathParam("caseNumber") String caseNumber) {
        Optional<RecoveryCase> recoveryCase = caseService.findByCaseNumber(caseNumber);
        if (recoveryCase.isPresent()) {
            return Response.ok(recoveryCase.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Recovery case not found\"}")
                .build();
    }

    /**
     * Get recovery case by student ID.
     */
    @GET
    @Path("/by-student/{studentSId}")
    public Response getByStudentId(@PathParam("studentSId") Integer studentSId) {
        Optional<RecoveryCase> recoveryCase = caseService.findByStudentId(studentSId);
        if (recoveryCase.isPresent()) {
            return Response.ok(recoveryCase.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Recovery case not found\"}")
                .build();
    }

    /**
     * Get all open cases.
     */
    @GET
    @Path("/open")
    public Response getOpenCases() {
        List<RecoveryCase> cases = caseService.findOpenCases();
        return Response.ok(cases).build();
    }

    /**
     * Get cases by status.
     */
    @GET
    @Path("/by-status/{status}")
    public Response getByStatus(@PathParam("status") String status) {
        try {
            CaseStatus caseStatus = CaseStatus.valueOf(status.toUpperCase());
            List<RecoveryCase> cases = caseService.findByStatus(caseStatus);
            return Response.ok(cases).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"Invalid status\"}")
                    .build();
        }
    }

    /**
     * Get cases assigned to an officer.
     */
    @GET
    @Path("/by-officer/{officerId}")
    public Response getByOfficer(@PathParam("officerId") Long officerId) {
        List<RecoveryCase> cases = caseService.findByOfficer(officerId);
        return Response.ok(cases).build();
    }

    /**
     * Update case status.
     */
    @PUT
    @Path("/{id}/status")
    public Response updateStatus(@PathParam("id") Long id, UpdateStatusRequest request) {
        try {
            CaseStatus newStatus = CaseStatus.valueOf(request.status.toUpperCase());
            RecoveryCase recoveryCase = caseService.updateStatus(id, newStatus, request.updatedBy);
            return Response.ok(recoveryCase).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * Assign case to an officer.
     */
    @PUT
    @Path("/{id}/assign")
    public Response assignToOfficer(@PathParam("id") Long id, AssignRequest request) {
        try {
            RecoveryCase recoveryCase = caseService.assignToOfficer(
                    id, request.officerId, request.assignedBy);
            return Response.ok(recoveryCase).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * Add notes to a case.
     */
    @POST
    @Path("/{id}/notes")
    public Response addNotes(@PathParam("id") Long id, AddNotesRequest request) {
        try {
            RecoveryCase recoveryCase = caseService.addNotes(id, request.notes, request.updatedBy);
            return Response.ok(recoveryCase).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * Calculate dues for a case.
     */
    @POST
    @Path("/{id}/calculate")
    public Response calculateDues(@PathParam("id") Long id, CalculateRequest request) {
        try {
            CalculationType calcType = CalculationType.valueOf(
                    request.calculationType != null ? request.calculationType.toUpperCase() : "INITIAL");
            RecoveryCalculation calculation = calculationService.calculateDues(id, calcType, request.calculatedBy);
            return Response.ok(calculation).build();
        } catch (Exception e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"" + e.getMessage() + "\"}")
                    .build();
        }
    }

    /**
     * Get calculations for a case.
     */
    @GET
    @Path("/{id}/calculations")
    public Response getCalculations(@PathParam("id") Long id) {
        List<RecoveryCalculation> calculations = calculationService.findByCaseId(id);
        return Response.ok(calculations).build();
    }

    /**
     * Get latest calculation for a case.
     */
    @GET
    @Path("/{id}/calculations/latest")
    public Response getLatestCalculation(@PathParam("id") Long id) {
        Optional<RecoveryCalculation> calculation = calculationService.findLatestByCaseId(id);
        if (calculation.isPresent()) {
            return Response.ok(calculation.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"No calculations found\"}")
                .build();
    }

    // Request DTOs
    public static class CreateCaseRequest {
        public Integer studentSId;
        public Long createdBy;
    }

    public static class UpdateStatusRequest {
        public String status;
        public Long updatedBy;
    }

    public static class AssignRequest {
        public Long officerId;
        public Long assignedBy;
    }

    public static class AddNotesRequest {
        public String notes;
        public Long updatedBy;
    }

    public static class CalculateRequest {
        public String calculationType;
        public Long calculatedBy;
    }
}
