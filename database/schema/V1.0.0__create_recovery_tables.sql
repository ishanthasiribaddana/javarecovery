-- =====================================================
-- JIAT Recovery System Database Schema
-- Version: 1.0.0
-- Database: MySQL 8.x
-- Description: Recovery-specific tables for ijts_recovery_db
-- =====================================================

-- Note: This script creates NEW tables only.
-- Existing ijts_system tables are used as READ-ONLY.

SET FOREIGN_KEY_CHECKS = 0;

-- =====================================================
-- 1. RECOVERY CASE - Main tracking table for each student
-- =====================================================
DROP TABLE IF EXISTS `recovery_case`;
CREATE TABLE `recovery_case` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `student_s_id` INT NOT NULL COMMENT 'FK to student.s_id',
    `case_number` VARCHAR(50) UNIQUE COMMENT 'e.g., REC-2024-00001',
    `status` ENUM('OPEN', 'IN_PROGRESS', 'RESOLVED', 'DISPUTED', 'CLOSED') DEFAULT 'OPEN',
    `assigned_officer_id` BIGINT COMMENT 'FK to recovery_system_user',
    `original_payment_option_id` INT COMMENT 'FK to payment_option',
    `original_scholarship_percentage` DOUBLE,
    `original_payable_amount` DOUBLE,
    `current_calculated_due` DOUBLE,
    `last_calculation_date` DATETIME,
    `notes` TEXT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_recovery_case_student` (`student_s_id`),
    INDEX `idx_recovery_case_status` (`status`),
    INDEX `idx_recovery_case_officer` (`assigned_officer_id`),
    INDEX `idx_recovery_case_active` (`is_active`),
    INDEX `idx_recovery_case_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 2. RECOVERY CALCULATION - AI-generated calculations with audit
-- =====================================================
DROP TABLE IF EXISTS `recovery_calculation`;
CREATE TABLE `recovery_calculation` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `recovery_case_id` BIGINT NOT NULL COMMENT 'FK to recovery_case',
    `calculation_type` ENUM('INITIAL', 'RECALCULATION', 'DEFAULT_REVERSION', 'MANUAL_ADJUSTMENT') NOT NULL,
    `base_course_fee` DOUBLE COMMENT 'Original course fee at enrollment',
    `scholarship_percentage` DOUBLE,
    `discounted_amount` DOUBLE COMMENT 'Fee after scholarship',
    `total_payments_db` DOUBLE COMMENT 'Total from database records',
    `total_payments_bank` DOUBLE COMMENT 'Total from bank reconciliation',
    `total_due` DOUBLE COMMENT 'Final calculated due amount',
    `uk_awards_due_gbp` DOUBLE COMMENT 'UK Awards due in GBP',
    `convocation_due` DOUBLE,
    `portal_id_card_due` DOUBLE,
    `calculation_json` TEXT COMMENT 'Full breakdown as JSON',
    `ai_explanation` TEXT COMMENT 'AI-generated explanation',
    `calculated_by` BIGINT COMMENT 'FK to recovery_system_user',
    `calculation_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `is_approved` TINYINT(1) DEFAULT 0,
    `approved_by` BIGINT,
    `approved_date` DATETIME,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_recovery_calc_case` (`recovery_case_id`),
    INDEX `idx_recovery_calc_type` (`calculation_type`),
    INDEX `idx_recovery_calc_approved` (`is_approved`),
    INDEX `idx_recovery_calc_active` (`is_active`),
    CONSTRAINT `fk_recovery_calc_case` FOREIGN KEY (`recovery_case_id`) 
        REFERENCES `recovery_case` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 3. BANK STATEMENT IMPORT - For CSV/Excel imports
