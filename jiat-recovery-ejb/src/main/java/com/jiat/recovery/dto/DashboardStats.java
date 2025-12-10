package com.jiat.recovery.dto;

import java.io.Serializable;

/**
 * DTO for dashboard statistics.
 */
public class DashboardStats implements Serializable {

    private static final long serialVersionUID = 1L;

    private long openCases;
    private long inProgressCases;
    private long disputedCases;
    private long resolvedCases;
    private long closedCases;
    private double totalOutstanding;
    private double thisMonthCollected;
    private double lastMonthCollected;
    private double recoveryRate;
    private double avgResolutionDays;
    private long pendingGrievances;
    private long unmatchedDeposits;

    // Getters and Setters
    public long getOpenCases() {
        return openCases;
    }

    public void setOpenCases(long openCases) {
        this.openCases = openCases;
    }

    public long getInProgressCases() {
        return inProgressCases;
    }

    public void setInProgressCases(long inProgressCases) {
        this.inProgressCases = inProgressCases;
    }

    public long getDisputedCases() {
        return disputedCases;
    }

    public void setDisputedCases(long disputedCases) {
        this.disputedCases = disputedCases;
    }

    public long getResolvedCases() {
        return resolvedCases;
    }

    public void setResolvedCases(long resolvedCases) {
        this.resolvedCases = resolvedCases;
    }

    public long getClosedCases() {
        return closedCases;
    }

    public void setClosedCases(long closedCases) {
        this.closedCases = closedCases;
    }

    public double getTotalOutstanding() {
        return totalOutstanding;
    }

    public void setTotalOutstanding(double totalOutstanding) {
        this.totalOutstanding = totalOutstanding;
    }

    public double getThisMonthCollected() {
        return thisMonthCollected;
    }

    public void setThisMonthCollected(double thisMonthCollected) {
        this.thisMonthCollected = thisMonthCollected;
    }

    public double getLastMonthCollected() {
        return lastMonthCollected;
    }

    public void setLastMonthCollected(double lastMonthCollected) {
        this.lastMonthCollected = lastMonthCollected;
    }

    public double getRecoveryRate() {
        return recoveryRate;
    }

    public void setRecoveryRate(double recoveryRate) {
        this.recoveryRate = recoveryRate;
    }

    public double getAvgResolutionDays() {
        return avgResolutionDays;
    }

    public void setAvgResolutionDays(double avgResolutionDays) {
        this.avgResolutionDays = avgResolutionDays;
    }

    public long getPendingGrievances() {
        return pendingGrievances;
    }

    public void setPendingGrievances(long pendingGrievances) {
        this.pendingGrievances = pendingGrievances;
    }

    public long getUnmatchedDeposits() {
        return unmatchedDeposits;
    }

    public void setUnmatchedDeposits(long unmatchedDeposits) {
        this.unmatchedDeposits = unmatchedDeposits;
    }

    public long getTotalActiveCases() {
        return openCases + inProgressCases + disputedCases;
    }

    public double getMonthOverMonthChange() {
        if (lastMonthCollected == 0) return 0;
        return ((thisMonthCollected - lastMonthCollected) / lastMonthCollected) * 100;
    }
}
