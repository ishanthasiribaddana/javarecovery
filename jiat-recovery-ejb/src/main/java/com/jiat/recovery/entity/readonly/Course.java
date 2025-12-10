package com.jiat.recovery.entity.readonly;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Read-only JPA entity for existing course table.
 */
@Entity
@Table(name = "course")
@NamedQueries({
    @NamedQuery(name = "Course.findByCode", 
                query = "SELECT c FROM Course c WHERE c.code = :code AND c.isActive = 1"),
    @NamedQuery(name = "Course.findActive", 
                query = "SELECT c FROM Course c WHERE c.isActive = 1 ORDER BY c.courseTitle")
})
public class Course implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "cid")
    private Integer cid;

    @Column(name = "course_title")
    private String courseTitle;

    @Column(name = "course_full_name")
    private String courseFullName;

    @Column(name = "duration")
    private Integer duration;

    @Column(name = "description")
    private String description;

    @Column(name = "standard_fee")
    private Double standardFee;

    @Column(name = "cash_discount_percentage")
    private Double cashDiscountPercentage;

    @Column(name = "code")
    private String code;

    @Column(name = "credits")
    private Double credits;

    @Column(name = "is_active")
    private Integer isActive;

    @Column(name = "currency_type_id")
    private Integer currencyTypeId;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Getters only (read-only entity)
    public Integer getCid() {
        return cid;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public String getCourseFullName() {
        return courseFullName;
    }

    public Integer getDuration() {
        return duration;
    }

    public String getDescription() {
        return description;
    }

    public Double getStandardFee() {
        return standardFee;
    }

    public Double getCashDiscountPercentage() {
        return cashDiscountPercentage;
    }

    public String getCode() {
        return code;
    }

    public Double getCredits() {
        return credits;
    }

    public Integer getIsActive() {
        return isActive;
    }

    public Integer getCurrencyTypeId() {
        return currencyTypeId;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    /**
     * Get display name (title or full name).
     */
    public String getDisplayName() {
        if (courseFullName != null && !courseFullName.trim().isEmpty()) {
            return courseFullName;
        }
        return courseTitle;
    }
}