-- =====================================================
DROP TABLE IF EXISTS `recovery_bank_statement_import`;
CREATE TABLE `recovery_bank_statement_import` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `import_batch_id` VARCHAR(50) COMMENT 'Group imports together',
    `bank_account_ba_id` INT COMMENT 'FK to bank_account',
    `transaction_date` DATE,
    `reference_number` VARCHAR(100),
    `description` TEXT,
    `amount` DOUBLE,
    `currency_type_id` INT DEFAULT 1 COMMENT 'FK to currency_type',
    `is_matched` TINYINT(1) DEFAULT 0,
    `matched_student_s_id` INT COMMENT 'FK to student if matched',
    `matched_by` BIGINT COMMENT 'FK to recovery_system_user',
    `matched_date` DATETIME,
    `import_file_name` VARCHAR(255),
    `import_date` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `imported_by` BIGINT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_bank_import_batch` (`import_batch_id`),
    INDEX `idx_bank_import_ref` (`reference_number`),
    INDEX `idx_bank_import_matched` (`is_matched`),
    INDEX `idx_bank_import_student` (`matched_student_s_id`),
    INDEX `idx_bank_import_date` (`transaction_date`),
    INDEX `idx_bank_import_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 4. DEPOSIT MATCH - Link bank imports to students
-- =====================================================
DROP TABLE IF EXISTS `recovery_deposit_match`;
CREATE TABLE `recovery_deposit_match` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `bank_statement_import_id` BIGINT NOT NULL COMMENT 'FK to recovery_bank_statement_import',
    `student_s_id` INT NOT NULL COMMENT 'FK to student',
    `recovery_case_id` BIGINT COMMENT 'FK to recovery_case',
    `match_type` ENUM('AUTO', 'MANUAL') DEFAULT 'MANUAL',
    `match_confidence` DOUBLE COMMENT 'For auto-match scoring (0-100)',
    `verified` TINYINT(1) DEFAULT 0,
    `verified_by` BIGINT,
    `verified_date` DATETIME,
    `notes` TEXT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_deposit_match_import` (`bank_statement_import_id`),
    INDEX `idx_deposit_match_student` (`student_s_id`),
    INDEX `idx_deposit_match_case` (`recovery_case_id`),
    INDEX `idx_deposit_match_verified` (`verified`),
    INDEX `idx_deposit_match_active` (`is_active`),
    CONSTRAINT `fk_deposit_match_import` FOREIGN KEY (`bank_statement_import_id`) 
        REFERENCES `recovery_bank_statement_import` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 5. GRIEVANCE - Student disputes
-- =====================================================
DROP TABLE IF EXISTS `recovery_grievance`;
CREATE TABLE `recovery_grievance` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `recovery_case_id` BIGINT COMMENT 'FK to recovery_case',
    `student_s_id` INT NOT NULL COMMENT 'FK to student',
    `grievance_number` VARCHAR(50) UNIQUE COMMENT 'e.g., GRV-2024-00001',
    `subject` VARCHAR(255),
    `description` TEXT,
    `status` ENUM('SUBMITTED', 'UNDER_REVIEW', 'RESOLVED', 'REJECTED') DEFAULT 'SUBMITTED',
    `priority` ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
    `assigned_to` BIGINT COMMENT 'FK to recovery_system_user',
    `resolution` TEXT,
    `resolved_by` BIGINT,
    `resolved_date` DATETIME,
    `submitted_via` ENUM('WEB', 'AI_AGENT', 'EMAIL') DEFAULT 'WEB',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_grievance_case` (`recovery_case_id`),
    INDEX `idx_grievance_student` (`student_s_id`),
    INDEX `idx_grievance_status` (`status`),
    INDEX `idx_grievance_priority` (`priority`),
    INDEX `idx_grievance_assigned` (`assigned_to`),
    INDEX `idx_grievance_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 6. GRIEVANCE ATTACHMENT - Links to document_manager
-- =====================================================
DROP TABLE IF EXISTS `recovery_grievance_attachment`;
CREATE TABLE `recovery_grievance_attachment` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `recovery_grievance_id` BIGINT NOT NULL COMMENT 'FK to recovery_grievance',
    `document_manager_id` INT COMMENT 'FK to existing document_manager',
    `file_path` VARCHAR(500) COMMENT 'Local file path if not using document_manager',
    `file_name` VARCHAR(255),
    `file_type` VARCHAR(50),
    `file_size_bytes` BIGINT,
    `attachment_type` ENUM('DEPOSIT_SLIP', 'EMAIL', 'PAYMENT_STRUCTURE', 'ID_PROOF', 'OTHER') DEFAULT 'OTHER',
    `description` VARCHAR(255),
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_grievance_attach_grievance` (`recovery_grievance_id`),
    INDEX `idx_grievance_attach_type` (`attachment_type`),
    INDEX `idx_grievance_attach_active` (`is_active`),
    CONSTRAINT `fk_grievance_attach_grievance` FOREIGN KEY (`recovery_grievance_id`) 
        REFERENCES `recovery_grievance` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 7. FEE CONFIGURATION - Configurable fees
