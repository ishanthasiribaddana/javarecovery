package com.jiat.recovery.service;

import com.jiat.recovery.entity.RecoveryCase;
import com.jiat.recovery.entity.RecoveryCalculation;
import com.jiat.recovery.entity.RecoveryReportTemplate;
import com.jiat.recovery.entity.RecoveryReportLog;
import com.jiat.recovery.entity.enums.GenerationStatus;
import com.jiat.recovery.entity.enums.ReportOutputFormat;
import com.jiat.recovery.entity.readonly.Student;
import com.jiat.recovery.entity.readonly.UniversalPaymentManager;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.ejb.Asynchronous;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.export.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

/**
 * EJB Service for report generation using JasperReports.
 */
@Stateless
public class ReportService {

    private static final Logger logger = LoggerFactory.getLogger(ReportService.class);
    private static final String REPORTS_OUTPUT_DIR = "reports/generated";

    @PersistenceContext(unitName = "RecoveryPU")
    private EntityManager em;

    @EJB
    private StudentService studentService;

    @EJB
    private RecoveryCaseService recoveryCaseService;

    @EJB
    private RecoveryCalculationService calculationService;

    /**
     * Get all report templates.
     */
    public List<RecoveryReportTemplate> getAllTemplates() {
        TypedQuery<RecoveryReportTemplate> query = em.createNamedQuery(
            "RecoveryReportTemplate.findAll", RecoveryReportTemplate.class);
        return query.getResultList();
    }

    /**
     * Get template by code.
     */
    public Optional<RecoveryReportTemplate> getTemplateByCode(String code) {
        TypedQuery<RecoveryReportTemplate> query = em.createNamedQuery(
            "RecoveryReportTemplate.findByCode", RecoveryReportTemplate.class);
        query.setParameter("templateCode", code);
        List<RecoveryReportTemplate> results = query.getResultList();
        return results.isEmpty() ? Optional.empty() : Optional.of(results.get(0));
    }

    /**
     * Generate a student financial statement.
     */
    public byte[] generateStudentStatement(Integer studentSId, ReportOutputFormat format) throws Exception {
        Optional<Student> studentOpt = studentService.findById(studentSId);
        if (studentOpt.isEmpty()) {
            throw new IllegalArgumentException("Student not found: " + studentSId);
        }

        Student student = studentOpt.get();
        Optional<UniversalPaymentManager> upmOpt = studentService.getPaymentManagerByStudentId(studentSId);
        Optional<RecoveryCase> caseOpt = recoveryCaseService.findByStudentId(studentSId);
        Optional<RecoveryCalculation> calcOpt = caseOpt.isPresent() 
            ? calculationService.findLatestByCaseId(caseOpt.get().getId())
            : Optional.empty();

        // Prepare parameters
        Map<String, Object> params = new HashMap<>();
        params.put("STUDENT_NAME", student.getDisplayName());
        params.put("STUDENT_ID", student.getStudentId());
        params.put("PROGRAM", student.getCourse() != null ? student.getCourse().getCourseTitle() : "N/A");
        params.put("REPORT_DATE", new Date());

        if (upmOpt.isPresent()) {
            UniversalPaymentManager upm = upmOpt.get();
            params.put("PAYMENT_OPTION", upm.getPaymentOption() != null ? upm.getPaymentOption().getName() : "N/A");
            params.put("SCHOLARSHIP_PERCENTAGE", upm.getScholarship() != null ? upm.getScholarship() : 0.0);
            params.put("TOTAL_PAID", upm.getPaidAmount() != null ? upm.getPaidAmount() : 0.0);
        } else {
            params.put("PAYMENT_OPTION", "N/A");
            params.put("SCHOLARSHIP_PERCENTAGE", 0.0);
            params.put("TOTAL_PAID", 0.0);
        }

        if (calcOpt.isPresent()) {
            RecoveryCalculation calc = calcOpt.get();
            params.put("BASE_COURSE_FEE", calc.getBaseCourseFee() != null ? calc.getBaseCourseFee() : 3000000.0);
            params.put("DISCOUNTED_FEE", calc.getDiscountedAmount() != null ? calc.getDiscountedAmount() : 0.0);
            params.put("TOTAL_DUE", calc.getTotalDue() != null ? calc.getTotalDue() : 0.0);
            params.put("UK_AWARDS_DUE_GBP", calc.getUkAwardsDueGbp() != null ? calc.getUkAwardsDueGbp() : 0.0);
            params.put("CONVOCATION_DUE", calc.getConvocationDue() != null ? calc.getConvocationDue() : 0.0);
            params.put("PORTAL_ID_CARD_DUE", calc.getPortalIdCardDue() != null ? calc.getPortalIdCardDue() : 0.0);
            
            double grandTotal = (calc.getTotalDue() != null ? calc.getTotalDue() : 0.0)
                + (calc.getConvocationDue() != null ? calc.getConvocationDue() : 0.0)
                + (calc.getPortalIdCardDue() != null ? calc.getPortalIdCardDue() : 0.0);
            params.put("GRAND_TOTAL_DUE", grandTotal);
        } else {
            params.put("BASE_COURSE_FEE", 3000000.0);
            params.put("DISCOUNTED_FEE", 0.0);
            params.put("TOTAL_DUE", 0.0);
            params.put("UK_AWARDS_DUE_GBP", 0.0);
            params.put("CONVOCATION_DUE", 0.0);
            params.put("PORTAL_ID_CARD_DUE", 0.0);
            params.put("GRAND_TOTAL_DUE", 0.0);
        }

        return generateReport("reports/student_financial_statement.jrxml", params, format);
    }

