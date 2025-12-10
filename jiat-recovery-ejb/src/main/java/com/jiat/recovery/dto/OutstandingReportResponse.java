package com.jiat.recovery.dto;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * DTO for paginated outstanding report response.
 */
public class OutstandingReportResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    private List<OutstandingReportRow> content;
    private int page;
    private int size;
    private long totalElements;
    private int totalPages;
    private Map<String, Double> summary;

    public OutstandingReportResponse() {}

    public OutstandingReportResponse(List<OutstandingReportRow> content, int page, int size, 
                                      long totalElements, Map<String, Double> summary) {
        this.content = content;
        this.page = page;
        this.size = size;
        this.totalElements = totalElements;
        this.totalPages = (int) Math.ceil((double) totalElements / size);
        this.summary = summary;
    }

    // Getters and Setters
    public List<OutstandingReportRow> getContent() { return content; }
    public void setContent(List<OutstandingReportRow> content) { this.content = content; }

    public int getPage() { return page; }
    public void setPage(int page) { this.page = page; }

    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }

    public long getTotalElements() { return totalElements; }
    public void setTotalElements(long totalElements) { this.totalElements = totalElements; }

    public int getTotalPages() { return totalPages; }
    public void setTotalPages(int totalPages) { this.totalPages = totalPages; }

    public Map<String, Double> getSummary() { return summary; }
    public void setSummary(Map<String, Double> summary) { this.summary = summary; }
}
