package com.jiat.recovery.entity.enums;

/**
 * User roles in the recovery system.
 */
public enum UserRole {
    ADMIN("Administrator"),
    RECOVERY_OFFICER("Recovery Officer"),
    FINANCE("Finance Department"),
    MANAGEMENT("Management"),
    STUDENT("Student");

    private final String displayName;

    UserRole(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