-- =====================================================
DROP TABLE IF EXISTS `recovery_fee_config`;
CREATE TABLE `recovery_fee_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `fee_code` VARCHAR(50) UNIQUE NOT NULL COMMENT 'e.g., UK_AWARDS_L1, CONVOCATION',
    `fee_name` VARCHAR(255) NOT NULL,
    `amount` DOUBLE NOT NULL,
    `currency_type_id` INT DEFAULT 1 COMMENT 'FK to currency_type (1=LKR, 2=GBP)',
    `effective_from` DATE,
    `effective_to` DATE,
    `is_mandatory` TINYINT(1) DEFAULT 1,
    `applies_to` ENUM('ALL', 'GRADUATING', 'SPECIFIC_COURSE') DEFAULT 'ALL',
    `course_cid` INT COMMENT 'FK to course if applies_to=SPECIFIC_COURSE',
    `description` TEXT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_fee_config_code` (`fee_code`),
    INDEX `idx_fee_config_currency` (`currency_type_id`),
    INDEX `idx_fee_config_effective` (`effective_from`, `effective_to`),
    INDEX `idx_fee_config_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 8. EXCHANGE RATE HISTORY
-- =====================================================
DROP TABLE IF EXISTS `recovery_exchange_rate`;
CREATE TABLE `recovery_exchange_rate` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `from_currency_id` INT NOT NULL COMMENT 'FK to currency_type (e.g., GBP)',
    `to_currency_id` INT NOT NULL COMMENT 'FK to currency_type (e.g., LKR)',
    `rate` DOUBLE NOT NULL,
    `rate_date` DATE NOT NULL,
    `source` VARCHAR(100) COMMENT 'e.g., FIXER_API, MANUAL',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_exchange_rate` (`from_currency_id`, `to_currency_id`, `rate_date`),
    INDEX `idx_exchange_rate_date` (`rate_date`),
    INDEX `idx_exchange_rate_currencies` (`from_currency_id`, `to_currency_id`),
    INDEX `idx_exchange_rate_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 9. AI CONVERSATION HISTORY
-- =====================================================
DROP TABLE IF EXISTS `recovery_ai_conversation`;
CREATE TABLE `recovery_ai_conversation` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `session_id` VARCHAR(100) COMMENT 'Group messages in session',
    `student_s_id` INT COMMENT 'FK to student (if student chat)',
    `user_id` BIGINT COMMENT 'FK to recovery_system_user (if staff)',
    `recovery_case_id` BIGINT COMMENT 'FK to recovery_case if related',
    `role` ENUM('USER', 'ASSISTANT', 'SYSTEM') NOT NULL,
    `message` TEXT NOT NULL,
    `context_json` TEXT COMMENT 'Student data context sent to AI',
    `tokens_used` INT,
    `model_used` VARCHAR(50),
    `response_time_ms` INT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_ai_conv_session` (`session_id`),
    INDEX `idx_ai_conv_student` (`student_s_id`),
    INDEX `idx_ai_conv_user` (`user_id`),
    INDEX `idx_ai_conv_case` (`recovery_case_id`),
    INDEX `idx_ai_conv_created` (`created_at`),
    INDEX `idx_ai_conv_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 10. SYSTEM USER - Recovery system specific users
-- =====================================================
DROP TABLE IF EXISTS `recovery_system_user`;
CREATE TABLE `recovery_system_user` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(100) UNIQUE NOT NULL,
    `password_hash` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255),
    `full_name` VARCHAR(255),
    `role` ENUM('ADMIN', 'RECOVERY_OFFICER', 'FINANCE', 'MANAGEMENT', 'STUDENT') NOT NULL,
    `general_user_profile_gup_id` INT COMMENT 'Link to main system user if exists',
    `student_s_id` INT COMMENT 'FK to student for STUDENT role',
    `phone` VARCHAR(20),
    `last_login` DATETIME,
    `login_attempts` INT DEFAULT 0,
    `is_locked` TINYINT(1) DEFAULT 0,
    `locked_until` DATETIME,
    `password_changed_at` DATETIME,
    `must_change_password` TINYINT(1) DEFAULT 0,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_sys_user_username` (`username`),
    INDEX `idx_sys_user_email` (`email`),
    INDEX `idx_sys_user_role` (`role`),
    INDEX `idx_sys_user_gup` (`general_user_profile_gup_id`),
    INDEX `idx_sys_user_student` (`student_s_id`),
    INDEX `idx_sys_user_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 11. AUDIT LOG - Recovery actions audit
-- =====================================================
DROP TABLE IF EXISTS `recovery_audit_log`;
CREATE TABLE `recovery_audit_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT COMMENT 'FK to recovery_system_user',
    `username` VARCHAR(100),
    `action` VARCHAR(100) NOT NULL COMMENT 'e.g., CALCULATION_CREATED, GRIEVANCE_RESOLVED',
    `entity_type` VARCHAR(100) COMMENT 'e.g., recovery_case, recovery_calculation',
    `entity_id` BIGINT,
    `old_values_json` TEXT,
    `new_values_json` TEXT,
    `description` TEXT,
    `ip_address` VARCHAR(50),
    `user_agent` TEXT,
    `request_url` VARCHAR(500),
    `request_method` VARCHAR(10),
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_audit_user` (`user_id`),
    INDEX `idx_audit_action` (`action`),
    INDEX `idx_audit_entity` (`entity_type`, `entity_id`),
    INDEX `idx_audit_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 12. REPORT TEMPLATE - Store report configurations
