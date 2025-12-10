package com.jiat.recovery.entity.enums;

/**
 * Role in AI conversation.
 */
public enum MessageRole {
    USER("User"),
    ASSISTANT("Assistant"),
    SYSTEM("System");

    private final String displayName;

    MessageRole(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}
