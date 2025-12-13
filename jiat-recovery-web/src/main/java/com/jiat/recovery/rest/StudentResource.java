package com.jiat.recovery.rest;

import com.jiat.recovery.dto.OverdueStudentDTO;
import com.jiat.recovery.dto.PaymentScheduleDTO;
import com.jiat.recovery.dto.StudentProfileDTO;
import com.jiat.recovery.dto.StudentSearchResult;
import com.jiat.recovery.dto.StudentSearchResponse;
import com.jiat.recovery.entity.readonly.Student;
import com.jiat.recovery.entity.readonly.UniversalPaymentManager;
import com.jiat.recovery.service.StudentService;
import com.jiat.recovery.service.ScholarshipService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 * REST Resource for student operations.
 */
@Path("/students")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class StudentResource {

    @Inject
    private StudentService studentService;
    
    @Inject
    private ScholarshipService scholarshipService;

    /**
     * Get student by internal ID.
     */
    @GET
    @Path("/{id}")
    public Response getById(@PathParam("id") Integer id) {
        Optional<Student> student = studentService.findById(id);
        if (student.isPresent()) {
            return Response.ok(student.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Student not found\"}")
                .build();
    }

    /**
     * Get student by student ID (e.g., "200300102947").
     */
    @GET
    @Path("/by-student-id/{studentId}")
    public Response getByStudentId(@PathParam("studentId") String studentId) {
        Optional<Student> student = studentService.findByStudentId(studentId);
        if (student.isPresent()) {
            return Response.ok(student.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Student not found\"}")
                .build();
    }

    /**
     * Get student by SCN number.
     */
    @GET
    @Path("/by-scn/{scnNo}")
    public Response getByScnNo(@PathParam("scnNo") String scnNo) {
        Optional<Student> student = studentService.findByScnNo(scnNo);
        if (student.isPresent()) {
            return Response.ok(student.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Student not found\"}")
                .build();
    }

    /**
     * Search students by name.
     */
    @GET
    @Path("/search")
    public Response searchByName(
            @QueryParam("name") String name,
            @QueryParam("limit") @DefaultValue("20") int limit) {
        if (name == null || name.trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"Name parameter is required\"}")
                    .build();
        }
        List<Student> students = studentService.searchByName(name, limit);
        return Response.ok(students).build();
    }

    /**
     * Get students by course.
     */
    @GET
    @Path("/by-course/{courseCid}")
    public Response getByCourse(@PathParam("courseCid") Integer courseCid) {
        List<Student> students = studentService.findByCourse(courseCid);
        return Response.ok(students).build();
    }

    /**
     * Get students by intake.
     */
    @GET
    @Path("/by-intake/{intakeId}")
    public Response getByIntake(@PathParam("intakeId") Integer intakeId) {
        List<Student> students = studentService.findByIntake(intakeId);
        return Response.ok(students).build();
    }

    /**
     * Get payment manager for a student.
     */
    @GET
    @Path("/{id}/payment-manager")
    public Response getPaymentManager(@PathParam("id") Integer id) {
        Optional<UniversalPaymentManager> upm = studentService.getPaymentManagerByStudentId(id);
        if (upm.isPresent()) {
            return Response.ok(upm.get()).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                .entity("{\"error\": \"Payment manager not found\"}")
                .build();
    }

    /**
     * Get total count of active students.
     */
    @GET
    @Path("/count")
    public Response getCount() {
        long count = studentService.countStudents();
        return Response.ok("{\"count\": " + count + "}").build();
    }

    /**
     * Search students by NIC.
     */
    @GET
    @Path("/by-nic")
    public Response searchByNic(
            @QueryParam("nic") String nic,
            @QueryParam("limit") @DefaultValue("20") int limit) {
        if (nic == null || nic.trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"NIC parameter is required\"}")
                    .build();
        }
        List<Student> students = studentService.searchByNic(nic, limit);
        return Response.ok(students).build();
    }

    /**
     * Get table counts for debugging.
     */
    @GET
    @Path("/table-counts")
    public Response getTableCounts() {
        long students = studentService.countStudents();
        long studentsWithDue = studentService.countStudentsWithDue();
        long paymentScheduler = studentService.countPaymentScheduler();
        long paymentSchedulerDates = studentService.countPaymentSchedulerDates();
        long upm = studentService.countUniversalPaymentManager();
        long upmWithDue = studentService.countUniversalPaymentManagerWithDue();
        return Response.ok("{\"students\": " + students + 
                ", \"studentsWithDue\": " + studentsWithDue +
                ", \"paymentScheduler\": " + paymentScheduler + 
                ", \"paymentSchedulerDates\": " + paymentSchedulerDates + 
                ", \"universalPaymentManager\": " + upm +
                ", \"universalPaymentManagerWithDue\": " + upmWithDue + "}").build();
    }

    /**
     * Search students by student ID, name, or NIC with pagination.
     * Returns detailed student information including NIC from general_user_profile.
     */
    @GET
    @Path("/search-all")
    public Response searchStudents(
            @QueryParam("q") String query,
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("20") int size) {
        if (query == null || query.trim().length() < 2) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"Search query must be at least 2 characters\"}")
                    .build();
        }
        
        List<Object[]> results = studentService.searchStudentsWithDetails(query.trim(), page, size);
        long totalElements = studentService.countSearchResults(query.trim());
        
        List<StudentSearchResult> content = results.stream()
                .map(StudentSearchResult::new)
                .collect(Collectors.toList());
        
        StudentSearchResponse response = new StudentSearchResponse(content, page, size, totalElements);
        return Response.ok(response).build();
    }

    /**
     * Get all students with pagination (loads by default).
     * If search query is provided, filters by name or NIC.
     */
    @GET
    @Path("/list")
    public Response listStudents(
            @QueryParam("q") String query,
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("20") int size) {
        
        List<Object[]> results;
        long totalElements;
        
        if (query != null && !query.trim().isEmpty()) {
            // Search by name or NIC
            results = studentService.searchStudentsByNameOrNic(query.trim(), page, size);
            totalElements = studentService.countSearchByNameOrNic(query.trim());
        } else {
            // Load all students
            results = studentService.getAllStudentsWithDetails(page, size);
            totalElements = studentService.countAllStudents();
        }
        
        List<StudentSearchResult> content = results.stream()
                .map(StudentSearchResult::new)
                .collect(Collectors.toList());
        
        StudentSearchResponse response = new StudentSearchResponse(content, page, size, totalElements);
        return Response.ok(response).build();
    }

    /**
     * Get detailed student profile by search term (NIC or name).
     * Returns full profile details for recovery purposes.
     */
    @GET
    @Path("/profile")
    public Response getStudentProfile(@QueryParam("q") String query) {
        if (query == null || query.trim().length() < 2) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"Search query must be at least 2 characters\"}")
                    .build();
        }
        
        Object[] result = studentService.searchStudentProfileByNicOrName(query.trim());
        
        if (result == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("{\"error\": \"Student not found\"}")
                    .build();
        }
        
        StudentProfileDTO profile = new StudentProfileDTO(result);
        
        // Fetch and attach payment schedule
        if (profile.getSId() != null) {
            PaymentScheduleDTO paymentSchedule = studentService.getPaymentSchedule(profile.getSId());
            profile.setPaymentSchedule(paymentSchedule);
        }
        
        return Response.ok(profile).build();
    }

    /**
     * Get detailed student profile by student ID (s_id).
     */
    @GET
    @Path("/profile/{sId}")
    public Response getStudentProfileById(@PathParam("sId") Integer sId) {
        Object[] result = studentService.getStudentProfileDetails(sId);
        
        if (result == null) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity("{\"error\": \"Student not found\"}")
                    .build();
        }
        
        StudentProfileDTO profile = new StudentProfileDTO(result);
        
        // Fetch and attach payment schedule
        if (profile.getSId() != null) {
            PaymentScheduleDTO paymentSchedule = studentService.getPaymentSchedule(profile.getSId());
            profile.setPaymentSchedule(paymentSchedule);
        }
        
        return Response.ok(profile).build();
    }
    
    /**
     * Get overdue students report.
     * Returns students with overdue payments for recovery tracking.
     */
    @GET
    @Path("/reports/overdue")
    public Response getOverdueStudentsReport(
            @QueryParam("branchId") Integer branchId,
            @QueryParam("paymentOptionId") Integer paymentOptionId,
            @QueryParam("offer") String offerFilter) {
        
        List<OverdueStudentDTO> report = studentService.getOverdueStudentsReport(branchId, paymentOptionId, offerFilter);
        return Response.ok(report).build();
    }
    
    /**
     * Get payment reconciliation report.
     * Compares voucher_item vs student_payment_scheduler_dates data.
     */
    @GET
    @Path("/reports/reconciliation")
    public Response getPaymentReconciliation(
            @QueryParam("status") String statusFilter) {
        
        var report = studentService.getPaymentReconciliation(statusFilter);
        return Response.ok(report).build();
    }
    
    /**
     * Get payment reconciliation summary statistics.
     */
    @GET
    @Path("/reports/reconciliation/summary")
    public Response getPaymentReconciliationSummary() {
        var summary = studentService.getPaymentReconciliationSummary();
        return Response.ok(summary).build();
    }
    
    /**
     * Get scholarship diagnostic report - identifies students with discounted_fee 
     * that doesn't match the calculated payable based on scholarship percentage.
     */
    @GET
    @Path("/reports/scholarship-diagnostic")
    public Response getScholarshipDiagnosticReport() {
        var report = studentService.getScholarshipDiagnosticReport();
        return Response.ok(report).build();
    }
    
    /**
     * Get IIC students for testing - finds students in IIC batches with their payment status.
     */
    @GET
    @Path("/reports/iic-test-cases")
    public Response getIicTestCases() {
        var testCases = studentService.getIicStudentsForTesting();
        return Response.ok(testCases).build();
    }
    
    /**
     * Get student recovery report - students registered after 2020-12-31 with payment details.
     */
    @GET
    @Path("/reports/recovery")
    public Response getStudentRecoveryReport(
            @QueryParam("limit") @DefaultValue("100") int limit) {
        var report = studentService.getStudentRecoveryReport(limit);
        return Response.ok(report).build();
    }
    
    /**
     * Get scholarship warning status for a specific student.
     */
    @GET
    @Path("/scholarship/warning/{gupId}")
    public Response getScholarshipWarningStatus(@PathParam("gupId") Integer gupId) {
        var status = scholarshipService.getScholarshipWarningStatus(gupId);
        return Response.ok(status).build();
    }
    
    /**
     * Get all students with scholarship warnings (for alert board).
     * Returns students within 14 days of scholarship expiry who haven't paid.
     */
    @GET
    @Path("/scholarship/warnings")
    public Response getStudentsWithWarnings() {
        var warnings = scholarshipService.getStudentsWithWarnings();
        return Response.ok(warnings).build();
    }
    
    /**
     * Get scholarship history for a specific scholarship_payment_scheduler.
     */
    @GET
    @Path("/scholarship/history/{spsId}")
    public Response getScholarshipHistory(@PathParam("spsId") Integer spsId) {
        var history = scholarshipService.getScholarshipHistory(spsId);
        return Response.ok(history).build();
    }
    
    /**
     * Manually trigger scholarship downgrade check (admin use).
     */
    @POST
    @Path("/scholarship/run-downgrade")
    public Response runManualDowngradeCheck() {
        int count = scholarshipService.runManualDowngradeCheck();
        return Response.ok("{\"downgraded\": " + count + "}").build();
    }
    
    /**
     * Get overdue report for courses 321, 328, 331, 340.
     * Shows students with student_batches.total_due_fee != 0.
     */
    @GET
    @Path("/reports/course-overdue")
    public Response getCourseOverdueReport() {
        var report = studentService.getCourseOverdueReport(0);
        return Response.ok(report).build();
    }
    
    /**
     * Get count of student_batches records with specific total_due_fee value.
     */
    @GET
    @Path("/reports/student-batches-count")
    public Response getStudentBatchesCount(@QueryParam("dueFee") Double dueFee) {
        if (dueFee == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity("{\"error\": \"dueFee parameter is required\"}")
                    .build();
        }
        Long count = studentService.getStudentBatchesCountByDueFee(dueFee);
        return Response.ok("{\"dueFee\": " + dueFee + ", \"count\": " + count + "}").build();
    }
    
    /**
     * Get count of inactive vs active student_batches in the overdue report.
     */
    @GET
    @Path("/reports/inactive-batches-count")
    public Response getInactiveBatchesCount() {
        var result = studentService.getInactiveBatchesInOverdueReport();
        return Response.ok(result).build();
    }
    
    /**
     * Analyze students who have overpaid (calculatedBalance < 0).
     */
    @GET
    @Path("/reports/overpaid-students")
    public Response getOverpaidStudents() {
        var result = studentService.analyzeOverpaidStudents();
        return Response.ok(result).build();
    }
}
