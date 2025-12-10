package com.jiat.recovery.dto;

import java.io.Serializable;

/**
 * DTO for monthly trend chart data.
 */
public class MonthlyTrendData implements Serializable {

    private static final long serialVersionUID = 1L;

    private String month;
    private double collected;
    private double target;

    public MonthlyTrendData() {}

    public MonthlyTrendData(String month, double collected, double target) {
        this.month = month;
        this.collected = collected;
        this.target = target;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public double getCollected() {
        return collected;
    }

    public void setCollected(double collected) {
        this.collected = collected;
    }

    public double getTarget() {
        return target;
    }

    public void setTarget(double target) {
        this.target = target;
    }

    public double getVariance() {
        return collected - target;
    }

    public double getAchievementPercentage() {
        if (target == 0) return 0;
        return (collected / target) * 100;
    }
}