-- =====================================================
DROP TABLE IF EXISTS `recovery_report_template`;
CREATE TABLE `recovery_report_template` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `template_code` VARCHAR(50) UNIQUE NOT NULL COMMENT 'e.g., FINANCIAL_STATEMENT',
    `template_name` VARCHAR(255) NOT NULL,
    `template_file_path` VARCHAR(500) COMMENT 'Path to .jrxml file',
    `output_formats` VARCHAR(100) COMMENT 'e.g., PDF,EXCEL,HTML',
    `category` ENUM('STUDENT', 'RECOVERY', 'FINANCE', 'MANAGEMENT') DEFAULT 'RECOVERY',
    `description` TEXT,
    `parameters_schema_json` TEXT COMMENT 'JSON schema for report parameters',
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_report_template_code` (`template_code`),
    INDEX `idx_report_template_category` (`category`),
    INDEX `idx_report_template_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 13. REPORT GENERATION LOG - Track generated reports
-- =====================================================
DROP TABLE IF EXISTS `recovery_report_log`;
CREATE TABLE `recovery_report_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `report_template_id` BIGINT NOT NULL COMMENT 'FK to recovery_report_template',
    `generated_by` BIGINT NOT NULL COMMENT 'FK to recovery_system_user',
    `parameters_json` TEXT COMMENT 'Report parameters used',
    `output_format` ENUM('PDF', 'EXCEL', 'HTML', 'CSV') DEFAULT 'PDF',
    `output_file_path` VARCHAR(500),
    `generation_status` ENUM('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED') DEFAULT 'PENDING',
    `error_message` TEXT,
    `generation_started_at` DATETIME,
    `generation_completed_at` DATETIME,
    `file_size_bytes` BIGINT,
    `download_count` INT DEFAULT 0,
    `last_downloaded_at` DATETIME,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_report_log_template` (`report_template_id`),
    INDEX `idx_report_log_user` (`generated_by`),
    INDEX `idx_report_log_status` (`generation_status`),
    INDEX `idx_report_log_created` (`created_at`),
    INDEX `idx_report_log_active` (`is_active`),
    CONSTRAINT `fk_report_log_template` FOREIGN KEY (`report_template_id`) 
        REFERENCES `recovery_report_template` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- 14. SCHEDULED REPORT - For automated report generation