    /**
     * Generate report from template.
     */
    public byte[] generateReport(String templatePath, Map<String, Object> params, ReportOutputFormat format) throws Exception {
        // Load template
        InputStream templateStream = getClass().getClassLoader().getResourceAsStream(templatePath);
        if (templateStream == null) {
            throw new IllegalArgumentException("Template not found: " + templatePath);
        }

        // Compile and fill report
        JasperReport jasperReport = JasperCompileManager.compileReport(templateStream);
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params, new JREmptyDataSource());

        // Export to desired format
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        switch (format) {
            case PDF:
                JRPdfExporter pdfExporter = new JRPdfExporter();
                pdfExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                pdfExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
                pdfExporter.exportReport();
                break;

            case EXCEL:
                JRXlsxExporter xlsxExporter = new JRXlsxExporter();
                xlsxExporter.setExporterInput(new SimpleExporterInput(jasperPrint));
                xlsxExporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
                SimpleXlsxReportConfiguration xlsxConfig = new SimpleXlsxReportConfiguration();
                xlsxConfig.setOnePagePerSheet(false);
                xlsxConfig.setDetectCellType(true);
                xlsxExporter.setConfiguration(xlsxConfig);
                xlsxExporter.exportReport();
                break;

            case HTML:
                JasperExportManager.exportReportToHtmlFile(jasperPrint, outputStream.toString());
                break;

            default:
                throw new IllegalArgumentException("Unsupported format: " + format);
        }

        return outputStream.toByteArray();
    }

    /**
     * Create a report log entry.
     */
    public RecoveryReportLog createReportLog(Long templateId, Long generatedBy, 
            String parametersJson, ReportOutputFormat format) {
        RecoveryReportLog log = new RecoveryReportLog();
        log.setReportTemplateId(templateId);
        log.setGeneratedBy(generatedBy);
        log.setParametersJson(parametersJson);
        log.setOutputFormat(format);
        log.setGenerationStatus(GenerationStatus.PENDING);
        
        em.persist(log);
        return log;
    }

    /**
     * Update report log with completion status.
     */
    public void completeReportLog(Long logId, String filePath, Long fileSize) {
        RecoveryReportLog log = em.find(RecoveryReportLog.class, logId);
        if (log != null) {
            log.completeGeneration(filePath, fileSize);
            em.merge(log);
        }
    }

    /**
     * Update report log with failure status.
     */
    public void failReportLog(Long logId, String errorMessage) {
        RecoveryReportLog log = em.find(RecoveryReportLog.class, logId);
        if (log != null) {
            log.failGeneration(errorMessage);
            em.merge(log);
        }
    }

    /**
     * Get report generation history.
     */
    public List<RecoveryReportLog> getReportHistory(Long userId, int limit) {
        TypedQuery<RecoveryReportLog> query = em.createNamedQuery(
            "RecoveryReportLog.findByUserId", RecoveryReportLog.class);
        query.setParameter("userId", userId);
        query.setMaxResults(limit);
        return query.getResultList();
    }

    /**
     * Get report by ID.
     */
    public Optional<RecoveryReportLog> getReportById(Long id) {
        RecoveryReportLog log = em.find(RecoveryReportLog.class, id);
        return Optional.ofNullable(log);
    }

    /**
     * Save report to file system.
     */
    public String saveReportToFile(byte[] reportData, String fileName) throws Exception {
        Path outputDir = Paths.get(REPORTS_OUTPUT_DIR);
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
        }

        Path filePath = outputDir.resolve(fileName);
        Files.write(filePath, reportData);

        return filePath.toString();
    }
}
