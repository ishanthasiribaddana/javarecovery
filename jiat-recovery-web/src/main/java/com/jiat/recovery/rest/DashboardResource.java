package com.jiat.recovery.rest;

import com.jiat.recovery.dto.DashboardStats;
import com.jiat.recovery.dto.MonthlyTrendData;
import com.jiat.recovery.dto.CourseOutstandingData;
import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.service.DashboardService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Map;

/**
 * REST Resource for dashboard data.
 */
@Path("/dashboard")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class DashboardResource {

    @Inject
    private DashboardService dashboardService;

    /**
     * Get comprehensive dashboard statistics.
     */
    @GET
    @Path("/stats")
    public Response getStats() {
        DashboardStats stats = dashboardService.getDashboardStats();
        return Response.ok(stats).build();
    }

    /**
     * Get monthly trend data for charts.
     */
    @GET
    @Path("/trend")
    public Response getMonthlyTrend() {
        List<MonthlyTrendData> trend = dashboardService.getMonthlyTrend();
        return Response.ok(trend).build();
    }

    /**
     * Get outstanding amounts by course.
     */
    @GET
    @Path("/outstanding-by-course")
    public Response getOutstandingByCourse() {
        List<CourseOutstandingData> data = dashboardService.getOutstandingByCourse();
        return Response.ok(data).build();
    }

    /**
     * Get cases assigned to current officer.
     */
    @GET
    @Path("/my-cases")
    public Response getMyCases(@QueryParam("officerId") Long officerId) {
        if (officerId == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"Officer ID is required\"}")
                    .build();
        }
        List<RecoveryCase> cases = dashboardService.getAssignedCases(officerId);
        return Response.ok(cases).build();
    }

    /**
     * Get recent activity feed.
     */
    @GET
    @Path("/activity")
    public Response getRecentActivity(@QueryParam("limit") @DefaultValue("10") int limit) {
        List<Map<String, Object>> activity = dashboardService.getRecentActivity(limit);
        return Response.ok(activity).build();
    }

    /**
     * Get all dashboard data in one call (for initial load).
     */
    @GET
    public Response getDashboard(@QueryParam("officerId") Long officerId) {
        DashboardStats stats = dashboardService.getDashboardStats();
        List<MonthlyTrendData> trend = dashboardService.getMonthlyTrend();
        List<CourseOutstandingData> courseData = dashboardService.getOutstandingByCourse();
        List<Map<String, Object>> activity = dashboardService.getRecentActivity(5);
        
        List<RecoveryCase> myCases = officerId != null 
            ? dashboardService.getAssignedCases(officerId) 
            : List.of();

        return Response.ok(Map.of(
            "stats", stats,
            "monthlyTrend", trend,
            "outstandingByCourse", courseData,
            "recentActivity", activity,
            "myCases", myCases
        )).build();
    }
}
