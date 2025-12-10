package com.jiat.recovery.entity.enums;

/**
 * Output format for reports.
 */
public enum ReportOutputFormat {
    PDF("PDF"),
    EXCEL("Excel"),
    HTML("HTML"),
    CSV("CSV");

    private final String displayName;

    ReportOutputFormat(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
