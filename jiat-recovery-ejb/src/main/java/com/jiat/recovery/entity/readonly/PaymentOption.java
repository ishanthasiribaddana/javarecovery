package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing payment_option table.
 * Payment options: Full Payment, Yearly, Semester, etc.
 */
@Entity
@Table(name = "payment_option")
@NamedQueries({
    @NamedQuery(name = "PaymentOption.findAll", 
                query = "SELECT p FROM PaymentOption p WHERE p.isActive = true"),
    @NamedQuery(name = "PaymentOption.findByName", 
                query = "SELECT p FROM PaymentOption p WHERE p.name = :name AND p.isActive = true")
})
public class PaymentOption implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "name")
    private String name;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters only (read-only entity)
    public Integer getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Check if this is a full payment option.
     */
    public boolean isFullPayment() {
        return name != null && name.toLowerCase().contains("full");
    }

    /**
     * Check if this is a yearly payment option.
     */
    public boolean isYearlyPayment() {
        return name != null && name.toLowerCase().contains("year");
    }

    /**
     * Check if this is a semester payment option.
     */
    public boolean isSemesterPayment() {
        return name != null && name.toLowerCase().contains("semester");
    }
}
