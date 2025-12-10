package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing course_fee_changed_history table.
 * Tracks historical course fee changes.
 */
@Entity
@Table(name = "course_fee_changed_history")
@NamedQueries({
    @NamedQuery(name = "CourseFeeChangedHistory.findByCourse", 
                query = "SELECT c FROM CourseFeeChangedHistory c WHERE c.courseCid = :courseCid AND c.isActive = true ORDER BY c.date DESC"),
    @NamedQuery(name = "CourseFeeChangedHistory.findEffectiveOnDate", 
                query = "SELECT c FROM CourseFeeChangedHistory c WHERE c.courseCid = :courseCid AND c.date <= :date AND c.isActive = true ORDER BY c.date DESC")
})
public class CourseFeeChangedHistory implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    private Integer id;

    @Column(name = "date")
    private LocalDateTime date;

    @Column(name = "amount")
    private Double amount;

    @Column(name = "description")
    private String description;

    @Column(name = "course_cid")
    private Integer courseCid;

    @Column(name = "is_active")
    private Boolean isActive;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters only
    public Integer getId() {
        return id;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public Double getAmount() {
        return amount;
    }

    public String getDescription() {
        return description;
    }

    public Integer getCourseCid() {
        return courseCid;
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
}
