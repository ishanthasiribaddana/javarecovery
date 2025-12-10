package com.jiat.recovery.dto;

import java.io.Serializable;
import java.util.List;

/**
 * DTO for paginated student search response.
 */
public class StudentSearchResponse implements Serializable {
    private static final long serialVersionUID = 1L;

    private List<StudentSearchResult> content;
    private int page;
    private int size;
    private long totalElements;
    private int totalPages;

    public StudentSearchResponse() {}

    public StudentSearchResponse(List<StudentSearchResult> content, int page, int size, long totalElements) {
        this.content = content;
        this.page = page;
        this.size = size;
        this.totalElements = totalElements;
        this.totalPages = size > 0 ? (int) Math.ceil((double) totalElements / size) : 0;
    }

    // Getters and Setters
    public List<StudentSearchResult> getContent() { return content; }
    public void setContent(List<StudentSearchResult> content) { this.content = content; }

    public int getPage() { return page; }
    public void setPage(int page) { this.page = page; }

    public int getSize() { return size; }
    public void setSize(int size) { this.size = size; }

    public long getTotalElements() { return totalElements; }
    public void setTotalElements(long totalElements) { this.totalElements = totalElements; }

    public int getTotalPages() { return totalPages; }
    public void setTotalPages(int totalPages) { this.totalPages = totalPages; }
}
