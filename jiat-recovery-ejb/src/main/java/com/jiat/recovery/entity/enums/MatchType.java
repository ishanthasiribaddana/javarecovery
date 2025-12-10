package com.jiat.recovery.entity.enums;

/**
 * Type of deposit matching.
 */
public enum MatchType {
    AUTO("Automatic Match"),
    MANUAL("Manual Match");

    private final String displayName;

    MatchType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
