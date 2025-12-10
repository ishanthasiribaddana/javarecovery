package com.jiat.recovery.entity.enums;

/**
 * Status of a recovery case.
 */
public enum CaseStatus {
    OPEN("Open"),
    IN_PROGRESS("In Progress"),
    RESOLVED("Resolved"),
    DISPUTED("Disputed"),
    CLOSED("Closed");

    private final String displayName;

    CaseStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
