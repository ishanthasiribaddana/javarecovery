package com.jiat.recovery.rest;

import com.jiat.recovery.dto.OutstandingReportResponse;
import com.jiat.recovery.service.OutstandingReportService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.Map;

/**
 * REST Resource for outstanding report.
 */
@Path("/outstanding")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class OutstandingResource {

    @Inject
    private OutstandingReportService outstandingService;

    /**
     * Get paginated outstanding report.
     */
    @GET
    public Response getReport(
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("50") int size,
            @QueryParam("search") @DefaultValue("") String search) {
        
        OutstandingReportResponse response = outstandingService.getOutstandingReport(page, size, search);
        return Response.ok(response).build();
    }

    /**
     * Get summary totals only.
     */
    @GET
    @Path("/summary")
    public Response getSummary() {
        Map<String, Double> summary = outstandingService.getSummary();
        return Response.ok(summary).build();
    }

    /**
     * Get total outstanding amount.
     */
    @GET
    @Path("/total")
    public Response getTotalOutstanding() {
        double total = outstandingService.getTotalOutstanding();
        return Response.ok(Map.of("totalOutstanding", total)).build();
    }
}