-- =====================================================
DROP TABLE IF EXISTS `recovery_scheduled_report`;
CREATE TABLE `recovery_scheduled_report` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `report_template_id` BIGINT NOT NULL COMMENT 'FK to recovery_report_template',
    `schedule_name` VARCHAR(255) NOT NULL,
    `cron_expression` VARCHAR(100) COMMENT 'e.g., 0 0 8 * * MON (every Monday 8am)',
    `parameters_json` TEXT,
    `output_format` ENUM('PDF', 'EXCEL') DEFAULT 'PDF',
    `email_recipients` TEXT COMMENT 'Comma-separated emails',
    `email_subject` VARCHAR(255),
    `email_body` TEXT,
    `last_run_at` DATETIME,
    `last_run_status` ENUM('SUCCESS', 'FAILED'),
    `last_error_message` TEXT,
    `next_run_at` DATETIME,
    `run_count` INT DEFAULT 0,
    `is_enabled` TINYINT(1) DEFAULT 1,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `created_by` BIGINT,
    `updated_by` BIGINT,
    `version` INT DEFAULT 0,
    `is_active` TINYINT(1) DEFAULT 1,
    PRIMARY KEY (`id`),
    INDEX `idx_scheduled_report_template` (`report_template_id`),
    INDEX `idx_scheduled_report_enabled` (`is_enabled`),
    INDEX `idx_scheduled_report_next_run` (`next_run_at`),
    INDEX `idx_scheduled_report_active` (`is_active`),
    CONSTRAINT `fk_scheduled_report_template` FOREIGN KEY (`report_template_id`) 
        REFERENCES `recovery_report_template` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- INITIAL DATA - Fee Configuration
-- =====================================================
INSERT INTO `recovery_fee_config` (`fee_code`, `fee_name`, `amount`, `currency_type_id`, `effective_from`, `is_mandatory`, `applies_to`, `description`) VALUES
('UK_AWARDS_L1', 'UK Awards Level 1', 100.00, 2, '2020-01-01', 1, 'ALL', 'International University Payment - UK Awards Level 1'),
('UK_AWARDS_L2', 'UK Awards Level 2', 110.00, 2, '2020-01-01', 1, 'ALL', 'International University Payment - UK Awards Level 2'),
('UK_AWARDS_L3', 'UK Awards Level 3', 130.00, 2, '2020-01-01', 1, 'ALL', 'International University Payment - UK Awards Level 3'),
('CONVOCATION', 'Convocation Fee', 35000.00, 1, '2020-01-01', 1, 'GRADUATING', 'Convocation Graduate Payment'),
('PORTAL_YEARLY', 'Student Portal (Yearly)', 3000.00, 1, '2020-01-01', 1, 'ALL', 'Student Portal Payment per year'),
('ID_CARD', 'Student ID Card', 1200.00, 1, '2020-01-01', 1, 'ALL', 'Student ID Card fee');

-- =====================================================
-- INITIAL DATA - Report Templates
-- =====================================================
INSERT INTO `recovery_report_template` (`template_code`, `template_name`, `output_formats`, `category`, `description`) VALUES
('FINANCIAL_STATEMENT', 'Student Financial Statement', 'PDF,HTML', 'STUDENT', 'Individual student financial statement with dues breakdown'),
('RECOVERY_SUMMARY', 'Recovery Summary Report', 'PDF,EXCEL', 'RECOVERY', 'Summary of all open recovery cases'),
('BANK_RECONCILIATION', 'Bank Reconciliation Report', 'PDF,EXCEL', 'FINANCE', 'Matched and unmatched bank deposits'),
('GRIEVANCE_REPORT', 'Grievance Status Report', 'PDF,EXCEL', 'RECOVERY', 'Open and resolved grievances'),
('COLLECTION_REPORT', 'Collection Report', 'PDF,EXCEL', 'FINANCE', 'Payments collected over period'),
('MANAGEMENT_DASHBOARD', 'Management Dashboard Report', 'PDF', 'MANAGEMENT', 'KPIs and recovery statistics');

-- =====================================================
-- INITIAL DATA - Default Admin User (password: admin123 - CHANGE IN PRODUCTION!)
-- =====================================================
INSERT INTO `recovery_system_user` (`username`, `password_hash`, `email`, `full_name`, `role`, `is_active`) VALUES
('admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZRGdjGj/n3.rsS8gvGqnHpSOhQKG6', 'admin@jiat.lk', 'System Administrator', 'ADMIN', 1);

