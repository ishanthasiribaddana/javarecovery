package com.jiat.recovery.rest;

import com.jiat.recovery.entity.SyncLog;
import com.jiat.recovery.service.FinanceSyncService;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Map;

/**
 * REST resource for Java Institute data synchronization.
 */
@Stateless
@Path("/sync")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SyncResource {

    @EJB
    private FinanceSyncService syncService;

    /**
     * Check Java Institute API health status.
     */
    @GET
    @Path("/health")
    public Response checkHealth() {
        Map<String, Object> health = syncService.checkApiHealth();
        return Response.ok(health).build();
    }

    /**
     * Trigger a full sync from Java Institute.
     */
    @POST
    @Path("/full")
    public Response triggerFullSync() {
        Map<String, Object> result = syncService.performFullSync("MANUAL");
        return Response.ok(result).build();
    }

    /**
     * Trigger an incremental sync from Java Institute.
     */
    @POST
    @Path("/incremental")
    public Response triggerIncrementalSync() {
        Map<String, Object> result = syncService.performIncrementalSync("MANUAL");
        return Response.ok(result).build();
    }

    /**
     * Get sync history.
     */
    @GET
    @Path("/history")
    public Response getSyncHistory(@QueryParam("limit") @DefaultValue("20") int limit) {
        List<SyncLog> history = syncService.getSyncHistory(limit);
        return Response.ok(history).build();
    }

    /**
     * Get sync status summary.
     */
    @GET
    @Path("/status")
    public Response getSyncStatus() {
        Map<String, Object> health = syncService.checkApiHealth();
        List<SyncLog> lastSync = syncService.getSyncHistory(1);
        
        health.put("lastSync", lastSync.isEmpty() ? null : lastSync.get(0));
        
        return Response.ok(health).build();
    }
}
