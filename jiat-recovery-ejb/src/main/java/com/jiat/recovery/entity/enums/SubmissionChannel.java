package com.jiat.recovery.entity.enums;

/**
 * Channel through which grievance was submitted.
 */
public enum SubmissionChannel {
    WEB("Web Portal"),
    AI_AGENT("AI Agent"),
    EMAIL("Email");

    private final String displayName;

    SubmissionChannel(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
