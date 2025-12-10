package com.jiat.recovery.entity;

import jakarta.persistence.*;

/**
 * Report template entity - stores report configurations.
 */
@Entity
@Table(name = "recovery_report_template")
@NamedQueries({
    @NamedQuery(name = "RecoveryReportTemplate.findByCode", 
                query = "SELECT t FROM RecoveryReportTemplate t WHERE t.templateCode = :templateCode AND t.isActive = true"),
    @NamedQuery(name = "RecoveryReportTemplate.findByCategory", 
                query = "SELECT t FROM RecoveryReportTemplate t WHERE t.category = :category AND t.isActive = true"),
    @NamedQuery(name = "RecoveryReportTemplate.findAll", 
                query = "SELECT t FROM RecoveryReportTemplate t WHERE t.isActive = true ORDER BY t.category, t.templateName")
})
public class RecoveryReportTemplate extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "template_code", unique = true, nullable = false, length = 50)
    private String templateCode;

    @Column(name = "template_name", nullable = false)
    private String templateName;

    @Column(name = "template_file_path", length = 500)
    private String templateFilePath;

    @Column(name = "output_formats", length = 100)
    private String outputFormats;

    @Column(name = "category")
    private String category; // STUDENT, RECOVERY, FINANCE, MANAGEMENT

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "parameters_schema_json", columnDefinition = "TEXT")
    private String parametersSchemaJson;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTemplateCode() {
        return templateCode;
    }

    public void setTemplateCode(String templateCode) {
        this.templateCode = templateCode;
    }

    public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getTemplateFilePath() {
        return templateFilePath;
    }

    public void setTemplateFilePath(String templateFilePath) {
        this.templateFilePath = templateFilePath;
    }

    public String getOutputFormats() {
        return outputFormats;
    }

    public void setOutputFormats(String outputFormats) {
        this.outputFormats = outputFormats;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getParametersSchemaJson() {
        return parametersSchemaJson;
    }

    public void setParametersSchemaJson(String parametersSchemaJson) {
        this.parametersSchemaJson = parametersSchemaJson;
    }

    /**
     * Check if this template supports a specific output format.
     */
    public boolean supportsFormat(String format) {
        if (outputFormats == null || format == null) {
            return false;
        }
        return outputFormats.toUpperCase().contains(format.toUpperCase());
    }
}
