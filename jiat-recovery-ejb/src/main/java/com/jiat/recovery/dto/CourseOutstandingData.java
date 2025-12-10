package com.jiat.recovery.dto;

import java.io.Serializable;

/**
 * DTO for course outstanding chart data.
 */
public class CourseOutstandingData implements Serializable {

    private static final long serialVersionUID = 1L;

    private String courseName;
    private double amount;

    public CourseOutstandingData() {}

    public CourseOutstandingData(String courseName, double amount) {
        this.courseName = courseName;
        this.amount = amount;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getFormattedAmount() {
        if (amount >= 1000000) {
            return String.format("Rs. %.1fM", amount / 1000000);
        } else if (amount >= 1000) {
            return String.format("Rs. %.0fK", amount / 1000);
        }
        return String.format("Rs. %.0f", amount);
    }
}
