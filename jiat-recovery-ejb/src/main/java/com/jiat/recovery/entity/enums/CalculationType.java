package com.jiat.recovery.entity.enums;

/**
 * Type of recovery calculation.
 */
public enum CalculationType {
    INITIAL("Initial Calculation"),
    RECALCULATION("Recalculation"),
    DEFAULT_REVERSION("Default Reversion"),
    MANUAL_ADJUSTMENT("Manual Adjustment");

    private final String displayName;

    CalculationType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
