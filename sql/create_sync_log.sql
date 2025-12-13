-- Create sync_log table for Java Institute API integration
-- Run this script in your MySQL database (java_aboroad)

CREATE TABLE IF NOT EXISTS sync_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sync_type VARCHAR(50) NOT NULL COMMENT 'FULL, INCREMENTAL, MANUAL',
    sync_time DATETIME NOT NULL COMMENT 'When sync was initiated',
    status VARCHAR(20) NOT NULL COMMENT 'SUCCESS, FAILED, IN_PROGRESS',
    records_synced INT COMMENT 'Total records synced',
    students_synced INT COMMENT 'Number of students synced',
    payments_synced INT COMMENT 'Number of payments synced',
    enrollments_synced INT COMMENT 'Number of enrollments synced',
    fee_structures_synced INT COMMENT 'Number of fee structures synced',
    offers_synced INT COMMENT 'Number of offers synced',
    error_message VARCHAR(1000) COMMENT 'Error message if sync failed',
    duration_ms BIGINT COMMENT 'Sync duration in milliseconds',
    triggered_by VARCHAR(100) COMMENT 'SCHEDULER, MANUAL, WEBHOOK',
    api_response_code INT COMMENT 'HTTP response code from API'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Verify table was created
SELECT 'sync_log table created successfully!' AS result;
DESCRIBE sync_log;
