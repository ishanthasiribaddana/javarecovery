package com.jiat.recovery.entity.enums;

/**
 * Type of grievance attachment.
 */
public enum AttachmentType {
    DEPOSIT_SLIP("Deposit Slip"),
    EMAIL("Email"),
    PAYMENT_STRUCTURE("Payment Structure"),
    ID_PROOF("ID Proof"),
    OTHER("Other");

    private final String displayName;

    AttachmentType(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
