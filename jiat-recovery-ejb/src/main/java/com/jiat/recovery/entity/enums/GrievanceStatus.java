package com.jiat.recovery.entity.enums;

/**
 * Status of a grievance.
 */
public enum GrievanceStatus {
    SUBMITTED("Submitted"),
    UNDER_REVIEW("Under Review"),
    RESOLVED("Resolved"),
    REJECTED("Rejected");

    private final String displayName;

    GrievanceStatus(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
