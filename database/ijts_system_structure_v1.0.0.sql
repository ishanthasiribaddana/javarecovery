-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table ijts_system.academic_officer_manager
DROP TABLE IF EXISTS `academic_officer_manager`;
CREATE TABLE IF NOT EXISTS `academic_officer_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_officer` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_officer` (`academic_officer`),
  KEY `added_by` (`added_by`),
  CONSTRAINT `academic_officer_manager_ibfk_1` FOREIGN KEY (`academic_officer`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `academic_officer_manager_ibfk_2` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.academic_policy_documents
DROP TABLE IF EXISTS `academic_policy_documents`;
CREATE TABLE IF NOT EXISTS `academic_policy_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_url` text,
  `academic_policy_level_1_id` int DEFAULT NULL,
  `academic_policy_level_2_id` int DEFAULT NULL,
  `academic_policy_level_3_id` int DEFAULT NULL,
  `academic_policy_level_4_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `version_name` varchar(45) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `academic_policy_level_1_id` (`academic_policy_level_1_id`) USING BTREE,
  KEY `academic_policy_level_2_id` (`academic_policy_level_2_id`) USING BTREE,
  KEY `academic_policy_level_3_id` (`academic_policy_level_3_id`) USING BTREE,
  KEY `academic_policy_level_4_id` (`academic_policy_level_4_id`) USING BTREE,
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`) USING BTREE,
  CONSTRAINT `academic_policy_documents_ibfk_1` FOREIGN KEY (`academic_policy_level_1_id`) REFERENCES `academic_policy_level_1` (`id`),
  CONSTRAINT `academic_policy_documents_ibfk_2` FOREIGN KEY (`academic_policy_level_2_id`) REFERENCES `academic_policy_level_2` (`id`),
  CONSTRAINT `academic_policy_documents_ibfk_3` FOREIGN KEY (`academic_policy_level_3_id`) REFERENCES `academic_policy_level_3` (`id`),
  CONSTRAINT `academic_policy_documents_ibfk_4` FOREIGN KEY (`academic_policy_level_4_id`) REFERENCES `academic_policy_level_4` (`id`),
  CONSTRAINT `academic_policy_documents_ibfk_5` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.academic_policy_level_1
DROP TABLE IF EXISTS `academic_policy_level_1`;
CREATE TABLE IF NOT EXISTS `academic_policy_level_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `no` varchar(45) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.academic_policy_level_2
DROP TABLE IF EXISTS `academic_policy_level_2`;
CREATE TABLE IF NOT EXISTS `academic_policy_level_2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `no` varchar(45) DEFAULT NULL,
  `academic_policy_level_1_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `academic_policy_level_1_id` (`academic_policy_level_1_id`) USING BTREE,
  CONSTRAINT `academic_policy_level_2_ibfk_1` FOREIGN KEY (`academic_policy_level_1_id`) REFERENCES `academic_policy_level_1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.academic_policy_level_3
DROP TABLE IF EXISTS `academic_policy_level_3`;
CREATE TABLE IF NOT EXISTS `academic_policy_level_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `no` varchar(45) DEFAULT NULL,
  `academic_policy_level_2_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `academic_policy_level_3_ibfk_1` (`academic_policy_level_2_id`),
  CONSTRAINT `academic_policy_level_3_ibfk_1` FOREIGN KEY (`academic_policy_level_2_id`) REFERENCES `academic_policy_level_2` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.academic_policy_level_4
DROP TABLE IF EXISTS `academic_policy_level_4`;
CREATE TABLE IF NOT EXISTS `academic_policy_level_4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `no` varchar(45) DEFAULT NULL,
  `academic_policy_level_3_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `academic_policy_level_3_id` (`academic_policy_level_3_id`) USING BTREE,
  CONSTRAINT `academic_policy_level_4_ibfk_1` FOREIGN KEY (`academic_policy_level_3_id`) REFERENCES `academic_policy_level_3` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.accessor_feedback_form
DROP TABLE IF EXISTS `accessor_feedback_form`;
CREATE TABLE IF NOT EXISTS `accessor_feedback_form` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `comment` text,
  `verification_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_accessor_feedback_form_verification_type1_idx` (`verification_type_id`),
  CONSTRAINT `fk_accessor_feedback_form_verification_type1` FOREIGN KEY (`verification_type_id`) REFERENCES `verification_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90842 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.access_level
DROP TABLE IF EXISTS `access_level`;
CREATE TABLE IF NOT EXISTS `access_level` (
  `id_al` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_al`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.access_level_manager
DROP TABLE IF EXISTS `access_level_manager`;
CREATE TABLE IF NOT EXISTS `access_level_manager` (
  `id_alm` int NOT NULL AUTO_INCREMENT,
  `access_level_id_al` int NOT NULL,
  `use_case_has_system_interface_uc_si_id` int NOT NULL,
  `user_role_ur_id` int NOT NULL,
  PRIMARY KEY (`id_alm`),
  KEY `fk_access_level_manager_access_level1_idx` (`access_level_id_al`),
  KEY `fk_access_level_manager_use_case_has_system_interface1_idx` (`use_case_has_system_interface_uc_si_id`),
  KEY `fk_access_level_manager_user_role1_idx` (`user_role_ur_id`),
  CONSTRAINT `fk_access_level_manager_access_level1` FOREIGN KEY (`access_level_id_al`) REFERENCES `access_level` (`id_al`),
  CONSTRAINT `fk_access_level_manager_use_case_has_system_interface1` FOREIGN KEY (`use_case_has_system_interface_uc_si_id`) REFERENCES `use_case_has_system_interface` (`uc_si_id`),
  CONSTRAINT `fk_access_level_manager_user_role1` FOREIGN KEY (`user_role_ur_id`) REFERENCES `user_role` (`ur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.account_type
DROP TABLE IF EXISTS `account_type`;
CREATE TABLE IF NOT EXISTS `account_type` (
  `a_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL COMMENT 'code',
  PRIMARY KEY (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.account_type_manager
DROP TABLE IF EXISTS `account_type_manager`;
CREATE TABLE IF NOT EXISTS `account_type_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `chart_of_account_coa_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_type_manager_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_account_type_manager_chart_of_account1_idx` (`chart_of_account_coa_id`),
  CONSTRAINT `fk_account_type_manager_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`),
  CONSTRAINT `fk_account_type_manager_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB AUTO_INCREMENT=37815 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.achievement_type
DROP TABLE IF EXISTS `achievement_type`;
CREATE TABLE IF NOT EXISTS `achievement_type` (
  `id_achievement_type` int NOT NULL AUTO_INCREMENT,
  `achievement_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_achievement_type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for procedure ijts_system.add_column_if_not_exists
DROP PROCEDURE IF EXISTS `add_column_if_not_exists`;
DELIMITER //
CREATE PROCEDURE `add_column_if_not_exists`(
    IN p_table_name VARCHAR(255),
    IN p_column_name VARCHAR(255),
    IN p_column_definition VARCHAR(500)
)
BEGIN
    DECLARE column_exists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO column_exists
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table_name
      AND COLUMN_NAME = p_column_name;
    
    IF column_exists = 0 THEN
        SET @sql = CONCAT('ALTER TABLE ', p_table_name, ' ADD COLUMN ', p_column_name, ' ', p_column_definition);
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END//
DELIMITER ;

-- Dumping structure for procedure ijts_system.add_index_if_not_exists
DROP PROCEDURE IF EXISTS `add_index_if_not_exists`;
DELIMITER //
CREATE PROCEDURE `add_index_if_not_exists`(
    IN p_table_name VARCHAR(255),
    IN p_index_name VARCHAR(255),
    IN p_column_name VARCHAR(255)
)
BEGIN
    DECLARE index_exists INT DEFAULT 0;
    
    SELECT COUNT(*) INTO index_exists
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = DATABASE()
      AND TABLE_NAME = p_table_name
      AND INDEX_NAME = p_index_name;
    
    IF index_exists = 0 THEN
        SET @sql = CONCAT('CREATE INDEX ', p_index_name, ' ON ', p_table_name, ' (', p_column_name, ')');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END//
DELIMITER ;

-- Dumping structure for table ijts_system.advertising_material
DROP TABLE IF EXISTS `advertising_material`;
CREATE TABLE IF NOT EXISTS `advertising_material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.ad_has_student
DROP TABLE IF EXISTS `ad_has_student`;
CREATE TABLE IF NOT EXISTS `ad_has_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agreement_document_id` int NOT NULL DEFAULT '0',
  `student_s_id` int NOT NULL DEFAULT '0',
  `is_agreed` tinyint NOT NULL DEFAULT '0',
  `ip_address` varchar(50) NOT NULL DEFAULT '0',
  `agreed_date` datetime DEFAULT NULL,
  `login_session_session_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ad_has_student_agreement_document` (`agreement_document_id`),
  KEY `FK_ad_has_student_student` (`student_s_id`),
  KEY `FK_ad_has_student_login_session` (`login_session_session_id`),
  CONSTRAINT `FK_ad_has_student_agreement_document` FOREIGN KEY (`agreement_document_id`) REFERENCES `agreement_document` (`id`),
  CONSTRAINT `FK_ad_has_student_login_session` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `FK_ad_has_student_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.ad_pages_has_student
DROP TABLE IF EXISTS `ad_pages_has_student`;
CREATE TABLE IF NOT EXISTS `ad_pages_has_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `agreement_document_pages_id` int NOT NULL DEFAULT '0',
  `student_s_id` int NOT NULL DEFAULT '0',
  `is_read` tinytext,
  `read_date` datetime DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `login_session_session_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ad_pages_has_student_agreement_document` (`agreement_document_pages_id`),
  KEY `FK_ad_pages_has_student_student` (`student_s_id`),
  KEY `FK_ad_pages_has_student_login_session` (`login_session_session_id`),
  CONSTRAINT `FK_ad_pages_has_student_agreement_document` FOREIGN KEY (`agreement_document_pages_id`) REFERENCES `agreement_document` (`id`),
  CONSTRAINT `FK_ad_pages_has_student_login_session` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `FK_ad_pages_has_student_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.affiliate_reward_plans
DROP TABLE IF EXISTS `affiliate_reward_plans`;
CREATE TABLE IF NOT EXISTS `affiliate_reward_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `registration_count_from` int DEFAULT NULL,
  `registration_count_to` int DEFAULT NULL,
  `reward_percentage` double DEFAULT NULL,
  `min_payment_plan` double DEFAULT NULL,
  `work_shop_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_affiliate_reward_system_work_shop1_idx` (`work_shop_id`),
  CONSTRAINT `fk_affiliate_reward_system_work_shop1` FOREIGN KEY (`work_shop_id`) REFERENCES `work_shop` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.affiliate_user
DROP TABLE IF EXISTS `affiliate_user`;
CREATE TABLE IF NOT EXISTS `affiliate_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(45) DEFAULT NULL,
  `pay_my_earning_limit_reached` double DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `affiliate_user_id` int DEFAULT NULL,
  `affiliate_user_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_refaral_user_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_affiliate_user_affiliate_user1_idx` (`affiliate_user_id`),
  KEY `fk_affiliate_user_affiliate_user_type1_idx` (`affiliate_user_type_id`),
  CONSTRAINT `fk_affiliate_user_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`),
  CONSTRAINT `fk_affiliate_user_affiliate_user_type1` FOREIGN KEY (`affiliate_user_type_id`) REFERENCES `affiliate_user_type` (`id`),
  CONSTRAINT `fk_refaral_user_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='there are affiliates and affiliate agents.\ncompany tranfer 10% to affiliate agent. \naffiliate agent re destribute to 7% to his affiliate.\nthat is shown in unary relationship.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.affiliate_user_payment_info
DROP TABLE IF EXISTS `affiliate_user_payment_info`;
CREATE TABLE IF NOT EXISTS `affiliate_user_payment_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_received` tinyint(1) DEFAULT NULL,
  `voucher_vid` int NOT NULL,
  `affiliate_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_refaral_user_payment_info_voucher1_idx` (`voucher_vid`),
  KEY `fk_affiliate_user_payment_info_affiliate_user1_idx` (`affiliate_user_id`),
  CONSTRAINT `fk_affiliate_user_payment_info_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`),
  CONSTRAINT `fk_refaral_user_payment_info_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.affiliate_user_reward_plans
DROP TABLE IF EXISTS `affiliate_user_reward_plans`;
CREATE TABLE IF NOT EXISTS `affiliate_user_reward_plans` (
  `id` int NOT NULL AUTO_INCREMENT,
  `percentage` double DEFAULT NULL,
  `affiliate_user_id` int NOT NULL,
  `affiliate_reward_plans_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_affiliate_user_reward_plans_affiliate_user1_idx` (`affiliate_user_id`),
  KEY `fk_affiliate_user_reward_plans_affiliate_reward_plans1_idx` (`affiliate_reward_plans_id`),
  CONSTRAINT `fk_affiliate_user_reward_plans_affiliate_reward_plans1` FOREIGN KEY (`affiliate_reward_plans_id`) REFERENCES `affiliate_reward_plans` (`id`),
  CONSTRAINT `fk_affiliate_user_reward_plans_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='ths table is added to made affiliate downline a network. using this table affiliate can difine the precentage thay can their downline affiliates.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.affiliate_user_type
DROP TABLE IF EXISTS `affiliate_user_type`;
CREATE TABLE IF NOT EXISTS `affiliate_user_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.agreement_document
DROP TABLE IF EXISTS `agreement_document`;
CREATE TABLE IF NOT EXISTS `agreement_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.agreement_document_pages
DROP TABLE IF EXISTS `agreement_document_pages`;
CREATE TABLE IF NOT EXISTS `agreement_document_pages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `page_title` varchar(1000) DEFAULT NULL,
  `page_content` text,
  `priority` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `agreement_document_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_agreement_document_pages_agreement_document` (`agreement_document_id`),
  KEY `FK_agreement_document_pages_user_login` (`created_by`),
  CONSTRAINT `FK_agreement_document_pages_agreement_document` FOREIGN KEY (`agreement_document_id`) REFERENCES `agreement_document` (`id`),
  CONSTRAINT `FK_agreement_document_pages_user_login` FOREIGN KEY (`created_by`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.allocated_staff_for_seminar
DROP TABLE IF EXISTS `allocated_staff_for_seminar`;
CREATE TABLE IF NOT EXISTS `allocated_staff_for_seminar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seminar_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_allocated_staff_for_seminar_seminar1_idx` (`seminar_id`),
  KEY `fk_allocated_staff_for_seminar_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_allocated_staff_for_seminar_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_allocated_staff_for_seminar_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.answer_group
DROP TABLE IF EXISTS `answer_group`;
CREATE TABLE IF NOT EXISTS `answer_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(345) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.answer_group_items
DROP TABLE IF EXISTS `answer_group_items`;
CREATE TABLE IF NOT EXISTS `answer_group_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feed_back_order` int DEFAULT NULL,
  `asnwer_id` int NOT NULL,
  `answer_group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_answer_group_items_asnwer1_idx` (`asnwer_id`),
  KEY `fk_answer_group_items_answer_group1_idx` (`answer_group_id`),
  CONSTRAINT `fk_answer_group_items_answer_group1` FOREIGN KEY (`answer_group_id`) REFERENCES `answer_group` (`id`),
  CONSTRAINT `fk_answer_group_items_asnwer1` FOREIGN KEY (`asnwer_id`) REFERENCES `asnwer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.api_consumer
DROP TABLE IF EXISTS `api_consumer`;
CREATE TABLE IF NOT EXISTS `api_consumer` (
  `ac_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Consumer name (e.g., TEMCO, Mobile App)',
  `api_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique API key',
  `api_secret` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'API secret for signing',
  `webhook_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to send webhook events',
  `allowed_endpoints` json DEFAULT NULL COMMENT 'Array of allowed API endpoints',
  `allowed_ips` json DEFAULT NULL COMMENT 'Array of allowed IP addresses',
  `rate_limit` int DEFAULT '1000' COMMENT 'Requests per hour',
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`ac_id`),
  UNIQUE KEY `idx_api_consumer_key` (`api_key`),
  KEY `idx_api_consumer_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.api_request_log
DROP TABLE IF EXISTS `api_request_log`;
CREATE TABLE IF NOT EXISTS `api_request_log` (
  `arl_id` bigint NOT NULL AUTO_INCREMENT,
  `api_consumer_ac_id` int DEFAULT NULL COMMENT 'FK to api_consumer.ac_id',
  `endpoint` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'GET, POST, PUT, DELETE',
  `request_headers` json DEFAULT NULL,
  `request_body` json DEFAULT NULL,
  `response_status` int DEFAULT NULL COMMENT 'HTTP status code',
  `response_body` json DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `execution_time_ms` int DEFAULT NULL,
  `error_message` text COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`arl_id`),
  KEY `idx_api_request_log_consumer` (`api_consumer_ac_id`),
  KEY `idx_api_request_log_endpoint` (`endpoint`),
  KEY `idx_api_request_log_status` (`response_status`),
  KEY `idx_api_request_log_created` (`created_at`),
  CONSTRAINT `fk_api_request_log_consumer` FOREIGN KEY (`api_consumer_ac_id`) REFERENCES `api_consumer` (`ac_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.application_checklist
DROP TABLE IF EXISTS `application_checklist`;
CREATE TABLE IF NOT EXISTS `application_checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.applying_scheme
DROP TABLE IF EXISTS `applying_scheme`;
CREATE TABLE IF NOT EXISTS `applying_scheme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.asnwer
DROP TABLE IF EXISTS `asnwer`;
CREATE TABLE IF NOT EXISTS `asnwer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment
DROP TABLE IF EXISTS `assesment`;
CREATE TABLE IF NOT EXISTS `assesment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesmentid` varchar(45) DEFAULT NULL,
  `name` varchar(500) DEFAULT NULL,
  `description` text,
  `submitting_criteria` varchar(545) DEFAULT NULL,
  `contribution` double DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `assesment_type_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `assesment_category_id` int NOT NULL,
  `internal_verification_perc` double DEFAULT NULL,
  `assesment_mode_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_assesment_type1_idx` (`assesment_type_id`),
  KEY `fk_assesment_course1_idx` (`course_cid`),
  KEY `fk_assesment_assesment_category1_idx` (`assesment_category_id`),
  KEY `fk_assesment_assesment_mode1_idx` (`assesment_mode_id`),
  CONSTRAINT `fk_assesment_assesment_category1` FOREIGN KEY (`assesment_category_id`) REFERENCES `assesment_category` (`id`),
  CONSTRAINT `fk_assesment_assesment_mode1` FOREIGN KEY (`assesment_mode_id`) REFERENCES `assesment_mode` (`id`),
  CONSTRAINT `fk_assesment_assesment_type1` FOREIGN KEY (`assesment_type_id`) REFERENCES `assesment_type` (`id`),
  CONSTRAINT `fk_assesment_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_category
DROP TABLE IF EXISTS `assesment_category`;
CREATE TABLE IF NOT EXISTS `assesment_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'assingment or exam paper',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_feedback_manager
DROP TABLE IF EXISTS `assesment_feedback_manager`;
CREATE TABLE IF NOT EXISTS `assesment_feedback_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_assesment_result_id` int NOT NULL,
  `accessor_feedback_form_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_feedback_manager_student_assesment_result1_idx` (`student_assesment_result_id`),
  KEY `fk_assesment_feedback_manager_accessor_feedback_form1_idx` (`accessor_feedback_form_id`),
  CONSTRAINT `fk_assesment_feedback_manager_accessor_feedback_form1` FOREIGN KEY (`accessor_feedback_form_id`) REFERENCES `accessor_feedback_form` (`id`),
  CONSTRAINT `fk_assesment_feedback_manager_student_assesment_result1` FOREIGN KEY (`student_assesment_result_id`) REFERENCES `student_assesment_result` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=245 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_marking_criterias
DROP TABLE IF EXISTS `assesment_marking_criterias`;
CREATE TABLE IF NOT EXISTS `assesment_marking_criterias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `rate` double DEFAULT NULL,
  `assesment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_marking_criterias_assesment1_idx` (`assesment_id`),
  CONSTRAINT `fk_assesment_marking_criterias_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=396 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_marking_criterias_intake
DROP TABLE IF EXISTS `assesment_marking_criterias_intake`;
CREATE TABLE IF NOT EXISTS `assesment_marking_criterias_intake` (
  `id` int NOT NULL,
  `assesment_marking_criteria_componant_manager_id` int NOT NULL,
  `batchesb_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assesment_marking_criteria_componant_manager_id` (`assesment_marking_criteria_componant_manager_id`),
  KEY `batchesb_id` (`batchesb_id`),
  CONSTRAINT `assesment_marking_criterias_intake_ibfk_1` FOREIGN KEY (`assesment_marking_criteria_componant_manager_id`) REFERENCES `assesment_marking_criteria_componant_manager` (`id`),
  CONSTRAINT `assesment_marking_criterias_intake_ibfk_2` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_marking_criterias_version
DROP TABLE IF EXISTS `assesment_marking_criterias_version`;
CREATE TABLE IF NOT EXISTS `assesment_marking_criterias_version` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_marking_criteria_componant
DROP TABLE IF EXISTS `assesment_marking_criteria_componant`;
CREATE TABLE IF NOT EXISTS `assesment_marking_criteria_componant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `marking_component_type_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `assesment_marking_criterias_version_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_marking_criteria_componant_marking_component_t_idx` (`marking_component_type_id`),
  KEY `fk_assesment_marking_criteria_componant_course1_idx` (`course_cid`),
  KEY `assesment_marking_criterias_version_id` (`assesment_marking_criterias_version_id`),
  CONSTRAINT `assesment_marking_criteria_componant_ibfk_1` FOREIGN KEY (`assesment_marking_criterias_version_id`) REFERENCES `assesment_marking_criteria_componant` (`id`),
  CONSTRAINT `fk_assesment_marking_criteria_componant_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_assesment_marking_criteria_componant_marking_component_type1` FOREIGN KEY (`marking_component_type_id`) REFERENCES `component_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=660 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_marking_criteria_componant_manager
DROP TABLE IF EXISTS `assesment_marking_criteria_componant_manager`;
CREATE TABLE IF NOT EXISTS `assesment_marking_criteria_componant_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesment_marking_criterias_id` int NOT NULL,
  `assesment_marking_criteria_componant_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `value` double DEFAULT NULL,
  `expected_word_count` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_marking_criteria_componant_manager_assesment_m_idx` (`assesment_marking_criterias_id`),
  KEY `fk_assesment_marking_criteria_componant_manager_assesment_m_idx1` (`assesment_marking_criteria_componant_id`),
  CONSTRAINT `fk_assesment_marking_criteria_componant_manager_assesment_mar1` FOREIGN KEY (`assesment_marking_criterias_id`) REFERENCES `assesment_marking_criterias` (`id`),
  CONSTRAINT `fk_assesment_marking_criteria_componant_manager_assesment_mar2` FOREIGN KEY (`assesment_marking_criteria_componant_id`) REFERENCES `assesment_marking_criteria_componant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=740 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_mode
DROP TABLE IF EXISTS `assesment_mode`;
CREATE TABLE IF NOT EXISTS `assesment_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_module_manager
DROP TABLE IF EXISTS `assesment_module_manager`;
CREATE TABLE IF NOT EXISTS `assesment_module_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesment_id` int NOT NULL,
  `course_module_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_module_manager_assesment1_idx` (`assesment_id`),
  KEY `fk_assesment_module_manager_course_module1_idx` (`course_module_id`),
  KEY `fk_assesment_module_manager_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_assesment_module_manager_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_assesment_module_manager_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`),
  CONSTRAINT `fk_assesment_module_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_outcome_module_manager
DROP TABLE IF EXISTS `assesment_outcome_module_manager`;
CREATE TABLE IF NOT EXISTS `assesment_outcome_module_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesment_id` int NOT NULL,
  `outcome_id` int NOT NULL,
  `course_module_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assesment_outcome_module_manager_assesment1_idx` (`assesment_id`),
  KEY `fk_assesment_outcome_module_manager_outcome1_idx` (`outcome_id`),
  KEY `fk_assesment_outcome_module_manager_course_module1_idx` (`course_module_id`),
  KEY `fk_assesment_outcome_module_manager_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_assesment_outcome_module_manager_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_assesment_outcome_module_manager_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`),
  CONSTRAINT `fk_assesment_outcome_module_manager_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`),
  CONSTRAINT `fk_assesment_outcome_module_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assesment_type
DROP TABLE IF EXISTS `assesment_type`;
CREATE TABLE IF NOT EXISTS `assesment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Individual \nGroup',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assessment_accessor_scheduler
DROP TABLE IF EXISTS `assessment_accessor_scheduler`;
CREATE TABLE IF NOT EXISTS `assessment_accessor_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assinged_date` datetime DEFAULT NULL,
  `date_to_complete` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `lecturer_id` int NOT NULL,
  `verification_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_accessment_accesser_manager_lecturer1_idx` (`lecturer_id`),
  KEY `fk_assessment_accessor_scheduler_verification_type1_idx` (`verification_type_id`),
  CONSTRAINT `fk_accessment_accesser_manager_lecturer1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`id`),
  CONSTRAINT `fk_assessment_accessor_scheduler_verification_type1` FOREIGN KEY (`verification_type_id`) REFERENCES `verification_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60797 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assessment_marking_criteria_component_comments
DROP TABLE IF EXISTS `assessment_marking_criteria_component_comments`;
CREATE TABLE IF NOT EXISTS `assessment_marking_criteria_component_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `range_from` int DEFAULT NULL,
  `range_to` int DEFAULT NULL,
  `comment` text,
  `assesment_marking_criteria_componant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assessment_marking_criteria_component_comments_assesment_idx` (`assesment_marking_criteria_componant_id`),
  CONSTRAINT `fk_assessment_marking_criteria_component_comments_assesment_m1` FOREIGN KEY (`assesment_marking_criteria_componant_id`) REFERENCES `assesment_marking_criteria_componant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=383 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assessment_reassess_request_type
DROP TABLE IF EXISTS `assessment_reassess_request_type`;
CREATE TABLE IF NOT EXISTS `assessment_reassess_request_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Recorrection\nAppeal',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assessment_result_reassess_controller
DROP TABLE IF EXISTS `assessment_result_reassess_controller`;
CREATE TABLE IF NOT EXISTS `assessment_result_reassess_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fee` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_send_to_assess` tinyint(1) DEFAULT NULL,
  `voucher_vid` int DEFAULT NULL,
  `assessment_reassess_request_type_id` int NOT NULL,
  `requested_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `student_assesment_result_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assessment_result_reassess_controller_voucher1_idx` (`voucher_vid`),
  KEY `fk_assessment_result_reassess_controller_assessment_reasses_idx` (`assessment_reassess_request_type_id`),
  KEY `fk_assessment_result_reassess_controller_student_assesment__idx` (`student_assesment_result_id`),
  CONSTRAINT `fk_assessment_result_reassess_controller_assessment_reassess_1` FOREIGN KEY (`assessment_reassess_request_type_id`) REFERENCES `assessment_reassess_request_type` (`id`),
  CONSTRAINT `fk_assessment_result_reassess_controller_student_assesment_re1` FOREIGN KEY (`student_assesment_result_id`) REFERENCES `student_assesment_result` (`id`),
  CONSTRAINT `fk_assessment_result_reassess_controller_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assessment_status
DROP TABLE IF EXISTS `assessment_status`;
CREATE TABLE IF NOT EXISTS `assessment_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.assignment_type
DROP TABLE IF EXISTS `assignment_type`;
CREATE TABLE IF NOT EXISTS `assignment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.attendance_sheet
DROP TABLE IF EXISTS `attendance_sheet`;
CREATE TABLE IF NOT EXISTS `attendance_sheet` (
  `as_id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `login_session_session_id` int NOT NULL,
  `batches_b_id` int NOT NULL,
  `total_student` int DEFAULT NULL,
  `total_absent` int DEFAULT NULL,
  PRIMARY KEY (`as_id`),
  KEY `FKattendance154617` (`login_session_session_id`),
  KEY `FKattendance597562` (`batches_b_id`),
  KEY `FKattendance154618` (`login_session_session_id`),
  KEY `FKattendance597563` (`batches_b_id`),
  CONSTRAINT `fk_attendance_sheet_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_attendance_sheet_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.attended_persons
DROP TABLE IF EXISTS `attended_persons`;
CREATE TABLE IF NOT EXISTS `attended_persons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `minutes_and_reviews_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_attended_persons_minutes_and_reviews1_idx` (`minutes_and_reviews_id`),
  KEY `fk_attended_persons_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_attended_persons_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_attended_persons_minutes_and_reviews1` FOREIGN KEY (`minutes_and_reviews_id`) REFERENCES `minutes_and_reviews` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.auto_instament_planer
DROP TABLE IF EXISTS `auto_instament_planer`;
CREATE TABLE IF NOT EXISTS `auto_instament_planer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` varchar(45) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `instalment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_auto_instament_planer_student1_idx` (`student_s_id`),
  KEY `fk_auto_instament_planer_instalment1_idx` (`instalment_id`),
  CONSTRAINT `fk_auto_instament_planer_instalment1` FOREIGN KEY (`instalment_id`) REFERENCES `instalment` (`id`),
  CONSTRAINT `fk_auto_instament_planer_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.awarding_body
DROP TABLE IF EXISTS `awarding_body`;
CREATE TABLE IF NOT EXISTS `awarding_body` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `currency_type_id` int DEFAULT NULL,
  `lkr_price` double DEFAULT NULL,
  `qualification_type_id` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_awarding_body_qualification_type` (`qualification_type_id`),
  KEY `FK_awarding_body_general_user_profile` (`created_by`),
  KEY `FK_awarding_body_course` (`course_id`),
  KEY `FK_awarding_body_currency_type` (`currency_type_id`),
  CONSTRAINT `FK_awarding_body_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`),
  CONSTRAINT `FK_awarding_body_currency_type` FOREIGN KEY (`currency_type_id`) REFERENCES `currency_type` (`id`),
  CONSTRAINT `FK_awarding_body_general_user_profile` FOREIGN KEY (`created_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_awarding_body_qualification_type` FOREIGN KEY (`qualification_type_id`) REFERENCES `qualification_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank
DROP TABLE IF EXISTS `bank`;
CREATE TABLE IF NOT EXISTS `bank` (
  `b_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_account
DROP TABLE IF EXISTS `bank_account`;
CREATE TABLE IF NOT EXISTS `bank_account` (
  `ba_id` int NOT NULL AUTO_INCREMENT,
  `account_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `opening_balance` double DEFAULT NULL,
  `bankb_id` int NOT NULL,
  `sub_chart_of_accountis_sca` int DEFAULT NULL,
  `bm_gop_id` int NOT NULL,
  PRIMARY KEY (`ba_id`),
  KEY `FKbank_accou72699` (`bankb_id`),
  KEY `FKbank_accou528220` (`sub_chart_of_accountis_sca`),
  KEY `fk_bank_account_bm_gop1_idx` (`bm_gop_id`),
  CONSTRAINT `fk_bank_account_bm_gop1` FOREIGN KEY (`bm_gop_id`) REFERENCES `bm_gop` (`id`),
  CONSTRAINT `FKbank_accou528220` FOREIGN KEY (`sub_chart_of_accountis_sca`) REFERENCES `sub_chart_of_account` (`is_sca`),
  CONSTRAINT `FKbank_accou72699` FOREIGN KEY (`bankb_id`) REFERENCES `bank` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_deposit
DROP TABLE IF EXISTS `bank_deposit`;
CREATE TABLE IF NOT EXISTS `bank_deposit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `general_journal_entry_gje_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bank_deposit_general_journal_entry1_idx` (`general_journal_entry_gje_id`),
  CONSTRAINT `fk_bank_deposit_general_journal_entry1` FOREIGN KEY (`general_journal_entry_gje_id`) REFERENCES `general_journal_entry` (`gje_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_document_manager
DROP TABLE IF EXISTS `bank_document_manager`;
CREATE TABLE IF NOT EXISTS `bank_document_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` int DEFAULT NULL,
  `bank_document_type_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bank_document_manager_bank_document_type1_idx` (`bank_document_type_id`),
  KEY `fk_bank_document_manager_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_bank_document_manager_bank_document_type1` FOREIGN KEY (`bank_document_type_id`) REFERENCES `bank_document_type` (`id`),
  CONSTRAINT `fk_bank_document_manager_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=579 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_document_type
DROP TABLE IF EXISTS `bank_document_type`;
CREATE TABLE IF NOT EXISTS `bank_document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_loan_required_document
DROP TABLE IF EXISTS `bank_loan_required_document`;
CREATE TABLE IF NOT EXISTS `bank_loan_required_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `required_document` text,
  `status` int DEFAULT NULL,
  `bank_b_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bank_loan_required_document_bank1_idx` (`bank_b_id`),
  CONSTRAINT `fk_bank_loan_required_document_bank1` FOREIGN KEY (`bank_b_id`) REFERENCES `bank` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_loan_requirement
DROP TABLE IF EXISTS `bank_loan_requirement`;
CREATE TABLE IF NOT EXISTS `bank_loan_requirement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requirement` text,
  `status` int DEFAULT NULL,
  `bank_b_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bank_loan_requirement_bank1_idx` (`bank_b_id`),
  CONSTRAINT `fk_bank_loan_requirement_bank1` FOREIGN KEY (`bank_b_id`) REFERENCES `bank` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bank_loan_status
DROP TABLE IF EXISTS `bank_loan_status`;
CREATE TABLE IF NOT EXISTS `bank_loan_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.banner
DROP TABLE IF EXISTS `banner`;
CREATE TABLE IF NOT EXISTS `banner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `banner_id` varchar(45) DEFAULT NULL,
  `banner_width` int DEFAULT NULL,
  `banner_height` int DEFAULT NULL,
  `banner_script` text,
  `banner_path` varchar(245) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `work_shop_id` int NOT NULL,
  `affiliate_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_banner_work_shop1_idx` (`work_shop_id`),
  KEY `fk_banner_affiliate_user1_idx` (`affiliate_user_id`),
  CONSTRAINT `fk_banner_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`),
  CONSTRAINT `fk_banner_work_shop1` FOREIGN KEY (`work_shop_id`) REFERENCES `work_shop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batches
DROP TABLE IF EXISTS `batches`;
CREATE TABLE IF NOT EXISTS `batches` (
  `b_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT NULL,
  `batch_identifiers` varchar(50) DEFAULT NULL,
  `total_student` int DEFAULT NULL,
  `total_collection` double DEFAULT NULL,
  `total_expected_amount` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `is_started` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `total_students` int DEFAULT NULL,
  `coursecid` int NOT NULL,
  `branch_bid` int NOT NULL,
  `stp_gom_id_sp` int NOT NULL,
  `batch_status_type_id` int NOT NULL,
  `batch_type_id` int DEFAULT NULL,
  `intake_id` int DEFAULT NULL,
  `batch_icon` varchar(255) DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `student_service_officer` int DEFAULT NULL,
  `is_show` tinyint NOT NULL DEFAULT '1',
  `is_status` tinyint DEFAULT '1',
  `qualification_type_id` int DEFAULT NULL,
  `batch_category_id` int DEFAULT NULL,
  PRIMARY KEY (`b_id`),
  KEY `FKbatches380120` (`coursecid`),
  KEY `FKbatches215232` (`branch_bid`),
  KEY `FKbatches215233` (`branch_bid`),
  KEY `fk_batches_stp_gom1_idx` (`stp_gom_id_sp`),
  KEY `fk_batches_batch_status_type1_idx` (`batch_status_type_id`),
  KEY `fk_batches_batch_type1_idx` (`batch_type_id`),
  KEY `fk_batches_intake1_idx` (`intake_id`),
  KEY `fk_batches_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `qualification_type_id` (`qualification_type_id`),
  KEY `batch_category_id` (`batch_category_id`),
  CONSTRAINT `batches_ibfk_1` FOREIGN KEY (`qualification_type_id`) REFERENCES `qualification_type` (`id`),
  CONSTRAINT `batches_ibfk_2` FOREIGN KEY (`batch_category_id`) REFERENCES `batch_category` (`id`),
  CONSTRAINT `fk_batches_batch_status_type1` FOREIGN KEY (`batch_status_type_id`) REFERENCES `batch_status_type` (`id`),
  CONSTRAINT `fk_batches_batch_type1` FOREIGN KEY (`batch_type_id`) REFERENCES `batch_type` (`id`),
  CONSTRAINT `fk_batches_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_batches_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_batches_intake1` FOREIGN KEY (`intake_id`) REFERENCES `intake` (`id`),
  CONSTRAINT `fk_batches_stp_gom1` FOREIGN KEY (`stp_gom_id_sp`) REFERENCES `stp_gom` (`id_sp`),
  CONSTRAINT `FKbatches380120` FOREIGN KEY (`coursecid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=235857 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_actions_documents
DROP TABLE IF EXISTS `batch_actions_documents`;
CREATE TABLE IF NOT EXISTS `batch_actions_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `batch_actions_document_type_id` int DEFAULT NULL,
  `batches_b_id` int DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `batch_actions_document_type_id` (`batch_actions_document_type_id`) USING BTREE,
  KEY `batches_b_id` (`batches_b_id`) USING BTREE,
  CONSTRAINT `batch_actions_documents_ibfk_1` FOREIGN KEY (`batch_actions_document_type_id`) REFERENCES `batch_actions_document_type` (`id`),
  CONSTRAINT `batch_actions_documents_ibfk_2` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_actions_document_type
DROP TABLE IF EXISTS `batch_actions_document_type`;
CREATE TABLE IF NOT EXISTS `batch_actions_document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_assesment_contribution
DROP TABLE IF EXISTS `batch_assesment_contribution`;
CREATE TABLE IF NOT EXISTS `batch_assesment_contribution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_bid` int DEFAULT NULL,
  `assesment_id` int DEFAULT NULL,
  `contribution` double DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bac_batches` (`batches_bid`),
  KEY `FK_bac__assesment` (`assesment_id`),
  KEY `FK_bac__general_user_profile` (`added_by`),
  CONSTRAINT `FK_bac__assesment` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `FK_bac__general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_bac_batches` FOREIGN KEY (`batches_bid`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=942 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_assignment_pre_assess_doc
DROP TABLE IF EXISTS `batch_assignment_pre_assess_doc`;
CREATE TABLE IF NOT EXISTS `batch_assignment_pre_assess_doc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_b_id` int NOT NULL,
  `assesment_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_assignment_pre_assess_doc_batches1_idx` (`batches_b_id`),
  KEY `fk_batch_assignment_pre_assess_doc_assesment1_idx` (`assesment_id`),
  KEY `fk_batch_assignment_pre_assess_doc_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_batch_assignment_pre_assess_doc_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_batch_assignment_pre_assess_doc_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_batch_assignment_pre_assess_doc_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_assignment_sheduler
DROP TABLE IF EXISTS `batch_assignment_sheduler`;
CREATE TABLE IF NOT EXISTS `batch_assignment_sheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `duration` double DEFAULT NULL,
  `plagiarism_check` tinyint(1) DEFAULT NULL,
  `doc` text,
  `batches_b_id` int NOT NULL,
  `assesment_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `assignment_type_id` int DEFAULT NULL,
  `lecture_buckets_id` int DEFAULT NULL,
  `document_upload_check` tinyint DEFAULT NULL,
  `scheduled_date` datetime DEFAULT NULL,
  `is_bulk` tinyint DEFAULT NULL,
  `is_receipt_upload` tinyint DEFAULT NULL,
  `receipt_submited_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignment_sheduler_batches1_idx` (`batches_b_id`),
  KEY `fk_assignment_sheduler_assesment1_idx` (`assesment_id`),
  KEY `fk_batch_assignment_sheduler_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `assignment_type_id` (`assignment_type_id`),
  KEY `lecture_buckets_id` (`lecture_buckets_id`),
  CONSTRAINT `batch_assignment_sheduler_ibfk_1` FOREIGN KEY (`assignment_type_id`) REFERENCES `assignment_type` (`id`),
  CONSTRAINT `batch_assignment_sheduler_ibfk_2` FOREIGN KEY (`lecture_buckets_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `fk_assignment_sheduler_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_assignment_sheduler_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_batch_assignment_sheduler_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10589 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_awarding_body
DROP TABLE IF EXISTS `batch_awarding_body`;
CREATE TABLE IF NOT EXISTS `batch_awarding_body` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_id` int DEFAULT NULL,
  `awarding_body_id` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_batch_awarding_body_batches` (`batches_id`),
  KEY `FK_batch_awarding_body_awarding_body` (`awarding_body_id`),
  CONSTRAINT `FK_batch_awarding_body_awarding_body` FOREIGN KEY (`awarding_body_id`) REFERENCES `awarding_body` (`id`),
  CONSTRAINT `FK_batch_awarding_body_batches` FOREIGN KEY (`batches_id`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_category
DROP TABLE IF EXISTS `batch_category`;
CREATE TABLE IF NOT EXISTS `batch_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_document_controller
DROP TABLE IF EXISTS `batch_document_controller`;
CREATE TABLE IF NOT EXISTS `batch_document_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_b_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_document_controller_batches1_idx` (`batches_b_id`),
  KEY `fk_batch_document_controller_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_batch_document_controller_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_batch_document_controller_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_exam_contribution
DROP TABLE IF EXISTS `batch_exam_contribution`;
CREATE TABLE IF NOT EXISTS `batch_exam_contribution` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_bid` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `contribution` double DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_bec_batches` (`batches_bid`),
  KEY `FK_bec_exam` (`exam_id`),
  KEY `FK_bec_general_user_profile` (`added_by`),
  CONSTRAINT `FK_bec_batches` FOREIGN KEY (`batches_bid`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_bec_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `FK_bec_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=829 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_exam_sheduler
DROP TABLE IF EXISTS `batch_exam_sheduler`;
CREATE TABLE IF NOT EXISTS `batch_exam_sheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `exam_center` varchar(255) DEFAULT NULL,
  `sample_exam_doc` varchar(450) DEFAULT NULL,
  `certified_printing_notice` varchar(450) DEFAULT NULL,
  `is_notice_cover_sent` tinyint(1) DEFAULT NULL,
  `is_paper_print_notice_sent` tinyint(1) DEFAULT NULL,
  `exam_id` int NOT NULL,
  `batches_b_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `examiner` int DEFAULT NULL,
  `comment` text,
  `first_comment` text,
  `final_comment` text,
  `lecture_buckets_id` int DEFAULT NULL,
  `location` text,
  `scheduled_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_sheduler_exam1_idx` (`exam_id`),
  KEY `fk_exam_sheduler_batches1_idx` (`batches_b_id`),
  KEY `fk_batch_exam_sheduler_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_batch_exam_sheduler_general_user_profile1_idx` (`examiner`),
  KEY `lecture_buckets_id` (`lecture_buckets_id`),
  CONSTRAINT `batch_exam_sheduler_ibfk_1` FOREIGN KEY (`lecture_buckets_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `fk_batch_exam_sheduler_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_batch_exam_sheduler_general_user_profile1` FOREIGN KEY (`examiner`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_exam_sheduler_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_exam_sheduler_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2811 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_group
DROP TABLE IF EXISTS `batch_group`;
CREATE TABLE IF NOT EXISTS `batch_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `batch_intake` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_group_group1_idx` (`group_id`),
  KEY `fk_batch_group_batches1_idx` (`batch_intake`),
  CONSTRAINT `fk_batch_group_batches1` FOREIGN KEY (`batch_intake`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_batch_group_group1` FOREIGN KEY (`group_id`) REFERENCES `intake_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2513 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_group_time_table
DROP TABLE IF EXISTS `batch_group_time_table`;
CREATE TABLE IF NOT EXISTS `batch_group_time_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batch_group_id` int NOT NULL,
  `time_table_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_group_time_table_batch_group1_idx` (`batch_group_id`),
  KEY `fk_batch_group_time_table_time_table1_idx` (`time_table_id`),
  CONSTRAINT `fk_batch_group_time_table_batch_group1` FOREIGN KEY (`batch_group_id`) REFERENCES `batch_group` (`id`),
  CONSTRAINT `fk_batch_group_time_table_time_table1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=186 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_handler
DROP TABLE IF EXISTS `batch_handler`;
CREATE TABLE IF NOT EXISTS `batch_handler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_b_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_handler_batches1_idx` (`batches_b_id`),
  KEY `fk_batch_handler_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_batch_handler_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_batch_handler_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1627 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_pool_transfer_history
DROP TABLE IF EXISTS `batch_pool_transfer_history`;
CREATE TABLE IF NOT EXISTS `batch_pool_transfer_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `from_name` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `transfer_fee` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `user_login_login_id` int NOT NULL,
  `student_pool_id` int NOT NULL,
  `student_batches_sb_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_pool_transfer_history_user_login1_idx` (`user_login_login_id`),
  KEY `fk_batch_pool_transfer_history_student_pool1_idx` (`student_pool_id`),
  KEY `fk_batch_pool_transfer_history_student_batches1_idx` (`student_batches_sb_id`),
  CONSTRAINT `fk_batch_pool_transfer_history_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`),
  CONSTRAINT `fk_batch_pool_transfer_history_student_pool1` FOREIGN KEY (`student_pool_id`) REFERENCES `student_pool_batch` (`id`),
  CONSTRAINT `fk_batch_pool_transfer_history_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_profile_completion
DROP TABLE IF EXISTS `batch_profile_completion`;
CREATE TABLE IF NOT EXISTS `batch_profile_completion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `batches_b_id` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uploaded_by` (`uploaded_by`) USING BTREE,
  KEY `batches_b_id` (`batches_b_id`) USING BTREE,
  CONSTRAINT `batch_profile_completion_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `batch_profile_completion_ibfk_2` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_status_type
DROP TABLE IF EXISTS `batch_status_type`;
CREATE TABLE IF NOT EXISTS `batch_status_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_transfer
DROP TABLE IF EXISTS `batch_transfer`;
CREATE TABLE IF NOT EXISTS `batch_transfer` (
  `id_bt` int NOT NULL AUTO_INCREMENT,
  `transfer_date` date DEFAULT NULL,
  `new_batch` int DEFAULT NULL,
  `old_batch` int DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `transfer_fee` double DEFAULT NULL,
  `transfer_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_croatian_ci,
  `batches_b_id` int DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `new_data` int DEFAULT NULL,
  `old_data` int DEFAULT NULL,
  `transfer_type_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id_bt`),
  KEY `fk_batch_transfer_general_user_profile1` (`general_user_profile_gup_id`),
  KEY `fk_batch_transfer_student_batches1` (`new_batch`),
  KEY `fk_batch_transfer_batches1` (`old_batch`),
  KEY `fk_batch_transfer_batches2_idx` (`batches_b_id`),
  KEY `fk_batch_transfer_transfer_type1_idx` (`transfer_type_id`),
  KEY `fk_batch_transfer_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_batch_transfer_batches1` FOREIGN KEY (`old_batch`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_batch_transfer_batches2` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_batch_transfer_transfer_type1` FOREIGN KEY (`transfer_type_id`) REFERENCES `transfer_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203422 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_transfer_access_manager
DROP TABLE IF EXISTS `batch_transfer_access_manager`;
CREATE TABLE IF NOT EXISTS `batch_transfer_access_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_id` int DEFAULT '0',
  `user_login_id` int DEFAULT '0',
  `is_active` tinyint DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_batch_transfer_access_manager_batches` (`batches_id`),
  KEY `FK_batch_transfer_access_manager_user_login` (`user_login_id`),
  KEY `FK_batch_transfer_access_manager_general_user_profile` (`added_by`),
  CONSTRAINT `FK_batch_transfer_access_manager_batches` FOREIGN KEY (`batches_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_batch_transfer_access_manager_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_batch_transfer_access_manager_user_login` FOREIGN KEY (`user_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5030 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_transfer_request
DROP TABLE IF EXISTS `batch_transfer_request`;
CREATE TABLE IF NOT EXISTS `batch_transfer_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `old_batched_id` int DEFAULT NULL,
  `new_batches_is` int DEFAULT NULL,
  `batch_awarding_body_id` int DEFAULT NULL,
  `online_transactions_id` int DEFAULT NULL,
  `is_paid` tinyint DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_batch_transfer_request_batches` (`old_batched_id`),
  KEY `FK_batch_transfer_request_batches_2` (`new_batches_is`),
  KEY `FK_batch_transfer_request_online_transactions` (`online_transactions_id`),
  KEY `FK_batch_transfer_request_batch_awarding_body` (`batch_awarding_body_id`),
  CONSTRAINT `FK_batch_transfer_request_batch_awarding_body` FOREIGN KEY (`batch_awarding_body_id`) REFERENCES `batch_awarding_body` (`id`),
  CONSTRAINT `FK_batch_transfer_request_batches` FOREIGN KEY (`old_batched_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_batch_transfer_request_batches_2` FOREIGN KEY (`new_batches_is`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_batch_transfer_request_online_transactions` FOREIGN KEY (`online_transactions_id`) REFERENCES `online_transactions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_transfer_voucher_item
DROP TABLE IF EXISTS `batch_transfer_voucher_item`;
CREATE TABLE IF NOT EXISTS `batch_transfer_voucher_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batch_transfer_id_bt` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_transfer_voucher_item_batch_transfer1_idx` (`batch_transfer_id_bt`),
  KEY `fk_batch_transfer_voucher_item_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_batch_transfer_voucher_item_batch_transfer1` FOREIGN KEY (`batch_transfer_id_bt`) REFERENCES `batch_transfer` (`id_bt`),
  CONSTRAINT `fk_batch_transfer_voucher_item_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3367 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.batch_type
DROP TABLE IF EXISTS `batch_type`;
CREATE TABLE IF NOT EXISTS `batch_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bm_gop
DROP TABLE IF EXISTS `bm_gop`;
CREATE TABLE IF NOT EXISTS `bm_gop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bm_gop_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_bm_gop_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch
DROP TABLE IF EXISTS `branch`;
CREATE TABLE IF NOT EXISTS `branch` (
  `bid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `registration` varchar(255) DEFAULT NULL,
  `vision` varchar(255) DEFAULT NULL,
  `mission` varchar(255) DEFAULT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `address3` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `branch_typebt_id` int NOT NULL,
  PRIMARY KEY (`bid`),
  KEY `FKbranch682926` (`branch_typebt_id`),
  CONSTRAINT `FKbranch682926` FOREIGN KEY (`branch_typebt_id`) REFERENCES `branch_type` (`bt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch_examination_bundle_delivery_controller
DROP TABLE IF EXISTS `branch_examination_bundle_delivery_controller`;
CREATE TABLE IF NOT EXISTS `branch_examination_bundle_delivery_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `qty` int DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `bundle_id` int NOT NULL,
  `exam_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_branch_examination_bundle_controller_bundle1_idx` (`bundle_id`),
  KEY `fk_branch_examination_bundle_controller_exam1_idx` (`exam_id`),
  KEY `fk_branch_examination_bundle_controller_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_branch_examination_bundle_controller_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_branch_examination_bundle_controller_bundle1` FOREIGN KEY (`bundle_id`) REFERENCES `bundle` (`id`),
  CONSTRAINT `fk_branch_examination_bundle_controller_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch_semester
DROP TABLE IF EXISTS `branch_semester`;
CREATE TABLE IF NOT EXISTS `branch_semester` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_bid` int NOT NULL,
  `intake_semeter_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_branch_intake_branch1_idx` (`branch_bid`),
  KEY `fk_branch_intake_intake_semeter1_idx` (`intake_semeter_id`),
  CONSTRAINT `fk_branch_intake_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_branch_intake_intake_semeter1` FOREIGN KEY (`intake_semeter_id`) REFERENCES `intake_semeter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch_type
DROP TABLE IF EXISTS `branch_type`;
CREATE TABLE IF NOT EXISTS `branch_type` (
  `bt_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch_users
DROP TABLE IF EXISTS `branch_users`;
CREATE TABLE IF NOT EXISTS `branch_users` (
  `bu_id` int NOT NULL AUTO_INCREMENT,
  `branch_bid` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`bu_id`),
  KEY `FKbranch_use746329` (`branch_bid`),
  KEY `FKbranch_use67839` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_branch_has_general_user_profile_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKbranch_use746329` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46794 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.branch_wise_task
DROP TABLE IF EXISTS `branch_wise_task`;
CREATE TABLE IF NOT EXISTS `branch_wise_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assigned_date` datetime DEFAULT NULL,
  `assigned_by` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `employees_employee_id` int DEFAULT NULL,
  `task_id` int DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `assigned_by` (`assigned_by`) USING BTREE,
  KEY `employees_employee_id` (`employees_employee_id`) USING BTREE,
  KEY `task_id` (`task_id`) USING BTREE,
  KEY `branch_bid` (`branch_bid`) USING BTREE,
  CONSTRAINT `branch_wise_task_ibfk_1` FOREIGN KEY (`assigned_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `branch_wise_task_ibfk_2` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `branch_wise_task_ibfk_3` FOREIGN KEY (`task_id`) REFERENCES `task` (`id`),
  CONSTRAINT `branch_wise_task_ibfk_4` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.buckets
DROP TABLE IF EXISTS `buckets`;
CREATE TABLE IF NOT EXISTS `buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `priority` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bucket_comments
DROP TABLE IF EXISTS `bucket_comments`;
CREATE TABLE IF NOT EXISTS `bucket_comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text,
  `buckets_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bucket_comments_buckets1_idx` (`buckets_id`),
  KEY `fk_bucket_comments_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_bucket_comments_buckets1` FOREIGN KEY (`buckets_id`) REFERENCES `buckets` (`id`),
  CONSTRAINT `fk_bucket_comments_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72067 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bucket_components
DROP TABLE IF EXISTS `bucket_components`;
CREATE TABLE IF NOT EXISTS `bucket_components` (
  `id` int NOT NULL AUTO_INCREMENT,
  `robo_class_starting_date` date DEFAULT NULL,
  `robo_class_starting_time` time DEFAULT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bucket_components_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_bucket_components_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bucket_transfer_history
DROP TABLE IF EXISTS `bucket_transfer_history`;
CREATE TABLE IF NOT EXISTS `bucket_transfer_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transfered_date` datetime DEFAULT NULL,
  `buckets_id_from` int NOT NULL,
  `buckets_id_to` int NOT NULL,
  `general_user_profile_student` int NOT NULL,
  `general_user_profile_employee` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `fk_bucket_transfer_history_buckets1_idx` (`buckets_id_from`),
  KEY `fk_bucket_transfer_history_buckets2_idx` (`buckets_id_to`),
  KEY `fk_bucket_transfer_history_general_user_profile1_idx` (`general_user_profile_student`),
  KEY `fk_bucket_transfer_history_general_user_profile2_idx` (`general_user_profile_employee`),
  CONSTRAINT `fk_bucket_transfer_history_buckets1` FOREIGN KEY (`buckets_id_from`) REFERENCES `buckets` (`id`),
  CONSTRAINT `fk_bucket_transfer_history_buckets2` FOREIGN KEY (`buckets_id_to`) REFERENCES `buckets` (`id`),
  CONSTRAINT `fk_bucket_transfer_history_general_user_profile1` FOREIGN KEY (`general_user_profile_student`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_bucket_transfer_history_general_user_profile2` FOREIGN KEY (`general_user_profile_employee`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2933 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.building
DROP TABLE IF EXISTS `building`;
CREATE TABLE IF NOT EXISTS `building` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `centre_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_building_general_organization_profile1_idx` (`centre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bundle
DROP TABLE IF EXISTS `bundle`;
CREATE TABLE IF NOT EXISTS `bundle` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  `barcode` varchar(145) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `bundle_send_type_id` int NOT NULL,
  `bundled_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bundle_bundle_send_type1_idx` (`bundle_send_type_id`),
  KEY `fk_bundle_employees1_idx` (`bundled_by`),
  CONSTRAINT `fk_bundle_bundle_send_type1` FOREIGN KEY (`bundle_send_type_id`) REFERENCES `delivery_type` (`id`),
  CONSTRAINT `fk_bundle_employees1` FOREIGN KEY (`bundled_by`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.bundle_courier_by
DROP TABLE IF EXISTS `bundle_courier_by`;
CREATE TABLE IF NOT EXISTS `bundle_courier_by` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc` varchar(145) DEFAULT NULL,
  `handover_date` date DEFAULT NULL,
  `bundle_id` int NOT NULL,
  `courier_by_org` int DEFAULT NULL,
  `handover_by_gup` int DEFAULT NULL,
  `received_by` int NOT NULL,
  `received_date` date DEFAULT NULL,
  `handover_qty` double DEFAULT NULL,
  `received_qty` double DEFAULT NULL,
  `grn_upload_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pack_courier_by_bundle1_idx` (`bundle_id`),
  KEY `fk_pack_courier_by_general_organization_profile1_idx` (`courier_by_org`),
  KEY `fk_bundle_courier_by_general_user_profile1_idx` (`handover_by_gup`),
  KEY `fk_bundle_courier_by_general_user_profile2_idx` (`received_by`),
  CONSTRAINT `fk_bundle_courier_by_general_user_profile1` FOREIGN KEY (`handover_by_gup`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_bundle_courier_by_general_user_profile2` FOREIGN KEY (`received_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_pack_courier_by_bundle1` FOREIGN KEY (`bundle_id`) REFERENCES `bundle` (`id`),
  CONSTRAINT `fk_pack_courier_by_general_organization_profile1` FOREIGN KEY (`courier_by_org`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_activities
DROP TABLE IF EXISTS `calendar_activities`;
CREATE TABLE IF NOT EXISTS `calendar_activities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `activity_date` datetime DEFAULT NULL,
  `activity` text,
  `calendar_schedule_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_calendar_activities_calendar_schedule1_idx` (`calendar_schedule_id`),
  KEY `fk_calendar_activities_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_calendar_activities_calendar_schedule1` FOREIGN KEY (`calendar_schedule_id`) REFERENCES `calendar_schedule` (`id`),
  CONSTRAINT `fk_calendar_activities_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13956 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_departments
DROP TABLE IF EXISTS `calendar_departments`;
CREATE TABLE IF NOT EXISTS `calendar_departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `calendar_department_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_calendar_departments_calendar_department_type1_idx` (`calendar_department_type_id`),
  CONSTRAINT `fk_calendar_departments_calendar_department_type1` FOREIGN KEY (`calendar_department_type_id`) REFERENCES `calendar_department_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_department_type
DROP TABLE IF EXISTS `calendar_department_type`;
CREATE TABLE IF NOT EXISTS `calendar_department_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_event
DROP TABLE IF EXISTS `calendar_event`;
CREATE TABLE IF NOT EXISTS `calendar_event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_event_reference
DROP TABLE IF EXISTS `calendar_event_reference`;
CREATE TABLE IF NOT EXISTS `calendar_event_reference` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calendar_schedule_id` int NOT NULL,
  `reference` int NOT NULL,
  `calendar_event_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__calendar_schedule` (`calendar_schedule_id`),
  KEY `FK_calendar_event_reference_calendar_event_reference_type` (`calendar_event_id`) USING BTREE,
  CONSTRAINT `FK__calendar_schedule` FOREIGN KEY (`calendar_schedule_id`) REFERENCES `calendar_schedule` (`id`),
  CONSTRAINT `FK_calendar_event_reference_calendar_event` FOREIGN KEY (`calendar_event_id`) REFERENCES `calendar_event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6162 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calendar_schedule
DROP TABLE IF EXISTS `calendar_schedule`;
CREATE TABLE IF NOT EXISTS `calendar_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `location` varchar(1000) DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `calendar_departments_id` int NOT NULL,
  `calendar_event_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `comment` text,
  `title` varchar(1000) DEFAULT NULL,
  `unique_id` varchar(45) DEFAULT NULL,
  `is_editable` tinyint NOT NULL,
  `is_deletable` tinyint NOT NULL,
  `is_draggable` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_calendar_schedule_branch1_idx` (`branch_bid`),
  KEY `fk_calendar_schedule_calendar_departments1_idx` (`calendar_departments_id`),
  KEY `fk_calendar_schedule_calendar_event1_idx` (`calendar_event_id`),
  KEY `fk_calendar_schedule_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_calendar_schedule_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_calendar_schedule_calendar_departments1` FOREIGN KEY (`calendar_departments_id`) REFERENCES `calendar_departments` (`id`),
  CONSTRAINT `fk_calendar_schedule_calendar_event1` FOREIGN KEY (`calendar_event_id`) REFERENCES `calendar_event` (`id`),
  CONSTRAINT `fk_calendar_schedule_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6222 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_history
DROP TABLE IF EXISTS `calling_history`;
CREATE TABLE IF NOT EXISTS `calling_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text,
  `calling_status_id` int NOT NULL,
  `calling_round_id` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `call_from` int NOT NULL,
  `call_to` int NOT NULL,
  `calling_purpose_id` int NOT NULL,
  `department_id` int NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `lecture_buckets_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marketer_target_calling_history_calling_status1_idx` (`calling_status_id`),
  KEY `fk_marketer_target_calling_history_calling_round1_idx` (`calling_round_id`),
  KEY `fk_marketer_target_calling_history_general_user_profile1_idx` (`call_from`),
  KEY `fk_marketer_target_calling_history_general_user_profile2_idx` (`call_to`),
  KEY `fk_calling_history_calling_purpose1_idx` (`calling_purpose_id`),
  KEY `fk_calling_history_department1_idx` (`department_id`),
  KEY `lecture_buckets_id` (`lecture_buckets_id`),
  CONSTRAINT `calling_history_ibfk_1` FOREIGN KEY (`lecture_buckets_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `fk_calling_history_calling_purpose1` FOREIGN KEY (`calling_purpose_id`) REFERENCES `calling_purpose` (`id`),
  CONSTRAINT `fk_calling_history_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_marketer_target_calling_history_calling_round1` FOREIGN KEY (`calling_round_id`) REFERENCES `calling_round` (`id`),
  CONSTRAINT `fk_marketer_target_calling_history_calling_status1` FOREIGN KEY (`calling_status_id`) REFERENCES `calling_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=816128 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_history_approval
DROP TABLE IF EXISTS `calling_history_approval`;
CREATE TABLE IF NOT EXISTS `calling_history_approval` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calling_history_id` int DEFAULT NULL,
  `approval` tinyint DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `FK_calling_history_approval_calling_history` (`calling_history_id`),
  KEY `FK_calling_history_approval_general_user_profile` (`approved_by`),
  CONSTRAINT `FK_calling_history_approval_calling_history` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `FK_calling_history_approval_general_user_profile` FOREIGN KEY (`approved_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3241 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_history_by_student_attendance
DROP TABLE IF EXISTS `calling_history_by_student_attendance`;
CREATE TABLE IF NOT EXISTS `calling_history_by_student_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calling_history_id` int DEFAULT NULL,
  `student_attendance_by_time_table_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ch_by_satt_calling_history` (`calling_history_id`),
  KEY `FK_ch_by_satt_time_table_student_attendance_by_time_table` (`student_attendance_by_time_table_id`),
  CONSTRAINT `FK_ch_by_satt_calling_history` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `FK_ch_by_satt_time_table_student_attendance_by_time_table` FOREIGN KEY (`student_attendance_by_time_table_id`) REFERENCES `student_attendance_by_time_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13563 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_purpose
DROP TABLE IF EXISTS `calling_purpose`;
CREATE TABLE IF NOT EXISTS `calling_purpose` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Due Collection\nInforming abount new course\nClass Cancell \nEnrollment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_round
DROP TABLE IF EXISTS `calling_round`;
CREATE TABLE IF NOT EXISTS `calling_round` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT '1st Round (Primary Call)\n2nd Round (Confirmation Call)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.calling_status
DROP TABLE IF EXISTS `calling_status`;
CREATE TABLE IF NOT EXISTS `calling_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL COMMENT 'No Answer\r\nNot Responded\r\nCall Again\r\nParent Answered\r\nParticipated Before\r\nReject\r\nOk',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.careers
DROP TABLE IF EXISTS `careers`;
CREATE TABLE IF NOT EXISTS `careers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `careerid` varchar(45) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_careers_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_careers_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.cash_settlement_history
DROP TABLE IF EXISTS `cash_settlement_history`;
CREATE TABLE IF NOT EXISTS `cash_settlement_history` (
  `id_cs` int NOT NULL AUTO_INCREMENT,
  `settlement_id` int DEFAULT NULL,
  `settlement_date` date DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `gup_for_am_id_gfa` int NOT NULL,
  `gup_for_am_id_gfa1` int NOT NULL,
  `sub_chart_of_account_is_sca` int DEFAULT NULL,
  `chart_of_account_coa_id` int DEFAULT NULL,
  `general_journal_entry_gje_id` int DEFAULT NULL,
  `gop_for_am_id_gfa` int DEFAULT NULL,
  PRIMARY KEY (`id_cs`),
  KEY `fk_cash_settlement_gup_for_am1_idx` (`gup_for_am_id_gfa`),
  KEY `fk_cash_settlement_gup_for_am2_idx` (`gup_for_am_id_gfa1`),
  KEY `fk_cash_settlement_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_cash_settlement_chart_of_account1_idx` (`chart_of_account_coa_id`),
  KEY `fk_cash_settlement_general_journal_entry1_idx` (`general_journal_entry_gje_id`),
  KEY `fk_cash_settlement_gop_for_am1_idx` (`gop_for_am_id_gfa`),
  CONSTRAINT `fk_cash_settlement_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_general_journal_entry1` FOREIGN KEY (`general_journal_entry_gje_id`) REFERENCES `general_journal_entry` (`gje_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_gop_for_am1` FOREIGN KEY (`gop_for_am_id_gfa`) REFERENCES `gop_for_am` (`id_gfa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_gup_for_am1` FOREIGN KEY (`gup_for_am_id_gfa`) REFERENCES `gup_for_am` (`id_gfa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_gup_for_am2` FOREIGN KEY (`gup_for_am_id_gfa1`) REFERENCES `gup_for_am` (`id_gfa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.cash_settlement_history_items
DROP TABLE IF EXISTS `cash_settlement_history_items`;
CREATE TABLE IF NOT EXISTS `cash_settlement_history_items` (
  `id_cshi` int NOT NULL AUTO_INCREMENT,
  `transaction_management_id_shg` int NOT NULL,
  `cash_settlement_history_id_cs` int NOT NULL,
  PRIMARY KEY (`id_cshi`),
  KEY `fk_cash_settlement_history_items_transaction_management1_idx` (`transaction_management_id_shg`),
  KEY `fk_cash_settlement_history_items_cash_settlement_history1_idx` (`cash_settlement_history_id_cs`),
  CONSTRAINT `fk_cash_settlement_history_items_cash_settlement_history1` FOREIGN KEY (`cash_settlement_history_id_cs`) REFERENCES `cash_settlement_history` (`id_cs`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cash_settlement_history_items_transaction_management1` FOREIGN KEY (`transaction_management_id_shg`) REFERENCES `transaction_management` (`id_shg`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4149 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.center_course_manager
DROP TABLE IF EXISTS `center_course_manager`;
CREATE TABLE IF NOT EXISTS `center_course_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `stp_gom_id_sp` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_center_course_manager_stp_gom1_idx` (`stp_gom_id_sp`),
  KEY `fk_center_course_manager_course1_idx` (`course_cid`),
  CONSTRAINT `fk_center_course_manager_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_center_course_manager_stp_gom1` FOREIGN KEY (`stp_gom_id_sp`) REFERENCES `stp_gom` (`id_sp`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.centre
DROP TABLE IF EXISTS `centre`;
CREATE TABLE IF NOT EXISTS `centre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `general_organization_profile_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certificate
DROP TABLE IF EXISTS `certificate`;
CREATE TABLE IF NOT EXISTS `certificate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `certificate_type_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_certificate_certificate_type1_idx` (`certificate_type_id`),
  KEY `fk_certificate_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_certificate_certificate_type1` FOREIGN KEY (`certificate_type_id`) REFERENCES `certificate_type` (`id`),
  CONSTRAINT `fk_certificate_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certificate_type
DROP TABLE IF EXISTS `certificate_type`;
CREATE TABLE IF NOT EXISTS `certificate_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certification_eligible_list
DROP TABLE IF EXISTS `certification_eligible_list`;
CREATE TABLE IF NOT EXISTS `certification_eligible_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `cerated_date` datetime DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  `submitted_date` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `list_code` varchar(50) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `generate_order` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=244 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certification_eligible_list_status
DROP TABLE IF EXISTS `certification_eligible_list_status`;
CREATE TABLE IF NOT EXISTS `certification_eligible_list_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certification_eligible_list_status_manager
DROP TABLE IF EXISTS `certification_eligible_list_status_manager`;
CREATE TABLE IF NOT EXISTS `certification_eligible_list_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certification_eligible_list_id` int DEFAULT NULL,
  `certification_eligible_list_status_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_celsm_certification_eligible_list` (`certification_eligible_list_id`),
  KEY `FK_celsm_certification_eligible_list_status` (`certification_eligible_list_status_id`),
  KEY `FK_celsm_general_user_profile` (`added_by`),
  CONSTRAINT `FK_celsm_certification_eligible_list` FOREIGN KEY (`certification_eligible_list_id`) REFERENCES `certification_eligible_list` (`id`),
  CONSTRAINT `FK_celsm_certification_eligible_list_status` FOREIGN KEY (`certification_eligible_list_status_id`) REFERENCES `certification_eligible_list_status` (`id`),
  CONSTRAINT `FK_celsm_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=242 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certification_eligible_list_student
DROP TABLE IF EXISTS `certification_eligible_list_student`;
CREATE TABLE IF NOT EXISTS `certification_eligible_list_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certification_eligible_list_id` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `assigned_date` datetime DEFAULT NULL,
  `is_eligible` tinyint DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `registration_no` varchar(50) DEFAULT NULL,
  `system_generated_no` varchar(50) DEFAULT NULL,
  `manual_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `certification_eligible_list_id` (`certification_eligible_list_id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `group_id` (`group_id`),
  CONSTRAINT `certification_eligible_list_student_ibfk_1` FOREIGN KEY (`certification_eligible_list_id`) REFERENCES `certification_eligible_list` (`id`),
  CONSTRAINT `certification_eligible_list_student_ibfk_2` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `certification_eligible_list_student_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `intake_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20264 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.certification_eligible_list_student_status_manager
DROP TABLE IF EXISTS `certification_eligible_list_student_status_manager`;
CREATE TABLE IF NOT EXISTS `certification_eligible_list_student_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certification_eligible_list_status_id` int DEFAULT NULL,
  `certification_eligible_list_student_is` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_celssm_certification_eligible_list_status` (`certification_eligible_list_status_id`),
  KEY `FK_celssm_certification_eligible_list_student` (`certification_eligible_list_student_is`),
  KEY `FK_celssm_general_user_profile` (`added_by`),
  CONSTRAINT `FK_celssm_certification_eligible_list_status` FOREIGN KEY (`certification_eligible_list_status_id`) REFERENCES `certification_eligible_list_status` (`id`),
  CONSTRAINT `FK_celssm_certification_eligible_list_student` FOREIGN KEY (`certification_eligible_list_student_is`) REFERENCES `certification_eligible_list_student` (`id`),
  CONSTRAINT `FK_celssm_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=36072 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.chart_of_account
DROP TABLE IF EXISTS `chart_of_account`;
CREATE TABLE IF NOT EXISTS `chart_of_account` (
  `coa_id` int NOT NULL AUTO_INCREMENT,
  `account_name` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `account_typea_id` int NOT NULL,
  `main_chart_of_account_id` int DEFAULT NULL,
  PRIMARY KEY (`coa_id`),
  KEY `FKchart_of_a609416` (`account_typea_id`),
  KEY `fk_chart_of_account_main_chart_of_account1_idx` (`main_chart_of_account_id`),
  CONSTRAINT `FKchart_of_a609416` FOREIGN KEY (`account_typea_id`) REFERENCES `account_type` (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=634 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.chat
DROP TABLE IF EXISTS `chat`;
CREATE TABLE IF NOT EXISTS `chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_time` datetime DEFAULT NULL,
  `message_text` text,
  `is_received` tinyint DEFAULT NULL,
  `chat_room_id` int DEFAULT NULL,
  `sender_id` int DEFAULT NULL,
  `researches_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `chat_room_id` (`chat_room_id`) USING BTREE,
  KEY `sender_id` (`sender_id`) USING BTREE,
  KEY `researches_id` (`researches_id`) USING BTREE,
  CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`chat_room_id`) REFERENCES `chat_room` (`id`),
  CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `chat_ibfk_3` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.chat_attachments
DROP TABLE IF EXISTS `chat_attachments`;
CREATE TABLE IF NOT EXISTS `chat_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `chat_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `chat_id` (`chat_id`) USING BTREE,
  CONSTRAINT `chat_attachments_ibfk_1` FOREIGN KEY (`chat_id`) REFERENCES `chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.chat_room
DROP TABLE IF EXISTS `chat_room`;
CREATE TABLE IF NOT EXISTS `chat_room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime DEFAULT NULL,
  `research_student_id` int DEFAULT NULL,
  `research_supervisors_id` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `research_student_id` (`research_student_id`) USING BTREE,
  KEY `research_supervisors_id` (`research_supervisors_id`) USING BTREE,
  CONSTRAINT `chat_room_ibfk_1` FOREIGN KEY (`research_student_id`) REFERENCES `research_student` (`id`),
  CONSTRAINT `chat_room_ibfk_2` FOREIGN KEY (`research_supervisors_id`) REFERENCES `research_supervisors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.cheque_deposit
DROP TABLE IF EXISTS `cheque_deposit`;
CREATE TABLE IF NOT EXISTS `cheque_deposit` (
  `id_cd` int NOT NULL AUTO_INCREMENT,
  `deposit_date` datetime DEFAULT NULL,
  `received_chequesid_rc` int NOT NULL,
  `general_journal_entrygje_id` int NOT NULL,
  PRIMARY KEY (`id_cd`),
  KEY `FKcheque_dep424145` (`received_chequesid_rc`),
  KEY `FKcheque_dep579089` (`general_journal_entrygje_id`),
  CONSTRAINT `FKcheque_dep424145` FOREIGN KEY (`received_chequesid_rc`) REFERENCES `received_cheques` (`id_rc`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKcheque_dep579089` FOREIGN KEY (`general_journal_entrygje_id`) REFERENCES `general_journal_entry` (`gje_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.city
DROP TABLE IF EXISTS `city`;
CREATE TABLE IF NOT EXISTS `city` (
  `id_c` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  `state_id_s` int DEFAULT NULL,
  `district_id_d` int NOT NULL,
  PRIMARY KEY (`id_c`),
  KEY `fk_city_state1_idx` (`state_id_s`),
  KEY `fk_city_district1_idx` (`district_id_d`),
  CONSTRAINT `fk_city_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`),
  CONSTRAINT `fk_city_state1` FOREIGN KEY (`state_id_s`) REFERENCES `state` (`id_s`)
) ENGINE=InnoDB AUTO_INCREMENT=1989 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.coin_type
DROP TABLE IF EXISTS `coin_type`;
CREATE TABLE IF NOT EXISTS `coin_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.commision_manager
DROP TABLE IF EXISTS `commision_manager`;
CREATE TABLE IF NOT EXISTS `commision_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_officer_id` int DEFAULT NULL,
  `commision_amount` double DEFAULT NULL,
  `is_paid` tinyint DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `voucher_id` int DEFAULT NULL,
  `universal_bucket_manager_id` int DEFAULT NULL,
  `is_voucher_canceled` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_commision_manager_voucher` (`voucher_id`),
  KEY `FK_commision_manager_academic_officer_manager` (`academic_officer_id`) USING BTREE,
  KEY `universal_bucket_manager_id` (`universal_bucket_manager_id`),
  CONSTRAINT `commision_manager_ibfk_1` FOREIGN KEY (`universal_bucket_manager_id`) REFERENCES `universal_bucket_manager` (`id`),
  CONSTRAINT `FK_commision_manager_general_user_profile` FOREIGN KEY (`academic_officer_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_commision_manager_voucher` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.commision_payments
DROP TABLE IF EXISTS `commision_payments`;
CREATE TABLE IF NOT EXISTS `commision_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `academic_officer_id` int DEFAULT NULL,
  `total_paid` double DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `entered_by` int DEFAULT NULL,
  `slip` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_commision_payments_general_user_profile` (`entered_by`),
  KEY `FK_commision_payments_academic_officer_manager` (`academic_officer_id`) USING BTREE,
  CONSTRAINT `FK_commision_payments_general_user_profile` FOREIGN KEY (`entered_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_commision_payments_general_user_profile_2` FOREIGN KEY (`academic_officer_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.commision_payment_data
DROP TABLE IF EXISTS `commision_payment_data`;
CREATE TABLE IF NOT EXISTS `commision_payment_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commision_manager_id` int DEFAULT NULL,
  `commision_payments_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_commision_payment_data_commision_manager` (`commision_manager_id`),
  KEY `FK_commision_payment_data_commision_payments` (`commision_payments_id`),
  CONSTRAINT `FK_commision_payment_data_commision_manager` FOREIGN KEY (`commision_manager_id`) REFERENCES `commision_manager` (`id`),
  CONSTRAINT `FK_commision_payment_data_commision_payments` FOREIGN KEY (`commision_payments_id`) REFERENCES `commision_payments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_online_application
DROP TABLE IF EXISTS `common_online_application`;
CREATE TABLE IF NOT EXISTS `common_online_application` (
  `id` int NOT NULL AUTO_INCREMENT,
  `applied_date` date DEFAULT NULL,
  `replied_date` date DEFAULT NULL,
  `description` text,
  `common_online_application_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_common_online_application_common_online_application_type_idx` (`common_online_application_type_id`),
  KEY `fk_common_online_application_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_common_online_application_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_common_online_application_common_online_application_type1` FOREIGN KEY (`common_online_application_type_id`) REFERENCES `common_online_application_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_common_online_application_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_common_online_application_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_online_application_course
DROP TABLE IF EXISTS `common_online_application_course`;
CREATE TABLE IF NOT EXISTS `common_online_application_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `common_online_application_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_common_online_application_course_common_online_applicati_idx` (`common_online_application_id`),
  KEY `fk_common_online_application_course_course1_idx` (`course_cid`),
  CONSTRAINT `fk_common_online_application_course_common_online_application1` FOREIGN KEY (`common_online_application_id`) REFERENCES `common_online_application` (`id`),
  CONSTRAINT `fk_common_online_application_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_online_application_request
DROP TABLE IF EXISTS `common_online_application_request`;
CREATE TABLE IF NOT EXISTS `common_online_application_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `common_online_application_course_id` int NOT NULL,
  `online_registration_request_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_common_online_application_request_common_online_applicat_idx` (`common_online_application_course_id`),
  KEY `fk_common_online_application_request_online_registration_re_idx` (`online_registration_request_id`),
  CONSTRAINT `fk_common_online_application_request_common_online_applicatio1` FOREIGN KEY (`common_online_application_course_id`) REFERENCES `common_online_application_course` (`id`),
  CONSTRAINT `fk_common_online_application_request_online_registration_requ1` FOREIGN KEY (`online_registration_request_id`) REFERENCES `online_registration_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_online_application_type
DROP TABLE IF EXISTS `common_online_application_type`;
CREATE TABLE IF NOT EXISTS `common_online_application_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_settings
DROP TABLE IF EXISTS `common_settings`;
CREATE TABLE IF NOT EXISTS `common_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.common_settings_upgraded_history
DROP TABLE IF EXISTS `common_settings_upgraded_history`;
CREATE TABLE IF NOT EXISTS `common_settings_upgraded_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `updated_value` varchar(45) DEFAULT NULL,
  `description` text,
  `common_settings_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_common_settings_upgraded_history_common_settings1_idx` (`common_settings_id`),
  KEY `fk_common_settings_upgraded_history_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_common_settings_upgraded_history_common_settings1` FOREIGN KEY (`common_settings_id`) REFERENCES `common_settings` (`id`),
  CONSTRAINT `fk_common_settings_upgraded_history_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.communication_history
DROP TABLE IF EXISTS `communication_history`;
CREATE TABLE IF NOT EXISTS `communication_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `content` text,
  `recepient_address` varchar(1000) DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `sent_date` datetime DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT NULL,
  `communication_type_id` int NOT NULL,
  `communication_purpose_id` int NOT NULL,
  `sent_by` int DEFAULT NULL,
  `sent_to` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_communication_history_communication_type1_idx` (`communication_type_id`),
  KEY `fk_communication_history_communication_purpose1_idx` (`communication_purpose_id`),
  KEY `fk_communication_history_general_user_profile1_idx` (`sent_by`),
  KEY `fk_communication_history_general_user_profile2_idx` (`sent_to`),
  CONSTRAINT `fk_communication_history_communication_purpose1` FOREIGN KEY (`communication_purpose_id`) REFERENCES `communication_purpose` (`id`),
  CONSTRAINT `fk_communication_history_communication_type1` FOREIGN KEY (`communication_type_id`) REFERENCES `communication_type` (`id`),
  CONSTRAINT `fk_communication_history_general_user_profile1` FOREIGN KEY (`sent_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_communication_history_general_user_profile2` FOREIGN KEY (`sent_to`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.communication_purpose
DROP TABLE IF EXISTS `communication_purpose`;
CREATE TABLE IF NOT EXISTS `communication_purpose` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.communication_type
DROP TABLE IF EXISTS `communication_type`;
CREATE TABLE IF NOT EXISTS `communication_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Email\nSMS',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.competition
DROP TABLE IF EXISTS `competition`;
CREATE TABLE IF NOT EXISTS `competition` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.competition_events
DROP TABLE IF EXISTS `competition_events`;
CREATE TABLE IF NOT EXISTS `competition_events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(45) DEFAULT NULL,
  `event_date` date DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `competition_id` int DEFAULT NULL,
  `registration_started` tinyint(1) DEFAULT NULL,
  `registration_ending_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `competition_id` (`competition_id`) USING BTREE,
  CONSTRAINT `competition_events_ibfk_1` FOREIGN KEY (`competition_id`) REFERENCES `competition` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.competition_teams
DROP TABLE IF EXISTS `competition_teams`;
CREATE TABLE IF NOT EXISTS `competition_teams` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(45) DEFAULT NULL,
  `team_logo` text,
  `registered_date` datetime DEFAULT NULL,
  `competition_events_id` int DEFAULT NULL,
  `other_name` varchar(100) DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `competition_events_id` (`competition_events_id`) USING BTREE,
  KEY `branch_bid` (`branch_bid`),
  CONSTRAINT `competition_teams_ibfk_1` FOREIGN KEY (`competition_events_id`) REFERENCES `competition_events` (`id`),
  CONSTRAINT `competition_teams_ibfk_2` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=301 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.competition_team_members
DROP TABLE IF EXISTS `competition_team_members`;
CREATE TABLE IF NOT EXISTS `competition_team_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int DEFAULT NULL,
  `competition_teams_id` int DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `competition_teams_id` (`competition_teams_id`) USING BTREE,
  CONSTRAINT `competition_team_members_ibfk_1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `competition_team_members_ibfk_2` FOREIGN KEY (`competition_teams_id`) REFERENCES `competition_teams` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=981 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.complain_manager
DROP TABLE IF EXISTS `complain_manager`;
CREATE TABLE IF NOT EXISTS `complain_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_complain_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_complain_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.component_type
DROP TABLE IF EXISTS `component_type`;
CREATE TABLE IF NOT EXISTS `component_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'marking\nassesment',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_locations
DROP TABLE IF EXISTS `com_locations`;
CREATE TABLE IF NOT EXISTS `com_locations` (
  `Location_Id` int NOT NULL AUTO_INCREMENT,
  `Location_Name` varchar(255) NOT NULL,
  `Location_Desc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Location_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_peer_to_host
DROP TABLE IF EXISTS `com_peer_to_host`;
CREATE TABLE IF NOT EXISTS `com_peer_to_host` (
  `Multi_Log_ID` int NOT NULL AUTO_INCREMENT,
  `Com_Posting_MethodTo_Id` int NOT NULL,
  `WildCard` varchar(10) NOT NULL,
  PRIMARY KEY (`Multi_Log_ID`),
  KEY `FKCom_Peer_t583062` (`Com_Posting_MethodTo_Id`),
  CONSTRAINT `FKCom_Peer_t583062` FOREIGN KEY (`Com_Posting_MethodTo_Id`) REFERENCES `com_posting_method` (`To_Id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_peer_to_peer_post
DROP TABLE IF EXISTS `com_peer_to_peer_post`;
CREATE TABLE IF NOT EXISTS `com_peer_to_peer_post` (
  `LogId` int NOT NULL AUTO_INCREMENT,
  `GUPforCommunicationGUP_ID` int NOT NULL,
  `Com_Posting_MethodTo_Id` int NOT NULL,
  `Peer_One_State` tinyint DEFAULT NULL,
  `Peer_two_State` tinyint DEFAULT NULL,
  PRIMARY KEY (`LogId`),
  KEY `FKCom_Peer_t246625` (`Com_Posting_MethodTo_Id`),
  KEY `FKCom_Peer_t323457` (`GUPforCommunicationGUP_ID`),
  CONSTRAINT `FKCom_Peer_t246625` FOREIGN KEY (`Com_Posting_MethodTo_Id`) REFERENCES `com_posting_method` (`To_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKCom_Peer_t323457` FOREIGN KEY (`GUPforCommunicationGUP_ID`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=101922 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_post
DROP TABLE IF EXISTS `com_post`;
CREATE TABLE IF NOT EXISTS `com_post` (
  `PostId` int NOT NULL AUTO_INCREMENT,
  `Date_Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Post_Head` varchar(255) NOT NULL,
  `Post_Body` varchar(20000) NOT NULL,
  PRIMARY KEY (`PostId`)
) ENGINE=InnoDB AUTO_INCREMENT=103188 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_posting_method
DROP TABLE IF EXISTS `com_posting_method`;
CREATE TABLE IF NOT EXISTS `com_posting_method` (
  `To_Id` int NOT NULL AUTO_INCREMENT,
  `Com_TypeIdST` int NOT NULL,
  `Com_Post_ControllerPost_Id` int NOT NULL,
  PRIMARY KEY (`To_Id`),
  KEY `FKCom_Postin4120` (`Com_Post_ControllerPost_Id`),
  KEY `FKCom_Postin300300` (`Com_TypeIdST`),
  CONSTRAINT `FKCom_Postin300300` FOREIGN KEY (`Com_TypeIdST`) REFERENCES `com_type` (`IdST`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKCom_Postin4120` FOREIGN KEY (`Com_Post_ControllerPost_Id`) REFERENCES `com_post_controller` (`Post_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103100 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_post_attachments
DROP TABLE IF EXISTS `com_post_attachments`;
CREATE TABLE IF NOT EXISTS `com_post_attachments` (
  `Log_ID` int NOT NULL AUTO_INCREMENT,
  `Post_ControllerPost_Id` int NOT NULL,
  `Attach_Type` tinyint NOT NULL,
  `isInactive` tinyint DEFAULT NULL,
  `Com_PostPostId` int NOT NULL,
  PRIMARY KEY (`Log_ID`),
  KEY `FKCom_Post_A212284` (`Com_PostPostId`),
  CONSTRAINT `FKCom_Post_A212284` FOREIGN KEY (`Com_PostPostId`) REFERENCES `com_post` (`PostId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_post_controller
DROP TABLE IF EXISTS `com_post_controller`;
CREATE TABLE IF NOT EXISTS `com_post_controller` (
  `Post_Id` int NOT NULL AUTO_INCREMENT,
  `From_ID` int NOT NULL,
  `Com_LocationsLocation_Id` int NOT NULL,
  `Com_PostPostId` int NOT NULL,
  `isActive` tinyint DEFAULT NULL,
  `date` date DEFAULT NULL,
  `com_post_status_id` int NOT NULL,
  PRIMARY KEY (`Post_Id`),
  KEY `FKCom_Post_C612228` (`Com_LocationsLocation_Id`),
  KEY `FKCom_Post_C182841` (`Com_PostPostId`),
  KEY `FKCom_Post_C248712` (`From_ID`),
  KEY `fk_com_post_controller_com_post_status1_idx` (`com_post_status_id`),
  CONSTRAINT `fk_com_post_controller_com_post_status1` FOREIGN KEY (`com_post_status_id`) REFERENCES `com_post_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKCom_Post_C182841` FOREIGN KEY (`Com_PostPostId`) REFERENCES `com_post` (`PostId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKCom_Post_C248712` FOREIGN KEY (`From_ID`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKCom_Post_C612228` FOREIGN KEY (`Com_LocationsLocation_Id`) REFERENCES `com_locations` (`Location_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103167 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_post_status
DROP TABLE IF EXISTS `com_post_status`;
CREATE TABLE IF NOT EXISTS `com_post_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.com_type
DROP TABLE IF EXISTS `com_type`;
CREATE TABLE IF NOT EXISTS `com_type` (
  `IdST` int NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(45) DEFAULT NULL,
  `Description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IdST`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.contents
DROP TABLE IF EXISTS `contents`;
CREATE TABLE IF NOT EXISTS `contents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.convocation_eligibility
DROP TABLE IF EXISTS `convocation_eligibility`;
CREATE TABLE IF NOT EXISTS `convocation_eligibility` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int DEFAULT NULL,
  `convocation_type_id` int DEFAULT NULL,
  `is_eligible` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `convocation_type_id` (`convocation_type_id`) USING BTREE,
  CONSTRAINT `convocation_eligibility_ibfk_1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `convocation_eligibility_ibfk_2` FOREIGN KEY (`convocation_type_id`) REFERENCES `convocation_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.convocation_photo_type
DROP TABLE IF EXISTS `convocation_photo_type`;
CREATE TABLE IF NOT EXISTS `convocation_photo_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.convocation_type
DROP TABLE IF EXISTS `convocation_type`;
CREATE TABLE IF NOT EXISTS `convocation_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.cooperative_membership
DROP TABLE IF EXISTS `cooperative_membership`;
CREATE TABLE IF NOT EXISTS `cooperative_membership` (
  `cm_id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int NOT NULL COMMENT 'FK to general_user_profile.gup_id',
  `cooperative_society_cs_id` int NOT NULL COMMENT 'FK to cooperative_society.cs_id',
  `membership_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership_type` enum('EMPLOYEE','DEPENDENT','RETIREE') COLLATE utf8mb4_unicode_ci DEFAULT 'EMPLOYEE',
  `is_verified` tinyint(1) DEFAULT '0',
  `verified_at` datetime DEFAULT NULL,
  `verified_by_gup_id` int DEFAULT NULL COMMENT 'Staff who verified the membership',
  `verification_document_url` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `membership_start_date` date DEFAULT NULL,
  `membership_end_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`cm_id`),
  UNIQUE KEY `idx_coop_membership_unique` (`gup_id`,`cooperative_society_cs_id`),
  KEY `idx_coop_membership_gup` (`gup_id`),
  KEY `idx_coop_membership_society` (`cooperative_society_cs_id`),
  KEY `idx_coop_membership_number` (`membership_number`),
  KEY `fk_coop_membership_verified_by` (`verified_by_gup_id`),
  CONSTRAINT `fk_coop_membership_gup` FOREIGN KEY (`gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_coop_membership_society` FOREIGN KEY (`cooperative_society_cs_id`) REFERENCES `cooperative_society` (`cs_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_coop_membership_verified_by` FOREIGN KEY (`verified_by_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.cooperative_society
DROP TABLE IF EXISTS `cooperative_society`;
CREATE TABLE IF NOT EXISTS `cooperative_society` (
  `cs_id` int NOT NULL AUTO_INCREMENT,
  `organization_id_gop` int DEFAULT NULL COMMENT 'FK to general_organization_profile.id_gop (optional)',
  `society_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `society_code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `society_type` enum('GOVERNMENT','PRIVATE','SEMI_GOVERNMENT') COLLATE utf8mb4_unicode_ci DEFAULT 'GOVERNMENT',
  `registration_number` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_percentage` decimal(5,2) DEFAULT '0.00' COMMENT 'Default discount for members',
  `agreement_start_date` date DEFAULT NULL,
  `agreement_end_date` date DEFAULT NULL,
  `contact_person` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`cs_id`),
  UNIQUE KEY `idx_cooperative_society_code` (`society_code`),
  KEY `idx_cooperative_society_name` (`society_name`),
  KEY `idx_cooperative_society_type` (`society_type`),
  KEY `idx_cooperative_society_org` (`organization_id_gop`),
  CONSTRAINT `fk_cooperative_society_org` FOREIGN KEY (`organization_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.counselling_history
DROP TABLE IF EXISTS `counselling_history`;
CREATE TABLE IF NOT EXISTS `counselling_history` (
  `id_ch` int NOT NULL AUTO_INCREMENT,
  `advice_no` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `description` text,
  `invoice` varchar(45) DEFAULT NULL,
  `gup_for_nm_id_gfn` int NOT NULL,
  `student_for_nm_id_sfn` int NOT NULL,
  `course_for_nm_id_cfn` int DEFAULT NULL,
  PRIMARY KEY (`id_ch`),
  KEY `fk_counselling_history_gup_for_nm1_idx` (`gup_for_nm_id_gfn`),
  KEY `fk_counselling_history_student_for_nm1_idx` (`student_for_nm_id_sfn`),
  KEY `fk_counselling_history_course_for_nm1_idx` (`course_for_nm_id_cfn`),
  CONSTRAINT `fk_counselling_history_course_for_nm1` FOREIGN KEY (`course_for_nm_id_cfn`) REFERENCES `course_for_nm` (`id_cfn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_counselling_history_gup_for_nm1` FOREIGN KEY (`gup_for_nm_id_gfn`) REFERENCES `gup_for_nm` (`id_gfn`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_counselling_history_student_for_nm1` FOREIGN KEY (`student_for_nm_id_sfn`) REFERENCES `student_for_nm` (`id_sfn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4818 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.country
DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `id_c` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course
DROP TABLE IF EXISTS `course`;
CREATE TABLE IF NOT EXISTS `course` (
  `cid` int NOT NULL AUTO_INCREMENT,
  `course_title` varchar(255) DEFAULT NULL,
  `course_full_name` varchar(255) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `description` text,
  `standard_fee` double DEFAULT NULL,
  `cash_discount_percentage` double DEFAULT NULL,
  `total_contact_hours` double DEFAULT NULL,
  `contact_hours_per_day` double DEFAULT NULL,
  `notional_hours` double DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `theory_lecture_hours` double DEFAULT NULL,
  `practical_hours` double DEFAULT NULL,
  `tutoria_hours` double DEFAULT NULL,
  `practical_lecture_hours` double DEFAULT NULL,
  `credits` double DEFAULT NULL,
  `total_allocated_time` double DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `course_typecourse_type_id` int DEFAULT NULL,
  `stp_gom_id_sp` int NOT NULL,
  `sub_chart_of_account_is_sca` int DEFAULT NULL,
  `student_years_id` int DEFAULT NULL,
  `lecture_units` double DEFAULT NULL COMMENT '1 lecture unit = 5 hours',
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `currency_type_id` int DEFAULT NULL,
  `course_category_id` int DEFAULT NULL,
  PRIMARY KEY (`cid`),
  KEY `FKcourse228802` (`course_typecourse_type_id`),
  KEY `fk_course_stp_gom1_idx` (`stp_gom_id_sp`),
  KEY `fk_course_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_course_student_years1_idx` (`student_years_id`),
  KEY `fk_course_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_course_course1_idx` (`course_cid`),
  KEY `fk_course_currency_type1_idx` (`currency_type_id`),
  KEY `fk_course_course_category1_idx` (`course_category_id`),
  CONSTRAINT `fk_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_course_category1` FOREIGN KEY (`course_category_id`) REFERENCES `course_category` (`id`),
  CONSTRAINT `fk_course_currency_type1` FOREIGN KEY (`currency_type_id`) REFERENCES `currency_type` (`id`),
  CONSTRAINT `fk_course_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_course_stp_gom1` FOREIGN KEY (`stp_gom_id_sp`) REFERENCES `stp_gom` (`id_sp`),
  CONSTRAINT `fk_course_student_years1` FOREIGN KEY (`student_years_id`) REFERENCES `student_years` (`id`),
  CONSTRAINT `fk_course_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`),
  CONSTRAINT `FKcourse228802` FOREIGN KEY (`course_typecourse_type_id`) REFERENCES `course_type` (`course_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=436 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_assigned_assessors
DROP TABLE IF EXISTS `course_assigned_assessors`;
CREATE TABLE IF NOT EXISTS `course_assigned_assessors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assigned_assessors_for_course_course1_idx` (`course_cid`),
  KEY `fk_assigned_assessors_for_course_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_assigned_assessors_for_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_assigned_assessors_for_course_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_category
DROP TABLE IF EXISTS `course_category`;
CREATE TABLE IF NOT EXISTS `course_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_documents
DROP TABLE IF EXISTS `course_documents`;
CREATE TABLE IF NOT EXISTS `course_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_manager_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_documents_document_manager1_idx` (`document_manager_id`),
  KEY `fk_course_documents_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_documents_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_documents_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_fee_changed_history
DROP TABLE IF EXISTS `course_fee_changed_history`;
CREATE TABLE IF NOT EXISTS `course_fee_changed_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` text,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_fee_changed_history_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_fee_changed_history_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_for_mm
DROP TABLE IF EXISTS `course_for_mm`;
CREATE TABLE IF NOT EXISTS `course_for_mm` (
  `id_cfm` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id_cfm`),
  KEY `fk_course_for_mm_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_for_mm_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_for_nm
DROP TABLE IF EXISTS `course_for_nm`;
CREATE TABLE IF NOT EXISTS `course_for_nm` (
  `id_cfn` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id_cfn`),
  KEY `fk_course_for_nm_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_for_nm_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_installment
DROP TABLE IF EXISTS `course_installment`;
CREATE TABLE IF NOT EXISTS `course_installment` (
  `id_ic` int NOT NULL AUTO_INCREMENT,
  `coursecid` int NOT NULL,
  `installmentid_ins` int NOT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id_ic`),
  KEY `FKcourse_ins854315` (`coursecid`),
  KEY `FKcourse_ins345142` (`installmentid_ins`),
  CONSTRAINT `FKcourse_ins345142` FOREIGN KEY (`installmentid_ins`) REFERENCES `installment` (`id_ins`),
  CONSTRAINT `FKcourse_ins854315` FOREIGN KEY (`coursecid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_internal_verifier
DROP TABLE IF EXISTS `course_internal_verifier`;
CREATE TABLE IF NOT EXISTS `course_internal_verifier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_internal_verifier_course1_idx` (`course_cid`),
  KEY `fk_course_internal_verifier_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_course_internal_verifier_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_course_internal_verifier_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_lecturer
DROP TABLE IF EXISTS `course_lecturer`;
CREATE TABLE IF NOT EXISTS `course_lecturer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `lecturer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_lecturer_course1_idx` (`course_cid`),
  KEY `fk_course_lecturer_lecturer1_idx` (`lecturer_id`),
  CONSTRAINT `fk_course_lecturer_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_lecturer_lecturer1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_level
DROP TABLE IF EXISTS `course_level`;
CREATE TABLE IF NOT EXISTS `course_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_levels
DROP TABLE IF EXISTS `course_levels`;
CREATE TABLE IF NOT EXISTS `course_levels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_level_manager
DROP TABLE IF EXISTS `course_level_manager`;
CREATE TABLE IF NOT EXISTS `course_level_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `course_level_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_level_course1_idx` (`course_cid`),
  KEY `fk_course_level_manager_course_level1_idx` (`course_level_id`),
  CONSTRAINT `fk_course_level_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_level_manager_course_level1` FOREIGN KEY (`course_level_id`) REFERENCES `course_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_module
DROP TABLE IF EXISTS `course_module`;
CREATE TABLE IF NOT EXISTS `course_module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `name` varchar(450) DEFAULT NULL,
  `description` text,
  `url` varchar(450) DEFAULT NULL,
  `title` varchar(145) DEFAULT NULL,
  `theory_lecture_hours` double DEFAULT NULL,
  `practical_hours` double DEFAULT NULL,
  `total_allocated_time` double DEFAULT NULL,
  `practical_lecture_hours` double DEFAULT NULL,
  `total_hours` double DEFAULT NULL,
  `tutorial_hours` double DEFAULT NULL,
  `assesment_status` tinyint(1) DEFAULT NULL,
  `tt_course_id` int NOT NULL,
  `course_cid` int DEFAULT NULL,
  `level` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_module_tt_course1_idx` (`tt_course_id`),
  KEY `fk_course_module_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_module_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_module_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=415 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_objective_manager
DROP TABLE IF EXISTS `course_objective_manager`;
CREATE TABLE IF NOT EXISTS `course_objective_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `objectives_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_objective_manager_objectives1_idx` (`objectives_id`),
  KEY `fk_course_objective_manager_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_course_objective_manager_objectives1` FOREIGN KEY (`objectives_id`) REFERENCES `objectives` (`id`),
  CONSTRAINT `fk_course_objective_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_package
DROP TABLE IF EXISTS `course_package`;
CREATE TABLE IF NOT EXISTS `course_package` (
  `transid` int NOT NULL AUTO_INCREMENT,
  `CID` int DEFAULT NULL,
  `PID` int DEFAULT NULL,
  PRIMARY KEY (`transid`),
  KEY `course_package_1_idx` (`CID`),
  KEY `course_package_2_idx` (`PID`),
  CONSTRAINT `course_package_1` FOREIGN KEY (`CID`) REFERENCES `course` (`cid`),
  CONSTRAINT `course_package_2` FOREIGN KEY (`PID`) REFERENCES `packages` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_price_level
DROP TABLE IF EXISTS `course_price_level`;
CREATE TABLE IF NOT EXISTS `course_price_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `value` double DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_price_level_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_price_level_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_reviews
DROP TABLE IF EXISTS `course_reviews`;
CREATE TABLE IF NOT EXISTS `course_reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `review` text,
  `rates` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_reviews_course1_idx` (`course_cid`),
  KEY `fk_course_reviews_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_course_reviews_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_reviews_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_tags
DROP TABLE IF EXISTS `course_tags`;
CREATE TABLE IF NOT EXISTS `course_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tags_course1_idx` (`course_cid`),
  CONSTRAINT `fk_tags_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_type
DROP TABLE IF EXISTS `course_type`;
CREATE TABLE IF NOT EXISTS `course_type` (
  `course_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`course_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_units
DROP TABLE IF EXISTS `course_units`;
CREATE TABLE IF NOT EXISTS `course_units` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `unit_id` int NOT NULL,
  `subject_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_module_manager_course1_idx` (`course_id`),
  KEY `fk_course_module_manager_course2_idx` (`unit_id`),
  KEY `fk_course_units_course1_idx` (`subject_id`),
  CONSTRAINT `fk_course_module_manager_course1` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_module_manager_course2` FOREIGN KEY (`unit_id`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_units_course1` FOREIGN KEY (`subject_id`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_unit_manager
DROP TABLE IF EXISTS `course_unit_manager`;
CREATE TABLE IF NOT EXISTS `course_unit_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `course_type_course_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_type_manager_course1_idx` (`course_cid`),
  KEY `fk_course_type_manager_course_type1_idx` (`course_type_course_type_id`),
  CONSTRAINT `fk_course_type_manager_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_type_manager_course_type1` FOREIGN KEY (`course_type_course_type_id`) REFERENCES `course_type` (`course_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_unit_outcome
DROP TABLE IF EXISTS `course_unit_outcome`;
CREATE TABLE IF NOT EXISTS `course_unit_outcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `outcome_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_unit_outcome_course1_idx` (`course_cid`),
  KEY `fk_course_unit_outcome_outcome1_idx` (`outcome_id`),
  CONSTRAINT `fk_course_unit_outcome_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_course_unit_outcome_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.course_unit_prerequisites
DROP TABLE IF EXISTS `course_unit_prerequisites`;
CREATE TABLE IF NOT EXISTS `course_unit_prerequisites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(345) DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_unit_prerequisites_course1_idx` (`course_cid`),
  CONSTRAINT `fk_course_unit_prerequisites_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.credit_or_debit
DROP TABLE IF EXISTS `credit_or_debit`;
CREATE TABLE IF NOT EXISTS `credit_or_debit` (
  `id_cod` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.credit_period
DROP TABLE IF EXISTS `credit_period`;
CREATE TABLE IF NOT EXISTS `credit_period` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` int DEFAULT NULL,
  `period` int DEFAULT NULL,
  `universal_person_or_org_type_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_credit_period_universal_person_or_org_type_manager1_idx` (`universal_person_or_org_type_manager_id`),
  CONSTRAINT `fk_credit_period_universal_person_or_org_type_manager1` FOREIGN KEY (`universal_person_or_org_type_manager_id`) REFERENCES `universal_person_or_org_type_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.currency_type
DROP TABLE IF EXISTS `currency_type`;
CREATE TABLE IF NOT EXISTS `currency_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.daily_bank_balance
DROP TABLE IF EXISTS `daily_bank_balance`;
CREATE TABLE IF NOT EXISTS `daily_bank_balance` (
  `id_dbb` int NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `bankb_id` int NOT NULL,
  PRIMARY KEY (`id_dbb`),
  KEY `FKdaily_bank31890` (`bankb_id`),
  CONSTRAINT `FKdaily_bank31890` FOREIGN KEY (`bankb_id`) REFERENCES `bank` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_changed_log_manager
DROP TABLE IF EXISTS `data_changed_log_manager`;
CREATE TABLE IF NOT EXISTS `data_changed_log_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `attribute_name` varchar(255) DEFAULT NULL,
  `old_data` varchar(255) DEFAULT NULL,
  `new_data` varchar(255) DEFAULT NULL,
  `user_login_login_id` int NOT NULL,
  `table_manager_id` int NOT NULL,
  `comment` text,
  `reference` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_data_changed_log_manager_user_login1_idx` (`user_login_login_id`),
  KEY `fk_data_changed_log_manager_table_manager1_idx` (`table_manager_id`),
  CONSTRAINT `fk_data_changed_log_manager_table_manager1` FOREIGN KEY (`table_manager_id`) REFERENCES `table_manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=610676 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_change_request_manager
DROP TABLE IF EXISTS `data_change_request_manager`;
CREATE TABLE IF NOT EXISTS `data_change_request_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL DEFAULT '0',
  `old_data` varchar(50) DEFAULT NULL,
  `new_data` varchar(50) DEFAULT NULL,
  `attribute` varchar(50) DEFAULT NULL,
  `transaction_id` int NOT NULL DEFAULT '0',
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  KEY `transaction_id` (`transaction_id`),
  CONSTRAINT `FK__dcrm_online_transactions` FOREIGN KEY (`transaction_id`) REFERENCES `online_transactions` (`id`),
  CONSTRAINT `FK__dcrm_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_change_voucher
DROP TABLE IF EXISTS `data_change_voucher`;
CREATE TABLE IF NOT EXISTS `data_change_voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_change_log_manager_id` int DEFAULT '0',
  `student_id` int DEFAULT '0',
  `voucher_id` int DEFAULT '0',
  `added_date` datetime DEFAULT NULL,
  `online_transaction_id` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_dcv_changed_log_manager` (`data_change_log_manager_id`),
  KEY `FK_data_change_voucher_student` (`student_id`),
  KEY `FK_data_change_voucher_voucher` (`voucher_id`),
  KEY `FK_data_change_voucher_online_transactions` (`online_transaction_id`),
  CONSTRAINT `FK_data_change_voucher_online_transactions` FOREIGN KEY (`online_transaction_id`) REFERENCES `online_transactions` (`id`),
  CONSTRAINT `FK_data_change_voucher_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `FK_data_change_voucher_voucher` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`vid`),
  CONSTRAINT `FK_dcv_changed_log_manager` FOREIGN KEY (`data_change_log_manager_id`) REFERENCES `data_changed_log_manager` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_receiving_source
DROP TABLE IF EXISTS `data_receiving_source`;
CREATE TABLE IF NOT EXISTS `data_receiving_source` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` int DEFAULT NULL,
  `universal_person_or_org_type_manager_id` int DEFAULT NULL,
  `year_id` int NOT NULL,
  `topic` varchar(1000) DEFAULT NULL,
  `uploaded_date` date DEFAULT NULL,
  `data_receiving_type_id` int NOT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_data_receiving_source_universal_person_or_org_type_manag_idx` (`universal_person_or_org_type_manager_id`),
  KEY `fk_data_receiving_source_year1_idx` (`year_id`),
  KEY `fk_data_receiving_source_data_receiving_type1_idx` (`data_receiving_type_id`),
  KEY `fk_data_receiving_source_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_data_receiving_source_data_receiving_type1` FOREIGN KEY (`data_receiving_type_id`) REFERENCES `data_receiving_type` (`id`),
  CONSTRAINT `fk_data_receiving_source_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_data_receiving_source_universal_person_or_org_type_manager1` FOREIGN KEY (`universal_person_or_org_type_manager_id`) REFERENCES `universal_person_or_org_type_manager` (`id`),
  CONSTRAINT `fk_data_receiving_source_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_receiving_source_manager
DROP TABLE IF EXISTS `data_receiving_source_manager`;
CREATE TABLE IF NOT EXISTS `data_receiving_source_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `gup_type_id_gt` int NOT NULL,
  `data_receiving_source_id` int NOT NULL,
  `is_assigned` tinyint(1) DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  `prospective_student_status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_data_receiving_source_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_data_receiving_source_manager_gup_type1_idx` (`gup_type_id_gt`),
  KEY `fk_data_receiving_source_manager_data_receiving_source1_idx` (`data_receiving_source_id`),
  KEY `fk_data_receiving_source_manager_branch1_idx` (`branch_bid`),
  KEY `fk_data_receiving_source_manager_prospective_student_status_idx` (`prospective_student_status_id`),
  CONSTRAINT `fk_data_receiving_source_manager_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_data_receiving_source_manager_data_receiving_source1` FOREIGN KEY (`data_receiving_source_id`) REFERENCES `data_receiving_source` (`id`),
  CONSTRAINT `fk_data_receiving_source_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_data_receiving_source_manager_gup_type1` FOREIGN KEY (`gup_type_id_gt`) REFERENCES `gup_type` (`id_gt`),
  CONSTRAINT `fk_data_receiving_source_manager_prospective_student_status1` FOREIGN KEY (`prospective_student_status_id`) REFERENCES `prospective_student_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1209 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.data_receiving_type
DROP TABLE IF EXISTS `data_receiving_type`;
CREATE TABLE IF NOT EXISTS `data_receiving_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.delivery_type
DROP TABLE IF EXISTS `delivery_type`;
CREATE TABLE IF NOT EXISTS `delivery_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'send\nreturn',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.department_documents
DROP TABLE IF EXISTS `department_documents`;
CREATE TABLE IF NOT EXISTS `department_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc_url` varchar(5000) DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `general_user_profile_uploaded_by` int NOT NULL,
  `department_document_type_id` int NOT NULL,
  `department_id` int NOT NULL,
  `document_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_department_documents_general_user_profile1_idx` (`general_user_profile_uploaded_by`),
  KEY `fk_department_documents_department_document_type1_idx` (`department_document_type_id`),
  KEY `fk_department_documents_department1_idx` (`department_id`),
  CONSTRAINT `fk_department_documents_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_department_documents_department_document_type1` FOREIGN KEY (`department_document_type_id`) REFERENCES `department_document_type` (`id`),
  CONSTRAINT `fk_department_documents_general_user_profile1` FOREIGN KEY (`general_user_profile_uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.department_document_type
DROP TABLE IF EXISTS `department_document_type`;
CREATE TABLE IF NOT EXISTS `department_document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.designation
DROP TABLE IF EXISTS `designation`;
CREATE TABLE IF NOT EXISTS `designation` (
  `id_d` int NOT NULL AUTO_INCREMENT,
  `name` varchar(450) DEFAULT NULL,
  `designation_level_id_dl` int DEFAULT NULL,
  PRIMARY KEY (`id_d`),
  KEY `fk_designation_designation_level1_idx` (`designation_level_id_dl`),
  CONSTRAINT `fk_designation_designation_level1` FOREIGN KEY (`designation_level_id_dl`) REFERENCES `designation_level` (`id_dl`)
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.designation_level
DROP TABLE IF EXISTS `designation_level`;
CREATE TABLE IF NOT EXISTS `designation_level` (
  `id_dl` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_dl`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.designation_level_user_manager
DROP TABLE IF EXISTS `designation_level_user_manager`;
CREATE TABLE IF NOT EXISTS `designation_level_user_manager` (
  `id_dlum` int NOT NULL AUTO_INCREMENT,
  `designation_id_d` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `designation_level_id_dl` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id_dlum`),
  KEY `fk_designation_level_user_manager_designation1_idx` (`designation_id_d`),
  KEY `fk_designation_level_user_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_designation_level_user_manager_designation_level1_idx` (`designation_level_id_dl`),
  KEY `fk_designation_level_user_manager_general_organization_prof_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_designation_level_user_manager_designation1` FOREIGN KEY (`designation_id_d`) REFERENCES `designation` (`id_d`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_designation_level_user_manager_designation_level1` FOREIGN KEY (`designation_level_id_dl`) REFERENCES `designation_level` (`id_dl`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_designation_level_user_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_designation_level_user_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.director_payments
DROP TABLE IF EXISTS `director_payments`;
CREATE TABLE IF NOT EXISTS `director_payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_date` date DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `url` text,
  `director_shares_id` int NOT NULL,
  `login_session_session_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `payment_month` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_director_payments_director_shares1_idx` (`director_shares_id`),
  KEY `fk_director_payments_login_session1_idx` (`login_session_session_id`),
  CONSTRAINT `fk_director_payments_director_shares1` FOREIGN KEY (`director_shares_id`) REFERENCES `director_shares` (`id`),
  CONSTRAINT `fk_director_payments_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.director_shares
DROP TABLE IF EXISTS `director_shares`;
CREATE TABLE IF NOT EXISTS `director_shares` (
  `id` int NOT NULL AUTO_INCREMENT,
  `share_name` varchar(1000) DEFAULT NULL,
  `share_value` double DEFAULT NULL,
  `director_shares_manager_id` int NOT NULL,
  `director_shares_level_id` int NOT NULL,
  `director_shares_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_director_shares_director_shares_manager1_idx` (`director_shares_manager_id`),
  KEY `fk_director_shares_director_shares_level1_idx` (`director_shares_level_id`),
  KEY `fk_director_shares_director_shares1_idx` (`director_shares_id`),
  CONSTRAINT `fk_director_shares_director_shares1` FOREIGN KEY (`director_shares_id`) REFERENCES `director_shares` (`id`),
  CONSTRAINT `fk_director_shares_director_shares_level1` FOREIGN KEY (`director_shares_level_id`) REFERENCES `director_shares_level` (`id`),
  CONSTRAINT `fk_director_shares_director_shares_manager1` FOREIGN KEY (`director_shares_manager_id`) REFERENCES `director_shares_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.director_shares_level
DROP TABLE IF EXISTS `director_shares_level`;
CREATE TABLE IF NOT EXISTS `director_shares_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.director_shares_manager
DROP TABLE IF EXISTS `director_shares_manager`;
CREATE TABLE IF NOT EXISTS `director_shares_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `starting_date` date DEFAULT NULL,
  `scheduled_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_director_shares_manager_branch1_idx` (`branch_bid`),
  KEY `fk_director_shares_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_director_shares_manager_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_director_shares_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.district
DROP TABLE IF EXISTS `district`;
CREATE TABLE IF NOT EXISTS `district` (
  `id_d` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `zoon_id_z` int DEFAULT NULL,
  `province_id_p` int DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id_d`),
  KEY `fk_district_zoon1_idx` (`zoon_id_z`),
  KEY `fk_district_province1_idx` (`province_id_p`),
  CONSTRAINT `fk_district_province1` FOREIGN KEY (`province_id_p`) REFERENCES `province` (`id_p`),
  CONSTRAINT `fk_district_zoon1` FOREIGN KEY (`zoon_id_z`) REFERENCES `zoon` (`id_z`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.divisional_secretariat
DROP TABLE IF EXISTS `divisional_secretariat`;
CREATE TABLE IF NOT EXISTS `divisional_secretariat` (
  `id_ds` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `district_id_d` int NOT NULL,
  PRIMARY KEY (`id_ds`),
  KEY `fk_divisional_secretariat_district1_idx` (`district_id_d`),
  CONSTRAINT `fk_divisional_secretariat_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.document_disposal
DROP TABLE IF EXISTS `document_disposal`;
CREATE TABLE IF NOT EXISTS `document_disposal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `fk_document_disposal_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_document_disposal_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.document_manager
DROP TABLE IF EXISTS `document_manager`;
CREATE TABLE IF NOT EXISTS `document_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `uploaded_date` date DEFAULT NULL,
  `document_type_id` int NOT NULL,
  `document_name` text,
  PRIMARY KEY (`id`),
  KEY `fk_document_manager_document_type1_idx` (`document_type_id`),
  CONSTRAINT `fk_document_manager_document_type1` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4481 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.document_type
DROP TABLE IF EXISTS `document_type`;
CREATE TABLE IF NOT EXISTS `document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Batch Malpractices Document\nPre Assessment Document\nStudent Assignment Marks Appeal Document',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.doc_access_controller
DROP TABLE IF EXISTS `doc_access_controller`;
CREATE TABLE IF NOT EXISTS `doc_access_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_print_granted` int DEFAULT NULL,
  `is_email_granted` int DEFAULT NULL,
  `is_download_granted` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `sub_policy_doc_id` int NOT NULL,
  `iso_ul_id` int NOT NULL,
  `policy_doc_id` int NOT NULL,
  `sub_policy_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_coc_access_controller_sub_policy_doc1_idx` (`sub_policy_doc_id`),
  KEY `fk_coc_access_controller_iso_ul1_idx` (`iso_ul_id`),
  KEY `fk_doc_access_controller_policy_doc1_idx` (`policy_doc_id`),
  KEY `fk_doc_access_controller_sub_policy1_idx` (`sub_policy_id`),
  CONSTRAINT `fk_coc_access_controller_iso_ul1` FOREIGN KEY (`iso_ul_id`) REFERENCES `iso_ul` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_coc_access_controller_sub_policy_doc1` FOREIGN KEY (`sub_policy_doc_id`) REFERENCES `sub_policy_doc_content` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_doc_access_controller_policy_doc1` FOREIGN KEY (`policy_doc_id`) REFERENCES `policy_doc` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_doc_access_controller_sub_policy1` FOREIGN KEY (`sub_policy_id`) REFERENCES `sub_policy` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.due_penalty
DROP TABLE IF EXISTS `due_penalty`;
CREATE TABLE IF NOT EXISTS `due_penalty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `penalty_id` int NOT NULL,
  `student_due_set_penalty_date_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_due_paid_penalty_penalty1_idx` (`penalty_id`),
  KEY `fk_due_paid_penalty_student_due_set_penalty_date1_idx` (`student_due_set_penalty_date_id`),
  CONSTRAINT `fk_due_paid_penalty_penalty1` FOREIGN KEY (`penalty_id`) REFERENCES `penalty` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_due_paid_penalty_student_due_set_penalty_date1` FOREIGN KEY (`student_due_set_penalty_date_id`) REFERENCES `student_due_set_penalty_date` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb3 COMMENT='Once the penalty is calculated, penalty amount is stored in this table';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.education_level
DROP TABLE IF EXISTS `education_level`;
CREATE TABLE IF NOT EXISTS `education_level` (
  `id_el` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_el`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_address
DROP TABLE IF EXISTS `email_address`;
CREATE TABLE IF NOT EXISTS `email_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(145) DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `email_owner_id` int NOT NULL,
  `email_bulk_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_email_address_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_email_address_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_email_address_general_user_profile2_idx` (`email_owner_id`),
  KEY `fk_email_address_email_bulk1_idx` (`email_bulk_id`),
  CONSTRAINT `fk_email_address_email_bulk1` FOREIGN KEY (`email_bulk_id`) REFERENCES `email_bulk` (`id`),
  CONSTRAINT `fk_email_address_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_email_address_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_email_address_general_user_profile2` FOREIGN KEY (`email_owner_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_bulk
DROP TABLE IF EXISTS `email_bulk`;
CREATE TABLE IF NOT EXISTS `email_bulk` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COMMENT='specific  quantity of emails are taken as a bulk Ex. 1000 email add, 5000 email add. like.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_bulk_template_manager
DROP TABLE IF EXISTS `email_bulk_template_manager`;
CREATE TABLE IF NOT EXISTS `email_bulk_template_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_template_id` int NOT NULL,
  `email_bulk_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_email_bulk_template_manager_email_template1_idx` (`email_template_id`),
  KEY `fk_email_bulk_template_manager_email_bulk1_idx` (`email_bulk_id`),
  CONSTRAINT `fk_email_bulk_template_manager_email_bulk1` FOREIGN KEY (`email_bulk_id`) REFERENCES `email_bulk` (`id`),
  CONSTRAINT `fk_email_bulk_template_manager_email_template1` FOREIGN KEY (`email_template_id`) REFERENCES `email_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_group
DROP TABLE IF EXISTS `email_group`;
CREATE TABLE IF NOT EXISTS `email_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Emails are send to groups like directors, HR managers,';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_group_manager
DROP TABLE IF EXISTS `email_group_manager`;
CREATE TABLE IF NOT EXISTS `email_group_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_address_id` int NOT NULL,
  `email_group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_email_group_manager_email_address1_idx` (`email_address_id`),
  KEY `fk_email_group_manager_email_group1_idx` (`email_group_id`),
  CONSTRAINT `fk_email_group_manager_email_address1` FOREIGN KEY (`email_address_id`) REFERENCES `email_address` (`id`),
  CONSTRAINT `fk_email_group_manager_email_group1` FOREIGN KEY (`email_group_id`) REFERENCES `email_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_group_template_manager
DROP TABLE IF EXISTS `email_group_template_manager`;
CREATE TABLE IF NOT EXISTS `email_group_template_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_template_id` int NOT NULL,
  `email_group_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_email_group_template_manager_email_template1_idx` (`email_template_id`),
  KEY `fk_email_group_template_manager_email_group_manager1_idx` (`email_group_manager_id`),
  CONSTRAINT `fk_email_group_template_manager_email_group_manager1` FOREIGN KEY (`email_group_manager_id`) REFERENCES `email_group_manager` (`id`),
  CONSTRAINT `fk_email_group_template_manager_email_template1` FOREIGN KEY (`email_template_id`) REFERENCES `email_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.email_template
DROP TABLE IF EXISTS `email_template`;
CREATE TABLE IF NOT EXISTS `email_template` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `subject` text,
  `content` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employees
DROP TABLE IF EXISTS `employees`;
CREATE TABLE IF NOT EXISTS `employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `general_user_profilegup_id` int NOT NULL,
  `epf_no` varchar(255) DEFAULT NULL,
  `day_off` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `ignore_start_time_period` double DEFAULT NULL,
  `annual_leaves` int DEFAULT NULL,
  `is_valid_loan` int DEFAULT NULL,
  `petty_cash_level` double DEFAULT NULL,
  `is_lecture` tinyint(1) DEFAULT NULL,
  `is_counsellor` tinyint(1) DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `available_coins` double DEFAULT NULL,
  `loss_coins` double DEFAULT NULL,
  `generated_coins` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `src` varchar(1000) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_epf` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `FKemployees374204` (`general_user_profilegup_id`),
  KEY `fk_employees_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_employees_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `FKemployees374204` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=750 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_attendance
DROP TABLE IF EXISTS `employee_attendance`;
CREATE TABLE IF NOT EXISTS `employee_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `employees_employee_id` (`employees_employee_id`),
  CONSTRAINT `employee_attendance_ibfk_1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_department
DROP TABLE IF EXISTS `employee_department`;
CREATE TABLE IF NOT EXISTS `employee_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_incharge` tinyint(1) DEFAULT NULL,
  `department_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `priority` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_department_department1_idx` (`department_id`),
  KEY `fk_employee_department_employees1_idx` (`employees_employee_id`),
  KEY `fk_employee_department_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_employee_department_department1` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_department_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_employee_department_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_documents
DROP TABLE IF EXISTS `employee_documents`;
CREATE TABLE IF NOT EXISTS `employee_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc_url` varchar(5000) DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `general_user_profile_uploaded_by` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  `employee_document_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_documents_general_user_profile1_idx` (`general_user_profile_uploaded_by`),
  KEY `fk_employee_documents_employees1_idx` (`employees_employee_id`),
  KEY `fk_employee_documents_employee_document_type1_idx` (`employee_document_type_id`),
  CONSTRAINT `fk_employee_documents_employee_document_type1` FOREIGN KEY (`employee_document_type_id`) REFERENCES `employee_document_type` (`id`),
  CONSTRAINT `fk_employee_documents_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_document_type
DROP TABLE IF EXISTS `employee_document_type`;
CREATE TABLE IF NOT EXISTS `employee_document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_role_manager
DROP TABLE IF EXISTS `employee_role_manager`;
CREATE TABLE IF NOT EXISTS `employee_role_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketer_leads_id` int NOT NULL,
  `coin_type_id` int NOT NULL,
  `is_generated` tinyint(1) DEFAULT NULL,
  `user_role_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_role_manager_marketer_leads1_idx` (`marketer_leads_id`),
  KEY `fk_employee_role_manager_coin_type1_idx` (`coin_type_id`),
  KEY `fk_employee_role_manager_user_role_employee1_idx` (`user_role_employee_id`),
  CONSTRAINT `fk_employee_role_manager_coin_type1` FOREIGN KEY (`coin_type_id`) REFERENCES `coin_type` (`id`),
  CONSTRAINT `fk_employee_role_manager_marketer_leads1` FOREIGN KEY (`marketer_leads_id`) REFERENCES `marketer_leads` (`id`),
  CONSTRAINT `fk_employee_role_manager_user_role_employee1` FOREIGN KEY (`user_role_employee_id`) REFERENCES `user_role_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_type
DROP TABLE IF EXISTS `employee_type`;
CREATE TABLE IF NOT EXISTS `employee_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.employee_type_manager
DROP TABLE IF EXISTS `employee_type_manager`;
CREATE TABLE IF NOT EXISTS `employee_type_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employee_type_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_type_manager_employee_type1_idx` (`employee_type_id`),
  KEY `fk_employee_type_manager_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_employee_type_manager_employee_type1` FOREIGN KEY (`employee_type_id`) REFERENCES `employee_type` (`id`),
  CONSTRAINT `fk_employee_type_manager_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.enrollment_type
DROP TABLE IF EXISTS `enrollment_type`;
CREATE TABLE IF NOT EXISTS `enrollment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event
DROP TABLE IF EXISTS `event`;
CREATE TABLE IF NOT EXISTS `event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` longtext,
  `is_main_large` tinyint DEFAULT NULL,
  `is_main_small` tinyint DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `entered_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `is_published` tinyint DEFAULT NULL,
  `view_count` int DEFAULT NULL,
  `description2` longtext,
  `token` varchar(255) DEFAULT NULL,
  `event_category_id` int DEFAULT NULL,
  `event_type_id` int NOT NULL,
  `event_status_id` int NOT NULL,
  `event_sub_category_id` int DEFAULT NULL,
  `general_user_profile_entered_by` int NOT NULL,
  `general_user_profile_updated_by` int DEFAULT NULL,
  `location` varchar(1000) DEFAULT NULL,
  `is_reg_required` tinyint DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `event_category_id` (`event_category_id`) USING BTREE,
  KEY `event_type_id` (`event_type_id`) USING BTREE,
  KEY `event_status_id` (`event_status_id`) USING BTREE,
  KEY `event_sub_category_id` (`event_sub_category_id`) USING BTREE,
  KEY `general_user_profile_entered_by` (`general_user_profile_entered_by`) USING BTREE,
  KEY `general_user_profile_updated_by` (`general_user_profile_updated_by`) USING BTREE,
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`event_category_id`) REFERENCES `event_category` (`id`),
  CONSTRAINT `event_ibfk_2` FOREIGN KEY (`event_type_id`) REFERENCES `event_type` (`id`),
  CONSTRAINT `event_ibfk_3` FOREIGN KEY (`event_status_id`) REFERENCES `event_status` (`id`),
  CONSTRAINT `event_ibfk_4` FOREIGN KEY (`event_sub_category_id`) REFERENCES `event_sub_category` (`id`),
  CONSTRAINT `event_ibfk_5` FOREIGN KEY (`general_user_profile_entered_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `event_ibfk_6` FOREIGN KEY (`general_user_profile_updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_category
DROP TABLE IF EXISTS `event_category`;
CREATE TABLE IF NOT EXISTS `event_category` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_images
DROP TABLE IF EXISTS `event_images`;
CREATE TABLE IF NOT EXISTS `event_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(500) DEFAULT NULL,
  `event_image_size_id` int DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `event-image-size_id` (`event_image_size_id`) USING BTREE,
  KEY `event_id` (`event_id`) USING BTREE,
  CONSTRAINT `event_images_ibfk_2` FOREIGN KEY (`event_image_size_id`) REFERENCES `event_image_size` (`id`),
  CONSTRAINT `event_images_ibfk_3` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_image_size
DROP TABLE IF EXISTS `event_image_size`;
CREATE TABLE IF NOT EXISTS `event_image_size` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `event_image_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `event-image-type_id` (`event_image_type_id`) USING BTREE,
  CONSTRAINT `event_image_size_ibfk_1` FOREIGN KEY (`event_image_type_id`) REFERENCES `event_image_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_image_type
DROP TABLE IF EXISTS `event_image_type`;
CREATE TABLE IF NOT EXISTS `event_image_type` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_registered_student
DROP TABLE IF EXISTS `event_registered_student`;
CREATE TABLE IF NOT EXISTS `event_registered_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` date DEFAULT NULL,
  `event_id` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `personal_indemnity` varchar(100) DEFAULT NULL,
  `parent_indemnity` varchar(100) DEFAULT NULL,
  `student_agreement` varchar(100) DEFAULT NULL,
  `payment_slip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_status
DROP TABLE IF EXISTS `event_status`;
CREATE TABLE IF NOT EXISTS `event_status` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_sub_category
DROP TABLE IF EXISTS `event_sub_category`;
CREATE TABLE IF NOT EXISTS `event_sub_category` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.event_type
DROP TABLE IF EXISTS `event_type`;
CREATE TABLE IF NOT EXISTS `event_type` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.evidences_type
DROP TABLE IF EXISTS `evidences_type`;
CREATE TABLE IF NOT EXISTS `evidences_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam
DROP TABLE IF EXISTS `exam`;
CREATE TABLE IF NOT EXISTS `exam` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_no` varchar(45) DEFAULT NULL,
  `exam_title` varchar(195) DEFAULT NULL,
  `exam_description` text,
  `exam_contribution` double DEFAULT NULL,
  `exam_duration` double DEFAULT NULL,
  `course_cid` int NOT NULL,
  `total_questions` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_course1_idx` (`course_cid`),
  CONSTRAINT `fk_student_exam_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_accessor_scheduler
DROP TABLE IF EXISTS `exam_accessor_scheduler`;
CREATE TABLE IF NOT EXISTS `exam_accessor_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assinged_date` datetime DEFAULT NULL,
  `date_to_complete` datetime DEFAULT NULL,
  `completed_date` datetime DEFAULT NULL,
  `lecturer_id` int DEFAULT NULL,
  `verification_type_id` int NOT NULL,
  `employees_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_accesser_manager_lecturer1_idx` (`lecturer_id`),
  KEY `fk_exam_accessor_scheduler_verification_type1_idx` (`verification_type_id`),
  KEY `employees_id` (`employees_id`),
  CONSTRAINT `exam_accessor_scheduler_ibfk_1` FOREIGN KEY (`employees_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_exam_accesser_manager_lecturer1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`id`),
  CONSTRAINT `fk_exam_accessor_scheduler_verification_type1` FOREIGN KEY (`verification_type_id`) REFERENCES `verification_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=376 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_center
DROP TABLE IF EXISTS `exam_center`;
CREATE TABLE IF NOT EXISTS `exam_center` (
  `id` int NOT NULL AUTO_INCREMENT,
  `center` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `branch_bid` (`branch_bid`),
  CONSTRAINT `exam_center_ibfk_1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_center_device
DROP TABLE IF EXISTS `exam_center_device`;
CREATE TABLE IF NOT EXISTS `exam_center_device` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `exam_center_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_exam_center_device_exam_center` (`exam_center_id`),
  CONSTRAINT `FK_exam_center_device_exam_center` FOREIGN KEY (`exam_center_id`) REFERENCES `exam_center` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_document_controller
DROP TABLE IF EXISTS `exam_document_controller`;
CREATE TABLE IF NOT EXISTS `exam_document_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document_manager_id` int NOT NULL,
  `batch_exam_sheduler_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_document_controller_document_manager1_idx` (`document_manager_id`),
  KEY `fk_exam_document_controller_batch_exam_sheduler1_idx` (`batch_exam_sheduler_id`),
  CONSTRAINT `fk_exam_document_controller_batch_exam_sheduler1` FOREIGN KEY (`batch_exam_sheduler_id`) REFERENCES `batch_exam_sheduler` (`id`),
  CONSTRAINT `fk_exam_document_controller_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2556 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_engine_answers
DROP TABLE IF EXISTS `exam_engine_answers`;
CREATE TABLE IF NOT EXISTS `exam_engine_answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `answer` text,
  `is_correct` tinyint(1) DEFAULT NULL,
  `exam_engine_questions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_engine_answers_exam_engine_questions1_idx` (`exam_engine_questions_id`),
  CONSTRAINT `fk_exam_engine_answers_exam_engine_questions1` FOREIGN KEY (`exam_engine_questions_id`) REFERENCES `exam_engine_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_engine_questions
DROP TABLE IF EXISTS `exam_engine_questions`;
CREATE TABLE IF NOT EXISTS `exam_engine_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` text,
  `is_published` tinyint(1) DEFAULT NULL,
  `published_date` datetime DEFAULT NULL,
  `general_user_profile_published_by` int DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `general_user_profile_entered_by` int NOT NULL,
  `exam_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_engine_questions_general_user_profile1_idx` (`general_user_profile_published_by`),
  KEY `fk_exam_engine_questions_general_user_profile2_idx` (`general_user_profile_entered_by`),
  KEY `fk_exam_engine_questions_exam1_idx` (`exam_id`),
  CONSTRAINT `fk_exam_engine_questions_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `fk_exam_engine_questions_general_user_profile1` FOREIGN KEY (`general_user_profile_published_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_exam_engine_questions_general_user_profile2` FOREIGN KEY (`general_user_profile_entered_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_feedback_manager
DROP TABLE IF EXISTS `exam_feedback_manager`;
CREATE TABLE IF NOT EXISTS `exam_feedback_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_exam_result_id` int NOT NULL,
  `accessor_feedback_form_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_feedback_manager_student_exam_result1_idx` (`student_exam_result_id`),
  KEY `fk_exam_feedback_manager_accessor_feedback_form1_idx` (`accessor_feedback_form_id`),
  CONSTRAINT `fk_exam_feedback_manager_accessor_feedback_form1` FOREIGN KEY (`accessor_feedback_form_id`) REFERENCES `accessor_feedback_form` (`id`),
  CONSTRAINT `fk_exam_feedback_manager_student_exam_result1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_marking_criteria
DROP TABLE IF EXISTS `exam_marking_criteria`;
CREATE TABLE IF NOT EXISTS `exam_marking_criteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_of_question` double DEFAULT NULL,
  `marks_per_each_question` double DEFAULT NULL,
  `assume_time` double DEFAULT NULL,
  `sum_of_marks` double DEFAULT NULL,
  `exam_id` int NOT NULL,
  `assesment_marking_criteria_componant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_marking_criteria_exam1_idx` (`exam_id`),
  KEY `fk_exam_marking_criteria_assesment_marking_criteria_compona_idx` (`assesment_marking_criteria_componant_id`),
  CONSTRAINT `fk_exam_marking_criteria_assesment_marking_criteria_componant1` FOREIGN KEY (`assesment_marking_criteria_componant_id`) REFERENCES `assesment_marking_criteria_componant` (`id`),
  CONSTRAINT `fk_exam_marking_criteria_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_marking_criteria_practical
DROP TABLE IF EXISTS `exam_marking_criteria_practical`;
CREATE TABLE IF NOT EXISTS `exam_marking_criteria_practical` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `exam_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_marking_criteria_practical_exam1_idx` (`exam_id`),
  CONSTRAINT `fk_exam_marking_criteria_practical_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_mode
DROP TABLE IF EXISTS `exam_mode`;
CREATE TABLE IF NOT EXISTS `exam_mode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_outcome
DROP TABLE IF EXISTS `exam_outcome`;
CREATE TABLE IF NOT EXISTS `exam_outcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `outcome_id` int NOT NULL,
  `exam_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_outcome_outcome1_idx` (`outcome_id`),
  KEY `fk_exam_outcome_exam1_idx` (`exam_id`),
  CONSTRAINT `fk_exam_outcome_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `fk_student_exam_outcome_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=451 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_paper_summary
DROP TABLE IF EXISTS `exam_paper_summary`;
CREATE TABLE IF NOT EXISTS `exam_paper_summary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` text,
  `exam_id` int NOT NULL,
  `prepared_by` int NOT NULL,
  `validated_by` int NOT NULL,
  `printed_by` int NOT NULL,
  `pack_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_papers_employees1_idx` (`prepared_by`),
  KEY `fk_exam_papers_employees2_idx` (`validated_by`),
  KEY `fk_exam_papers_exam1_idx` (`exam_id`),
  KEY `fk_exam_papers_employees3_idx` (`printed_by`),
  KEY `fk_exam_papers_pack1_idx` (`pack_id`),
  KEY `fk_exam_paper_summary_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_exam_paper_summary_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_exam_papers_employees1` FOREIGN KEY (`prepared_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_exam_papers_employees2` FOREIGN KEY (`validated_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_exam_papers_employees3` FOREIGN KEY (`printed_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_exam_papers_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `fk_exam_papers_pack1` FOREIGN KEY (`pack_id`) REFERENCES `pack` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_questions
DROP TABLE IF EXISTS `exam_questions`;
CREATE TABLE IF NOT EXISTS `exam_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `entered_date` date DEFAULT NULL,
  `description` text,
  `exam_question_topics_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_questions_exam_question_topics1_idx` (`exam_question_topics_id`),
  KEY `fk_exam_questions_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_exam_questions_exam_question_topics1` FOREIGN KEY (`exam_question_topics_id`) REFERENCES `exam_question_topics` (`id`),
  CONSTRAINT `fk_exam_questions_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_question_answers
DROP TABLE IF EXISTS `exam_question_answers`;
CREATE TABLE IF NOT EXISTS `exam_question_answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `is_correct_answer` tinyint(1) DEFAULT NULL,
  `exam_questions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_question_answers_exam_questions1_idx` (`exam_questions_id`),
  CONSTRAINT `fk_exam_question_answers_exam_questions1` FOREIGN KEY (`exam_questions_id`) REFERENCES `exam_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=248 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_question_topics
DROP TABLE IF EXISTS `exam_question_topics`;
CREATE TABLE IF NOT EXISTS `exam_question_topics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `question_count` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `exam_question_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_question_topics_course1_idx` (`course_cid`),
  KEY `fk_question_topics_exam_question_type1_idx` (`exam_question_type_id`),
  CONSTRAINT `fk_question_topics_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_question_topics_exam_question_type1` FOREIGN KEY (`exam_question_type_id`) REFERENCES `exam_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_question_type
DROP TABLE IF EXISTS `exam_question_type`;
CREATE TABLE IF NOT EXISTS `exam_question_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_request
DROP TABLE IF EXISTS `exam_request`;
CREATE TABLE IF NOT EXISTS `exam_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` date DEFAULT NULL,
  `is_scheduled` tinyint(1) DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  `exam_id` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `fk_exam_request_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_exam_request_branch1_idx` (`branch_bid`),
  KEY `fk_exam_request_exam1_idx` (`exam_id`),
  CONSTRAINT `fk_exam_request_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_exam_request_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `fk_exam_request_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_request_manager
DROP TABLE IF EXISTS `exam_request_manager`;
CREATE TABLE IF NOT EXISTS `exam_request_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_request_id` int NOT NULL,
  `batch_exam_sheduler_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_request_manager_exam_request1_idx` (`exam_request_id`),
  KEY `fk_exam_request_manager_batch_exam_sheduler1_idx` (`batch_exam_sheduler_id`),
  CONSTRAINT `fk_exam_request_manager_batch_exam_sheduler1` FOREIGN KEY (`batch_exam_sheduler_id`) REFERENCES `batch_exam_sheduler` (`id`),
  CONSTRAINT `fk_exam_request_manager_exam_request1` FOREIGN KEY (`exam_request_id`) REFERENCES `exam_request` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_result_reassess_controller
DROP TABLE IF EXISTS `exam_result_reassess_controller`;
CREATE TABLE IF NOT EXISTS `exam_result_reassess_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fee` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_marks_entered` tinyint(1) DEFAULT NULL,
  `requested_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `student_exam_result_id` int NOT NULL,
  `voucher_vid` int DEFAULT NULL,
  `assessment_reassess_request_type_id` int NOT NULL,
  `student_exam_result_id_new` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_exam_result_reassess_controller_student_exam_result1_idx` (`student_exam_result_id`),
  KEY `fk_exam_result_reassess_controller_voucher1_idx` (`voucher_vid`),
  KEY `fk_exam_result_reassess_controller_assessment_reassess_requ_idx` (`assessment_reassess_request_type_id`),
  KEY `fk_exam_result_reassess_controller_student_exam_result2_idx` (`student_exam_result_id_new`),
  CONSTRAINT `fk_exam_result_reassess_controller_assessment_reassess_reques1` FOREIGN KEY (`assessment_reassess_request_type_id`) REFERENCES `assessment_reassess_request_type` (`id`),
  CONSTRAINT `fk_exam_result_reassess_controller_student_exam_result1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`),
  CONSTRAINT `fk_exam_result_reassess_controller_student_exam_result2` FOREIGN KEY (`student_exam_result_id_new`) REFERENCES `student_exam_result` (`id`),
  CONSTRAINT `fk_exam_result_reassess_controller_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.exam_type
DROP TABLE IF EXISTS `exam_type`;
CREATE TABLE IF NOT EXISTS `exam_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.federated_employees
DROP TABLE IF EXISTS `federated_employees`;
CREATE TABLE IF NOT EXISTS `federated_employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `general_user_profilegup_id` int NOT NULL,
  `epf_no` varchar(255) DEFAULT NULL,
  `day_off` varchar(255) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `ignore_start_time_period` double DEFAULT NULL,
  `annual_leaves` int DEFAULT NULL,
  `is_valid_loan` int DEFAULT NULL,
  `petty_cash_level` double DEFAULT NULL,
  `is_lecture` tinyint DEFAULT NULL,
  `is_counsellor` tinyint DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `available_coins` double DEFAULT NULL,
  `loss_coins` double DEFAULT NULL,
  `generated_coins` double DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `src` varchar(1000) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_epf` tinyint DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_hr_system/employees';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.federated_employees_details
DROP TABLE IF EXISTS `federated_employees_details`;
CREATE TABLE IF NOT EXISTS `federated_employees_details` (
  `fdr_emp_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nic` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile_phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `whatsapp` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mid_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name_with_initials` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_phone` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `profile_created_date` date DEFAULT NULL,
  `user_title_id` int DEFAULT NULL,
  `emegency_number` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint NOT NULL DEFAULT '0',
  `employee_id` int DEFAULT NULL,
  `epf_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `day_off` int DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `ignore_start_time_period` double DEFAULT NULL,
  `annual_leaves` int DEFAULT NULL,
  `is_valid_loan` int DEFAULT NULL,
  `petty_cash_level` double DEFAULT NULL,
  `src` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_start_time` timestamp NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `general_organization_profile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`fdr_emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_hr_system/employees_details';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.feedback_componats_manager
DROP TABLE IF EXISTS `feedback_componats_manager`;
CREATE TABLE IF NOT EXISTS `feedback_componats_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marks` double DEFAULT NULL,
  `comment` text,
  `accessor_feedback_form_id` int NOT NULL,
  `assesment_marking_criteria_componant_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feedback_componats_manager_accessor_feedback_form1_idx` (`accessor_feedback_form_id`),
  KEY `fk_feedback_componats_manager_assesment_marking_criteria_co_idx` (`assesment_marking_criteria_componant_id`),
  CONSTRAINT `fk_feedback_componats_manager_accessor_feedback_form1` FOREIGN KEY (`accessor_feedback_form_id`) REFERENCES `accessor_feedback_form` (`id`),
  CONSTRAINT `fk_feedback_componats_manager_assesment_marking_criteria_comp1` FOREIGN KEY (`assesment_marking_criteria_componant_id`) REFERENCES `assesment_marking_criteria_componant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=596772 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.ffinger
DROP TABLE IF EXISTS `ffinger`;
CREATE TABLE IF NOT EXISTS `ffinger` (
  `id_pfg` int NOT NULL AUTO_INCREMENT,
  `person_category_id_pc` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id_pfg`),
  KEY `fk_pc_for_gup_person_category1_idx` (`person_category_id_pc`),
  KEY `fk_pc_for_gup_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_pc_for_gup_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_pc_for_gup_person_category1` FOREIGN KEY (`person_category_id_pc`) REFERENCES `person_category` (`id_pc`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_attendance_data
DROP TABLE IF EXISTS `finger_print_attendance_data`;
CREATE TABLE IF NOT EXISTS `finger_print_attendance_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `checkout` datetime DEFAULT NULL,
  `is_synced` tinyint(1) DEFAULT NULL,
  `is_sms_sent` tinyint(1) DEFAULT NULL,
  `finger_print_machine_id` int NOT NULL,
  `finger_print_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_finger_print_attendance_data_finger_print_machine1_idx` (`finger_print_machine_id`),
  KEY `fk_finger_print_attendance_data_finger_print_user1_idx` (`finger_print_user_id`),
  CONSTRAINT `fk_finger_print_attendance_data_finger_print_machine1` FOREIGN KEY (`finger_print_machine_id`) REFERENCES `finger_print_machine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_finger_print_attendance_data_finger_print_user1` FOREIGN KEY (`finger_print_user_id`) REFERENCES `finger_print_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19564 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_employee_attendance
DROP TABLE IF EXISTS `finger_print_employee_attendance`;
CREATE TABLE IF NOT EXISTS `finger_print_employee_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finger_print_user_attendance_id` int NOT NULL,
  `employee_attendance_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `finger_print_user_attendance_id` (`finger_print_user_attendance_id`),
  KEY `employee_attendance_id` (`employee_attendance_id`),
  CONSTRAINT `finger_print_employee_attendance_ibfk_1` FOREIGN KEY (`finger_print_user_attendance_id`) REFERENCES `finger_print_user_attendance` (`id`),
  CONSTRAINT `finger_print_employee_attendance_ibfk_2` FOREIGN KEY (`employee_attendance_id`) REFERENCES `employee_attendance` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_machine
DROP TABLE IF EXISTS `finger_print_machine`;
CREATE TABLE IF NOT EXISTS `finger_print_machine` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sn` varchar(45) DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `finger_print_machine_model_id` int NOT NULL,
  `finger_print_region_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_finger_print_machine_branch1_idx` (`branch_bid`),
  KEY `fk_finger_print_machine_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_finger_print_machine_finger_print_machine_model1_idx` (`finger_print_machine_model_id`),
  KEY `finger_print_region_id` (`finger_print_region_id`),
  CONSTRAINT `finger_print_machine_ibfk_1` FOREIGN KEY (`finger_print_region_id`) REFERENCES `finger_print_region` (`id`),
  CONSTRAINT `fk_finger_print_machine_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_finger_print_machine_finger_print_machine_model1` FOREIGN KEY (`finger_print_machine_model_id`) REFERENCES `finger_print_machine_model` (`id`),
  CONSTRAINT `fk_finger_print_machine_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_machine_model
DROP TABLE IF EXISTS `finger_print_machine_model`;
CREATE TABLE IF NOT EXISTS `finger_print_machine_model` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `model_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_machine_user
DROP TABLE IF EXISTS `finger_print_machine_user`;
CREATE TABLE IF NOT EXISTS `finger_print_machine_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finger_print_user_id` int NOT NULL,
  `finger_print_machine_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_finger_print_machine_user_finger_print_user1_idx` (`finger_print_user_id`),
  KEY `fk_finger_print_machine_user_finger_print_machine1_idx` (`finger_print_machine_id`),
  CONSTRAINT `fk_finger_print_machine_user_finger_print_machine1` FOREIGN KEY (`finger_print_machine_id`) REFERENCES `finger_print_machine` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_finger_print_machine_user_finger_print_user1` FOREIGN KEY (`finger_print_user_id`) REFERENCES `finger_print_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4584 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_region
DROP TABLE IF EXISTS `finger_print_region`;
CREATE TABLE IF NOT EXISTS `finger_print_region` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_region_user
DROP TABLE IF EXISTS `finger_print_region_user`;
CREATE TABLE IF NOT EXISTS `finger_print_region_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finger_print_region_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `added_date` datetime NOT NULL,
  `is_student` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `enrollment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `finger_print_region_id` (`finger_print_region_id`),
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`),
  CONSTRAINT `finger_print_region_user_ibfk_1` FOREIGN KEY (`finger_print_region_id`) REFERENCES `finger_print_region` (`id`),
  CONSTRAINT `finger_print_region_user_ibfk_2` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_student_attendance
DROP TABLE IF EXISTS `finger_print_student_attendance`;
CREATE TABLE IF NOT EXISTS `finger_print_student_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finger_print_attendance_data_id` int NOT NULL,
  `student_attendance_by_time_table_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_finger_print_student_attendance_finger_print_attendance__idx` (`finger_print_attendance_data_id`),
  KEY `fk_finger_print_student_attendance_student_attendance_by_ti_idx` (`student_attendance_by_time_table_id`),
  CONSTRAINT `fk_finger_print_student_attendance_finger_print_attendance_da1` FOREIGN KEY (`finger_print_attendance_data_id`) REFERENCES `finger_print_attendance_data` (`id`),
  CONSTRAINT `fk_finger_print_student_attendance_student_attendance_by_time1` FOREIGN KEY (`student_attendance_by_time_table_id`) REFERENCES `student_attendance_by_time_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_user
DROP TABLE IF EXISTS `finger_print_user`;
CREATE TABLE IF NOT EXISTS `finger_print_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_finger_print_user_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_finger_print_user_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=938 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.finger_print_user_attendance
DROP TABLE IF EXISTS `finger_print_user_attendance`;
CREATE TABLE IF NOT EXISTS `finger_print_user_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `finger_print_region_user_id` int NOT NULL,
  `action_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `finger_print_region_user_id` (`finger_print_region_user_id`),
  CONSTRAINT `finger_print_user_attendance_ibfk_1` FOREIGN KEY (`finger_print_region_user_id`) REFERENCES `finger_print_region_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.fixed_expenses
DROP TABLE IF EXISTS `fixed_expenses`;
CREATE TABLE IF NOT EXISTS `fixed_expenses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chart_of_account_coa_id` int NOT NULL,
  `gop_for_am_id_gfa` int NOT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `value` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fixed_expenses_chart_of_account1_idx` (`chart_of_account_coa_id`),
  KEY `fk_fixed_expenses_gop_for_am1_idx` (`gop_for_am_id_gfa`),
  KEY `fk_fixed_expenses_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  CONSTRAINT `fk_fixed_expenses_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`),
  CONSTRAINT `fk_fixed_expenses_gop_for_am1` FOREIGN KEY (`gop_for_am_id_gfa`) REFERENCES `gop_for_am` (`id_gfa`),
  CONSTRAINT `fk_fixed_expenses_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.floor
DROP TABLE IF EXISTS `floor`;
CREATE TABLE IF NOT EXISTS `floor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `building_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_hall_floor_hall` (`building_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.fund_transfer
DROP TABLE IF EXISTS `fund_transfer`;
CREATE TABLE IF NOT EXISTS `fund_transfer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_account_from` int NOT NULL,
  `member_account_to` int NOT NULL,
  `voucher_vid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_fund_transfer_member_accounts1_idx` (`member_account_from`),
  KEY `fk_fund_transfer_member_accounts2_idx` (`member_account_to`),
  KEY `fk_fund_transfer_voucher1_idx` (`voucher_vid`),
  CONSTRAINT `fk_fund_transfer_member_accounts1` FOREIGN KEY (`member_account_from`) REFERENCES `member_accounts` (`id`),
  CONSTRAINT `fk_fund_transfer_member_accounts2` FOREIGN KEY (`member_account_to`) REFERENCES `member_accounts` (`id`),
  CONSTRAINT `fk_fund_transfer_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.further_studies
DROP TABLE IF EXISTS `further_studies`;
CREATE TABLE IF NOT EXISTS `further_studies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `further_studiesid` varchar(45) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_further_studies_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_further_studies_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_journal_entry
DROP TABLE IF EXISTS `general_journal_entry`;
CREATE TABLE IF NOT EXISTS `general_journal_entry` (
  `gje_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `credit` double DEFAULT NULL,
  `debit` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `branchbid` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `chequeno` varchar(45) DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `login_sessionsession_id` int NOT NULL,
  `payment_modepayment_mode_id` int NOT NULL,
  `user_loginlogin_id` int DEFAULT NULL,
  `voucher_itemvi_id` int NOT NULL,
  `sub_chart_of_accountis_sca` int DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `credit_or_debit_id_cod` int NOT NULL,
  `general_journal_entry_gje_id` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`gje_id`),
  KEY `FKgeneral_jo133980` (`branchbid`),
  KEY `FKgeneral_jo973771` (`general_user_profilegup_id`),
  KEY `FKgeneral_jo935390` (`login_sessionsession_id`),
  KEY `FKgeneral_jo747371` (`payment_modepayment_mode_id`),
  KEY `FKgeneral_jo360021` (`user_loginlogin_id`),
  KEY `FKgeneral_jo63548` (`voucher_itemvi_id`),
  KEY `FKgeneral_jo208431` (`sub_chart_of_accountis_sca`),
  KEY `fk_general_journal_entry_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_general_journal_entry_credit_or_debit1_idx` (`credit_or_debit_id_cod`),
  KEY `fk_general_journal_entry_general_journal_entry1_idx` (`general_journal_entry_gje_id`),
  CONSTRAINT `fk_general_journal_entry_credit_or_debit1` FOREIGN KEY (`credit_or_debit_id_cod`) REFERENCES `credit_or_debit` (`id_cod`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_general_journal_entry1` FOREIGN KEY (`general_journal_entry_gje_id`) REFERENCES `general_journal_entry` (`gje_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo133980` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo208431` FOREIGN KEY (`sub_chart_of_accountis_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo360021` FOREIGN KEY (`user_loginlogin_id`) REFERENCES `user_login` (`login_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo63548` FOREIGN KEY (`voucher_itemvi_id`) REFERENCES `voucher_item` (`vi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo747371` FOREIGN KEY (`payment_modepayment_mode_id`) REFERENCES `payment_mode` (`payment_mode_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo935390` FOREIGN KEY (`login_sessionsession_id`) REFERENCES `login_session` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo973771` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=428460 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_journal_entry_received_cheques
DROP TABLE IF EXISTS `general_journal_entry_received_cheques`;
CREATE TABLE IF NOT EXISTS `general_journal_entry_received_cheques` (
  `id_cgje` int NOT NULL AUTO_INCREMENT,
  `general_journal_entrygje_id` int NOT NULL,
  `received_chequesid_rc` int NOT NULL,
  PRIMARY KEY (`id_cgje`),
  KEY `FKgeneral_jo300236` (`general_journal_entrygje_id`),
  KEY `FKgeneral_jo854707` (`received_chequesid_rc`),
  CONSTRAINT `FKgeneral_jo300236` FOREIGN KEY (`general_journal_entrygje_id`) REFERENCES `general_journal_entry` (`gje_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_jo854707` FOREIGN KEY (`received_chequesid_rc`) REFERENCES `received_cheques` (`id_rc`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_journal_entry_temp
DROP TABLE IF EXISTS `general_journal_entry_temp`;
CREATE TABLE IF NOT EXISTS `general_journal_entry_temp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `credit` double DEFAULT NULL,
  `debit` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL,
  `cheque_no` varchar(45) DEFAULT NULL,
  `voucher_item_vi_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `sub_chart_of_account_is_sca1` int DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `general_journal_entry_temp_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_general_journal_entry_temp_voucher_item1_idx` (`voucher_item_vi_id`),
  KEY `fk_general_journal_entry_temp_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_general_journal_entry_temp_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_general_journal_entry_temp_sub_chart_of_account2_idx` (`sub_chart_of_account_is_sca1`),
  KEY `fk_general_journal_entry_temp_branch1_idx` (`branch_bid`),
  KEY `fk_general_journal_entry_temp_general_journal_entry_temp1_idx` (`general_journal_entry_temp_id`),
  CONSTRAINT `fk_general_journal_entry_temp_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_temp_general_journal_entry_temp1` FOREIGN KEY (`general_journal_entry_temp_id`) REFERENCES `general_journal_entry_temp` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_temp_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_temp_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_temp_sub_chart_of_account2` FOREIGN KEY (`sub_chart_of_account_is_sca1`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_general_journal_entry_temp_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4879 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_organization_profile
DROP TABLE IF EXISTS `general_organization_profile`;
CREATE TABLE IF NOT EXISTS `general_organization_profile` (
  `id_gop` int NOT NULL AUTO_INCREMENT,
  `name` varchar(450) DEFAULT NULL,
  `address1` varchar(450) DEFAULT NULL,
  `address2` varchar(450) DEFAULT NULL,
  `address3` varchar(450) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `vision` varchar(45) DEFAULT NULL,
  `mision` varchar(45) DEFAULT NULL,
  `registration_no` varchar(45) DEFAULT NULL,
  `website` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  `objectives` varchar(45) DEFAULT NULL,
  `moto` varchar(45) DEFAULT NULL,
  `logo` varchar(45) DEFAULT NULL,
  `header` varchar(45) DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  `registration_type_id_rt` int DEFAULT NULL,
  `country_id_c` int DEFAULT NULL,
  `organization_type_id_ot` int NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `district_id_d` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`id_gop`),
  KEY `fk_general_organization_profile_registration_type1_idx` (`registration_type_id_rt`),
  KEY `fk_general_organization_profile_country1_idx` (`country_id_c`),
  KEY `fk_general_organization_profile_organization_type1_idx` (`organization_type_id_ot`),
  KEY `fk_general_organization_profile_district1_idx` (`district_id_d`),
  CONSTRAINT `fk_general_organization_profile_country1` FOREIGN KEY (`country_id_c`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_general_organization_profile_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`),
  CONSTRAINT `fk_general_organization_profile_organization_type1` FOREIGN KEY (`organization_type_id_ot`) REFERENCES `organization_type` (`id_ot`),
  CONSTRAINT `fk_general_organization_profile_registration_type1` FOREIGN KEY (`registration_type_id_rt`) REFERENCES `registration_type` (`id_rt`)
) ENGINE=InnoDB AUTO_INCREMENT=6014 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_user_profile
DROP TABLE IF EXISTS `general_user_profile`;
CREATE TABLE IF NOT EXISTS `general_user_profile` (
  `gup_id` int NOT NULL AUTO_INCREMENT,
  `nic` varchar(255) DEFAULT NULL,
  `child_no` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `mid_name` varchar(255) DEFAULT NULL,
  `address1` varchar(1000) DEFAULT NULL,
  `address2` varchar(1000) DEFAULT NULL,
  `address3` varchar(1000) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `office_phone` varchar(255) DEFAULT NULL,
  `home_phone` varchar(255) DEFAULT NULL,
  `mobile_phone` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `img` varchar(255) DEFAULT NULL,
  `about_me` text,
  `profile_created_date` date DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `first_name` varchar(1000) DEFAULT NULL,
  `last_name` varchar(1000) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name_with_in` varchar(450) DEFAULT NULL,
  `names_denoted_by_initials` varchar(245) DEFAULT NULL,
  `is_email_subscribe` int DEFAULT NULL,
  `is_sms_subscribe` int DEFAULT NULL,
  `postal_code` varchar(45) DEFAULT NULL,
  `nationality` varchar(45) DEFAULT NULL,
  `file_no` varchar(45) DEFAULT NULL,
  `occupation` varchar(145) DEFAULT NULL,
  `skype` varchar(45) DEFAULT NULL,
  `whatsapp` varchar(45) DEFAULT NULL,
  `viber` varchar(45) DEFAULT NULL,
  `is_mail_verified` tinyint(1) DEFAULT NULL,
  `languageslanguage_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `education_level_id_el` int DEFAULT NULL,
  `occupation_id_o` int DEFAULT NULL,
  `industry_id_i` int DEFAULT NULL,
  `profession_id_p` int DEFAULT NULL,
  `designation_id_d` int DEFAULT NULL,
  `country_id_c` int DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `district_id_d` int DEFAULT NULL,
  `martial_status_id` int DEFAULT NULL,
  `nationality_id` int DEFAULT NULL,
  `user_title_id` int DEFAULT NULL,
  `user_gender_id` int DEFAULT NULL,
  `country_of_citizenship` int DEFAULT NULL,
  `country_of_birth` int DEFAULT NULL,
  `height` double DEFAULT NULL,
  `enroll_age` int DEFAULT NULL,
  `is_enroll_age_verified` tinyint DEFAULT NULL,
  PRIMARY KEY (`gup_id`),
  KEY `FKgeneral_us779845` (`languageslanguage_id`),
  KEY `fk_general_user_profile_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_general_user_profile_education_level1_idx` (`education_level_id_el`),
  KEY `fk_general_user_profile_occupation1_idx` (`occupation_id_o`),
  KEY `fk_general_user_profile_industry1_idx` (`industry_id_i`),
  KEY `fk_general_user_profile_profession1_idx` (`profession_id_p`),
  KEY `fk_general_user_profile_designation1_idx` (`designation_id_d`),
  KEY `fk_general_user_profile_country1_idx` (`country_id_c`),
  KEY `fk_general_user_profile_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_general_user_profile_district1_idx` (`district_id_d`),
  KEY `fk_general_user_profile_martial_status1_idx` (`martial_status_id`),
  KEY `fk_general_user_profile_nationality1_idx` (`nationality_id`),
  KEY `fk_general_user_profile_user_title1_idx` (`user_title_id`),
  KEY `fk_general_user_profile_user_gender1_idx` (`user_gender_id`),
  KEY `fk_general_user_profile_country2_idx` (`country_of_citizenship`),
  KEY `fk_general_user_profile_country3_idx` (`country_of_birth`),
  CONSTRAINT `fk_general_user_profile_country1` FOREIGN KEY (`country_id_c`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_general_user_profile_country2` FOREIGN KEY (`country_of_citizenship`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_general_user_profile_country3` FOREIGN KEY (`country_of_birth`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_general_user_profile_designation1` FOREIGN KEY (`designation_id_d`) REFERENCES `designation` (`id_d`),
  CONSTRAINT `fk_general_user_profile_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`),
  CONSTRAINT `fk_general_user_profile_education_level1` FOREIGN KEY (`education_level_id_el`) REFERENCES `education_level` (`id_el`),
  CONSTRAINT `fk_general_user_profile_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_general_user_profile_industry1` FOREIGN KEY (`industry_id_i`) REFERENCES `industry` (`id_i`),
  CONSTRAINT `fk_general_user_profile_martial_status1` FOREIGN KEY (`martial_status_id`) REFERENCES `martial_status` (`id`),
  CONSTRAINT `fk_general_user_profile_nationality1` FOREIGN KEY (`nationality_id`) REFERENCES `nationality` (`id`),
  CONSTRAINT `fk_general_user_profile_occupation1` FOREIGN KEY (`occupation_id_o`) REFERENCES `occupation` (`id_o`),
  CONSTRAINT `fk_general_user_profile_profession1` FOREIGN KEY (`profession_id_p`) REFERENCES `profession` (`id_p`),
  CONSTRAINT `fk_general_user_profile_user_gender1` FOREIGN KEY (`user_gender_id`) REFERENCES `user_gender` (`id`),
  CONSTRAINT `fk_general_user_profile_user_title1` FOREIGN KEY (`user_title_id`) REFERENCES `user_title` (`id`),
  CONSTRAINT `FKgeneral_us779845` FOREIGN KEY (`languageslanguage_id`) REFERENCES `languages` (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=252826 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_user_profile_general_user_type
DROP TABLE IF EXISTS `general_user_profile_general_user_type`;
CREATE TABLE IF NOT EXISTS `general_user_profile_general_user_type` (
  `id_gugut` int NOT NULL AUTO_INCREMENT,
  `general_user_profilegup_id` int NOT NULL,
  `general_user_typeid_gut` int NOT NULL,
  PRIMARY KEY (`id_gugut`),
  KEY `FKgeneral_us706086` (`general_user_profilegup_id`),
  KEY `FKgeneral_us372887` (`general_user_typeid_gut`),
  CONSTRAINT `FKgeneral_us372887` FOREIGN KEY (`general_user_typeid_gut`) REFERENCES `general_user_type` (`id_gut`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKgeneral_us706086` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40050 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.general_user_type
DROP TABLE IF EXISTS `general_user_type`;
CREATE TABLE IF NOT EXISTS `general_user_type` (
  `id_gut` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_gut`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gje_scoa_manager
DROP TABLE IF EXISTS `gje_scoa_manager`;
CREATE TABLE IF NOT EXISTS `gje_scoa_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `general_journal_entry_gje_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gje_scoa_manager_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_gje_scoa_manager_general_journal_entry1_idx` (`general_journal_entry_gje_id`),
  CONSTRAINT `fk_gje_scoa_manager_general_journal_entry1` FOREIGN KEY (`general_journal_entry_gje_id`) REFERENCES `general_journal_entry` (`gje_id`),
  CONSTRAINT `fk_gje_scoa_manager_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gn_division
DROP TABLE IF EXISTS `gn_division`;
CREATE TABLE IF NOT EXISTS `gn_division` (
  `id_gd` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `divisional_secretariat_id_ds` int NOT NULL,
  PRIMARY KEY (`id_gd`),
  KEY `fk_gn_division_divisional_secretariat1_idx` (`divisional_secretariat_id_ds`),
  CONSTRAINT `fk_gn_division_divisional_secretariat1` FOREIGN KEY (`divisional_secretariat_id_ds`) REFERENCES `divisional_secretariat` (`id_ds`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gom_coa
DROP TABLE IF EXISTS `gom_coa`;
CREATE TABLE IF NOT EXISTS `gom_coa` (
  `id_gc` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  `chart_of_account_coa_id` int NOT NULL,
  PRIMARY KEY (`id_gc`),
  KEY `fk_gom_coa_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_gom_coa_chart_of_account1_idx` (`chart_of_account_coa_id`),
  CONSTRAINT `fk_gom_coa_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`),
  CONSTRAINT `fk_gom_coa_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=303 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gop_for_am
DROP TABLE IF EXISTS `gop_for_am`;
CREATE TABLE IF NOT EXISTS `gop_for_am` (
  `id_gfa` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id_gfa`),
  KEY `fk_gop_for_am_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_gop_for_am_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gop_for_mm
DROP TABLE IF EXISTS `gop_for_mm`;
CREATE TABLE IF NOT EXISTS `gop_for_mm` (
  `id_gfm` varchar(45) NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL AUTO_INCREMENT,
  `SEPR` varchar(45) DEFAULT NULL COMMENT 'Standard Enrolment Potential Ratio',
  PRIMARY KEY (`id_gfm`),
  KEY `fk_gop_for_mm_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_gop_for_mm_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.guardian_relationship
DROP TABLE IF EXISTS `guardian_relationship`;
CREATE TABLE IF NOT EXISTS `guardian_relationship` (
  `id_gt` int NOT NULL AUTO_INCREMENT,
  `relationship` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_gt`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.guarntor_type
DROP TABLE IF EXISTS `guarntor_type`;
CREATE TABLE IF NOT EXISTS `guarntor_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_for_am
DROP TABLE IF EXISTS `gup_for_am`;
CREATE TABLE IF NOT EXISTS `gup_for_am` (
  `id_gfa` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id_gfa`),
  KEY `fk_gup_for_am_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_gup_for_am_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=478 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_for_nm
DROP TABLE IF EXISTS `gup_for_nm`;
CREATE TABLE IF NOT EXISTS `gup_for_nm` (
  `id_gfn` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id_gfn`),
  KEY `fk_gup_for_nm_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_gup_for_nm_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_gop_manager
DROP TABLE IF EXISTS `gup_gop_manager`;
CREATE TABLE IF NOT EXISTS `gup_gop_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gup_gop_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_gup_gop_manager_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_gup_gop_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_gup_gop_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_scoa_manager
DROP TABLE IF EXISTS `gup_scoa_manager`;
CREATE TABLE IF NOT EXISTS `gup_scoa_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gup_scoa_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_gup_scoa_manager_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  CONSTRAINT `fk_gup_scoa_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_gup_scoa_manager_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_type
DROP TABLE IF EXISTS `gup_type`;
CREATE TABLE IF NOT EXISTS `gup_type` (
  `id_gt` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_gt`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_type_manager
DROP TABLE IF EXISTS `gup_type_manager`;
CREATE TABLE IF NOT EXISTS `gup_type_manager` (
  `id_gtm` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `gup_type_id_gt` int NOT NULL,
  PRIMARY KEY (`id_gtm`),
  KEY `fk_gup_type_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_gup_type_manager_gup_type1_idx` (`gup_type_id_gt`),
  CONSTRAINT `fk_gup_type_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_gup_type_manager_gup_type1` FOREIGN KEY (`gup_type_id_gt`) REFERENCES `gup_type` (`id_gt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16662 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gup_user_banner_info
DROP TABLE IF EXISTS `gup_user_banner_info`;
CREATE TABLE IF NOT EXISTS `gup_user_banner_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_banner_info_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gup_user_banner_info_user_banner_info1_idx` (`user_banner_info_id`),
  KEY `fk_gup_user_banner_info_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_gup_user_banner_info_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_gup_user_banner_info_user_banner_info1` FOREIGN KEY (`user_banner_info_id`) REFERENCES `user_banner_info` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.gurantor_loan_manager
DROP TABLE IF EXISTS `gurantor_loan_manager`;
CREATE TABLE IF NOT EXISTS `gurantor_loan_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_master_id` int NOT NULL,
  `loan_guarntor_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_gurantor_loan_manager_loan_master1_idx` (`loan_master_id`),
  KEY `fk_gurantor_loan_manager_loan_guarntor1_idx` (`loan_guarntor_id`),
  CONSTRAINT `fk_gurantor_loan_manager_loan_guarntor1` FOREIGN KEY (`loan_guarntor_id`) REFERENCES `loan_guarntor` (`id`),
  CONSTRAINT `fk_gurantor_loan_manager_loan_master1` FOREIGN KEY (`loan_master_id`) REFERENCES `loan_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.hall
DROP TABLE IF EXISTS `hall`;
CREATE TABLE IF NOT EXISTS `hall` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `hall_type_id` int NOT NULL,
  `section_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `no_of_students` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hall_hall_type1_idx` (`hall_type_id`),
  KEY `fk_hall_section1_idx` (`section_id`),
  KEY `fk_hall_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_hall_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_hall_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_hall_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_hall_hall_type1` FOREIGN KEY (`hall_type_id`) REFERENCES `hall_type` (`id`),
  CONSTRAINT `fk_hall_section1` FOREIGN KEY (`section_id`) REFERENCES `section` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.halls_in_floor
DROP TABLE IF EXISTS `halls_in_floor`;
CREATE TABLE IF NOT EXISTS `halls_in_floor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `floor_id` int NOT NULL DEFAULT '0',
  `image_url` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.hall_floor_table
DROP TABLE IF EXISTS `hall_floor_table`;
CREATE TABLE IF NOT EXISTS `hall_floor_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_number` varchar(50) NOT NULL DEFAULT '0',
  `capacity` int NOT NULL DEFAULT '0',
  `is_active` tinytext,
  `halls_in_floor_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_hall_table_hall_floor` (`halls_in_floor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.hall_organization_manager
DROP TABLE IF EXISTS `hall_organization_manager`;
CREATE TABLE IF NOT EXISTS `hall_organization_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hall_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hall_organization_manager_hall1_idx` (`hall_id`),
  KEY `fk_hall_organization_manager_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_hall_organization_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_hall_organization_manager_hall1` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.hall_table
DROP TABLE IF EXISTS `hall_table`;
CREATE TABLE IF NOT EXISTS `hall_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_number` varchar(50) NOT NULL DEFAULT '0',
  `capacity` int NOT NULL DEFAULT '0',
  `is_active` tinytext,
  `hall_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_hall_table_hall` (`hall_id`),
  CONSTRAINT `FK_hall_table_hall` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.hall_type
DROP TABLE IF EXISTS `hall_type`;
CREATE TABLE IF NOT EXISTS `hall_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.help_ticket
DROP TABLE IF EXISTS `help_ticket`;
CREATE TABLE IF NOT EXISTS `help_ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `subject` varchar(750) DEFAULT NULL,
  `description` text,
  `doc` varchar(345) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `is_viewed` tinyint(1) DEFAULT NULL,
  `help_ticket_submitted_by_id` int NOT NULL,
  `help_ticket_status_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `help_ticket_type_id` int NOT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_help_ticket_help_ticket_submitted_by1_idx` (`help_ticket_submitted_by_id`),
  KEY `fk_help_ticket_help_ticket_status1_idx` (`help_ticket_status_id`),
  KEY `fk_help_ticket_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_help_ticket_help_ticket_type1_idx` (`help_ticket_type_id`),
  KEY `fk_help_ticket_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_help_ticket_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_help_ticket_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_help_ticket_help_ticket_status1` FOREIGN KEY (`help_ticket_status_id`) REFERENCES `help_ticket_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_help_ticket_help_ticket_submitted_by1` FOREIGN KEY (`help_ticket_submitted_by_id`) REFERENCES `help_ticket_submitted_by` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_help_ticket_help_ticket_type1` FOREIGN KEY (`help_ticket_type_id`) REFERENCES `help_ticket_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1955 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.help_ticket_reply
DROP TABLE IF EXISTS `help_ticket_reply`;
CREATE TABLE IF NOT EXISTS `help_ticket_reply` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `subject` varchar(750) DEFAULT NULL,
  `description` text,
  `comment` text,
  `doc` varchar(145) DEFAULT NULL,
  `ratings` int DEFAULT NULL,
  `is_viewed` tinyint(1) DEFAULT NULL,
  `help_ticket_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_help_ticket_peply_help_ticket1_idx` (`help_ticket_id`),
  KEY `fk_help_ticket_peply_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_help_ticket_peply_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_help_ticket_peply_help_ticket1` FOREIGN KEY (`help_ticket_id`) REFERENCES `help_ticket` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.help_ticket_status
DROP TABLE IF EXISTS `help_ticket_status`;
CREATE TABLE IF NOT EXISTS `help_ticket_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.help_ticket_submitted_by
DROP TABLE IF EXISTS `help_ticket_submitted_by`;
CREATE TABLE IF NOT EXISTS `help_ticket_submitted_by` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1955 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.help_ticket_type
DROP TABLE IF EXISTS `help_ticket_type`;
CREATE TABLE IF NOT EXISTS `help_ticket_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.id_card_issuing
DROP TABLE IF EXISTS `id_card_issuing`;
CREATE TABLE IF NOT EXISTS `id_card_issuing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `issued_date` datetime DEFAULT NULL,
  `issued_by` int DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `issued_by` (`issued_by`) USING BTREE,
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`) USING BTREE,
  CONSTRAINT `id_card_issuing_ibfk_1` FOREIGN KEY (`issued_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `id_card_issuing_ibfk_2` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.iic_document_type
DROP TABLE IF EXISTS `iic_document_type`;
CREATE TABLE IF NOT EXISTS `iic_document_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.image_library
DROP TABLE IF EXISTS `image_library`;
CREATE TABLE IF NOT EXISTS `image_library` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `url` varchar(450) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.inactive_approve
DROP TABLE IF EXISTS `inactive_approve`;
CREATE TABLE IF NOT EXISTS `inactive_approve` (
  `ia_id` int NOT NULL AUTO_INCREMENT,
  `approve_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `voucher_item_inactiveid_vii` int NOT NULL,
  `login_sessionsession_id` int NOT NULL,
  PRIMARY KEY (`ia_id`),
  KEY `FKinactive_a815705` (`voucher_item_inactiveid_vii`),
  KEY `FKinactive_a194333` (`login_sessionsession_id`),
  CONSTRAINT `FKinactive_a194333` FOREIGN KEY (`login_sessionsession_id`) REFERENCES `login_session` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKinactive_a815705` FOREIGN KEY (`voucher_item_inactiveid_vii`) REFERENCES `voucher_item_inactive` (`id_vii`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1995 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.income_level
DROP TABLE IF EXISTS `income_level`;
CREATE TABLE IF NOT EXISTS `income_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.individual_exam_scheduler
DROP TABLE IF EXISTS `individual_exam_scheduler`;
CREATE TABLE IF NOT EXISTS `individual_exam_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_date` date DEFAULT NULL,
  `student_batches_sb_id` int NOT NULL,
  `admission_no` varchar(255) DEFAULT NULL,
  `is_participated` tinyint(1) DEFAULT NULL,
  `generated_date` datetime DEFAULT NULL,
  `general_user_profile_generated_by` int NOT NULL,
  `exam_id` int NOT NULL,
  `paper_downloaded_time` datetime DEFAULT NULL,
  `paper_submitted_time` datetime DEFAULT NULL,
  `corrrect_answers` int DEFAULT NULL,
  `wrong_answers` int DEFAULT NULL,
  `student_exam_result_id` int DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `exam_center_id` int DEFAULT NULL,
  `zoom_link` text,
  `is_repeat` tinyint DEFAULT NULL,
  `location` text,
  `is_trail` tinyint(1) DEFAULT NULL,
  `batch_exam_sheduler_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_individual_exam_scheduler_student_batches1_idx` (`student_batches_sb_id`),
  KEY `fk_individual_exam_scheduler_general_user_profile1_idx` (`general_user_profile_generated_by`),
  KEY `fk_individual_exam_scheduler_exam1_idx` (`exam_id`),
  KEY `fk_individual_exam_scheduler_student_exam_result1_idx` (`student_exam_result_id`),
  KEY `FK_individual_exam_scheduler_exam_center` (`exam_center_id`),
  KEY `FK_individual_exam_scheduler_batch_exam_sheduler` (`batch_exam_sheduler_id`),
  CONSTRAINT `FK_individual_exam_scheduler_batch_exam_sheduler` FOREIGN KEY (`batch_exam_sheduler_id`) REFERENCES `batch_exam_sheduler` (`id`),
  CONSTRAINT `fk_individual_exam_scheduler_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `FK_individual_exam_scheduler_exam_center` FOREIGN KEY (`exam_center_id`) REFERENCES `exam_center` (`id`),
  CONSTRAINT `fk_individual_exam_scheduler_general_user_profile1` FOREIGN KEY (`general_user_profile_generated_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_individual_exam_scheduler_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`),
  CONSTRAINT `fk_individual_exam_scheduler_student_exam_result1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5746 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.industrial_partners
DROP TABLE IF EXISTS `industrial_partners`;
CREATE TABLE IF NOT EXISTS `industrial_partners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logo_url` text,
  `name` varchar(45) DEFAULT NULL,
  `short_name` varchar(45) DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `industrial_partners_type_id` int DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `general_organization_profile_id_gop` (`general_organization_profile_id_gop`) USING BTREE,
  KEY `industrial_partners_type_id` (`industrial_partners_type_id`),
  CONSTRAINT `industrial_partners_ibfk_1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `industrial_partners_ibfk_2` FOREIGN KEY (`industrial_partners_type_id`) REFERENCES `industrial_partners_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.industrial_partners_documents
DROP TABLE IF EXISTS `industrial_partners_documents`;
CREATE TABLE IF NOT EXISTS `industrial_partners_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `industrial_partners_id` int DEFAULT NULL,
  `doc_url` text,
  `is_active` tinyint(1) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `industrial_partners_id` (`industrial_partners_id`) USING BTREE,
  KEY `uploaded_by` (`uploaded_by`) USING BTREE,
  CONSTRAINT `industrial_partners_documents_ibfk_2` FOREIGN KEY (`industrial_partners_id`) REFERENCES `industrial_partners` (`id`),
  CONSTRAINT `industrial_partners_documents_ibfk_3` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.industrial_partners_type
DROP TABLE IF EXISTS `industrial_partners_type`;
CREATE TABLE IF NOT EXISTS `industrial_partners_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.industry
DROP TABLE IF EXISTS `industry`;
CREATE TABLE IF NOT EXISTS `industry` (
  `id_i` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_i`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.installment
DROP TABLE IF EXISTS `installment`;
CREATE TABLE IF NOT EXISTS `installment` (
  `id_ins` int NOT NULL AUTO_INCREMENT,
  `ins_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_ins`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.installment_manager
DROP TABLE IF EXISTS `installment_manager`;
CREATE TABLE IF NOT EXISTS `installment_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `course_fee` double NOT NULL,
  `discount` double DEFAULT NULL,
  `discounted_fee` double DEFAULT NULL,
  `no_of_installment` int DEFAULT NULL,
  `interest_rate` double DEFAULT NULL,
  `total_paid_capital` double DEFAULT NULL COMMENT 'course_fee=350000\ndiscounted_amount=210000\ninstallment_amount = 210000/9\n\ntotal_paid_capital=discounted_amount-total_paid_installment_amount',
  `total_paid_amount` double DEFAULT NULL COMMENT 'paid_capital + interest+penalty',
  `balance` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `voucher_vid` int NOT NULL,
  `member_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_installment_manager_student1_idx` (`student_s_id`),
  KEY `fk_installment_manager_course1_idx` (`course_cid`),
  KEY `fk_installment_manager_voucher1_idx` (`voucher_vid`),
  KEY `fk_installment_manager_member1_idx` (`member_id`),
  CONSTRAINT `fk_installment_manager_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_installment_manager_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_installment_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_installment_manager_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=3065 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.installment_planner
DROP TABLE IF EXISTS `installment_planner`;
CREATE TABLE IF NOT EXISTS `installment_planner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scheduled_date` date DEFAULT NULL,
  `installment` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `delay_payment` double DEFAULT NULL,
  `penalty` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `interest_amount` double DEFAULT NULL,
  `installment_manager_id` int NOT NULL,
  `monthly_installment_principal_amount` double DEFAULT NULL,
  `principal_amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_installment_planner_installment_manager1_idx` (`installment_manager_id`),
  CONSTRAINT `fk_installment_planner_installment_manager1` FOREIGN KEY (`installment_manager_id`) REFERENCES `installment_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7688 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.instalment
DROP TABLE IF EXISTS `instalment`;
CREATE TABLE IF NOT EXISTS `instalment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.intake
DROP TABLE IF EXISTS `intake`;
CREATE TABLE IF NOT EXISTS `intake` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Every month create a new intake \nIt should auto generate 1st of month ',
  `name` varchar(45) DEFAULT NULL COMMENT '2017-March',
  `year_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intake_year1_idx` (`year_id`),
  KEY `fk_intake_course1_idx` (`course_cid`),
  KEY `fk_intake_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_intake_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_intake_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_intake_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3759 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.intake_exam_type
DROP TABLE IF EXISTS `intake_exam_type`;
CREATE TABLE IF NOT EXISTS `intake_exam_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `last_updated_date` datetime DEFAULT NULL,
  `last_updated_by` int DEFAULT NULL,
  `batchesb_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `exam_mode_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `last_updated_by` (`last_updated_by`) USING BTREE,
  KEY `batchesb_id` (`batchesb_id`) USING BTREE,
  KEY `course_cid` (`course_cid`) USING BTREE,
  KEY `exam_mode_id` (`exam_mode_id`) USING BTREE,
  CONSTRAINT `intake_exam_type_ibfk_1` FOREIGN KEY (`last_updated_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `intake_exam_type_ibfk_2` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `intake_exam_type_ibfk_3` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `intake_exam_type_ibfk_4` FOREIGN KEY (`exam_mode_id`) REFERENCES `exam_mode` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33715 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.intake_group
DROP TABLE IF EXISTS `intake_group`;
CREATE TABLE IF NOT EXISTS `intake_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.intake_semeter
DROP TABLE IF EXISTS `intake_semeter`;
CREATE TABLE IF NOT EXISTS `intake_semeter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT NULL COMMENT 'Registered, On going, Completed',
  `intake_id` int NOT NULL,
  `year_semester_id` int NOT NULL,
  `student_years_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intake_semeter_intake1_idx` (`intake_id`),
  KEY `fk_intake_semeter_year_semester1_idx` (`year_semester_id`),
  KEY `fk_intake_semeter_student_years1_idx` (`student_years_id`),
  KEY `fk_intake_semeter_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_intake_semeter_intake1` FOREIGN KEY (`intake_id`) REFERENCES `intake` (`id`),
  CONSTRAINT `fk_intake_semeter_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_intake_semeter_student_years1` FOREIGN KEY (`student_years_id`) REFERENCES `student_years` (`id`),
  CONSTRAINT `fk_intake_semeter_year_semester1` FOREIGN KEY (`year_semester_id`) REFERENCES `year_semester` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.intake_unit_teaching_assessment_plan
DROP TABLE IF EXISTS `intake_unit_teaching_assessment_plan`;
CREATE TABLE IF NOT EXISTS `intake_unit_teaching_assessment_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `teaching_assessment_plan_src` varchar(1000) DEFAULT NULL,
  `lecturer` int DEFAULT NULL,
  `verifier` int DEFAULT NULL,
  `batches_b_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `lecturer_log_src` varchar(1000) DEFAULT NULL,
  `time_table_deviation_src` varchar(1000) DEFAULT NULL,
  `internal_audit_evidences_sampling_report_src` varchar(1000) DEFAULT NULL,
  `unit_initializing_minute` varchar(1000) DEFAULT NULL,
  `unit_finalizing_minute` varchar(1000) DEFAULT NULL,
  `student_malpractise_investigation_src` varchar(1000) DEFAULT NULL,
  `staff_malpractise_investigation_src` varchar(1000) DEFAULT NULL,
  `other_incident_src` varchar(1000) DEFAULT NULL,
  `student_dropout_src` varchar(1000) DEFAULT NULL,
  `unit_initializing_video` varchar(1000) DEFAULT NULL,
  `unit_profile_completion_doc` varchar(1000) DEFAULT NULL,
  `student_profile_completion_doc` varchar(1000) DEFAULT NULL,
  `unit_standardisation_meeting` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_intake_unit_teaching_assessment_plan_general_user_profil_idx` (`lecturer`),
  KEY `fk_intake_unit_teaching_assessment_plan_general_user_profil_idx1` (`verifier`),
  KEY `fk_intake_unit_teaching_assessment_plan_batches1_idx` (`batches_b_id`),
  KEY `fk_intake_unit_teaching_assessment_plan_course1_idx` (`course_cid`),
  CONSTRAINT `fk_intake_unit_teaching_assessment_plan_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_intake_unit_teaching_assessment_plan_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_intake_unit_teaching_assessment_plan_general_user_profile1` FOREIGN KEY (`lecturer`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_intake_unit_teaching_assessment_plan_general_user_profile2` FOREIGN KEY (`verifier`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1197 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interface_menu
DROP TABLE IF EXISTS `interface_menu`;
CREATE TABLE IF NOT EXISTS `interface_menu` (
  `if_id` int NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(255) DEFAULT NULL,
  `icon` varchar(45) DEFAULT NULL,
  `priority` int DEFAULT '0',
  PRIMARY KEY (`if_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interface_sub_menu
DROP TABLE IF EXISTS `interface_sub_menu`;
CREATE TABLE IF NOT EXISTS `interface_sub_menu` (
  `ifs_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ifs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_batches
DROP TABLE IF EXISTS `international_eligible_batches`;
CREATE TABLE IF NOT EXISTS `international_eligible_batches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_id` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_international_eligible_batches_batches` (`batches_id`),
  KEY `FK_international_eligible_batches_general_user_profile` (`added_by`),
  CONSTRAINT `FK_international_eligible_batches_batches` FOREIGN KEY (`batches_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_international_eligible_batches_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_list
DROP TABLE IF EXISTS `international_eligible_list`;
CREATE TABLE IF NOT EXISTS `international_eligible_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `university_id` int DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `international_eligible_status_id` int DEFAULT NULL,
  `academic_yesr` varchar(50) DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_international_eligible_list_general_organization_profile` (`university_id`),
  KEY `FK_international_eligible_list_general_user_profile` (`created_by`),
  KEY `FK_international_eligible_list_international_eligible_status` (`international_eligible_status_id`),
  CONSTRAINT `FK_international_eligible_list_general_organization_profile` FOREIGN KEY (`university_id`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `FK_international_eligible_list_general_user_profile` FOREIGN KEY (`created_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_international_eligible_list_international_eligible_status` FOREIGN KEY (`international_eligible_status_id`) REFERENCES `international_eligible_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_list_students
DROP TABLE IF EXISTS `international_eligible_list_students`;
CREATE TABLE IF NOT EXISTS `international_eligible_list_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `international_eligible_list_id` int DEFAULT NULL,
  `international_eligible_students_id` int DEFAULT NULL,
  `assign_date` datetime DEFAULT NULL,
  `assign_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=892 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_status
DROP TABLE IF EXISTS `international_eligible_status`;
CREATE TABLE IF NOT EXISTS `international_eligible_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_students
DROP TABLE IF EXISTS `international_eligible_students`;
CREATE TABLE IF NOT EXISTS `international_eligible_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `universal_bucket_manager_id` int DEFAULT NULL,
  `general_organization_profile_id` int DEFAULT NULL,
  `is_application_form_available` tinyint DEFAULT NULL,
  `is_ol_cerificate_available` tinyint DEFAULT NULL,
  `is_english_pass` tinyint DEFAULT NULL,
  `is_ielts_available` tinyint DEFAULT NULL,
  `ielts_band` double DEFAULT NULL,
  `id_l4_cerificate_available` tinyint DEFAULT NULL,
  `id_l5_cerificate_available` tinyint DEFAULT NULL,
  `is_nic_front_available` tinyint DEFAULT NULL,
  `is_assigned` tinyint DEFAULT NULL,
  `is_birth_certification_available` tinyint DEFAULT NULL,
  `is_nic_back_available` tinyint DEFAULT NULL,
  `english_grade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__universal_bucket_manager` (`universal_bucket_manager_id`),
  KEY `FK__general_organization_profile` (`general_organization_profile_id`),
  CONSTRAINT `FK__general_organization_profile` FOREIGN KEY (`general_organization_profile_id`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `FK__universal_bucket_manager` FOREIGN KEY (`universal_bucket_manager_id`) REFERENCES `universal_bucket_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=664 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.international_eligible_student_status_manager
DROP TABLE IF EXISTS `international_eligible_student_status_manager`;
CREATE TABLE IF NOT EXISTS `international_eligible_student_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `international_eligible_students_id` int DEFAULT NULL,
  `international_eligible_status_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_iessm_international_eligible_status` (`international_eligible_status_id`),
  KEY `FK_iessm_international_eligible_list_students` (`international_eligible_students_id`),
  CONSTRAINT `FK_iessm_international_eligible_list_students` FOREIGN KEY (`international_eligible_students_id`) REFERENCES `international_eligible_list_students` (`id`),
  CONSTRAINT `FK_iessm_international_eligible_status` FOREIGN KEY (`international_eligible_status_id`) REFERENCES `international_eligible_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interview
DROP TABLE IF EXISTS `interview`;
CREATE TABLE IF NOT EXISTS `interview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interview_appointment
DROP TABLE IF EXISTS `interview_appointment`;
CREATE TABLE IF NOT EXISTS `interview_appointment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `is_attended` tinyint(1) DEFAULT NULL,
  `max_appointment` int DEFAULT NULL,
  `interview_appointment_schedule_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_interview_appointment_interview_appointment_schedule1_idx` (`interview_appointment_schedule_id`),
  KEY `fk_interview_appointment_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_interview_appointment_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_interview_appointment_interview_appointment_schedule1` FOREIGN KEY (`interview_appointment_schedule_id`) REFERENCES `interview_appointment_schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interview_appointment_schedule
DROP TABLE IF EXISTS `interview_appointment_schedule`;
CREATE TABLE IF NOT EXISTS `interview_appointment_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `max_appointment` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interview_status
DROP TABLE IF EXISTS `interview_status`;
CREATE TABLE IF NOT EXISTS `interview_status` (
  `is_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`is_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.interview_type
DROP TABLE IF EXISTS `interview_type`;
CREATE TABLE IF NOT EXISTS `interview_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.iso_gop
DROP TABLE IF EXISTS `iso_gop`;
CREATE TABLE IF NOT EXISTS `iso_gop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_iso_gop_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_iso_gop_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.iso_ul
DROP TABLE IF EXISTS `iso_ul`;
CREATE TABLE IF NOT EXISTS `iso_ul` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_login_login_id` int NOT NULL,
  `is_pending` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_iso_ul_user_login1_idx` (`user_login_login_id`),
  CONSTRAINT `fk_iso_ul_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.item_category
DROP TABLE IF EXISTS `item_category`;
CREATE TABLE IF NOT EXISTS `item_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.item_class
DROP TABLE IF EXISTS `item_class`;
CREATE TABLE IF NOT EXISTS `item_class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.item_coupon
DROP TABLE IF EXISTS `item_coupon`;
CREATE TABLE IF NOT EXISTS `item_coupon` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(45) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `date_from` datetime DEFAULT NULL,
  `date_to` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `org_item_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_item_coupon_org_item1_idx` (`org_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.item_master
DROP TABLE IF EXISTS `item_master`;
CREATE TABLE IF NOT EXISTS `item_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `item_category_id` int NOT NULL,
  `item_type_id` int NOT NULL,
  `item_class_id` int NOT NULL,
  `unit_of_measure_id` int NOT NULL,
  `image` text,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `fk_item_master_item_category1_idx` (`item_category_id`),
  KEY `fk_item_master_item_type1_idx` (`item_type_id`),
  KEY `fk_item_master_item_class1_idx` (`item_class_id`),
  KEY `fk_item_master_unit_of_measure1_idx` (`unit_of_measure_id`),
  CONSTRAINT `fk_item_master_item_category1` FOREIGN KEY (`item_category_id`) REFERENCES `item_category` (`id`),
  CONSTRAINT `fk_item_master_item_class1` FOREIGN KEY (`item_class_id`) REFERENCES `item_class` (`id`),
  CONSTRAINT `fk_item_master_item_type1` FOREIGN KEY (`item_type_id`) REFERENCES `item_type` (`id`),
  CONSTRAINT `fk_item_master_unit_of_measure1` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `unit_of_measure` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.item_type
DROP TABLE IF EXISTS `item_type`;
CREATE TABLE IF NOT EXISTS `item_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.ivr_script
DROP TABLE IF EXISTS `ivr_script`;
CREATE TABLE IF NOT EXISTS `ivr_script` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.languages
DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `language_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`language_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.leads_exam_manager
DROP TABLE IF EXISTS `leads_exam_manager`;
CREATE TABLE IF NOT EXISTS `leads_exam_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketer_call_list_id` int DEFAULT NULL,
  `student_exam_id` int NOT NULL,
  `assigned_date` date DEFAULT NULL,
  `batch_exam_sheduler_id` int DEFAULT NULL,
  `pack_sent` tinyint(1) DEFAULT NULL,
  `pack_sent_informed` tinyint(1) DEFAULT NULL,
  `pack_received_confirmed` tinyint(1) DEFAULT NULL,
  `called_before_two_days` tinyint(1) DEFAULT NULL,
  `called_before_one_day` tinyint(1) DEFAULT NULL,
  `online_registration_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_leads_exam_manager_marketer_call_list1_idx` (`marketer_call_list_id`),
  KEY `fk_leads_exam_manager_student_exam1_idx` (`student_exam_id`),
  KEY `fk_leads_exam_manager_batch_exam_sheduler1_idx` (`batch_exam_sheduler_id`),
  KEY `fk_leads_exam_manager_online_registration1_idx` (`online_registration_id`),
  CONSTRAINT `fk_leads_exam_manager_batch_exam_sheduler1` FOREIGN KEY (`batch_exam_sheduler_id`) REFERENCES `batch_exam_sheduler` (`id`),
  CONSTRAINT `fk_leads_exam_manager_marketer_call_list1` FOREIGN KEY (`marketer_call_list_id`) REFERENCES `marketer_call_list` (`id`),
  CONSTRAINT `fk_leads_exam_manager_online_registration1` FOREIGN KEY (`online_registration_id`) REFERENCES `online_registration` (`id`),
  CONSTRAINT `fk_leads_exam_manager_student_exam1` FOREIGN KEY (`student_exam_id`) REFERENCES `student_exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3561 DEFAULT CHARSET=utf8mb3 COMMENT='Out of the large database some student shows interest to join with the perticular course.So such student is called a ''Lead''.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.leads_student
DROP TABLE IF EXISTS `leads_student`;
CREATE TABLE IF NOT EXISTS `leads_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nic` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `first_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `last_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `phone_no` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `whatsapp_no` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `address_line1` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `address_line2` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `address_line3` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `officer_nic` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `officer_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `seminar_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `seminar_branch` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `seminar_date` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `is_assigned_intake` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=392 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecturer
DROP TABLE IF EXISTS `lecturer`;
CREATE TABLE IF NOT EXISTS `lecturer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `experience` varchar(45) DEFAULT NULL,
  `specialize` varchar(255) DEFAULT NULL,
  `current_work` varchar(255) DEFAULT NULL,
  `biography` text,
  `priority` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lecturer_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_lecturer_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecturer_hourly_rate
DROP TABLE IF EXISTS `lecturer_hourly_rate`;
CREATE TABLE IF NOT EXISTS `lecturer_hourly_rate` (
  `id_lhr` int NOT NULL AUTO_INCREMENT,
  `rete` varchar(45) DEFAULT NULL,
  `designation_level_user_manager_id_dlum` int NOT NULL,
  PRIMARY KEY (`id_lhr`),
  KEY `fk_lecture_payment_rate_designation_level_user_manager1_idx` (`designation_level_user_manager_id_dlum`),
  CONSTRAINT `fk_lecture_payment_rate_designation_level_user_manager1` FOREIGN KEY (`designation_level_user_manager_id_dlum`) REFERENCES `designation_level_user_manager` (`id_dlum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecturer_module_manager
DROP TABLE IF EXISTS `lecturer_module_manager`;
CREATE TABLE IF NOT EXISTS `lecturer_module_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lecturer_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lecturer_modules_lecturer1_idx` (`lecturer_id`),
  KEY `fk_lecturer_modules_course1_idx` (`course_cid`),
  CONSTRAINT `fk_lecturer_modules_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_lecturer_modules_lecturer1` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecturer_performance_survey
DROP TABLE IF EXISTS `lecturer_performance_survey`;
CREATE TABLE IF NOT EXISTS `lecturer_performance_survey` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` double DEFAULT NULL,
  `survey_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `batches_b_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lecturer_performance_survey_survey1_idx` (`survey_id`),
  KEY `fk_lecturer_performance_survey_employees1_idx` (`employees_employee_id`),
  KEY `fk_lecturer_performance_survey_course1_idx` (`course_cid`),
  KEY `fk_lecturer_performance_survey_batches1_idx` (`batches_b_id`),
  KEY `fk_lecturer_performance_survey_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_lecturer_performance_survey_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lecturer_performance_survey_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lecturer_performance_survey_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lecturer_performance_survey_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_lecturer_performance_survey_survey1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2638 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecturer_performance_survey_participants
DROP TABLE IF EXISTS `lecturer_performance_survey_participants`;
CREATE TABLE IF NOT EXISTS `lecturer_performance_survey_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lecturer_performance_survey_id` int NOT NULL,
  `survey_participants_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lecturer_survey_summary_lecturer_performance_survey1_idx` (`lecturer_performance_survey_id`),
  KEY `fk_lecturer_performance_survey_participants_survey_particip_idx` (`survey_participants_id`),
  CONSTRAINT `fk_lecturer_performance_survey_participants_survey_participan1` FOREIGN KEY (`survey_participants_id`) REFERENCES `survey_participants` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_lecturer_survey_summary_lecturer_performance_survey1` FOREIGN KEY (`lecturer_performance_survey_id`) REFERENCES `lecturer_performance_survey` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=163486 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecture_buckets
DROP TABLE IF EXISTS `lecture_buckets`;
CREATE TABLE IF NOT EXISTS `lecture_buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buckect_name` varchar(200) DEFAULT NULL,
  `bucket_content` text,
  `lecture_bucket_type_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `priority` int DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `lecture_bucket_type_id` (`lecture_bucket_type_id`) USING BTREE,
  KEY `course_cid` (`course_cid`) USING BTREE,
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`) USING BTREE,
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `lecture_buckets_ibfk_1` FOREIGN KEY (`lecture_bucket_type_id`) REFERENCES `lecture_bucket_type` (`id`),
  CONSTRAINT `lecture_buckets_ibfk_2` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `lecture_buckets_ibfk_3` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `lecture_buckets_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2224 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecture_bucket_type
DROP TABLE IF EXISTS `lecture_bucket_type`;
CREATE TABLE IF NOT EXISTS `lecture_bucket_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lecture_video
DROP TABLE IF EXISTS `lecture_video`;
CREATE TABLE IF NOT EXISTS `lecture_video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uploaded_by` (`uploaded_by`) USING BTREE,
  CONSTRAINT `lecture_video_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lesson
DROP TABLE IF EXISTS `lesson`;
CREATE TABLE IF NOT EXISTS `lesson` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lessonid` varchar(45) DEFAULT NULL,
  `name` varchar(450) DEFAULT NULL,
  `content` text,
  `theory_lectures` double DEFAULT NULL,
  `practical_lectures` double DEFAULT NULL,
  `practical` double DEFAULT NULL,
  `tutorials` double DEFAULT NULL,
  `total_contact_hours` double DEFAULT NULL,
  `total_hours` double DEFAULT NULL,
  `course_module_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lesson_course_module1_idx` (`course_module_id`),
  CONSTRAINT `fk_lesson_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=613 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lesson_content
DROP TABLE IF EXISTS `lesson_content`;
CREATE TABLE IF NOT EXISTS `lesson_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `contents_id` int NOT NULL,
  `lesson_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lesson_content_contents1_idx` (`contents_id`),
  KEY `fk_lesson_content_lesson1_idx` (`lesson_id`),
  CONSTRAINT `fk_lesson_content_contents1` FOREIGN KEY (`contents_id`) REFERENCES `contents` (`id`),
  CONSTRAINT `fk_lesson_content_lesson1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lesson_teaching_assessments
DROP TABLE IF EXISTS `lesson_teaching_assessments`;
CREATE TABLE IF NOT EXISTS `lesson_teaching_assessments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lesson_teaching_assessment_plan_id` int NOT NULL,
  `assesment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lesson_teaching_assessments_lesson_teaching_assessment_p_idx` (`lesson_teaching_assessment_plan_id`),
  KEY `fk_lesson_teaching_assessments_assesment1_idx` (`assesment_id`),
  CONSTRAINT `fk_lesson_teaching_assessments_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_lesson_teaching_assessments_lesson_teaching_assessment_plan1` FOREIGN KEY (`lesson_teaching_assessment_plan_id`) REFERENCES `lesson_teaching_assessment_plan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lesson_teaching_assessment_plan
DROP TABLE IF EXISTS `lesson_teaching_assessment_plan`;
CREATE TABLE IF NOT EXISTS `lesson_teaching_assessment_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesment_id` int DEFAULT NULL,
  `lesson_id` int NOT NULL,
  `lesson_teaching_assessment_plan_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_teaching_assessment_plan_assesment1_idx` (`assesment_id`),
  KEY `fk_module_teaching_assessment_plan_lesson1_idx` (`lesson_id`),
  KEY `fk_lesson_teaching_assessment_plan_lesson_teaching_assessme_idx` (`lesson_teaching_assessment_plan_type_id`),
  CONSTRAINT `fk_lesson_teaching_assessment_plan_lesson_teaching_assessment1` FOREIGN KEY (`lesson_teaching_assessment_plan_type_id`) REFERENCES `lesson_teaching_assessment_plan_type` (`id`),
  CONSTRAINT `fk_module_teaching_assessment_plan_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_module_teaching_assessment_plan_lesson1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=599 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lesson_teaching_assessment_plan_type
DROP TABLE IF EXISTS `lesson_teaching_assessment_plan_type`;
CREATE TABLE IF NOT EXISTS `lesson_teaching_assessment_plan_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.letter_manager
DROP TABLE IF EXISTS `letter_manager`;
CREATE TABLE IF NOT EXISTS `letter_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `url` text,
  `day_count` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  CONSTRAINT `letter_manager_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.levels
DROP TABLE IF EXISTS `levels`;
CREATE TABLE IF NOT EXISTS `levels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `levelid` varchar(100) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.levels_manager
DROP TABLE IF EXISTS `levels_manager`;
CREATE TABLE IF NOT EXISTS `levels_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `levels_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_levels_manager_levels1_idx` (`levels_id`),
  KEY `fk_levels_manager_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_levels_manager_levels1` FOREIGN KEY (`levels_id`) REFERENCES `levels` (`id`),
  CONSTRAINT `fk_levels_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.lien_type
DROP TABLE IF EXISTS `lien_type`;
CREATE TABLE IF NOT EXISTS `lien_type` (
  `lt_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`lt_id`),
  KEY `idx_lien_type_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.livinghistory
DROP TABLE IF EXISTS `livinghistory`;
CREATE TABLE IF NOT EXISTS `livinghistory` (
  `id_lh` int NOT NULL AUTO_INCREMENT,
  `city_id_c` int NOT NULL,
  PRIMARY KEY (`id_lh`),
  KEY `fk_livinghistory_city1_idx` (`city_id_c`),
  CONSTRAINT `fk_livinghistory_city1` FOREIGN KEY (`city_id_c`) REFERENCES `city` (`id_c`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan
DROP TABLE IF EXISTS `loan`;
CREATE TABLE IF NOT EXISTS `loan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `description` text,
  `loan_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_loan_type1_idx` (`loan_type_id`),
  CONSTRAINT `fk_loan_loan_type1` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_approval
DROP TABLE IF EXISTS `loan_approval`;
CREATE TABLE IF NOT EXISTS `loan_approval` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `description` text,
  `loan_master_id` int NOT NULL,
  `loan_approval_type_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_approval_loan_master1_idx` (`loan_master_id`),
  KEY `fk_loan_approval_loan_approval_type1_idx` (`loan_approval_type_id`),
  KEY `fk_loan_approval_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_loan_approval_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_loan_approval_loan_approval_type1` FOREIGN KEY (`loan_approval_type_id`) REFERENCES `loan_approval_type` (`id`),
  CONSTRAINT `fk_loan_approval_loan_master1` FOREIGN KEY (`loan_master_id`) REFERENCES `loan_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_approval_type
DROP TABLE IF EXISTS `loan_approval_type`;
CREATE TABLE IF NOT EXISTS `loan_approval_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_document_request
DROP TABLE IF EXISTS `loan_document_request`;
CREATE TABLE IF NOT EXISTS `loan_document_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `bank_b_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_document_request_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_loan_document_request_bank1_idx` (`bank_b_id`),
  KEY `fk_loan_document_request_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_loan_document_request_bank1` FOREIGN KEY (`bank_b_id`) REFERENCES `bank` (`b_id`),
  CONSTRAINT `fk_loan_document_request_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_loan_document_request_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_guarntor
DROP TABLE IF EXISTS `loan_guarntor`;
CREATE TABLE IF NOT EXISTS `loan_guarntor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guarntor_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_guarntor_guarntor_type1_idx` (`guarntor_type_id`),
  KEY `fk_loan_guarntor_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_loan_guarntor_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_loan_guarntor_guarntor_type1` FOREIGN KEY (`guarntor_type_id`) REFERENCES `guarntor_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_installment
DROP TABLE IF EXISTS `loan_installment`;
CREATE TABLE IF NOT EXISTS `loan_installment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `interest` double DEFAULT NULL,
  `is_paid` int DEFAULT NULL,
  `loan_master_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_installment_loan_master1_idx` (`loan_master_id`),
  CONSTRAINT `fk_loan_installment_loan_master1` FOREIGN KEY (`loan_master_id`) REFERENCES `loan_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_master
DROP TABLE IF EXISTS `loan_master`;
CREATE TABLE IF NOT EXISTS `loan_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `loan_id` varchar(45) DEFAULT NULL,
  `reference` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `total_paid_capital` double DEFAULT NULL,
  `total_paid_interest` double DEFAULT NULL,
  `loan_interest_rate` double DEFAULT NULL,
  `due` double DEFAULT NULL,
  `requested_date` date DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `completed_date` date DEFAULT NULL,
  `duration` double DEFAULT NULL,
  `purpose` text,
  `loan_type_id` int NOT NULL,
  `loan_status_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `universal_person_or_org_type_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_master_loan_type1_idx` (`loan_type_id`),
  KEY `fk_loan_master_loan_status1_idx` (`loan_status_id`),
  KEY `fk_loan_master_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_loan_master_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_loan_master_universal_person_or_org_type_manager1_idx` (`universal_person_or_org_type_manager_id`),
  CONSTRAINT `fk_loan_master_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_loan_master_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_loan_master_loan_status1` FOREIGN KEY (`loan_status_id`) REFERENCES `loan_status` (`id`),
  CONSTRAINT `fk_loan_master_loan_type1` FOREIGN KEY (`loan_type_id`) REFERENCES `loan_type` (`id`),
  CONSTRAINT `fk_loan_master_universal_person_or_org_type_manager1` FOREIGN KEY (`universal_person_or_org_type_manager_id`) REFERENCES `universal_person_or_org_type_manager` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_plan
DROP TABLE IF EXISTS `loan_plan`;
CREATE TABLE IF NOT EXISTS `loan_plan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `discount_percentage` double DEFAULT NULL,
  `min_interest_rate` double DEFAULT NULL,
  `min_monthly_installment` double DEFAULT NULL,
  `max_interest_rate` double DEFAULT NULL,
  `max_monthly_installment` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_quotation
DROP TABLE IF EXISTS `loan_quotation`;
CREATE TABLE IF NOT EXISTS `loan_quotation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `interest_rate` double DEFAULT NULL,
  `monthly_installment` double DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `payable_amount` double DEFAULT NULL,
  `course_fee` double DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `member_loan_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_loan_quotation_member_loan1_idx` (`member_loan_id`),
  CONSTRAINT `fk_loan_quotation_member_loan1` FOREIGN KEY (`member_loan_id`) REFERENCES `member_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_status
DROP TABLE IF EXISTS `loan_status`;
CREATE TABLE IF NOT EXISTS `loan_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.loan_type
DROP TABLE IF EXISTS `loan_type`;
CREATE TABLE IF NOT EXISTS `loan_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.login_session
DROP TABLE IF EXISTS `login_session`;
CREATE TABLE IF NOT EXISTS `login_session` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(255) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `user_loginlogin_id` int NOT NULL,
  `branchbid` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `user_login_group_id` int DEFAULT NULL,
  PRIMARY KEY (`session_id`),
  KEY `FKlogin_sess13153` (`user_loginlogin_id`),
  KEY `FKlogin_sess212888` (`branchbid`),
  KEY `fk_login_session_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_login_session_user_login_group1_idx` (`user_login_group_id`),
  CONSTRAINT `fk_login_session_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_login_session_user_login_group1` FOREIGN KEY (`user_login_group_id`) REFERENCES `user_login_group` (`id`),
  CONSTRAINT `FKlogin_sess212888` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12761645 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.mail_category
DROP TABLE IF EXISTS `mail_category`;
CREATE TABLE IF NOT EXISTS `mail_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.main_chart_of_account
DROP TABLE IF EXISTS `main_chart_of_account`;
CREATE TABLE IF NOT EXISTS `main_chart_of_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `account_type_a_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_main_chart_of_account_account_type1_idx` (`account_type_a_id`),
  CONSTRAINT `fk_main_chart_of_account_account_type1` FOREIGN KEY (`account_type_a_id`) REFERENCES `account_type` (`a_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.major_sequence
DROP TABLE IF EXISTS `major_sequence`;
CREATE TABLE IF NOT EXISTS `major_sequence` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_major_sequence_course1_idx` (`course_cid`),
  CONSTRAINT `fk_major_sequence_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.manager_approved_penalty
DROP TABLE IF EXISTS `manager_approved_penalty`;
CREATE TABLE IF NOT EXISTS `manager_approved_penalty` (
  `id` int(11) unsigned zerofill NOT NULL,
  `date` datetime DEFAULT NULL,
  `penaty_amount` double DEFAULT NULL,
  `approved_amount` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `employees_employee_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_manager_approved_penalty_employees1_idx` (`employees_employee_id`),
  KEY `fk_manager_approved_penalty_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_manager_approved_penalty_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_manager_approved_penalty_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_child_numbers
DROP TABLE IF EXISTS `markating_child_numbers`;
CREATE TABLE IF NOT EXISTS `markating_child_numbers` (
  `LogId` int NOT NULL AUTO_INCREMENT,
  `Student_Id` int DEFAULT NULL,
  `Student_MarkaterLogId` int unsigned NOT NULL,
  `State` tinyint DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `SideLogId` int NOT NULL,
  `Id_First_Reg` int NOT NULL,
  PRIMARY KEY (`LogId`),
  KEY `FKmarkating_425726` (`Student_Id`),
  KEY `FKmarkating_925429` (`Student_MarkaterLogId`),
  KEY `FKmarkating_428896` (`SideLogId`),
  KEY `FKmarkating_824157` (`Id_First_Reg`),
  KEY `FKmarkating_673159` (`Id_First_Reg`),
  KEY `FKmarkating_925430` (`Student_MarkaterLogId`),
  CONSTRAINT `FKmarkating_425726` FOREIGN KEY (`Student_Id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKmarkating_428896` FOREIGN KEY (`SideLogId`) REFERENCES `markating_side` (`LogId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKmarkating_673159` FOREIGN KEY (`Id_First_Reg`) REFERENCES `student_batches` (`sb_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKmarkating_925429` FOREIGN KEY (`Student_MarkaterLogId`) REFERENCES `marketing_student_markter` (`Log_Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_flush_conditions
DROP TABLE IF EXISTS `markating_flush_conditions`;
CREATE TABLE IF NOT EXISTS `markating_flush_conditions` (
  `IdMFC` int unsigned NOT NULL AUTO_INCREMENT,
  `ConditionName` varchar(45) NOT NULL,
  `ConditionParm` varchar(45) NOT NULL,
  `ConditionDesc` varchar(255) NOT NULL,
  PRIMARY KEY (`IdMFC`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_intraduced_batch
DROP TABLE IF EXISTS `markating_intraduced_batch`;
CREATE TABLE IF NOT EXISTS `markating_intraduced_batch` (
  `ID_MIB` int NOT NULL AUTO_INCREMENT,
  `Intraduced_Rec_ID` int NOT NULL,
  `student_batchessb_id` int NOT NULL,
  PRIMARY KEY (`ID_MIB`),
  KEY `FKmarkating_953521` (`Intraduced_Rec_ID`),
  KEY `FKmarkating_528683` (`student_batchessb_id`),
  CONSTRAINT `FKmarkating_528683` FOREIGN KEY (`student_batchessb_id`) REFERENCES `student_batches` (`sb_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKmarkating_953521` FOREIGN KEY (`Intraduced_Rec_ID`) REFERENCES `markating_introducer` (`LogId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_introducer
DROP TABLE IF EXISTS `markating_introducer`;
CREATE TABLE IF NOT EXISTS `markating_introducer` (
  `LogId` int NOT NULL AUTO_INCREMENT,
  `Child_Student` int NOT NULL,
  `Stud_Marketer_Id` int unsigned NOT NULL,
  `state` tinyint DEFAULT NULL,
  PRIMARY KEY (`LogId`),
  KEY `FKMarkating_134883` (`Stud_Marketer_Id`),
  KEY `FKMarkating_28875` (`Child_Student`),
  CONSTRAINT `FKMarkating_134883` FOREIGN KEY (`Stud_Marketer_Id`) REFERENCES `marketing_student_markter` (`Log_Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKMarkating_28875` FOREIGN KEY (`Child_Student`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_parent_data
DROP TABLE IF EXISTS `markating_parent_data`;
CREATE TABLE IF NOT EXISTS `markating_parent_data` (
  `LogId` int unsigned NOT NULL AUTO_INCREMENT,
  `Stud_Marketer_Id` int unsigned NOT NULL,
  `Student_Parent_Id` int unsigned NOT NULL,
  PRIMARY KEY (`LogId`),
  KEY `FK_Markating_Parent_Data_1` (`Stud_Marketer_Id`),
  KEY `FK_Markating_Parent_Data_2` (`Student_Parent_Id`),
  KEY `FKmarkating_884029` (`Stud_Marketer_Id`),
  KEY `FKmarkating_991091` (`Student_Parent_Id`),
  CONSTRAINT `FK_Markating_Parent_Data_1` FOREIGN KEY (`Stud_Marketer_Id`) REFERENCES `marketing_student_markter` (`Log_Id`),
  CONSTRAINT `FK_Markating_Parent_Data_2` FOREIGN KEY (`Student_Parent_Id`) REFERENCES `markating_parent_data` (`LogId`),
  CONSTRAINT `FKmarkating_884029` FOREIGN KEY (`Stud_Marketer_Id`) REFERENCES `marketing_student_markter` (`Log_Id`),
  CONSTRAINT `FKmarkating_991091` FOREIGN KEY (`Student_Parent_Id`) REFERENCES `markating_parent_data` (`LogId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.markating_side
DROP TABLE IF EXISTS `markating_side`;
CREATE TABLE IF NOT EXISTS `markating_side` (
  `LogId` int NOT NULL AUTO_INCREMENT,
  `Directions` varchar(255) NOT NULL,
  `State` tinyint DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`LogId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketer_call_list
DROP TABLE IF EXISTS `marketer_call_list`;
CREATE TABLE IF NOT EXISTS `marketer_call_list` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assign_date` date DEFAULT NULL,
  `is_acheived` tinyint(1) DEFAULT NULL,
  `seminar_id` int DEFAULT NULL,
  `employees_employee_id` int NOT NULL,
  `data_receiving_source_manager_id` int NOT NULL,
  `org_employee_id` int DEFAULT NULL,
  `acheived_date` date DEFAULT NULL,
  `is_removed` tinyint(1) DEFAULT NULL,
  `not_interested` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_MarketerTargets_seminar1_idx` (`seminar_id`),
  KEY `fk_marketer_targets_employees1_idx` (`employees_employee_id`),
  KEY `fk_marketer_targets_data_receiving_source_manager1_idx` (`data_receiving_source_manager_id`),
  KEY `fk_marketer_call_list_org_employee1_idx` (`org_employee_id`),
  CONSTRAINT `fk_marketer_call_list_org_employee1` FOREIGN KEY (`org_employee_id`) REFERENCES `org_employee` (`id`),
  CONSTRAINT `fk_marketer_targets_data_receiving_source_manager1` FOREIGN KEY (`data_receiving_source_manager_id`) REFERENCES `data_receiving_source_manager` (`id`),
  CONSTRAINT `fk_marketer_targets_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_MarketerTargets_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=929 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketer_call_list_calling_history
DROP TABLE IF EXISTS `marketer_call_list_calling_history`;
CREATE TABLE IF NOT EXISTS `marketer_call_list_calling_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketer_call_list_id` int NOT NULL,
  `calling_history_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marketer_call_list_calling_history_marketer_call_list1_idx` (`marketer_call_list_id`),
  KEY `fk_marketer_call_list_calling_history_calling_history1_idx` (`calling_history_id`),
  CONSTRAINT `fk_marketer_call_list_calling_history_calling_history1` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `fk_marketer_call_list_calling_history_marketer_call_list1` FOREIGN KEY (`marketer_call_list_id`) REFERENCES `marketer_call_list` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketer_leads
DROP TABLE IF EXISTS `marketer_leads`;
CREATE TABLE IF NOT EXISTS `marketer_leads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employees_employee_id` int NOT NULL,
  `entered_date` date DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `comment` text,
  `general_organization_profile_origin` int DEFAULT NULL,
  `student_batches_sb_id` int DEFAULT NULL,
  `verified` int DEFAULT NULL,
  `verified_date` date DEFAULT NULL,
  `transfered_to_bin` int DEFAULT NULL,
  `total_marks` double DEFAULT NULL,
  `scholarship` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marketer_leads_employees1_idx` (`employees_employee_id`),
  KEY `fk_marketer_leads_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_marketer_leads_general_organization_profile1_idx` (`general_organization_profile_origin`),
  KEY `fk_marketer_leads_student_batches1_idx` (`student_batches_sb_id`),
  CONSTRAINT `fk_marketer_leads_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_marketer_leads_general_organization_profile1` FOREIGN KEY (`general_organization_profile_origin`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_marketer_leads_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_marketer_leads_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48260 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketer_lead_update_log
DROP TABLE IF EXISTS `marketer_lead_update_log`;
CREATE TABLE IF NOT EXISTS `marketer_lead_update_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marketer_leads_id` int NOT NULL,
  `general_user_profile_updated_by` int NOT NULL,
  `name_exist` varchar(500) DEFAULT NULL,
  `name_new` varchar(500) DEFAULT NULL,
  `mobile_exist` varchar(45) DEFAULT NULL,
  `mobile_new` varchar(45) DEFAULT NULL,
  `email_exist` varchar(50) DEFAULT NULL,
  `email_new` varchar(50) DEFAULT NULL,
  `address_exist` varchar(300) DEFAULT NULL,
  `address_new` varchar(300) DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marketer_lead_update_log_marketer_leads1_idx` (`marketer_leads_id`),
  KEY `fk_marketer_lead_update_log_general_user_profile1_idx` (`general_user_profile_updated_by`),
  CONSTRAINT `fk_marketer_lead_update_log_general_user_profile1` FOREIGN KEY (`general_user_profile_updated_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_marketer_lead_update_log_marketer_leads1` FOREIGN KEY (`marketer_leads_id`) REFERENCES `marketer_leads` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9592 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketingbinarytreetransactions
DROP TABLE IF EXISTS `marketingbinarytreetransactions`;
CREATE TABLE IF NOT EXISTS `marketingbinarytreetransactions` (
  `IDMBTT` int unsigned NOT NULL AUTO_INCREMENT,
  `AuthorizedBy` int unsigned NOT NULL,
  `State` tinyint unsigned NOT NULL,
  `PaymentValue` double NOT NULL,
  `TransDate` date NOT NULL,
  `PaidTo` int NOT NULL,
  PRIMARY KEY (`IDMBTT`),
  KEY `FKmarketingb824810` (`PaidTo`),
  CONSTRAINT `FKmarketingb824810` FOREIGN KEY (`PaidTo`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketing_marketer_child_numbers
DROP TABLE IF EXISTS `marketing_marketer_child_numbers`;
CREATE TABLE IF NOT EXISTS `marketing_marketer_child_numbers` (
  `LogId` int unsigned NOT NULL AUTO_INCREMENT,
  `Student_Market_Child_Numbers` int unsigned NOT NULL,
  `Child_No_Log_Id` int NOT NULL,
  PRIMARY KEY (`LogId`),
  KEY `FKmarketing_592510` (`Student_Market_Child_Numbers`),
  KEY `FKmarketing_435575` (`Child_No_Log_Id`),
  CONSTRAINT `FK_Marketing_Marketer_Child_Numbers_1` FOREIGN KEY (`Child_No_Log_Id`) REFERENCES `markating_child_numbers` (`LogId`),
  CONSTRAINT `FKmarketing_592510` FOREIGN KEY (`Student_Market_Child_Numbers`) REFERENCES `marketing_student_markter` (`Log_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marketing_student_markter
DROP TABLE IF EXISTS `marketing_student_markter`;
CREATE TABLE IF NOT EXISTS `marketing_student_markter` (
  `Log_Id` int unsigned NOT NULL AUTO_INCREMENT,
  `state` tinyint unsigned NOT NULL,
  `Registered_Stud_Id` int NOT NULL,
  `Sys_Date` datetime NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`Log_Id`),
  KEY `FKmarketing_62621` (`Registered_Stud_Id`),
  CONSTRAINT `FKmarketing_62621` FOREIGN KEY (`Registered_Stud_Id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.marking_feedback_components
DROP TABLE IF EXISTS `marking_feedback_components`;
CREATE TABLE IF NOT EXISTS `marking_feedback_components` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  `marking_feedback_component_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_marking_feedback_components_marking_feedback_component_t_idx` (`marking_feedback_component_type_id`),
  CONSTRAINT `fk_marking_feedback_components_marking_feedback_component_type1` FOREIGN KEY (`marking_feedback_component_type_id`) REFERENCES `component_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.martial_status
DROP TABLE IF EXISTS `martial_status`;
CREATE TABLE IF NOT EXISTS `martial_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_batch_group_student_academic_data
DROP TABLE IF EXISTS `materialized_batch_group_student_academic_data`;
CREATE TABLE IF NOT EXISTS `materialized_batch_group_student_academic_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `last_attendanced_time` datetime DEFAULT NULL,
  `batches_id` int DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `batch_group_id` int DEFAULT NULL,
  `batch_group_name` varchar(50) DEFAULT NULL,
  `student_branch_id` int DEFAULT NULL,
  `student_branch` varchar(50) DEFAULT NULL,
  `is_paid` tinyint DEFAULT NULL,
  `total_paid` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_kpi_system/materialized_batch_group_student_academic_data';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_present_student
DROP TABLE IF EXISTS `materialized_present_student`;
CREATE TABLE IF NOT EXISTS `materialized_present_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `branch_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196606 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_registered_student_academic_data
DROP TABLE IF EXISTS `materialized_registered_student_academic_data`;
CREATE TABLE IF NOT EXISTS `materialized_registered_student_academic_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `registered_date` date DEFAULT NULL,
  `relevant_year` int DEFAULT NULL,
  `last_attendanced_time` datetime DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `student_branch_id` int DEFAULT NULL,
  `student_branch` varchar(50) DEFAULT NULL,
  `batches_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_kpi_system/materialized_registered_student_academic_data';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_academic_year
DROP TABLE IF EXISTS `materialized_student_academic_year`;
CREATE TABLE IF NOT EXISTS `materialized_student_academic_year` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `academic_year` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4096 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_assessment_monitoring
DROP TABLE IF EXISTS `materialized_student_assessment_monitoring`;
CREATE TABLE IF NOT EXISTS `materialized_student_assessment_monitoring` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_sid` int DEFAULT NULL,
  `batches_bid` int DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `assessment_id` int DEFAULT NULL,
  `assessment` varchar(255) DEFAULT NULL,
  `assessment_date` date DEFAULT NULL,
  `is_marks_entered` tinyint(1) DEFAULT '0',
  `marks_entered_date` date DEFAULT NULL,
  `is_marks_released` tinyint(1) DEFAULT '0',
  `marks_released_date` date DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32201 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_current_due_table
DROP TABLE IF EXISTS `materialized_student_current_due_table`;
CREATE TABLE IF NOT EXISTS `materialized_student_current_due_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(45) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `scholarship` double DEFAULT NULL,
  `total_due` double DEFAULT NULL,
  `current_due` double DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `verification_token` varchar(100) DEFAULT NULL,
  `branch_name` varchar(45) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '0',
  `expired_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4842 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_exam_monitoring
DROP TABLE IF EXISTS `materialized_student_exam_monitoring`;
CREATE TABLE IF NOT EXISTS `materialized_student_exam_monitoring` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_sid` int DEFAULT NULL,
  `batches_bid` int DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `exam` varchar(255) DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `is_marks_entered` tinyint(1) DEFAULT '0',
  `marks_entered_date` date DEFAULT NULL,
  `is_marks_released` tinyint(1) DEFAULT '0',
  `marks_released_date` date DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25942 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_invoices
DROP TABLE IF EXISTS `materialized_student_invoices`;
CREATE TABLE IF NOT EXISTS `materialized_student_invoices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `voucher_id` varchar(255) DEFAULT NULL,
  `system_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_year` int DEFAULT NULL,
  `invoice_age` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `voucher_type_id` int DEFAULT NULL,
  `voucher_type` varchar(45) DEFAULT NULL,
  `voucher_item_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`voucher_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_kpi_system/materialized_student_invoices';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_last_attendance_data
DROP TABLE IF EXISTS `materialized_student_last_attendance_data`;
CREATE TABLE IF NOT EXISTS `materialized_student_last_attendance_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `last_attendanced_time` datetime DEFAULT NULL,
  `batches_id` int DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7076 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_loan_eligible_student_table
DROP TABLE IF EXISTS `materialized_student_loan_eligible_student_table`;
CREATE TABLE IF NOT EXISTS `materialized_student_loan_eligible_student_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `nic` varchar(45) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `name_with_initials` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `address_line1` varchar(255) DEFAULT NULL,
  `address_line2` varchar(255) DEFAULT NULL,
  `address_line3` varchar(255) DEFAULT NULL,
  `scholarship` double DEFAULT NULL,
  `total_due` double DEFAULT NULL,
  `gender_type` varchar(45) DEFAULT NULL,
  `verification_token` varchar(100) DEFAULT NULL,
  `branch_name` varchar(45) DEFAULT NULL,
  `intake_id` int DEFAULT NULL,
  `intake_name` varchar(255) DEFAULT NULL,
  `profile_create_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:B#8bx251o@86.48.6.131:3306/temco_system/materialized_student_loan_eligible_student_table';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_payment_summary_table
DROP TABLE IF EXISTS `materialized_student_payment_summary_table`;
CREATE TABLE IF NOT EXISTS `materialized_student_payment_summary_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `batch_identifiers` varchar(255) DEFAULT NULL,
  `batch_title` varchar(255) DEFAULT NULL,
  `scholarship` int DEFAULT NULL,
  `paid_amount` decimal(10,2) DEFAULT NULL,
  `due_amount` decimal(10,2) DEFAULT NULL,
  `branch_name` varchar(255) DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_finance_system/materialized_student_payment_summary_table';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_student_research_assessment_monitoring
DROP TABLE IF EXISTS `materialized_student_research_assessment_monitoring`;
CREATE TABLE IF NOT EXISTS `materialized_student_research_assessment_monitoring` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_sid` int DEFAULT NULL,
  `batches_bid` int DEFAULT NULL,
  `student_batches` varchar(255) DEFAULT NULL,
  `nic` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `research_assessment_id` int DEFAULT NULL,
  `research_assessment` varchar(255) DEFAULT NULL,
  `research_assessment_date` date DEFAULT NULL,
  `is_marks_entered` tinyint(1) DEFAULT '0',
  `marks_entered_date` date DEFAULT NULL,
  `is_marks_released` tinyint(1) DEFAULT '0',
  `marks_released_date` date DEFAULT NULL,
  `last_update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37696 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_time_table_details
DROP TABLE IF EXISTS `materialized_time_table_details`;
CREATE TABLE IF NOT EXISTS `materialized_time_table_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `lecture_buckets_id` int DEFAULT NULL,
  `lecture_buckets_name` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `s_time` time DEFAULT NULL,
  `e_time` time DEFAULT NULL,
  `zoom_link` text,
  `is_sms_sent` tinyint(1) DEFAULT NULL,
  `intake_id` int DEFAULT NULL,
  `intake_identifiers` varchar(255) DEFAULT NULL,
  `intake_title` varchar(45) DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `branch_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user` (`time_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73646 DEFAULT CHARSET=utf8mb3 CONNECTION='mysql://exon_tranfer:3x0Z#pAs5MoRd@217.76.55.101:3306/ijts_communication/materialized_time_table_details';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.materialized_view_un_payment_manager_vs_calling_history
DROP TABLE IF EXISTS `materialized_view_un_payment_manager_vs_calling_history`;
CREATE TABLE IF NOT EXISTS `materialized_view_un_payment_manager_vs_calling_history` (
  `upm_id` int NOT NULL DEFAULT '0',
  `general_user_profile_gup_id` int NOT NULL,
  `paid_amount` double DEFAULT NULL,
  `scholarship_released_date` date DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  `ch_id` int NOT NULL DEFAULT '0',
  `calling_purpose_id` int NOT NULL,
  `call_to` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.meeting_participants
DROP TABLE IF EXISTS `meeting_participants`;
CREATE TABLE IF NOT EXISTS `meeting_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `minutes_and_reviews_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meeting_participants_minutes_and_reviews1_idx` (`minutes_and_reviews_id`),
  KEY `fk_meeting_participants_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_meeting_participants_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_meeting_participants_minutes_and_reviews1` FOREIGN KEY (`minutes_and_reviews_id`) REFERENCES `minutes_and_reviews` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member
DROP TABLE IF EXISTS `member`;
CREATE TABLE IF NOT EXISTS `member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `member_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_member_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_member_member_type1_idx` (`member_type_id`),
  CONSTRAINT `fk_member_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_member_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_member_member_type1` FOREIGN KEY (`member_type_id`) REFERENCES `member_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_accounts
DROP TABLE IF EXISTS `member_accounts`;
CREATE TABLE IF NOT EXISTS `member_accounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_no` varchar(45) DEFAULT NULL,
  `member_id` int NOT NULL,
  `products_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_accounts_member1_idx` (`member_id`),
  KEY `fk_member_accounts_products1_idx` (`products_id`),
  KEY `fk_member_accounts_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_member_accounts_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_member_accounts_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_accounts_products1` FOREIGN KEY (`products_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_account_scoa_manager
DROP TABLE IF EXISTS `member_account_scoa_manager`;
CREATE TABLE IF NOT EXISTS `member_account_scoa_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `member_accounts_id` int NOT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_account_scoa_manager_member_accounts1_idx` (`member_accounts_id`),
  KEY `fk_member_account_scoa_manager_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  CONSTRAINT `fk_member_account_scoa_manager_member_accounts1` FOREIGN KEY (`member_accounts_id`) REFERENCES `member_accounts` (`id`),
  CONSTRAINT `fk_member_account_scoa_manager_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_loan
DROP TABLE IF EXISTS `member_loan`;
CREATE TABLE IF NOT EXISTS `member_loan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `loan_id` int NOT NULL,
  `granted_date` date DEFAULT NULL,
  `loan_status_id` int NOT NULL,
  `member_accounts_id` int DEFAULT NULL,
  `loan_amount` double DEFAULT NULL,
  `current_balance` double DEFAULT NULL,
  `total_paid_interest` double DEFAULT NULL,
  `total_arrears` double DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `requested_loan_ammount` double DEFAULT NULL,
  `down_payment` double DEFAULT NULL,
  `down_payment_paid_amount` double DEFAULT NULL,
  `down_payment_due` double DEFAULT NULL,
  `is_document_submitted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_loan_member1_idx` (`member_id`),
  KEY `fk_member_loan_loan1_idx` (`loan_id`),
  KEY `fk_member_loan_loan_status1_idx` (`loan_status_id`),
  KEY `fk_member_loan_member_accounts1_idx` (`member_accounts_id`),
  KEY `fk_member_loan_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_member_loan_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_member_loan_loan1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`id`),
  CONSTRAINT `fk_member_loan_loan_status1` FOREIGN KEY (`loan_status_id`) REFERENCES `loan_status` (`id`),
  CONSTRAINT `fk_member_loan_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_loan_member_accounts1` FOREIGN KEY (`member_accounts_id`) REFERENCES `member_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_loan_status_history
DROP TABLE IF EXISTS `member_loan_status_history`;
CREATE TABLE IF NOT EXISTS `member_loan_status_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_changed_date` date DEFAULT NULL,
  `member_loan_id` int NOT NULL,
  `status_change_by` int NOT NULL,
  `loan_status_id` int NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `fk_membr_loan_status_history_member_loan1_idx` (`member_loan_id`),
  KEY `fk_membr_loan_status_history_general_user_profile1_idx` (`status_change_by`),
  KEY `fk_membr_loan_status_history_loan_status1_idx` (`loan_status_id`),
  CONSTRAINT `fk_membr_loan_status_history_general_user_profile1` FOREIGN KEY (`status_change_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_membr_loan_status_history_loan_status1` FOREIGN KEY (`loan_status_id`) REFERENCES `loan_status` (`id`),
  CONSTRAINT `fk_membr_loan_status_history_member_loan1` FOREIGN KEY (`member_loan_id`) REFERENCES `member_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_manager
DROP TABLE IF EXISTS `member_manager`;
CREATE TABLE IF NOT EXISTS `member_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `member_id1` int NOT NULL,
  `gup_type_id_gt` int NOT NULL,
  `member_loan_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_manager_member1_idx` (`member_id`),
  KEY `fk_member_manager_member2_idx` (`member_id1`),
  KEY `fk_member_manager_gup_type1_idx` (`gup_type_id_gt`),
  KEY `fk_member_manager_member_loan1_idx` (`member_loan_id`),
  CONSTRAINT `fk_member_manager_gup_type1` FOREIGN KEY (`gup_type_id_gt`) REFERENCES `gup_type` (`id_gt`),
  CONSTRAINT `fk_member_manager_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_manager_member2` FOREIGN KEY (`member_id1`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_manager_member_loan1` FOREIGN KEY (`member_loan_id`) REFERENCES `member_loan` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_type
DROP TABLE IF EXISTS `member_type`;
CREATE TABLE IF NOT EXISTS `member_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_uploads
DROP TABLE IF EXISTS `member_uploads`;
CREATE TABLE IF NOT EXISTS `member_uploads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` date DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `url` text,
  `member_id` int NOT NULL,
  `voucher_item_vi_id` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `deposited_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_uploads_member1_idx` (`member_id`),
  KEY `fk_member_uploads_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_member_uploads_member1` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `fk_member_uploads_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.member_voucher_history
DROP TABLE IF EXISTS `member_voucher_history`;
CREATE TABLE IF NOT EXISTS `member_voucher_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_accounts_id` int NOT NULL,
  `voucher_vid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_member_voucher_history_member_accounts1_idx` (`member_accounts_id`),
  KEY `fk_member_voucher_history_voucher1_idx` (`voucher_vid`),
  CONSTRAINT `fk_member_voucher_history_member_accounts1` FOREIGN KEY (`member_accounts_id`) REFERENCES `member_accounts` (`id`),
  CONSTRAINT `fk_member_voucher_history_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.message_subjects
DROP TABLE IF EXISTS `message_subjects`;
CREATE TABLE IF NOT EXISTS `message_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_id` (`course_id`),
  CONSTRAINT `message_subjects_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.minutes_and_reviews
DROP TABLE IF EXISTS `minutes_and_reviews`;
CREATE TABLE IF NOT EXISTS `minutes_and_reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `doc_url` varchar(145) DEFAULT NULL,
  `pdf_doc` varchar(245) DEFAULT NULL,
  `description` text,
  `is_completed` tinyint(1) DEFAULT NULL,
  `minutes_type_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `minutes_and_reviews_status_id` int NOT NULL,
  `org_department_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_minutes_document_minutes_type1_idx` (`minutes_type_id`),
  KEY `fk_minutes_document_org_department1_idx` (`org_department_id`),
  KEY `fk_minutes_and_reviews_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_minutes_and_reviews_minutes_and_reviews_status1_idx` (`minutes_and_reviews_status_id`),
  CONSTRAINT `fk_minutes_and_reviews_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_minutes_and_reviews_minutes_and_reviews_status1` FOREIGN KEY (`minutes_and_reviews_status_id`) REFERENCES `minutes_and_reviews_status` (`id`),
  CONSTRAINT `fk_minutes_document_minutes_type1` FOREIGN KEY (`minutes_type_id`) REFERENCES `minutes_type` (`id`),
  CONSTRAINT `fk_minutes_document_org_department1` FOREIGN KEY (`org_department_id`) REFERENCES `org_department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.minutes_and_reviews_status
DROP TABLE IF EXISTS `minutes_and_reviews_status`;
CREATE TABLE IF NOT EXISTS `minutes_and_reviews_status` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'Sheduled, Meeting Done, Document Uploaded, Document Upload Pending, First Waning, Second Warning, Disciplinary Action has Taken',
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.minutes_level
DROP TABLE IF EXISTS `minutes_level`;
CREATE TABLE IF NOT EXISTS `minutes_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Level 1\nLevel 2\nLevel 3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.minutes_type
DROP TABLE IF EXISTS `minutes_type`;
CREATE TABLE IF NOT EXISTS `minutes_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `minutes_type_id` int DEFAULT NULL,
  `minutes_level_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_minutes_type_minutes_type1_idx` (`minutes_type_id`),
  KEY `fk_minutes_type_minutes_level1_idx` (`minutes_level_id`),
  CONSTRAINT `fk_minutes_type_minutes_level1` FOREIGN KEY (`minutes_level_id`) REFERENCES `minutes_level` (`id`),
  CONSTRAINT `fk_minutes_type_minutes_type1` FOREIGN KEY (`minutes_type_id`) REFERENCES `minutes_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module
DROP TABLE IF EXISTS `module`;
CREATE TABLE IF NOT EXISTS `module` (
  `idModule` int NOT NULL AUTO_INCREMENT,
  `ModuleName` varchar(500) NOT NULL,
  `ModuleDesc` varchar(500) DEFAULT NULL,
  `ModuleState` tinyint NOT NULL,
  `ModuleWeight` int NOT NULL,
  PRIMARY KEY (`idModule`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_assesment
DROP TABLE IF EXISTS `module_assesment`;
CREATE TABLE IF NOT EXISTS `module_assesment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assesment_id` int NOT NULL,
  `course_module_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_assesment_assesment1_idx` (`assesment_id`),
  KEY `fk_module_assesment_course_module1_idx` (`course_module_id`),
  CONSTRAINT `fk_module_assesment_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_module_assesment_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_assessor
DROP TABLE IF EXISTS `module_assessor`;
CREATE TABLE IF NOT EXISTS `module_assessor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_module_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_assessor_course_module1_idx` (`course_module_id`),
  KEY `fk_module_assessor_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_module_assessor_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_module_assessor_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=632 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_content
DROP TABLE IF EXISTS `module_content`;
CREATE TABLE IF NOT EXISTS `module_content` (
  `idModule_Content` int NOT NULL AUTO_INCREMENT,
  `state` tinyint DEFAULT NULL,
  `Module_idModule` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`idModule_Content`),
  KEY `fk_Module_Content_Module1_idx` (`Module_idModule`),
  KEY `fk_Module_Content_course1_idx` (`course_cid`),
  CONSTRAINT `fk_Module_Content_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_Module_Content_Module1` FOREIGN KEY (`Module_idModule`) REFERENCES `module` (`idModule`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_grade
DROP TABLE IF EXISTS `module_grade`;
CREATE TABLE IF NOT EXISTS `module_grade` (
  `idModuleGrade` int NOT NULL AUTO_INCREMENT,
  `ModuleGradeCode` varchar(45) DEFAULT NULL,
  `GradeDescription` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idModuleGrade`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_mark_states
DROP TABLE IF EXISTS `module_mark_states`;
CREATE TABLE IF NOT EXISTS `module_mark_states` (
  `idMark_States` int NOT NULL AUTO_INCREMENT,
  `StateName` varchar(45) NOT NULL,
  `Mark_StatesLogic` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idMark_States`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_other_assignments
DROP TABLE IF EXISTS `module_other_assignments`;
CREATE TABLE IF NOT EXISTS `module_other_assignments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assignment_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_other_assignments_course1_idx` (`course_cid`),
  CONSTRAINT `fk_module_other_assignments_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_other_assignments_students
DROP TABLE IF EXISTS `module_other_assignments_students`;
CREATE TABLE IF NOT EXISTS `module_other_assignments_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `youtube_link` varchar(255) DEFAULT NULL,
  `facebook_link` varchar(255) DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `module_other_assignments_id` int NOT NULL,
  `marks_released_date` datetime DEFAULT NULL,
  `general_user_profile_released_by` int DEFAULT NULL,
  `total_marks` double DEFAULT NULL,
  `lecturer_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_other_assignments_students_student1_idx` (`student_s_id`),
  KEY `fk_module_other_assignments_students_module_other_assignmen_idx` (`module_other_assignments_id`),
  KEY `general_user_profile_released_by` (`general_user_profile_released_by`),
  KEY `lecturer_id` (`lecturer_id`),
  CONSTRAINT `fk_module_other_assignments_students_module_other_assignments1` FOREIGN KEY (`module_other_assignments_id`) REFERENCES `module_other_assignments` (`id`),
  CONSTRAINT `module_other_assignments_students_ibfk_1` FOREIGN KEY (`general_user_profile_released_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `module_other_assignments_students_ibfk_2` FOREIGN KEY (`lecturer_id`) REFERENCES `lecturer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68574 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_other_assignment_marking_criteria
DROP TABLE IF EXISTS `module_other_assignment_marking_criteria`;
CREATE TABLE IF NOT EXISTS `module_other_assignment_marking_criteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `criteria_name` varchar(255) DEFAULT NULL,
  `maximum_marks` double DEFAULT NULL,
  `module_other_assignments_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_moamc_moa` (`module_other_assignments_id`),
  CONSTRAINT `FK_moamc_moa` FOREIGN KEY (`module_other_assignments_id`) REFERENCES `module_other_assignments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_other_assignment_marks
DROP TABLE IF EXISTS `module_other_assignment_marks`;
CREATE TABLE IF NOT EXISTS `module_other_assignment_marks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marks` double NOT NULL DEFAULT '0',
  `module_other_assignments_students_id` int NOT NULL DEFAULT '0',
  `module_other_assignment_marking_criteria_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_moam_moas` (`module_other_assignments_students_id`),
  KEY `FK_moam_moamc` (`module_other_assignment_marking_criteria_id`),
  CONSTRAINT `FK_moam_moamc` FOREIGN KEY (`module_other_assignment_marking_criteria_id`) REFERENCES `module_other_assignment_marking_criteria` (`id`),
  CONSTRAINT `FK_moam_moas` FOREIGN KEY (`module_other_assignments_students_id`) REFERENCES `module_other_assignments_students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_outcome
DROP TABLE IF EXISTS `module_outcome`;
CREATE TABLE IF NOT EXISTS `module_outcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_module_id` int NOT NULL,
  `outcome_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_outcome_course_module1_idx` (`course_module_id`),
  KEY `fk_module_outcome_outcome1_idx` (`outcome_id`),
  CONSTRAINT `fk_module_outcome_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`),
  CONSTRAINT `fk_module_outcome_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=725 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_student_marks
DROP TABLE IF EXISTS `module_student_marks`;
CREATE TABLE IF NOT EXISTS `module_student_marks` (
  `idStudent_Module_Marks` int NOT NULL AUTO_INCREMENT,
  `Module_Marks` int NOT NULL,
  `Module_MarkState_Desc` varchar(255) DEFAULT NULL,
  `Mark_States_idMark_States` int NOT NULL,
  `Module_idModule` int NOT NULL,
  `ModuleGrade_idModuleGrade` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`idStudent_Module_Marks`),
  KEY `fk_Student_Module_Marks_Mark_States1_idx` (`Mark_States_idMark_States`),
  KEY `fk_Student_Module_Marks_Module1_idx` (`Module_idModule`),
  KEY `fk_Student_Module_Marks_ModuleGrade1_idx` (`ModuleGrade_idModuleGrade`),
  KEY `fk_module_student_marks_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_module_student_marks_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Module_Marks_Mark_States1` FOREIGN KEY (`Mark_States_idMark_States`) REFERENCES `module_mark_states` (`idMark_States`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Module_Marks_Module1` FOREIGN KEY (`Module_idModule`) REFERENCES `module` (`idModule`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Module_Marks_ModuleGrade1` FOREIGN KEY (`ModuleGrade_idModuleGrade`) REFERENCES `module_grade` (`idModuleGrade`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2151 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.module_topics
DROP TABLE IF EXISTS `module_topics`;
CREATE TABLE IF NOT EXISTS `module_topics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  `course_module_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_module_topics_course_module1_idx` (`course_module_id`),
  CONSTRAINT `fk_module_topics_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3551 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.monitoring_batch
DROP TABLE IF EXISTS `monitoring_batch`;
CREATE TABLE IF NOT EXISTS `monitoring_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batches_bid` int DEFAULT NULL,
  `monitoring_batch_group_id` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_monitoring_batch_monitoring_batch_group` (`monitoring_batch_group_id`),
  KEY `FK_monitoring_batch_general_user_profile` (`added_by`),
  KEY `FK_monitoring_batch_batches` (`batches_bid`),
  CONSTRAINT `FK_monitoring_batch_batches` FOREIGN KEY (`batches_bid`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_monitoring_batch_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_monitoring_batch_monitoring_batch_group` FOREIGN KEY (`monitoring_batch_group_id`) REFERENCES `monitoring_batch_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.monitoring_batch_group
DROP TABLE IF EXISTS `monitoring_batch_group`;
CREATE TABLE IF NOT EXISTS `monitoring_batch_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.monthly_marketing_targets
DROP TABLE IF EXISTS `monthly_marketing_targets`;
CREATE TABLE IF NOT EXISTS `monthly_marketing_targets` (
  `target_id` int NOT NULL AUTO_INCREMENT,
  `month` varchar(40) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`target_id`),
  KEY `fk_monthly_marketing_targets_branch1` (`branch_bid`),
  CONSTRAINT `fk_monthly_marketing_targets_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.nationality
DROP TABLE IF EXISTS `nationality`;
CREATE TABLE IF NOT EXISTS `nationality` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news
DROP TABLE IF EXISTS `news`;
CREATE TABLE IF NOT EXISTS `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) DEFAULT NULL,
  `description` longtext,
  `is_main_large` tinyint(1) DEFAULT NULL,
  `is_main_small` tinyint(1) DEFAULT NULL,
  `post_date` date DEFAULT NULL,
  `entered_date` date DEFAULT NULL,
  `updated_date` date DEFAULT NULL,
  `general_user_profile_entered_by` int NOT NULL,
  `general_user_profile_updated_by` int NOT NULL,
  `news_type_id` int NOT NULL,
  `news_category_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_published` tinyint(1) DEFAULT NULL,
  `view_count` int DEFAULT NULL,
  `description2` text,
  `news_sub_category_id` int DEFAULT NULL,
  `news_status_id` int NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `is_main` tinyint NOT NULL DEFAULT '0',
  `is_sub` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_news_general_user_profile1_idx` (`general_user_profile_entered_by`),
  KEY `fk_news_general_user_profile2_idx` (`general_user_profile_updated_by`),
  KEY `fk_news_news_type1_idx` (`news_type_id`),
  KEY `fk_news_news_category1_idx` (`news_category_id`),
  KEY `fk_news_news_sub_category1_idx` (`news_sub_category_id`),
  KEY `fk_news_news_status1_idx` (`news_status_id`),
  CONSTRAINT `fk_news_news_category1` FOREIGN KEY (`news_category_id`) REFERENCES `news_category` (`id`),
  CONSTRAINT `fk_news_news_sub_category1` FOREIGN KEY (`news_sub_category_id`) REFERENCES `news_sub_category` (`id`),
  CONSTRAINT `fk_news_news_type1` FOREIGN KEY (`news_type_id`) REFERENCES `news_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_approval_history
DROP TABLE IF EXISTS `news_approval_history`;
CREATE TABLE IF NOT EXISTS `news_approval_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `approved_date` datetime DEFAULT NULL,
  `news_status_id` int NOT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `fk_news_approval_history_news1_idx` (`news_id`),
  KEY `fk_news_approval_history_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_news_approval_history_news_status1_idx` (`news_status_id`),
  CONSTRAINT `fk_news_approval_history_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_news_approval_history_news1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  CONSTRAINT `fk_news_approval_history_news_status1` FOREIGN KEY (`news_status_id`) REFERENCES `news_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_category
DROP TABLE IF EXISTS `news_category`;
CREATE TABLE IF NOT EXISTS `news_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_images
DROP TABLE IF EXISTS `news_images`;
CREATE TABLE IF NOT EXISTS `news_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(500) DEFAULT NULL,
  `news_id` int NOT NULL,
  `news_image_size_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_news_images_news1_idx` (`news_id`),
  KEY `fk_news_images_news_image_size1_idx` (`news_image_size_id`),
  CONSTRAINT `fk_news_images_news1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  CONSTRAINT `fk_news_images_news_image_size1` FOREIGN KEY (`news_image_size_id`) REFERENCES `news_image_size` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6600 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_image_size
DROP TABLE IF EXISTS `news_image_size`;
CREATE TABLE IF NOT EXISTS `news_image_size` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `news_image_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_news_image_size_news_image_type1_idx` (`news_image_type_id`),
  CONSTRAINT `fk_news_image_size_news_image_type1` FOREIGN KEY (`news_image_type_id`) REFERENCES `news_image_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_image_type
DROP TABLE IF EXISTS `news_image_type`;
CREATE TABLE IF NOT EXISTS `news_image_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_status
DROP TABLE IF EXISTS `news_status`;
CREATE TABLE IF NOT EXISTS `news_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_subscriber_type
DROP TABLE IF EXISTS `news_subscriber_type`;
CREATE TABLE IF NOT EXISTS `news_subscriber_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int DEFAULT NULL,
  `subscriber_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `news_id` (`news_id`) USING BTREE,
  KEY `subscriber_type_id` (`subscriber_type_id`) USING BTREE,
  CONSTRAINT `news_subscriber_type_ibfk_1` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`),
  CONSTRAINT `news_subscriber_type_ibfk_2` FOREIGN KEY (`subscriber_type_id`) REFERENCES `subscriber_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_sub_category
DROP TABLE IF EXISTS `news_sub_category`;
CREATE TABLE IF NOT EXISTS `news_sub_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.news_type
DROP TABLE IF EXISTS `news_type`;
CREATE TABLE IF NOT EXISTS `news_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.notification_message
DROP TABLE IF EXISTS `notification_message`;
CREATE TABLE IF NOT EXISTS `notification_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `message` text,
  `sent_by` int DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `universal_notification_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sent_by` (`sent_by`) USING BTREE,
  KEY `universal_notification_type_id` (`universal_notification_type_id`) USING BTREE,
  CONSTRAINT `notification_message_ibfk_1` FOREIGN KEY (`sent_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `notification_message_ibfk_2` FOREIGN KEY (`universal_notification_type_id`) REFERENCES `universal_notification_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.notification_message_timetable
DROP TABLE IF EXISTS `notification_message_timetable`;
CREATE TABLE IF NOT EXISTS `notification_message_timetable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int DEFAULT NULL,
  `notification_message_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `time_table_id` (`time_table_id`) USING BTREE,
  KEY `notification_message_id` (`notification_message_id`) USING BTREE,
  CONSTRAINT `notification_message_timetable_ibfk_1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`),
  CONSTRAINT `notification_message_timetable_ibfk_2` FOREIGN KEY (`notification_message_id`) REFERENCES `notification_message` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.notification_response_type
DROP TABLE IF EXISTS `notification_response_type`;
CREATE TABLE IF NOT EXISTS `notification_response_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `response_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.no_answer_campaign
DROP TABLE IF EXISTS `no_answer_campaign`;
CREATE TABLE IF NOT EXISTS `no_answer_campaign` (
  `id` int NOT NULL AUTO_INCREMENT,
  `campaign_date` date DEFAULT NULL,
  `ivr_script_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_no_answer_campaign_ivr_script` (`ivr_script_id`),
  KEY `FK_no_answer_campaign_general_user_profile` (`added_by`),
  CONSTRAINT `FK_no_answer_campaign_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_no_answer_campaign_ivr_script` FOREIGN KEY (`ivr_script_id`) REFERENCES `ivr_script` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.no_answer_campaign_students
DROP TABLE IF EXISTS `no_answer_campaign_students`;
CREATE TABLE IF NOT EXISTS `no_answer_campaign_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_answer_campaign_id` int DEFAULT NULL,
  `no_answer_manager_id` int DEFAULT NULL,
  `is_responded` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_no_answer_campaign_students_no_answer_campaign` (`no_answer_campaign_id`),
  KEY `FK_no_answer_campaign_students_no_answer_manager` (`no_answer_manager_id`),
  CONSTRAINT `FK_no_answer_campaign_students_no_answer_campaign` FOREIGN KEY (`no_answer_campaign_id`) REFERENCES `no_answer_campaign` (`id`),
  CONSTRAINT `FK_no_answer_campaign_students_no_answer_manager` FOREIGN KEY (`no_answer_manager_id`) REFERENCES `no_answer_manager` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.no_answer_manager
DROP TABLE IF EXISTS `no_answer_manager`;
CREATE TABLE IF NOT EXISTS `no_answer_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `universal_bucket_manager_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `is_comfirmed` tinyint DEFAULT NULL,
  `comfirm_date` datetime DEFAULT NULL,
  `comfirm_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_no_answer_manager_universal_bucket_manager` (`universal_bucket_manager_id`),
  KEY `FK_no_answer_manager_general_user_profile` (`added_by`),
  KEY `FK_no_answer_manager_general_user_profile_2` (`comfirm_by`),
  CONSTRAINT `FK_no_answer_manager_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_no_answer_manager_general_user_profile_2` FOREIGN KEY (`comfirm_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_no_answer_manager_universal_bucket_manager` FOREIGN KEY (`universal_bucket_manager_id`) REFERENCES `universal_bucket_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6309 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.objectives
DROP TABLE IF EXISTS `objectives`;
CREATE TABLE IF NOT EXISTS `objectives` (
  `id` int NOT NULL AUTO_INCREMENT,
  `objectiveid` varchar(45) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.objectives_manager
DROP TABLE IF EXISTS `objectives_manager`;
CREATE TABLE IF NOT EXISTS `objectives_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weight` varchar(45) DEFAULT NULL,
  `objectives_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  `course_module_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_objectives_manager_objectives1_idx` (`objectives_id`),
  KEY `fk_objectives_manager_tt_course1_idx` (`tt_course_id`),
  KEY `fk_objectives_manager_course_module1_idx` (`course_module_id`),
  CONSTRAINT `fk_objectives_manager_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`),
  CONSTRAINT `fk_objectives_manager_objectives1` FOREIGN KEY (`objectives_id`) REFERENCES `objectives` (`id`),
  CONSTRAINT `fk_objectives_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.occupation
DROP TABLE IF EXISTS `occupation`;
CREATE TABLE IF NOT EXISTS `occupation` (
  `id_o` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_o`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.occurrences
DROP TABLE IF EXISTS `occurrences`;
CREATE TABLE IF NOT EXISTS `occurrences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `no_of_repeats` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.offer_given_type
DROP TABLE IF EXISTS `offer_given_type`;
CREATE TABLE IF NOT EXISTS `offer_given_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.offer_mail_sent_manager
DROP TABLE IF EXISTS `offer_mail_sent_manager`;
CREATE TABLE IF NOT EXISTS `offer_mail_sent_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sent_date` datetime DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `universal_payment_manager_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_offer_mail_sent_manager_universal_payment_manager1_idx` (`universal_payment_manager_id`),
  KEY `fk_offer_mail_sent_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_offer_mail_sent_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_offer_mail_sent_manager_universal_payment_manager1` FOREIGN KEY (`universal_payment_manager_id`) REFERENCES `universal_payment_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2910 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.offer_manager
DROP TABLE IF EXISTS `offer_manager`;
CREATE TABLE IF NOT EXISTS `offer_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` int DEFAULT NULL,
  `offer_given_type_id` int NOT NULL,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `discount_percentage` double DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `comment` text,
  `offer_name_id` int NOT NULL,
  `offer_type_id_ot` int NOT NULL,
  `universal_approval_status_manager_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `offer_value` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_offer_manager_offer_given_type1_idx` (`offer_given_type_id`),
  KEY `fk_offer_manager_offer_name1_idx` (`offer_name_id`),
  KEY `fk_offer_manager_offer_type1_idx` (`offer_type_id_ot`),
  KEY `fk_offer_manager_universal_approval_status_manager1_idx` (`universal_approval_status_manager_id`),
  KEY `fk_offer_manager_course1_idx` (`course_cid`),
  CONSTRAINT `fk_offer_manager_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_offer_manager_offer_given_type1` FOREIGN KEY (`offer_given_type_id`) REFERENCES `offer_given_type` (`id`),
  CONSTRAINT `fk_offer_manager_offer_name1` FOREIGN KEY (`offer_name_id`) REFERENCES `offer_name` (`id`),
  CONSTRAINT `fk_offer_manager_offer_type1` FOREIGN KEY (`offer_type_id_ot`) REFERENCES `offer_type` (`id_ot`),
  CONSTRAINT `fk_offer_manager_universal_approval_status_manager1` FOREIGN KEY (`universal_approval_status_manager_id`) REFERENCES `universal_approval_status_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3494 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.offer_name
DROP TABLE IF EXISTS `offer_name`;
CREATE TABLE IF NOT EXISTS `offer_name` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2221 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.offer_type
DROP TABLE IF EXISTS `offer_type`;
CREATE TABLE IF NOT EXISTS `offer_type` (
  `id_ot` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_ot`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_attendance
DROP TABLE IF EXISTS `online_attendance`;
CREATE TABLE IF NOT EXISTS `online_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `starting_time` time DEFAULT NULL,
  `ending_time` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_online_attendance_time_table1_idx` (`time_table_id`),
  KEY `fk_online_attendance_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_online_attendance_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_online_attendance_time_table1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107495 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_attendance_students
DROP TABLE IF EXISTS `online_attendance_students`;
CREATE TABLE IF NOT EXISTS `online_attendance_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `online_attendance_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `vote_time` time DEFAULT NULL,
  `is_activated` tinyint(1) DEFAULT NULL,
  `is_voted` tinyint(1) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_online_attendance_students_online_attendance1_idx` (`online_attendance_id`),
  KEY `fk_online_attendance_students_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_online_attendance_students_online_attendance1` FOREIGN KEY (`online_attendance_id`) REFERENCES `online_attendance` (`id`),
  CONSTRAINT `fk_online_attendance_students_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4072239 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_leads
DROP TABLE IF EXISTS `online_leads`;
CREATE TABLE IF NOT EXISTS `online_leads` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `message` text,
  `is_responded` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2389 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_payment_type
DROP TABLE IF EXISTS `online_payment_type`;
CREATE TABLE IF NOT EXISTS `online_payment_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_registration
DROP TABLE IF EXISTS `online_registration`;
CREATE TABLE IF NOT EXISTS `online_registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `date` date DEFAULT NULL,
  `requested_reason` int DEFAULT NULL,
  `is_replied` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `school` int DEFAULT NULL,
  `online_registration_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_online_registration_course1_idx` (`course_cid`),
  KEY `fk_online_registration_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_online_registration_general_organization_profile1_idx` (`school`),
  KEY `online_registration_ibfk_1` (`online_registration_type_id`),
  CONSTRAINT `fk_online_registration_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_online_registration_general_organization_profile1` FOREIGN KEY (`school`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_online_registration_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `online_registration_ibfk_1` FOREIGN KEY (`online_registration_type_id`) REFERENCES `online_registration_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6994 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_registration_request
DROP TABLE IF EXISTS `online_registration_request`;
CREATE TABLE IF NOT EXISTS `online_registration_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(545) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_registration_type
DROP TABLE IF EXISTS `online_registration_type`;
CREATE TABLE IF NOT EXISTS `online_registration_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_transactions
DROP TABLE IF EXISTS `online_transactions`;
CREATE TABLE IF NOT EXISTS `online_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `order_id` varchar(1000) DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `reference` int DEFAULT NULL COMMENT 'Voucher id, Voucher Item Id',
  `online_transaction_type_id` int NOT NULL,
  `reponse_code` int DEFAULT NULL,
  `reason_code` int DEFAULT NULL,
  `reason` text,
  `voucher_vid` int DEFAULT NULL,
  `payment_gateway_id` int NOT NULL DEFAULT '1',
  `indicator` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_online_transactions_student1_idx` (`student_s_id`),
  KEY `fk_online_transactions_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_online_transactions_course1_idx` (`course_cid`),
  KEY `fk_online_transactions_online_transaction_type1_idx` (`online_transaction_type_id`),
  KEY `fk_online_transactions_voucher1_idx` (`voucher_vid`),
  KEY `payment_gateway_id` (`payment_gateway_id`),
  CONSTRAINT `fk_online_transactions_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_online_transactions_online_transaction_type1` FOREIGN KEY (`online_transaction_type_id`) REFERENCES `online_transaction_type` (`id`),
  CONSTRAINT `online_transactions_ibfk_1` FOREIGN KEY (`payment_gateway_id`) REFERENCES `payment_gateways` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37565 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.online_transaction_type
DROP TABLE IF EXISTS `online_transaction_type`;
CREATE TABLE IF NOT EXISTS `online_transaction_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Voucher,Voucher Item\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.opening_balances
DROP TABLE IF EXISTS `opening_balances`;
CREATE TABLE IF NOT EXISTS `opening_balances` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `DATE` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `credit_or_debit_id_cod` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `fk_opening_balances_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_opening_balances_credit_or_debit1_idx` (`credit_or_debit_id_cod`),
  CONSTRAINT `fk_opening_balances_credit_or_debit1` FOREIGN KEY (`credit_or_debit_id_cod`) REFERENCES `credit_or_debit` (`id_cod`),
  CONSTRAINT `fk_opening_balances_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.organization_sub_types
DROP TABLE IF EXISTS `organization_sub_types`;
CREATE TABLE IF NOT EXISTS `organization_sub_types` (
  `id_ost` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `organization_type_id_ot` int NOT NULL,
  PRIMARY KEY (`id_ost`),
  KEY `fk_organization_sub_types_organization_type1_idx` (`organization_type_id_ot`),
  CONSTRAINT `fk_organization_sub_types_organization_type1` FOREIGN KEY (`organization_type_id_ot`) REFERENCES `organization_type` (`id_ot`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.organization_type
DROP TABLE IF EXISTS `organization_type`;
CREATE TABLE IF NOT EXISTS `organization_type` (
  `id_ot` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_ot`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.organization_type_manager
DROP TABLE IF EXISTS `organization_type_manager`;
CREATE TABLE IF NOT EXISTS `organization_type_manager` (
  `id_otm` int NOT NULL AUTO_INCREMENT,
  `organization_type_id_ot` int NOT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `general_organization_profile_id_gop1` int DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_otm`),
  KEY `fk_organization_type_manager_organization_type1_idx` (`organization_type_id_ot`),
  KEY `fk_organization_type_manager_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_organization_type_manager_general_organization_profile2_idx` (`general_organization_profile_id_gop1`),
  CONSTRAINT `fk_organization_type_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_organization_type_manager_general_organization_profile2` FOREIGN KEY (`general_organization_profile_id_gop1`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_organization_type_manager_organization_type1` FOREIGN KEY (`organization_type_id_ot`) REFERENCES `organization_type` (`id_ot`)
) ENGINE=InnoDB AUTO_INCREMENT=1015 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_account_type
DROP TABLE IF EXISTS `org_account_type`;
CREATE TABLE IF NOT EXISTS `org_account_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_type_a_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_account_type_account_type1_idx` (`account_type_a_id`),
  KEY `fk_org_account_type_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_account_type_account_type1` FOREIGN KEY (`account_type_a_id`) REFERENCES `account_type` (`a_id`),
  CONSTRAINT `fk_org_account_type_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_category
DROP TABLE IF EXISTS `org_category`;
CREATE TABLE IF NOT EXISTS `org_category` (
  `id_oc` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `org_category_id_oc` int DEFAULT NULL,
  PRIMARY KEY (`id_oc`),
  KEY `fk_org_category_org_category1_idx` (`org_category_id_oc`),
  CONSTRAINT `fk_org_category_org_category1` FOREIGN KEY (`org_category_id_oc`) REFERENCES `org_category` (`id_oc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_category_manager
DROP TABLE IF EXISTS `org_category_manager`;
CREATE TABLE IF NOT EXISTS `org_category_manager` (
  `id_ocm` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  `org_category_id_oc` int NOT NULL,
  PRIMARY KEY (`id_ocm`),
  KEY `fk_org_category_manager_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_org_category_manager_org_category1_idx` (`org_category_id_oc`),
  CONSTRAINT `fk_org_category_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_org_category_manager_org_category1` FOREIGN KEY (`org_category_id_oc`) REFERENCES `org_category` (`id_oc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_chart_of_account
DROP TABLE IF EXISTS `org_chart_of_account`;
CREATE TABLE IF NOT EXISTS `org_chart_of_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chart_of_account_coa_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_chart_of_account_chart_of_account1_idx` (`chart_of_account_coa_id`),
  KEY `fk_org_chart_of_account_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_chart_of_account_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`),
  CONSTRAINT `fk_org_chart_of_account_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_common_settings
DROP TABLE IF EXISTS `org_common_settings`;
CREATE TABLE IF NOT EXISTS `org_common_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  `common_settings_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_common_settings_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_org_common_settings_common_settings1_idx` (`common_settings_id`),
  CONSTRAINT `fk_org_common_settings_common_settings1` FOREIGN KEY (`common_settings_id`) REFERENCES `common_settings` (`id`),
  CONSTRAINT `fk_org_common_settings_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_department
DROP TABLE IF EXISTS `org_department`;
CREATE TABLE IF NOT EXISTS `org_department` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_department_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_department_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_employee
DROP TABLE IF EXISTS `org_employee`;
CREATE TABLE IF NOT EXISTS `org_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employees_employee_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `assigned_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_employee_employees1_idx` (`employees_employee_id`),
  KEY `fk_org_employee_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_employee_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_org_employee_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_financial_target
DROP TABLE IF EXISTS `org_financial_target`;
CREATE TABLE IF NOT EXISTS `org_financial_target` (
  `id` int NOT NULL AUTO_INCREMENT,
  `target` double DEFAULT NULL,
  `year_id` int NOT NULL,
  `month` int DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_financial_target_year1_idx` (`year_id`),
  KEY `fk_org_financial_target_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_financial_target_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_org_financial_target_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_item
DROP TABLE IF EXISTS `org_item`;
CREATE TABLE IF NOT EXISTS `org_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_master_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `selling_price` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `item_price` double DEFAULT NULL,
  `available_qty` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_item_item_master1_idx` (`item_master_id`),
  KEY `fk_org_item_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_item_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_org_item_item_master1` FOREIGN KEY (`item_master_id`) REFERENCES `item_master` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_main_chart_of_account
DROP TABLE IF EXISTS `org_main_chart_of_account`;
CREATE TABLE IF NOT EXISTS `org_main_chart_of_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_chart_of_account_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_main_chart_of_account_main_chart_of_account1_idx` (`main_chart_of_account_id`),
  KEY `fk_org_main_chart_of_account_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_org_main_chart_of_account_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_org_main_chart_of_account_main_chart_of_account1` FOREIGN KEY (`main_chart_of_account_id`) REFERENCES `main_chart_of_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.org_sub_chart_of_account
DROP TABLE IF EXISTS `org_sub_chart_of_account`;
CREATE TABLE IF NOT EXISTS `org_sub_chart_of_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` int DEFAULT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `organization_type_manager_id_otm` int NOT NULL,
  `fix_amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_org_sub_chart_of_account_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_org_sub_chart_of_account_organization_type_manager1_idx` (`organization_type_manager_id_otm`),
  CONSTRAINT `fk_org_sub_chart_of_account_organization_type_manager1` FOREIGN KEY (`organization_type_manager_id_otm`) REFERENCES `organization_type_manager` (`id_otm`),
  CONSTRAINT `fk_org_sub_chart_of_account_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.outcome
DROP TABLE IF EXISTS `outcome`;
CREATE TABLE IF NOT EXISTS `outcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `outcomeid` varchar(45) DEFAULT NULL,
  `name` text,
  `description` text,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_outcome_course1_idx` (`course_cid`),
  CONSTRAINT `fk_outcome_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.outcome_assesment_manager
DROP TABLE IF EXISTS `outcome_assesment_manager`;
CREATE TABLE IF NOT EXISTS `outcome_assesment_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `weight` varchar(45) DEFAULT NULL,
  `outcome_id` int NOT NULL,
  `assesment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_outcome_assesment_manager_outcome1_idx` (`outcome_id`),
  KEY `fk_outcome_assesment_manager_assesment1_idx` (`assesment_id`),
  CONSTRAINT `fk_outcome_assesment_manager_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `fk_outcome_assesment_manager_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.outcome_manager
DROP TABLE IF EXISTS `outcome_manager`;
CREATE TABLE IF NOT EXISTS `outcome_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `outcome_id` int NOT NULL,
  `lesson_id` int NOT NULL,
  `course_module_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_outcome_manager_outcome1_idx` (`outcome_id`),
  KEY `fk_outcome_manager_lesson1_idx` (`lesson_id`),
  KEY `fk_outcome_manager_course_module1_idx` (`course_module_id`),
  CONSTRAINT `fk_outcome_manager_course_module1` FOREIGN KEY (`course_module_id`) REFERENCES `course_module` (`id`),
  CONSTRAINT `fk_outcome_manager_lesson1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`),
  CONSTRAINT `fk_outcome_manager_outcome1` FOREIGN KEY (`outcome_id`) REFERENCES `outcome` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1134 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.overview
DROP TABLE IF EXISTS `overview`;
CREATE TABLE IF NOT EXISTS `overview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `overviewid` varchar(45) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.overview_manager
DROP TABLE IF EXISTS `overview_manager`;
CREATE TABLE IF NOT EXISTS `overview_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `overview_id` int NOT NULL,
  `tt_course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_overview_manager_overview1_idx` (`overview_id`),
  KEY `fk_overview_manager_tt_course1_idx` (`tt_course_id`),
  CONSTRAINT `fk_overview_manager_overview1` FOREIGN KEY (`overview_id`) REFERENCES `overview` (`id`),
  CONSTRAINT `fk_overview_manager_tt_course1` FOREIGN KEY (`tt_course_id`) REFERENCES `tt_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.pack
DROP TABLE IF EXISTS `pack`;
CREATE TABLE IF NOT EXISTS `pack` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `backed_by` int NOT NULL,
  `bundle_id` int NOT NULL,
  `barcode` varchar(145) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pack_employees1_idx` (`backed_by`),
  KEY `fk_pack_bundle1_idx` (`bundle_id`),
  CONSTRAINT `fk_pack_bundle1` FOREIGN KEY (`bundle_id`) REFERENCES `bundle` (`id`),
  CONSTRAINT `fk_pack_employees1` FOREIGN KEY (`backed_by`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.packages
DROP TABLE IF EXISTS `packages`;
CREATE TABLE IF NOT EXISTS `packages` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `Packages_Name` varchar(255) NOT NULL,
  `Bulk_Price` double NOT NULL,
  `state` int NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.package_manager
DROP TABLE IF EXISTS `package_manager`;
CREATE TABLE IF NOT EXISTS `package_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.participants_answer
DROP TABLE IF EXISTS `participants_answer`;
CREATE TABLE IF NOT EXISTS `participants_answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `survey_participants_id` int NOT NULL,
  `question_id` int NOT NULL,
  `asnwer_id` int NOT NULL,
  `lecturer_performance_survey_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_participants_feed_back_survey_participants1_idx` (`survey_participants_id`),
  KEY `fk_participants_feed_back_question1_idx` (`question_id`),
  KEY `fk_participants_feed_back_asnwer1_idx` (`asnwer_id`),
  KEY `fk_participants_answer_lecturer_performance_survey1_idx` (`lecturer_performance_survey_id`),
  CONSTRAINT `fk_participants_answer_lecturer_performance_survey1` FOREIGN KEY (`lecturer_performance_survey_id`) REFERENCES `lecturer_performance_survey` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_participants_feed_back_asnwer1` FOREIGN KEY (`asnwer_id`) REFERENCES `asnwer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_participants_feed_back_question1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_participants_feed_back_survey_participants1` FOREIGN KEY (`survey_participants_id`) REFERENCES `survey_participants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1615988 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.password_manager
DROP TABLE IF EXISTS `password_manager`;
CREATE TABLE IF NOT EXISTS `password_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `password` text,
  `password_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_password_manager_password_type1_idx` (`password_type_id`),
  CONSTRAINT `fk_password_manager_password_type1` FOREIGN KEY (`password_type_id`) REFERENCES `password_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.password_type
DROP TABLE IF EXISTS `password_type`;
CREATE TABLE IF NOT EXISTS `password_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_cheque_in_favour_of_org
DROP TABLE IF EXISTS `payment_cheque_in_favour_of_org`;
CREATE TABLE IF NOT EXISTS `payment_cheque_in_favour_of_org` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  `affiliate_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_cheque_in_favour_of_org_general_organization_pro_idx` (`general_organization_profile_id_gop`),
  KEY `fk_payment_cheque_in_favour_of_org_affiliate_user1_idx` (`affiliate_user_id`),
  CONSTRAINT `fk_payment_cheque_in_favour_of_org_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`),
  CONSTRAINT `fk_payment_cheque_in_favour_of_org_general_organization_profi1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_cheque_in_favour_of_user
DROP TABLE IF EXISTS `payment_cheque_in_favour_of_user`;
CREATE TABLE IF NOT EXISTS `payment_cheque_in_favour_of_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `affiliate_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_cheque_in_favour_of_user_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_payment_cheque_in_favour_of_user_affiliate_user1_idx` (`affiliate_user_id`),
  CONSTRAINT `fk_payment_cheque_in_favour_of_user_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`),
  CONSTRAINT `fk_payment_cheque_in_favour_of_user_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_gateways
DROP TABLE IF EXISTS `payment_gateways`;
CREATE TABLE IF NOT EXISTS `payment_gateways` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `bank_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK__bank` (`bank_id`),
  CONSTRAINT `FK__bank` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_history
DROP TABLE IF EXISTS `payment_history`;
CREATE TABLE IF NOT EXISTS `payment_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference` int DEFAULT NULL,
  `voucher_vid` int NOT NULL,
  `voucher_type_vt_id` int NOT NULL,
  `universal_person_or_org_type_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_history_voucher1_idx` (`voucher_vid`),
  KEY `fk_payment_history_voucher_type1_idx` (`voucher_type_vt_id`),
  KEY `fk_payment_history_universal_person_or_org_type_manager1_idx` (`universal_person_or_org_type_manager_id`),
  CONSTRAINT `fk_payment_history_universal_person_or_org_type_manager1` FOREIGN KEY (`universal_person_or_org_type_manager_id`) REFERENCES `universal_person_or_org_type_manager` (`id`),
  CONSTRAINT `fk_payment_history_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`),
  CONSTRAINT `fk_payment_history_voucher_type1` FOREIGN KEY (`voucher_type_vt_id`) REFERENCES `voucher_type` (`vt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_mode
DROP TABLE IF EXISTS `payment_mode`;
CREATE TABLE IF NOT EXISTS `payment_mode` (
  `payment_mode_id` int NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`payment_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_option
DROP TABLE IF EXISTS `payment_option`;
CREATE TABLE IF NOT EXISTS `payment_option` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.payment_option_type
DROP TABLE IF EXISTS `payment_option_type`;
CREATE TABLE IF NOT EXISTS `payment_option_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.penalty
DROP TABLE IF EXISTS `penalty`;
CREATE TABLE IF NOT EXISTS `penalty` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Due Date Exceeding Penalty\nDue 7 Days Exceeding Penalty\nDue 14 Days Exceeding Penalty',
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.penalty_values
DROP TABLE IF EXISTS `penalty_values`;
CREATE TABLE IF NOT EXISTS `penalty_values` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` double DEFAULT NULL COMMENT 'daily increasing value',
  `percentage` double DEFAULT NULL,
  `initial_value` double DEFAULT NULL COMMENT 'penalty start value',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `penalty_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_penalty_values_penalty1_idx` (`penalty_id`),
  CONSTRAINT `fk_penalty_values_penalty1` FOREIGN KEY (`penalty_id`) REFERENCES `penalty` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='this table can be used to store value of penalty which increase on daily or regular basis\n';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.person_category
DROP TABLE IF EXISTS `person_category`;
CREATE TABLE IF NOT EXISTS `person_category` (
  `id_pc` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_pc`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.petty_cash_issue
DROP TABLE IF EXISTS `petty_cash_issue`;
CREATE TABLE IF NOT EXISTS `petty_cash_issue` (
  `id_ca` int NOT NULL AUTO_INCREMENT,
  `pretty_cash_requestid_pcr` int NOT NULL,
  `general_journal_entrygje_id` int NOT NULL,
  `login_sessionsession_id` int NOT NULL,
  `issued_amount` double DEFAULT NULL,
  `payment_modepayment_mode_id` int NOT NULL,
  PRIMARY KEY (`id_ca`),
  KEY `FKpetty_cash891713` (`pretty_cash_requestid_pcr`),
  KEY `FKpetty_cash790895` (`general_journal_entrygje_id`),
  KEY `FKpetty_cash963257` (`login_sessionsession_id`),
  KEY `FKpetty_cash151277` (`payment_modepayment_mode_id`),
  CONSTRAINT `FKpetty_cash151277` FOREIGN KEY (`payment_modepayment_mode_id`) REFERENCES `payment_mode` (`payment_mode_id`),
  CONSTRAINT `FKpetty_cash790895` FOREIGN KEY (`general_journal_entrygje_id`) REFERENCES `general_journal_entry` (`gje_id`),
  CONSTRAINT `FKpetty_cash891713` FOREIGN KEY (`pretty_cash_requestid_pcr`) REFERENCES `pretty_cash_request` (`id_pcr`),
  CONSTRAINT `FKpetty_cash963257` FOREIGN KEY (`login_sessionsession_id`) REFERENCES `login_session` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.plagiarism_database_results
DROP TABLE IF EXISTS `plagiarism_database_results`;
CREATE TABLE IF NOT EXISTS `plagiarism_database_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `other_scan_id` varchar(255) DEFAULT NULL,
  `result_id` varchar(255) DEFAULT NULL,
  `file_name` text,
  `matched_words` int DEFAULT NULL,
  `identical_words` int DEFAULT NULL,
  `minor_changed_words` int DEFAULT NULL,
  `related_meaning_words` int DEFAULT NULL,
  `plagiarism_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_plagiarism_database_results_plagiarism_manager1_idx` (`plagiarism_manager_id`),
  CONSTRAINT `fk_plagiarism_database_results_plagiarism_manager1` FOREIGN KEY (`plagiarism_manager_id`) REFERENCES `plagiarism_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2949 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.plagiarism_internet_results
DROP TABLE IF EXISTS `plagiarism_internet_results`;
CREATE TABLE IF NOT EXISTS `plagiarism_internet_results` (
  `id` int NOT NULL AUTO_INCREMENT,
  `result_id` varchar(45) DEFAULT NULL,
  `url` text,
  `title` text,
  `introduction` text,
  `matched_words` int DEFAULT NULL,
  `identical_words` int DEFAULT NULL,
  `minor_changed_words` int DEFAULT NULL,
  `related_meaning_words` int DEFAULT NULL,
  `plagiarism_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_plagiarism_internet_results_plagiarism_manager1_idx` (`plagiarism_manager_id`),
  CONSTRAINT `fk_plagiarism_internet_results_plagiarism_manager1` FOREIGN KEY (`plagiarism_manager_id`) REFERENCES `plagiarism_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11598 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.plagiarism_manager
DROP TABLE IF EXISTS `plagiarism_manager`;
CREATE TABLE IF NOT EXISTS `plagiarism_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `doc` varchar(1000) DEFAULT NULL,
  `page_count` int DEFAULT NULL,
  `scan_id` varchar(255) DEFAULT NULL,
  `batch_assignment_sheduler_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `score` double DEFAULT NULL,
  `total_words` int DEFAULT NULL,
  `file_size` double DEFAULT NULL,
  `credits` int DEFAULT NULL,
  `identical_words` int DEFAULT NULL,
  `minor_changed_words` int DEFAULT NULL,
  `related_meaning_words` int DEFAULT NULL,
  `excluded_words` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_scaned` tinyint(1) DEFAULT NULL,
  `pdf_doc` varchar(1000) DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_plagiarism_manager_batch_assignment_sheduler1_idx` (`batch_assignment_sheduler_id`),
  KEY `fk_plagiarism_manager_student1_idx` (`student_s_id`),
  KEY `uploaded_by` (`uploaded_by`),
  CONSTRAINT `fk_plagiarism_manager_batch_assignment_sheduler1` FOREIGN KEY (`batch_assignment_sheduler_id`) REFERENCES `batch_assignment_sheduler` (`id`),
  CONSTRAINT `fk_plagiarism_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `plagiarism_manager_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2187 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.plagiarism_payment
DROP TABLE IF EXISTS `plagiarism_payment`;
CREATE TABLE IF NOT EXISTS `plagiarism_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plagiarism_manager_id` int NOT NULL,
  `online_transactions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_plagiarism_payment_plagiarism_manager1_idx` (`plagiarism_manager_id`),
  KEY `fk_plagiarism_payment_online_transactions1_idx` (`online_transactions_id`),
  CONSTRAINT `fk_plagiarism_payment_online_transactions1` FOREIGN KEY (`online_transactions_id`) REFERENCES `online_transactions` (`id`),
  CONSTRAINT `fk_plagiarism_payment_plagiarism_manager1` FOREIGN KEY (`plagiarism_manager_id`) REFERENCES `plagiarism_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=879 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.policy_doc
DROP TABLE IF EXISTS `policy_doc`;
CREATE TABLE IF NOT EXISTS `policy_doc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(450) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.policy_document
DROP TABLE IF EXISTS `policy_document`;
CREATE TABLE IF NOT EXISTS `policy_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `description` text,
  `uploaded_date` date DEFAULT NULL,
  `doc_url` varchar(245) DEFAULT NULL,
  `icon` varchar(145) DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_policy_document_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_policy_document_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.policy_doc_access_conroller
DROP TABLE IF EXISTS `policy_doc_access_conroller`;
CREATE TABLE IF NOT EXISTS `policy_doc_access_conroller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `policy_doc_access_role_id` int NOT NULL,
  `policy_document_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_policy_doc_access_conroller_policy_doc_access_role1_idx` (`policy_doc_access_role_id`),
  KEY `fk_policy_doc_access_conroller_policy_document1_idx` (`policy_document_id`),
  CONSTRAINT `fk_policy_doc_access_conroller_policy_doc_access_role1` FOREIGN KEY (`policy_doc_access_role_id`) REFERENCES `policy_doc_access_role` (`id`),
  CONSTRAINT `fk_policy_doc_access_conroller_policy_document1` FOREIGN KEY (`policy_document_id`) REFERENCES `policy_document` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.policy_doc_access_role
DROP TABLE IF EXISTS `policy_doc_access_role`;
CREATE TABLE IF NOT EXISTS `policy_doc_access_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.pool
DROP TABLE IF EXISTS `pool`;
CREATE TABLE IF NOT EXISTS `pool` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'course_title\nMain Pool \n\nPurpose of the main pool:\nIf the oopc1 pool  become false due to absence, all other pools will become false and main pool will become true',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.pool_batch
DROP TABLE IF EXISTS `pool_batch`;
CREATE TABLE IF NOT EXISTS `pool_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL COMMENT '2016/March/Tue',
  `pool_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pool_batch_pool1_idx` (`pool_id`),
  KEY `fk_pool_batch_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_pool_batch_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_pool_batch_pool1` FOREIGN KEY (`pool_id`) REFERENCES `pool` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.pool_batch_controller
DROP TABLE IF EXISTS `pool_batch_controller`;
CREATE TABLE IF NOT EXISTS `pool_batch_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `main_pool_id` int NOT NULL,
  `pool_permanent_fk` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pool_batch_controller_student_batches1_idx` (`main_pool_id`),
  KEY `fk_pool_batch_controller_student_batches2_idx` (`pool_permanent_fk`),
  CONSTRAINT `fk_pool_batch_controller_student_batches1` FOREIGN KEY (`main_pool_id`) REFERENCES `student_batches` (`sb_id`),
  CONSTRAINT `fk_pool_batch_controller_student_batches2` FOREIGN KEY (`pool_permanent_fk`) REFERENCES `student_batches` (`sb_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.postpone_duration
DROP TABLE IF EXISTS `postpone_duration`;
CREATE TABLE IF NOT EXISTS `postpone_duration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.pretty_cash_request
DROP TABLE IF EXISTS `pretty_cash_request`;
CREATE TABLE IF NOT EXISTS `pretty_cash_request` (
  `id_pcr` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `amount` double DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `date` date DEFAULT NULL,
  `id` varchar(255) DEFAULT NULL,
  `branchbid` int NOT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id_pcr`),
  KEY `FKpretty_cas733805` (`general_user_profilegup_id`),
  KEY `FKpretty_cas130033` (`branchbid`),
  CONSTRAINT `FKpretty_cas130033` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `FKpretty_cas733805` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.privileges
DROP TABLE IF EXISTS `privileges`;
CREATE TABLE IF NOT EXISTS `privileges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.products
DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` varchar(45) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.profession
DROP TABLE IF EXISTS `profession`;
CREATE TABLE IF NOT EXISTS `profession` (
  `id_p` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_p`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.profile_picture_history
DROP TABLE IF EXISTS `profile_picture_history`;
CREATE TABLE IF NOT EXISTS `profile_picture_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `image_path` varchar(245) DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `updated_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_profile_picture_history_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_profile_picture_history_general_user_profile2_idx` (`updated_by`),
  CONSTRAINT `fk_profile_picture_history_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_profile_picture_history_general_user_profile2` FOREIGN KEY (`updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.prospective_student_status
DROP TABLE IF EXISTS `prospective_student_status`;
CREATE TABLE IF NOT EXISTS `prospective_student_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Prospective,IVR Responded\nDatabase students must generate IVR.Their status will be change as Prospective to IVR Responded',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.province
DROP TABLE IF EXISTS `province`;
CREATE TABLE IF NOT EXISTS `province` (
  `id_p` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `country_id_c` int NOT NULL,
  PRIMARY KEY (`id_p`),
  KEY `fk_province_country1_idx` (`country_id_c`),
  CONSTRAINT `fk_province_country1` FOREIGN KEY (`country_id_c`) REFERENCES `country` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.qualification
DROP TABLE IF EXISTS `qualification`;
CREATE TABLE IF NOT EXISTS `qualification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.qualification_type
DROP TABLE IF EXISTS `qualification_type`;
CREATE TABLE IF NOT EXISTS `qualification_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.qualification_upgrade_request
DROP TABLE IF EXISTS `qualification_upgrade_request`;
CREATE TABLE IF NOT EXISTS `qualification_upgrade_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `year_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_qualification_upgrade_request_student1_idx` (`student_s_id`),
  KEY `fk_qualification_upgrade_request_year1_idx` (`year_id`),
  CONSTRAINT `fk_qualification_upgrade_request_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_qualification_upgrade_request_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.question
DROP TABLE IF EXISTS `question`;
CREATE TABLE IF NOT EXISTS `question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.received_cheques
DROP TABLE IF EXISTS `received_cheques`;
CREATE TABLE IF NOT EXISTS `received_cheques` (
  `id_rc` int NOT NULL AUTO_INCREMENT,
  `cheque_no` varchar(255) DEFAULT NULL,
  `cheque_date` date DEFAULT NULL,
  `is_deposited` int DEFAULT NULL,
  `bankb_id` int NOT NULL,
  `branchbid` int NOT NULL,
  `cheque_amount` double DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  PRIMARY KEY (`id_rc`),
  KEY `FKreceived_c670133` (`bankb_id`),
  KEY `FKreceived_c557023` (`branchbid`),
  KEY `FKreceived_c550728` (`general_user_profilegup_id`),
  CONSTRAINT `FKreceived_c550728` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKreceived_c557023` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKreceived_c670133` FOREIGN KEY (`bankb_id`) REFERENCES `bank` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=352 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.recording_sampling_data
DROP TABLE IF EXISTS `recording_sampling_data`;
CREATE TABLE IF NOT EXISTS `recording_sampling_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `calling_history_id` int DEFAULT NULL,
  `recording_sampling_manager_id` int DEFAULT NULL,
  `is_sampled` tinyint DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_recording_sampling_data_calling_history` (`calling_history_id`),
  KEY `FK_recording_sampling_data_recording_sampling_manager` (`recording_sampling_manager_id`),
  CONSTRAINT `FK_recording_sampling_data_calling_history` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `FK_recording_sampling_data_recording_sampling_manager` FOREIGN KEY (`recording_sampling_manager_id`) REFERENCES `recording_sampling_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5745 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.recording_sampling_manager
DROP TABLE IF EXISTS `recording_sampling_manager`;
CREATE TABLE IF NOT EXISTS `recording_sampling_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `officer_id` int DEFAULT NULL,
  `recording_type_id` int DEFAULT NULL,
  `total_count` int DEFAULT NULL,
  `sampling_count` int DEFAULT NULL,
  `is_approved` tinyint DEFAULT NULL,
  `approved_date` datetime DEFAULT NULL,
  `approved_by` int DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `FK_recording_sampling_manager_general_user_profile` (`officer_id`),
  KEY `FK_recording_sampling_manager_general_user_profile_2` (`approved_by`),
  KEY `FK_recording_sampling_manager_recording_type` (`recording_type_id`) USING BTREE,
  CONSTRAINT `FK_recording_sampling_manager_general_user_profile` FOREIGN KEY (`officer_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_recording_sampling_manager_general_user_profile_2` FOREIGN KEY (`approved_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_recording_sampling_manager_recording_type` FOREIGN KEY (`recording_type_id`) REFERENCES `recording_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1411 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.recording_type
DROP TABLE IF EXISTS `recording_type`;
CREATE TABLE IF NOT EXISTS `recording_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.recovery_action
DROP TABLE IF EXISTS `recovery_action`;
CREATE TABLE IF NOT EXISTS `recovery_action` (
  `ra_id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL COMMENT 'FK to student.s_id',
  `action_type_rat_id` int NOT NULL COMMENT 'FK to recovery_action_type.rat_id',
  `action_date` datetime NOT NULL,
  `action_status` enum('SCHEDULED','IN_PROGRESS','COMPLETED','CANCELLED') COLLATE utf8mb4_unicode_ci DEFAULT 'SCHEDULED',
  `outcome` text COLLATE utf8mb4_unicode_ci COMMENT 'Result of the action',
  `next_action_date` date DEFAULT NULL,
  `assigned_to_gup_id` int DEFAULT NULL COMMENT 'Staff assigned to this action',
  `completed_by_gup_id` int DEFAULT NULL COMMENT 'Staff who completed the action',
  `completed_at` datetime DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`ra_id`),
  KEY `idx_recovery_action_student` (`student_s_id`),
  KEY `idx_recovery_action_type` (`action_type_rat_id`),
  KEY `idx_recovery_action_date` (`action_date`),
  KEY `idx_recovery_action_status` (`action_status`),
  KEY `idx_recovery_action_assigned` (`assigned_to_gup_id`),
  KEY `idx_recovery_action_next_date` (`next_action_date`),
  KEY `fk_recovery_action_completed_by` (`completed_by_gup_id`),
  CONSTRAINT `fk_recovery_action_assigned_to` FOREIGN KEY (`assigned_to_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_recovery_action_completed_by` FOREIGN KEY (`completed_by_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_recovery_action_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_recovery_action_type` FOREIGN KEY (`action_type_rat_id`) REFERENCES `recovery_action_type` (`rat_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.recovery_action_type
DROP TABLE IF EXISTS `recovery_action_type`;
CREATE TABLE IF NOT EXISTS `recovery_action_type` (
  `rat_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `priority` int DEFAULT '0' COMMENT 'Order of escalation',
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`rat_id`),
  KEY `idx_recovery_action_type_name` (`name`),
  KEY `idx_recovery_action_type_priority` (`priority`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.registration_type
DROP TABLE IF EXISTS `registration_type`;
CREATE TABLE IF NOT EXISTS `registration_type` (
  `id_rt` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_rt`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.reject_type
DROP TABLE IF EXISTS `reject_type`;
CREATE TABLE IF NOT EXISTS `reject_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.related_documents
DROP TABLE IF EXISTS `related_documents`;
CREATE TABLE IF NOT EXISTS `related_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc` text,
  `academic_policy_level_1_id` int DEFAULT NULL,
  `academic_policy_level_2_id` int DEFAULT NULL,
  `academic_policy_level_3_id` int DEFAULT NULL,
  `academic_policy_level_4_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `academic_policy_level_1_id` (`academic_policy_level_1_id`) USING BTREE,
  KEY `academic_policy_level_2_id` (`academic_policy_level_2_id`) USING BTREE,
  KEY `academic_policy_level_3_id` (`academic_policy_level_3_id`) USING BTREE,
  KEY `academic_policy_level_4_id` (`academic_policy_level_4_id`) USING BTREE,
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`) USING BTREE,
  CONSTRAINT `related_documents_ibfk_1` FOREIGN KEY (`academic_policy_level_1_id`) REFERENCES `academic_policy_level_1` (`id`),
  CONSTRAINT `related_documents_ibfk_2` FOREIGN KEY (`academic_policy_level_2_id`) REFERENCES `academic_policy_level_2` (`id`),
  CONSTRAINT `related_documents_ibfk_3` FOREIGN KEY (`academic_policy_level_3_id`) REFERENCES `academic_policy_level_3` (`id`),
  CONSTRAINT `related_documents_ibfk_4` FOREIGN KEY (`academic_policy_level_4_id`) REFERENCES `academic_policy_level_4` (`id`),
  CONSTRAINT `related_documents_ibfk_5` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.researches
DROP TABLE IF EXISTS `researches`;
CREATE TABLE IF NOT EXISTS `researches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `research_student_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `research_topic` text,
  `is_published` tinyint(1) DEFAULT NULL,
  `is_patented` tinyint(1) DEFAULT NULL,
  `is_interviewed_1` tinyint(1) DEFAULT NULL,
  `is_interviewed_2` tinyint(1) DEFAULT NULL,
  `is_interviewed_3` tinyint(1) DEFAULT NULL,
  `url_1` text,
  `url_2` text,
  `url_3` text,
  `research_description` text,
  PRIMARY KEY (`id`),
  KEY `fk_researches_research_student1_idx` (`research_student_id`),
  CONSTRAINT `fk_researches_research_student1` FOREIGN KEY (`research_student_id`) REFERENCES `research_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4227 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.researches_industrial_visit_documnet
DROP TABLE IF EXISTS `researches_industrial_visit_documnet`;
CREATE TABLE IF NOT EXISTS `researches_industrial_visit_documnet` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `url` text,
  `researches_id` int DEFAULT NULL,
  `visit_round` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `researches_id` (`researches_id`) USING BTREE,
  CONSTRAINT `researches_industrial_visit_documnet_ibfk_1` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1027 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_evaluation_form_data
DROP TABLE IF EXISTS `research_evaluation_form_data`;
CREATE TABLE IF NOT EXISTS `research_evaluation_form_data` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `interview_1` text,
  `interview_2` text,
  `interview_3` text,
  `research_student_id` int DEFAULT NULL,
  `research_evaluation_form_type_category_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `research_student_id` (`research_student_id`),
  KEY `research_evaluation_form_type_category_id` (`research_evaluation_form_type_category_id`),
  CONSTRAINT `research_evaluation_form_data_ibfk_1` FOREIGN KEY (`research_student_id`) REFERENCES `research_student` (`id`),
  CONSTRAINT `research_evaluation_form_data_ibfk_2` FOREIGN KEY (`research_evaluation_form_type_category_id`) REFERENCES `research_evaluation_form_type_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1466 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_evaluation_form_type
DROP TABLE IF EXISTS `research_evaluation_form_type`;
CREATE TABLE IF NOT EXISTS `research_evaluation_form_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_evaluation_form_type_category
DROP TABLE IF EXISTS `research_evaluation_form_type_category`;
CREATE TABLE IF NOT EXISTS `research_evaluation_form_type_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `research_evaluation_form_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `research_evaluation_form_type_id` (`research_evaluation_form_type_id`),
  CONSTRAINT `research_evaluation_form_type_category_ibfk_1` FOREIGN KEY (`research_evaluation_form_type_id`) REFERENCES `research_evaluation_form_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_has_supervisors
DROP TABLE IF EXISTS `research_has_supervisors`;
CREATE TABLE IF NOT EXISTS `research_has_supervisors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `researches_id` int NOT NULL,
  `research_supervisors_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_has_supervisors_researches1_idx` (`researches_id`),
  KEY `fk_research_has_supervisors_research_supervisors1_idx` (`research_supervisors_id`),
  CONSTRAINT `fk_research_has_supervisors_research_supervisors1` FOREIGN KEY (`research_supervisors_id`) REFERENCES `research_supervisors` (`id`),
  CONSTRAINT `fk_research_has_supervisors_researches1` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_patent
DROP TABLE IF EXISTS `research_patent`;
CREATE TABLE IF NOT EXISTS `research_patent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `patent_no` varchar(255) DEFAULT NULL,
  `patented_date` datetime DEFAULT NULL,
  `researches_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_patent_researches1_idx` (`researches_id`),
  CONSTRAINT `fk_research_patent_researches1` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_publications
DROP TABLE IF EXISTS `research_publications`;
CREATE TABLE IF NOT EXISTS `research_publications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `publication_no` varchar(255) DEFAULT NULL,
  `link` text,
  `published_date` datetime DEFAULT NULL,
  `researches_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_publications_researches1_idx` (`researches_id`),
  CONSTRAINT `fk_research_publications_researches1` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_steps
DROP TABLE IF EXISTS `research_steps`;
CREATE TABLE IF NOT EXISTS `research_steps` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_steps_history
DROP TABLE IF EXISTS `research_steps_history`;
CREATE TABLE IF NOT EXISTS `research_steps_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` datetime DEFAULT NULL,
  `researches_id` int NOT NULL,
  `research_steps_id` int NOT NULL,
  `general_user_profilegup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_steps_history_researches1_idx` (`researches_id`),
  KEY `fk_research_steps_history_research_steps1_idx` (`research_steps_id`),
  KEY `fk_research_steps_history_general_user_profile1_idx` (`general_user_profilegup_id`),
  CONSTRAINT `fk_research_steps_history_general_user_profile1` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_research_steps_history_research_steps1` FOREIGN KEY (`research_steps_id`) REFERENCES `research_steps` (`id`),
  CONSTRAINT `fk_research_steps_history_researches1` FOREIGN KEY (`researches_id`) REFERENCES `researches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3107 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_student
DROP TABLE IF EXISTS `research_student`;
CREATE TABLE IF NOT EXISTS `research_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` datetime DEFAULT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_student_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_reserach_student_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3542 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_student_subjects
DROP TABLE IF EXISTS `research_student_subjects`;
CREATE TABLE IF NOT EXISTS `research_student_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `research_subjects_id` int NOT NULL,
  `researches_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_student_subjects_research_subjects1_idx` (`research_subjects_id`),
  KEY `fk_research_student_subjects_researches1_idx` (`researches_id`),
  CONSTRAINT `fk_research_student_subjects_research_subjects1` FOREIGN KEY (`research_subjects_id`) REFERENCES `research_subjects` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4874 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_subjects
DROP TABLE IF EXISTS `research_subjects`;
CREATE TABLE IF NOT EXISTS `research_subjects` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `research_subject_status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_subjects_research_subject_status1_idx` (`research_subject_status_id`),
  CONSTRAINT `fk_research_subjects_research_subject_status1` FOREIGN KEY (`research_subject_status_id`) REFERENCES `research_subject_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_subject_approval_manager
DROP TABLE IF EXISTS `research_subject_approval_manager`;
CREATE TABLE IF NOT EXISTS `research_subject_approval_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `research_subjects_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `universal_approve_status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_subject_approval_manager_research_subjects1_idx` (`research_subjects_id`),
  KEY `fk_research_subject_approval_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_research_subject_approval_manager_universal_approve_stat_idx` (`universal_approve_status_id`),
  CONSTRAINT `fk_research_subject_approval_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_research_subject_approval_manager_research_subjects1` FOREIGN KEY (`research_subjects_id`) REFERENCES `research_subjects` (`id`),
  CONSTRAINT `fk_research_subject_approval_manager_universal_approve_status1` FOREIGN KEY (`universal_approve_status_id`) REFERENCES `universal_approve_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_subject_status
DROP TABLE IF EXISTS `research_subject_status`;
CREATE TABLE IF NOT EXISTS `research_subject_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.research_supervisors
DROP TABLE IF EXISTS `research_supervisors`;
CREATE TABLE IF NOT EXISTS `research_supervisors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_research_supervisors_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_research_supervisors_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.revolver_status
DROP TABLE IF EXISTS `revolver_status`;
CREATE TABLE IF NOT EXISTS `revolver_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.risk_category
DROP TABLE IF EXISTS `risk_category`;
CREATE TABLE IF NOT EXISTS `risk_category` (
  `rc_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_score` int NOT NULL,
  `max_score` int NOT NULL,
  `color_code` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'UI color for risk level',
  `description` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`rc_id`),
  KEY `idx_risk_category_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sampling_table
DROP TABLE IF EXISTS `sampling_table`;
CREATE TABLE IF NOT EXISTS `sampling_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `population_size` double DEFAULT NULL,
  `sample_size` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.satisfaction_level
DROP TABLE IF EXISTS `satisfaction_level`;
CREATE TABLE IF NOT EXISTS `satisfaction_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sbc_status
DROP TABLE IF EXISTS `sbc_status`;
CREATE TABLE IF NOT EXISTS `sbc_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sbc_status_manager
DROP TABLE IF EXISTS `sbc_status_manager`;
CREATE TABLE IF NOT EXISTS `sbc_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sbc_status_id` int NOT NULL,
  `student_batches_sb_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sbc_status_manager_sbc_status1_idx` (`sbc_status_id`),
  KEY `fk_sbc_status_manager_student_batches1_idx` (`student_batches_sb_id`),
  CONSTRAINT `fk_sbc_status_manager_sbc_status1` FOREIGN KEY (`sbc_status_id`) REFERENCES `sbc_status` (`id`),
  CONSTRAINT `fk_sbc_status_manager_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scheduled_content
DROP TABLE IF EXISTS `scheduled_content`;
CREATE TABLE IF NOT EXISTS `scheduled_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int NOT NULL,
  `lesson_content_id` int NOT NULL,
  `is_completed` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_lesson_content_time_table1_idx` (`time_table_id`),
  KEY `fk_lesson_content_lesson_content1_idx` (`lesson_content_id`),
  CONSTRAINT `fk_lesson_content_lesson_content1` FOREIGN KEY (`lesson_content_id`) REFERENCES `lesson_content` (`id`),
  CONSTRAINT `fk_lesson_content_time_table1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scholarship_email_type
DROP TABLE IF EXISTS `scholarship_email_type`;
CREATE TABLE IF NOT EXISTS `scholarship_email_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scholarship_groups
DROP TABLE IF EXISTS `scholarship_groups`;
CREATE TABLE IF NOT EXISTS `scholarship_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_scholarship_groups_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_scholarship_groups_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=1368 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scholarship_marking_criteria_type
DROP TABLE IF EXISTS `scholarship_marking_criteria_type`;
CREATE TABLE IF NOT EXISTS `scholarship_marking_criteria_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scholarship_payment_scheduler
DROP TABLE IF EXISTS `scholarship_payment_scheduler`;
CREATE TABLE IF NOT EXISTS `scholarship_payment_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scholarship_value` double DEFAULT NULL,
  `release_date` date DEFAULT NULL,
  `course_fee` double DEFAULT NULL,
  `discounted_fee` double DEFAULT NULL,
  `payment1_date` date DEFAULT NULL,
  `payment1_amount` double DEFAULT NULL,
  `payment1_paid` double DEFAULT NULL,
  `payment1_due` double DEFAULT NULL,
  `payment2_date` date DEFAULT NULL,
  `payment2_amount` double DEFAULT NULL,
  `payment2_paid` double DEFAULT NULL,
  `payment2_due` double DEFAULT NULL,
  `payment3_date` date DEFAULT NULL,
  `payment3_amount` double DEFAULT NULL,
  `payment3_paid` double DEFAULT NULL,
  `payment3_due` double DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `course_cid` int DEFAULT NULL,
  `scholarship_groups_id` int DEFAULT NULL,
  `year_payment_value` double DEFAULT NULL,
  `semester_payment_value` double DEFAULT NULL,
  `scholarship_email_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_scholarship_payment_scheduler_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_scholarship_payment_scheduler_course1_idx` (`course_cid`),
  KEY `fk_scholarship_payment_scheduler_scholarship_groups1_idx` (`scholarship_groups_id`),
  KEY `scholarship_email_type_id` (`scholarship_email_type_id`),
  CONSTRAINT `fk_scholarship_payment_scheduler_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_scholarship_payment_scheduler_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_scholarship_payment_scheduler_scholarship_groups1` FOREIGN KEY (`scholarship_groups_id`) REFERENCES `scholarship_groups` (`id`),
  CONSTRAINT `scholarship_payment_scheduler_ibfk_1` FOREIGN KEY (`scholarship_email_type_id`) REFERENCES `scholarship_email_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13503 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scholaship_marking_criteria
DROP TABLE IF EXISTS `scholaship_marking_criteria`;
CREATE TABLE IF NOT EXISTS `scholaship_marking_criteria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.scoa_type
DROP TABLE IF EXISTS `scoa_type`;
CREATE TABLE IF NOT EXISTS `scoa_type` (
  `id_st` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_st`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.section
DROP TABLE IF EXISTS `section`;
CREATE TABLE IF NOT EXISTS `section` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `building_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_section_building1_idx` (`building_id`),
  CONSTRAINT `fk_section_building1` FOREIGN KEY (`building_id`) REFERENCES `building` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.security_question
DROP TABLE IF EXISTS `security_question`;
CREATE TABLE IF NOT EXISTS `security_question` (
  `id_sq` int NOT NULL DEFAULT '0',
  `question` text,
  PRIMARY KEY (`id_sq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.selection_program_link_manager
DROP TABLE IF EXISTS `selection_program_link_manager`;
CREATE TABLE IF NOT EXISTS `selection_program_link_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lecture_bucket_id` int DEFAULT NULL,
  `link` varchar(1000) DEFAULT NULL,
  `lecture_date` date DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `upload_by` int DEFAULT NULL,
  `upload_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__lecture_buckets` (`lecture_bucket_id`),
  KEY `upload_by` (`upload_by`),
  CONSTRAINT `FK__lecture_buckets` FOREIGN KEY (`lecture_bucket_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `selection_program_link_manager_ibfk_1` FOREIGN KEY (`upload_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=933 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.semester
DROP TABLE IF EXISTS `semester`;
CREATE TABLE IF NOT EXISTS `semester` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar
DROP TABLE IF EXISTS `seminar`;
CREATE TABLE IF NOT EXISTS `seminar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(345) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `seminar_category_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `advertising_material_id` int DEFAULT NULL,
  `location` int DEFAULT NULL,
  `no` varchar(45) DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_course1_idx` (`course_cid`),
  KEY `fk_seminar_seminar_category1_idx` (`seminar_category_id`),
  KEY `fk_seminar_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_seminar_advertising_material1_idx` (`advertising_material_id`),
  KEY `fk_seminar_general_organization_profile2_idx` (`location`),
  KEY `branch_bid` (`branch_bid`),
  CONSTRAINT `fk_seminar_advertising_material1` FOREIGN KEY (`advertising_material_id`) REFERENCES `advertising_material` (`id`),
  CONSTRAINT `fk_seminar_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_seminar_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_seminar_general_organization_profile2` FOREIGN KEY (`location`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_seminar_seminar_category1` FOREIGN KEY (`seminar_category_id`) REFERENCES `seminar_category` (`id`),
  CONSTRAINT `seminar_ibfk_1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=2193 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_batch
DROP TABLE IF EXISTS `seminar_batch`;
CREATE TABLE IF NOT EXISTS `seminar_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seminar_id` int NOT NULL,
  `batches_b_id` int NOT NULL,
  `hall_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_batch_seminar1_idx` (`seminar_id`),
  KEY `fk_seminar_batch_batches1_idx` (`batches_b_id`),
  KEY `fk_seminar_batch_hall1_idx` (`hall_id`),
  CONSTRAINT `fk_seminar_batch_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_seminar_batch_hall1` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`),
  CONSTRAINT `fk_seminar_batch_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_budget
DROP TABLE IF EXISTS `seminar_budget`;
CREATE TABLE IF NOT EXISTS `seminar_budget` (
  `id` int NOT NULL AUTO_INCREMENT,
  `budgeted_amount` double DEFAULT NULL,
  `seminar_budget_category_id` int NOT NULL,
  `seminar_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_budget_seminar_budget_category1_idx` (`seminar_budget_category_id`),
  KEY `fk_seminar_budget_seminar1_idx` (`seminar_id`),
  CONSTRAINT `fk_seminar_budget_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`),
  CONSTRAINT `fk_seminar_budget_seminar_budget_category1` FOREIGN KEY (`seminar_budget_category_id`) REFERENCES `seminar_budget_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_budget_category
DROP TABLE IF EXISTS `seminar_budget_category`;
CREATE TABLE IF NOT EXISTS `seminar_budget_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_category
DROP TABLE IF EXISTS `seminar_category`;
CREATE TABLE IF NOT EXISTS `seminar_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_details
DROP TABLE IF EXISTS `seminar_details`;
CREATE TABLE IF NOT EXISTS `seminar_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seminar_count` int DEFAULT NULL,
  `exam_sat` int DEFAULT NULL,
  `exam_absent` int DEFAULT NULL,
  `seminar_id` int NOT NULL,
  `seminar_hall_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_details_seminar1_idx` (`seminar_id`),
  KEY `fk_seminar_details_seminar_hall1_idx` (`seminar_hall_id`),
  CONSTRAINT `fk_seminar_details_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`),
  CONSTRAINT `fk_seminar_details_seminar_hall1` FOREIGN KEY (`seminar_hall_id`) REFERENCES `seminar_hall` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_examination
DROP TABLE IF EXISTS `seminar_examination`;
CREATE TABLE IF NOT EXISTS `seminar_examination` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `upload_paper` varchar(245) DEFAULT NULL,
  `upload_marking_schem` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_hall
DROP TABLE IF EXISTS `seminar_hall`;
CREATE TABLE IF NOT EXISTS `seminar_hall` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `hall_charge` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_has_examination
DROP TABLE IF EXISTS `seminar_has_examination`;
CREATE TABLE IF NOT EXISTS `seminar_has_examination` (
  `id` int NOT NULL AUTO_INCREMENT,
  `seminar_id` int NOT NULL,
  `seminar_examination_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_has_examination_seminar1_idx` (`seminar_id`),
  KEY `fk_seminar_has_examination_seminar_examination1_idx` (`seminar_examination_id`),
  CONSTRAINT `fk_seminar_has_examination_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`),
  CONSTRAINT `fk_seminar_has_examination_seminar_examination1` FOREIGN KEY (`seminar_examination_id`) REFERENCES `seminar_examination` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_history
DROP TABLE IF EXISTS `seminar_history`;
CREATE TABLE IF NOT EXISTS `seminar_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assign_date` datetime DEFAULT NULL,
  `student_sid` int NOT NULL,
  `seminar_to` int NOT NULL,
  `seminar_from` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_seminar_history_leads1_idx` (`student_sid`) USING BTREE,
  KEY `fk_seminar_history_seminar1_idx` (`seminar_to`) USING BTREE,
  KEY `seminar_from` (`seminar_from`),
  CONSTRAINT `fk_seminar_history_leads1` FOREIGN KEY (`student_sid`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_seminar_history_seminar1` FOREIGN KEY (`seminar_to`) REFERENCES `seminar` (`id`),
  CONSTRAINT `seminar_history_ibfk_1` FOREIGN KEY (`seminar_from`) REFERENCES `seminar` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=94564 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_images
DROP TABLE IF EXISTS `seminar_images`;
CREATE TABLE IF NOT EXISTS `seminar_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(245) DEFAULT NULL,
  `description` text,
  `seminar_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_images_seminar1_idx` (`seminar_id`),
  CONSTRAINT `fk_seminar_images_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_participants
DROP TABLE IF EXISTS `seminar_participants`;
CREATE TABLE IF NOT EXISTS `seminar_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `discount_percentage` double DEFAULT NULL,
  `exam_sat` tinyint(1) DEFAULT NULL,
  `seminar_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `city_id_c` int NOT NULL,
  `course_type_course_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_participants_seminar1_idx` (`seminar_id`),
  KEY `fk_seminar_participants_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_seminar_participants_city1_idx` (`city_id_c`),
  KEY `fk_seminar_participants_course_type1_idx` (`course_type_course_type_id`),
  CONSTRAINT `fk_seminar_participants_city1` FOREIGN KEY (`city_id_c`) REFERENCES `city` (`id_c`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seminar_participants_course_type1` FOREIGN KEY (`course_type_course_type_id`) REFERENCES `course_type` (`course_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seminar_participants_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seminar_participants_seminar1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1136 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.seminar_students_examination
DROP TABLE IF EXISTS `seminar_students_examination`;
CREATE TABLE IF NOT EXISTS `seminar_students_examination` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marks` int DEFAULT NULL,
  `answer_sheet` varchar(245) DEFAULT NULL,
  `seminar_participants_id` int NOT NULL,
  `seminar_examination_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_seminar_students_examination_seminar_participants1_idx` (`seminar_participants_id`),
  KEY `fk_seminar_students_examination_seminar_examination1_idx` (`seminar_examination_id`),
  CONSTRAINT `fk_seminar_students_examination_seminar_examination1` FOREIGN KEY (`seminar_examination_id`) REFERENCES `seminar_examination` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_seminar_students_examination_seminar_participants1` FOREIGN KEY (`seminar_participants_id`) REFERENCES `seminar_participants` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sent_email_bulk
DROP TABLE IF EXISTS `sent_email_bulk`;
CREATE TABLE IF NOT EXISTS `sent_email_bulk` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sent_date` datetime DEFAULT NULL,
  `sent_by` int DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sent_by` (`sent_by`) USING BTREE,
  CONSTRAINT `sent_email_bulk_ibfk_1` FOREIGN KEY (`sent_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sent_email_bulk_intake
DROP TABLE IF EXISTS `sent_email_bulk_intake`;
CREATE TABLE IF NOT EXISTS `sent_email_bulk_intake` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sent_email_bulk_id` int DEFAULT NULL,
  `batchesb_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sent_email_bulk_id` (`sent_email_bulk_id`) USING BTREE,
  KEY `batchesb_id` (`batchesb_id`) USING BTREE,
  CONSTRAINT `sent_email_bulk_intake_ibfk_1` FOREIGN KEY (`sent_email_bulk_id`) REFERENCES `sent_email_bulk` (`id`),
  CONSTRAINT `sent_email_bulk_intake_ibfk_2` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.servey_type
DROP TABLE IF EXISTS `servey_type`;
CREATE TABLE IF NOT EXISTS `servey_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.setting
DROP TABLE IF EXISTS `setting`;
CREATE TABLE IF NOT EXISTS `setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `value` double DEFAULT NULL,
  `setting_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_setting_setting_type1_idx` (`setting_type_id`),
  CONSTRAINT `fk_setting_setting_type1` FOREIGN KEY (`setting_type_id`) REFERENCES `setting_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10736 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.setting_type
DROP TABLE IF EXISTS `setting_type`;
CREATE TABLE IF NOT EXISTS `setting_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.set_target
DROP TABLE IF EXISTS `set_target`;
CREATE TABLE IF NOT EXISTS `set_target` (
  `id_st` int NOT NULL AUTO_INCREMENT,
  `year` varchar(45) DEFAULT NULL,
  `month` varchar(45) DEFAULT NULL,
  `target` int DEFAULT NULL,
  `course_for_mm_id_cfm` int NOT NULL,
  `gop_for_mm_id_gfm` varchar(45) NOT NULL,
  PRIMARY KEY (`id_st`),
  KEY `fk_set_target_course_for_mm1_idx` (`course_for_mm_id_cfm`),
  KEY `fk_set_target_gop_for_mm1_idx` (`gop_for_mm_id_gfm`),
  CONSTRAINT `fk_set_target_course_for_mm1` FOREIGN KEY (`course_for_mm_id_cfm`) REFERENCES `course_for_mm` (`id_cfm`),
  CONSTRAINT `fk_set_target_gop_for_mm1` FOREIGN KEY (`gop_for_mm_id_gfm`) REFERENCES `gop_for_mm` (`id_gfm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.short_course
DROP TABLE IF EXISTS `short_course`;
CREATE TABLE IF NOT EXISTS `short_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `short_coursecol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.short_course_syllabus
DROP TABLE IF EXISTS `short_course_syllabus`;
CREATE TABLE IF NOT EXISTS `short_course_syllabus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `fee` double DEFAULT NULL,
  `short_course_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_short_course_syllabus_short_course1_idx` (`short_course_id`),
  KEY `fk_short_course_syllabus_course1_idx` (`course_cid`),
  CONSTRAINT `fk_short_course_syllabus_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_short_course_syllabus_short_course1` FOREIGN KEY (`short_course_id`) REFERENCES `short_course` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.slot_repetition_manager
DROP TABLE IF EXISTS `slot_repetition_manager`;
CREATE TABLE IF NOT EXISTS `slot_repetition_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `occurrences_id` int NOT NULL,
  `time_table_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_time_table_has_occurrences_occurrences1_idx` (`occurrences_id`),
  KEY `fk_time_table_has_occurrences_time_table1_idx` (`time_table_id`),
  CONSTRAINT `fk_time_table_has_occurrences_occurrences1` FOREIGN KEY (`occurrences_id`) REFERENCES `occurrences` (`id`),
  CONSTRAINT `fk_time_table_has_occurrences_time_table1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sm_course
DROP TABLE IF EXISTS `sm_course`;
CREATE TABLE IF NOT EXISTS `sm_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sm_course_course1_idx` (`course_cid`),
  CONSTRAINT `fk_sm_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sm_hall
DROP TABLE IF EXISTS `sm_hall`;
CREATE TABLE IF NOT EXISTS `sm_hall` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hall_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sm_hall_hall1_idx` (`hall_id`),
  CONSTRAINT `fk_sm_hall_hall1` FOREIGN KEY (`hall_id`) REFERENCES `hall` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.society
DROP TABLE IF EXISTS `society`;
CREATE TABLE IF NOT EXISTS `society` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `cover_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.society_students
DROP TABLE IF EXISTS `society_students`;
CREATE TABLE IF NOT EXISTS `society_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `society_id` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `registered_date` datetime NOT NULL,
  `is_active` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_society_reqistered_student_society` (`society_id`),
  KEY `FK_society_reqistered_student_student` (`students_id`),
  CONSTRAINT `FK_society_reqistered_student_society` FOREIGN KEY (`society_id`) REFERENCES `society` (`id`),
  CONSTRAINT `FK_society_reqistered_student_student` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1928 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_buyer
DROP TABLE IF EXISTS `software_valley_buyer`;
CREATE TABLE IF NOT EXISTS `software_valley_buyer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_buyer_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_software_valley_buyer_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_category
DROP TABLE IF EXISTS `software_valley_category`;
CREATE TABLE IF NOT EXISTS `software_valley_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_chat
DROP TABLE IF EXISTS `software_valley_chat`;
CREATE TABLE IF NOT EXISTS `software_valley_chat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chat_time` datetime DEFAULT NULL,
  `chat` text,
  `is_seller_recieved` tinyint(1) DEFAULT NULL,
  `software_valley_chat_room_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_chat_software_valley_chat_room1_idx` (`software_valley_chat_room_id`),
  CONSTRAINT `fk_software_valley_chat_software_valley_chat_room1` FOREIGN KEY (`software_valley_chat_room_id`) REFERENCES `software_valley_chat_room` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_chat_attachments
DROP TABLE IF EXISTS `software_valley_chat_attachments`;
CREATE TABLE IF NOT EXISTS `software_valley_chat_attachments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `software_valley_chat_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_chat_attachments_software_valley_chat1_idx` (`software_valley_chat_id`),
  CONSTRAINT `fk_software_valley_chat_attachments_software_valley_chat1` FOREIGN KEY (`software_valley_chat_id`) REFERENCES `software_valley_chat` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_chat_room
DROP TABLE IF EXISTS `software_valley_chat_room`;
CREATE TABLE IF NOT EXISTS `software_valley_chat_room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime DEFAULT NULL,
  `software_valley_user_id` int NOT NULL,
  `software_valley_buyer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_chat_room_software_valley_user1_idx` (`software_valley_user_id`),
  KEY `fk_software_valley_chat_room_software_valley_buyer1_idx` (`software_valley_buyer_id`),
  CONSTRAINT `fk_software_valley_chat_room_software_valley_buyer1` FOREIGN KEY (`software_valley_buyer_id`) REFERENCES `software_valley_buyer` (`id`),
  CONSTRAINT `fk_software_valley_chat_room_software_valley_user1` FOREIGN KEY (`software_valley_user_id`) REFERENCES `software_valley_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_languages
DROP TABLE IF EXISTS `software_valley_languages`;
CREATE TABLE IF NOT EXISTS `software_valley_languages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_language_manager
DROP TABLE IF EXISTS `software_valley_language_manager`;
CREATE TABLE IF NOT EXISTS `software_valley_language_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_valley_user_id` int NOT NULL,
  `software_valley_language_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_languages_manager_software_valley_user1_idx` (`software_valley_user_id`),
  KEY `fk_software_valley_languages_manager_software_valley_langua_idx` (`software_valley_language_id`),
  CONSTRAINT `fk_software_valley_languages_manager_software_valley_languages1` FOREIGN KEY (`software_valley_language_id`) REFERENCES `software_valley_languages` (`id`),
  CONSTRAINT `fk_software_valley_languages_manager_software_valley_user1` FOREIGN KEY (`software_valley_user_id`) REFERENCES `software_valley_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_links
DROP TABLE IF EXISTS `software_valley_links`;
CREATE TABLE IF NOT EXISTS `software_valley_links` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_links_manager
DROP TABLE IF EXISTS `software_valley_links_manager`;
CREATE TABLE IF NOT EXISTS `software_valley_links_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link_name` text,
  `software_valley_links_id` int NOT NULL,
  `software_valley_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_links_manager_software_valley_links1_idx` (`software_valley_links_id`),
  KEY `fk_software_valley_links_manager_software_valley_user1_idx` (`software_valley_user_id`),
  CONSTRAINT `fk_software_valley_links_manager_software_valley_links1` FOREIGN KEY (`software_valley_links_id`) REFERENCES `software_valley_links` (`id`),
  CONSTRAINT `fk_software_valley_links_manager_software_valley_user1` FOREIGN KEY (`software_valley_user_id`) REFERENCES `software_valley_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_online_transactions
DROP TABLE IF EXISTS `software_valley_online_transactions`;
CREATE TABLE IF NOT EXISTS `software_valley_online_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_valley_purchase_id` int NOT NULL,
  `amount` double DEFAULT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `response_code` int DEFAULT NULL,
  `reason_code` int DEFAULT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_online_transactions_software_valley_purc_idx` (`software_valley_purchase_id`),
  CONSTRAINT `fk_software_valley_online_transactions_software_valley_purcha1` FOREIGN KEY (`software_valley_purchase_id`) REFERENCES `software_valley_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project
DROP TABLE IF EXISTS `software_valley_project`;
CREATE TABLE IF NOT EXISTS `software_valley_project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` text,
  `description` text,
  `software_valley_user_id` int NOT NULL,
  `software_valley_sub_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_projects_software_valley_user1_idx` (`software_valley_user_id`),
  KEY `fk_software_valley_projects_software_valley_project_sub_cat_idx` (`software_valley_sub_category_id`),
  CONSTRAINT `fk_software_valley_software_valley_project_sub_categ1` FOREIGN KEY (`software_valley_sub_category_id`) REFERENCES `software_valley_sub_category` (`id`),
  CONSTRAINT `fk_software_valley_software_valley_user1` FOREIGN KEY (`software_valley_user_id`) REFERENCES `software_valley_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_files
DROP TABLE IF EXISTS `software_valley_project_files`;
CREATE TABLE IF NOT EXISTS `software_valley_project_files` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `software_valley_project_file_type_id` int NOT NULL,
  `software_valley_project_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_project_files_software_valley_project_fi_idx` (`software_valley_project_file_type_id`),
  KEY `fk_software_valley_project_files_software_valley_projects1_idx` (`software_valley_project_id`),
  CONSTRAINT `fk_software_valley_project_files_software_valley_project_file1` FOREIGN KEY (`software_valley_project_file_type_id`) REFERENCES `software_valley_project_file_type` (`id`),
  CONSTRAINT `fk_software_valley_project_files_software_valley_projects1` FOREIGN KEY (`software_valley_project_id`) REFERENCES `software_valley_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_file_type
DROP TABLE IF EXISTS `software_valley_project_file_type`;
CREATE TABLE IF NOT EXISTS `software_valley_project_file_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_packages
DROP TABLE IF EXISTS `software_valley_project_packages`;
CREATE TABLE IF NOT EXISTS `software_valley_project_packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `package_name` varchar(45) DEFAULT NULL,
  `description` text,
  `delivery_time` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `number_of_pages` int DEFAULT NULL,
  `software_valley_project_id` int NOT NULL,
  `software_valley_project_package_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_project_packages_software_valley_project_idx` (`software_valley_project_id`),
  KEY `fk_software_valley_project_packages_software_valley_project_idx1` (`software_valley_project_package_type_id`),
  CONSTRAINT `fk_software_valley_project_packages_software_valley_project_p1` FOREIGN KEY (`software_valley_project_package_type_id`) REFERENCES `software_valley_project_package_type` (`id`),
  CONSTRAINT `fk_software_valley_project_packages_software_valley_projects1` FOREIGN KEY (`software_valley_project_id`) REFERENCES `software_valley_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_package_type
DROP TABLE IF EXISTS `software_valley_project_package_type`;
CREATE TABLE IF NOT EXISTS `software_valley_project_package_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_requirements
DROP TABLE IF EXISTS `software_valley_project_requirements`;
CREATE TABLE IF NOT EXISTS `software_valley_project_requirements` (
  `id` int NOT NULL AUTO_INCREMENT,
  `description` text,
  `url_1` text,
  `url_2` text,
  `url_3` text,
  `software_valley_purchase_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_project_requirements_software_valley_pur_idx` (`software_valley_purchase_id`),
  CONSTRAINT `fk_software_valley_project_requirements_software_valley_purch1` FOREIGN KEY (`software_valley_purchase_id`) REFERENCES `software_valley_purchase` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_project_tags
DROP TABLE IF EXISTS `software_valley_project_tags`;
CREATE TABLE IF NOT EXISTS `software_valley_project_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_valley_tags_id` int NOT NULL,
  `software_valley_project_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_project_tags_manager_software_valley_pro_idx` (`software_valley_tags_id`),
  KEY `fk_software_valley_project_tags_manager_software_valley_pro_idx1` (`software_valley_project_id`),
  CONSTRAINT `fk_software_valley_project_tags_manager_software_valley_proje1` FOREIGN KEY (`software_valley_tags_id`) REFERENCES `software_valley_tags` (`id`),
  CONSTRAINT `fk_software_valley_project_tags_manager_software_valley_proje2` FOREIGN KEY (`software_valley_project_id`) REFERENCES `software_valley_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_purchase
DROP TABLE IF EXISTS `software_valley_purchase`;
CREATE TABLE IF NOT EXISTS `software_valley_purchase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `purchased_date` datetime DEFAULT NULL,
  `software_valley_buyer_id` int NOT NULL,
  `amount` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `software_valley_project_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_purchase_software_valley_buyer1_idx` (`software_valley_buyer_id`),
  KEY `fk_software_valley_purchase_software_valley_project1_idx` (`software_valley_project_id`),
  CONSTRAINT `fk_software_valley_purchase_software_valley_buyer1` FOREIGN KEY (`software_valley_buyer_id`) REFERENCES `software_valley_buyer` (`id`),
  CONSTRAINT `fk_software_valley_purchase_software_valley_project1` FOREIGN KEY (`software_valley_project_id`) REFERENCES `software_valley_project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_skills
DROP TABLE IF EXISTS `software_valley_skills`;
CREATE TABLE IF NOT EXISTS `software_valley_skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_skills_manager
DROP TABLE IF EXISTS `software_valley_skills_manager`;
CREATE TABLE IF NOT EXISTS `software_valley_skills_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `software_valley_skills_id` int NOT NULL,
  `software_valley_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_skills_manager_software_valley_skills1_idx` (`software_valley_skills_id`),
  KEY `fk_software_valley_skills_manager_software_valley_user1_idx` (`software_valley_user_id`),
  CONSTRAINT `fk_software_valley_skills_manager_software_valley_skills1` FOREIGN KEY (`software_valley_skills_id`) REFERENCES `software_valley_skills` (`id`),
  CONSTRAINT `fk_software_valley_skills_manager_software_valley_user1` FOREIGN KEY (`software_valley_user_id`) REFERENCES `software_valley_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_sub_category
DROP TABLE IF EXISTS `software_valley_sub_category`;
CREATE TABLE IF NOT EXISTS `software_valley_sub_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `software_valley_category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_software_valley_project_sub_category_software_valley_pro_idx` (`software_valley_category_id`),
  CONSTRAINT `fk_software_valley_project_sub_category_software_valley_proje1` FOREIGN KEY (`software_valley_category_id`) REFERENCES `software_valley_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_tags
DROP TABLE IF EXISTS `software_valley_tags`;
CREATE TABLE IF NOT EXISTS `software_valley_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.software_valley_user
DROP TABLE IF EXISTS `software_valley_user`;
CREATE TABLE IF NOT EXISTS `software_valley_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `profile_created_date` datetime DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `profile_picture` text,
  `user_title` varchar(1000) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `description` text,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `student_s_id` (`student_s_id`),
  CONSTRAINT `software_valley_user_ibfk_1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.special_task
DROP TABLE IF EXISTS `special_task`;
CREATE TABLE IF NOT EXISTS `special_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.special_task_manager
DROP TABLE IF EXISTS `special_task_manager`;
CREATE TABLE IF NOT EXISTS `special_task_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT NULL,
  `special_task_id` int DEFAULT NULL,
  `last_comment` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `universal_bucket_manager_id` int DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `special_task_id` (`special_task_id`) USING BTREE,
  KEY `universal_bucket_manager_id` (`universal_bucket_manager_id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  CONSTRAINT `special_task_manager_ibfk_1` FOREIGN KEY (`special_task_id`) REFERENCES `special_task` (`id`),
  CONSTRAINT `special_task_manager_ibfk_2` FOREIGN KEY (`universal_bucket_manager_id`) REFERENCES `universal_bucket_manager` (`id`),
  CONSTRAINT `special_task_manager_ibfk_3` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18436 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sport
DROP TABLE IF EXISTS `sport`;
CREATE TABLE IF NOT EXISTS `sport` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `cover_url` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_batch
DROP TABLE IF EXISTS `sports_batch`;
CREATE TABLE IF NOT EXISTS `sports_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batch_name` varchar(45) DEFAULT NULL,
  `starting_date` datetime DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  `year_id` int DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_sport_batch_sport` (`sport_id`) USING BTREE,
  KEY `FK_sport_batch_year` (`year_id`) USING BTREE,
  KEY `FK_sport_batch_branch` (`branch_bid`) USING BTREE,
  CONSTRAINT `FK_sport_batch_branch` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `FK_sport_batch_sport` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`),
  CONSTRAINT `FK_sport_batch_year` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_batch_trainers
DROP TABLE IF EXISTS `sports_batch_trainers`;
CREATE TABLE IF NOT EXISTS `sports_batch_trainers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sports_trainer_id` int DEFAULT NULL,
  `sports_batch_id` int DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sports_trainer_id` (`sports_trainer_id`) USING BTREE,
  KEY `sports_batch_id` (`sports_batch_id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  CONSTRAINT `sports_batch_trainers_ibfk_1` FOREIGN KEY (`sports_trainer_id`) REFERENCES `sports_trainer` (`id`),
  CONSTRAINT `sports_batch_trainers_ibfk_2` FOREIGN KEY (`sports_batch_id`) REFERENCES `sports_batch` (`id`),
  CONSTRAINT `sports_batch_trainers_ibfk_3` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_club_attendance
DROP TABLE IF EXISTS `sports_club_attendance`;
CREATE TABLE IF NOT EXISTS `sports_club_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `is_attended` tinyint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  `sports_club_time_table_id` int DEFAULT NULL,
  `sports_club_member_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__sports_club_time_table` (`sports_club_time_table_id`) USING BTREE,
  KEY `FK__sports_club_member` (`sports_club_member_id`) USING BTREE,
  CONSTRAINT `FK__sports_club_member` FOREIGN KEY (`sports_club_member_id`) REFERENCES `sports_club_member` (`id`),
  CONSTRAINT `FK__sports_club_time_table` FOREIGN KEY (`sports_club_time_table_id`) REFERENCES `sports_club_time_table` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_club_member
DROP TABLE IF EXISTS `sports_club_member`;
CREATE TABLE IF NOT EXISTS `sports_club_member` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` datetime DEFAULT NULL,
  `students_id` int NOT NULL,
  `year_id` int DEFAULT NULL,
  `sports_club_member_status_id` int NOT NULL,
  `sports_batch_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sports_club_member_student1_idx` (`students_id`),
  KEY `fk_sports_club_member_year1_idx` (`year_id`),
  KEY `fk_sports_club_member_sports_club_member_status1_idx` (`sports_club_member_status_id`),
  KEY `sports_batch_id` (`sports_batch_id`),
  CONSTRAINT `fk_sports_club_member_sports_club_member_status1` FOREIGN KEY (`sports_club_member_status_id`) REFERENCES `sports_club_member_status` (`id`),
  CONSTRAINT `fk_sports_club_member_student1` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_sports_club_member_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`),
  CONSTRAINT `sports_club_member_ibfk_1` FOREIGN KEY (`sports_batch_id`) REFERENCES `sports_batch` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_club_member_status
DROP TABLE IF EXISTS `sports_club_member_status`;
CREATE TABLE IF NOT EXISTS `sports_club_member_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_club_time_table
DROP TABLE IF EXISTS `sports_club_time_table`;
CREATE TABLE IF NOT EXISTS `sports_club_time_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `starting_time` time DEFAULT NULL,
  `ending_time` time DEFAULT NULL,
  `scheduled_date` date DEFAULT NULL,
  `is_done` tinyint DEFAULT NULL,
  `sports_trainr_id` int DEFAULT NULL,
  `sports_batch_id` int DEFAULT NULL,
  `sports_location_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__sports_trainer` (`sports_trainr_id`) USING BTREE,
  KEY `FK__sports_batch` (`sports_batch_id`) USING BTREE,
  KEY `FK__sports_location` (`sports_location_id`) USING BTREE,
  CONSTRAINT `FK__sports_batch` FOREIGN KEY (`sports_batch_id`) REFERENCES `sports_batch` (`id`),
  CONSTRAINT `FK__sports_location` FOREIGN KEY (`sports_location_id`) REFERENCES `sports_location` (`id`),
  CONSTRAINT `FK__sports_trainer` FOREIGN KEY (`sports_trainr_id`) REFERENCES `sports_trainer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_location
DROP TABLE IF EXISTS `sports_location`;
CREATE TABLE IF NOT EXISTS `sports_location` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sports_trainer
DROP TABLE IF EXISTS `sports_trainer`;
CREATE TABLE IF NOT EXISTS `sports_trainer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` datetime DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `designation_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__sport` (`sport_id`) USING BTREE,
  KEY `FK__general_user_profile` (`general_user_profile_gup_id`) USING BTREE,
  CONSTRAINT `FK__general_user_profile` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK__sport` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sport_branch
DROP TABLE IF EXISTS `sport_branch`;
CREATE TABLE IF NOT EXISTS `sport_branch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sport_id` int DEFAULT NULL,
  `branch_bid` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sport_id` (`sport_id`) USING BTREE,
  KEY `branch_bid` (`branch_bid`) USING BTREE,
  CONSTRAINT `sport_branch_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`),
  CONSTRAINT `sport_branch_ibfk_2` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sport_club_member_status_manager
DROP TABLE IF EXISTS `sport_club_member_status_manager`;
CREATE TABLE IF NOT EXISTS `sport_club_member_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `sports_club_member_id` int NOT NULL,
  `sports_club_member_status_id` int NOT NULL,
  `login_session_session_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sport_club_member_status_manager_sports_club_member1_idx` (`sports_club_member_id`),
  KEY `fk_sport_club_member_status_manager_sports_club_member_stat_idx` (`sports_club_member_status_id`),
  KEY `fk_sport_club_member_status_manager_login_session1_idx` (`login_session_session_id`),
  CONSTRAINT `fk_sport_club_member_status_manager_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `fk_sport_club_member_status_manager_sports_club_member1` FOREIGN KEY (`sports_club_member_id`) REFERENCES `sports_club_member` (`id`),
  CONSTRAINT `fk_sport_club_member_status_manager_sports_club_member_status1` FOREIGN KEY (`sports_club_member_status_id`) REFERENCES `sports_club_member_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sport_registered_student
DROP TABLE IF EXISTS `sport_registered_student`;
CREATE TABLE IF NOT EXISTS `sport_registered_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` date DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `sport_id` (`sport_id`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  CONSTRAINT `sport_registered_student_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`),
  CONSTRAINT `sport_registered_student_ibfk_2` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2643 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.state
DROP TABLE IF EXISTS `state`;
CREATE TABLE IF NOT EXISTS `state` (
  `id_s` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `country_id_c` int DEFAULT NULL,
  PRIMARY KEY (`id_s`),
  KEY `fk_state_country1_idx` (`country_id_c`),
  CONSTRAINT `fk_state_country1` FOREIGN KEY (`country_id_c`) REFERENCES `country` (`id_c`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.status_manager
DROP TABLE IF EXISTS `status_manager`;
CREATE TABLE IF NOT EXISTS `status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status_id` varchar(45) DEFAULT NULL,
  `name` varchar(345) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.stp_branch
DROP TABLE IF EXISTS `stp_branch`;
CREATE TABLE IF NOT EXISTS `stp_branch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stp_branch_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_stp_branch_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.stp_gom
DROP TABLE IF EXISTS `stp_gom`;
CREATE TABLE IF NOT EXISTS `stp_gom` (
  `id_sp` int NOT NULL AUTO_INCREMENT,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id_sp`),
  KEY `fk_stp_gom_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_stp_gom_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.stp_student
DROP TABLE IF EXISTS `stp_student`;
CREATE TABLE IF NOT EXISTS `stp_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stp_student_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_stp_student_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8982 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student
DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `s_id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(255) DEFAULT NULL,
  `scn_no` varchar(45) DEFAULT NULL,
  `current_study` varchar(255) DEFAULT NULL,
  `iq_marks` double DEFAULT NULL,
  `school` varchar(255) DEFAULT NULL,
  `name_on_certificate` text,
  `academic_year` int DEFAULT NULL,
  `student_id_img` varchar(145) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `interview_statusis_id` int NOT NULL,
  `student_introduced_bysc_id` int NOT NULL,
  `coursecid` int NOT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `no_of_Installment` varchar(45) DEFAULT NULL,
  `course_fee_total_due_amount` double DEFAULT NULL,
  `intake_id` int DEFAULT NULL,
  `student_entry_stream_id` int DEFAULT NULL,
  `is_profile_data_verified` tinyint(1) DEFAULT NULL,
  `no_of_credits` double DEFAULT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `id_card_verified` tinyint(1) DEFAULT NULL,
  `seminar_date` date DEFAULT NULL,
  `verification_token` varchar(100) DEFAULT NULL,
  `seminar_id` int DEFAULT NULL,
  `certificate_name_verified` tinyint DEFAULT NULL,
  `certificate_name_verified_by` int DEFAULT NULL,
  `certificate_name_entered_at` datetime DEFAULT NULL,
  `certificate_name_verified_at` datetime DEFAULT NULL,
  `profile_name` varchar(255) DEFAULT NULL,
  `leads_reference` varchar(45) DEFAULT NULL,
  `bcu_id` varchar(50) DEFAULT NULL,
  `uk_award_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`s_id`),
  KEY `FKstudent412747` (`interview_statusis_id`),
  KEY `FKstudent901036` (`student_introduced_bysc_id`),
  KEY `FKstudent783696` (`coursecid`),
  KEY `FKstudent375572` (`general_user_profilegup_id`),
  KEY `fk_student_branch1_idx` (`branch_bid`),
  KEY `fk_student_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_intake1_idx` (`intake_id`),
  KEY `fk_student_student_entry_stream1_idx` (`student_entry_stream_id`),
  KEY `seminar_id` (`seminar_id`),
  KEY `certificate_name_verified_by` (`certificate_name_verified_by`),
  CONSTRAINT `fk_student_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_intake1` FOREIGN KEY (`intake_id`) REFERENCES `intake` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_student_entry_stream1` FOREIGN KEY (`student_entry_stream_id`) REFERENCES `student_entry_stream` (`id`),
  CONSTRAINT `FKstudent412747` FOREIGN KEY (`interview_statusis_id`) REFERENCES `interview_status` (`is_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKstudent783696` FOREIGN KEY (`coursecid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKstudent901036` FOREIGN KEY (`student_introduced_bysc_id`) REFERENCES `student_introduced_by` (`sc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`certificate_name_verified_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=154586 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.studentship_status
DROP TABLE IF EXISTS `studentship_status`;
CREATE TABLE IF NOT EXISTS `studentship_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.studentship_status_controller
DROP TABLE IF EXISTS `studentship_status_controller`;
CREATE TABLE IF NOT EXISTS `studentship_status_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `comment` text,
  `student_s_id` int NOT NULL,
  `studentship_status_id` int NOT NULL,
  `alert` text,
  PRIMARY KEY (`id`),
  KEY `fk_studentship_status_student1_idx` (`student_s_id`),
  KEY `fk_studentship_status_controller_studentship_status1_idx` (`studentship_status_id`),
  CONSTRAINT `fk_studentship_status_controller_studentship_status1` FOREIGN KEY (`studentship_status_id`) REFERENCES `studentship_status` (`id`),
  CONSTRAINT `fk_studentship_status_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_academic_status
DROP TABLE IF EXISTS `student_academic_status`;
CREATE TABLE IF NOT EXISTS `student_academic_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `qualification_type_id` int DEFAULT NULL,
  `batches_id` int DEFAULT NULL,
  `is_complete` tinyint DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `enterd_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_academic_status_student` (`student_id`),
  KEY `FK_student_academic_status_qualification_type` (`qualification_type_id`),
  KEY `FK_student_academic_status_general_user_profile` (`enterd_by`),
  KEY `FK_student_academic_status_batches` (`batches_id`) USING BTREE,
  CONSTRAINT `FK_student_academic_status_batches` FOREIGN KEY (`batches_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `FK_student_academic_status_general_user_profile` FOREIGN KEY (`enterd_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_academic_status_qualification_type` FOREIGN KEY (`qualification_type_id`) REFERENCES `qualification_type` (`id`),
  CONSTRAINT `FK_student_academic_status_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_alumni
DROP TABLE IF EXISTS `student_alumni`;
CREATE TABLE IF NOT EXISTS `student_alumni` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` tinyint(1) DEFAULT NULL,
  `entered_date` date DEFAULT NULL,
  `last_updated_date` date DEFAULT NULL,
  `description` text,
  `student_s_id` int NOT NULL,
  `designation_id_d` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `general_user_profile_gup_id_entered_by` int NOT NULL,
  `general_user_profile_gup_id_updated_by` int NOT NULL,
  `year_id` int NOT NULL,
  `priority` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_approved` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_alumni_student1_idx` (`student_s_id`),
  KEY `fk_student_alumni_designation1_idx` (`designation_id_d`),
  KEY `fk_student_alumni_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_alumni_general_user_profile1_idx` (`general_user_profile_gup_id_entered_by`),
  KEY `fk_student_alumni_general_user_profile2_idx` (`general_user_profile_gup_id_updated_by`),
  KEY `fk_student_alumni_year1_idx` (`year_id`),
  CONSTRAINT `fk_student_alumni_designation1` FOREIGN KEY (`designation_id_d`) REFERENCES `designation` (`id_d`),
  CONSTRAINT `fk_student_alumni_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_alumni_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id_entered_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_alumni_general_user_profile2` FOREIGN KEY (`general_user_profile_gup_id_updated_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_alumni_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_alumni_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1014 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_alumni_images
DROP TABLE IF EXISTS `student_alumni_images`;
CREATE TABLE IF NOT EXISTS `student_alumni_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(1000) DEFAULT NULL,
  `student_alumni_image_type_id` int NOT NULL,
  `student_alumni_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_alumni_images_student_alumni_image_type1_idx` (`student_alumni_image_type_id`),
  KEY `fk_student_alumni_images_student_alumni1_idx` (`student_alumni_id`),
  CONSTRAINT `fk_student_alumni_images_student_alumni1` FOREIGN KEY (`student_alumni_id`) REFERENCES `student_alumni` (`id`),
  CONSTRAINT `fk_student_alumni_images_student_alumni_image_type1` FOREIGN KEY (`student_alumni_image_type_id`) REFERENCES `student_alumni_image_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=547 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_alumni_image_type
DROP TABLE IF EXISTS `student_alumni_image_type`;
CREATE TABLE IF NOT EXISTS `student_alumni_image_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_application_course_preferences
DROP TABLE IF EXISTS `student_application_course_preferences`;
CREATE TABLE IF NOT EXISTS `student_application_course_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `student_application_manager_id` int NOT NULL,
  `major_sequence_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_application_course_preferences_student_applicati_idx` (`student_application_manager_id`),
  KEY `fk_student_application_course_preferences_major_sequence1_idx` (`major_sequence_id`),
  KEY `fk_student_application_course_preferences_general_organizat_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_student_application_course_preferences_general_organizatio1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_application_course_preferences_major_sequence1` FOREIGN KEY (`major_sequence_id`) REFERENCES `major_sequence` (`id`),
  CONSTRAINT `fk_student_application_course_preferences_student_application1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_application_documents
DROP TABLE IF EXISTS `student_application_documents`;
CREATE TABLE IF NOT EXISTS `student_application_documents` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_application_manager_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_application_documents_student_application_manage_idx` (`student_application_manager_id`),
  KEY `fk_student_application_documents_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_application_documents_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_application_documents_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_application_manager
DROP TABLE IF EXISTS `student_application_manager`;
CREATE TABLE IF NOT EXISTS `student_application_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_org_id` int NOT NULL,
  `applying_scheme_id` int NOT NULL,
  `student_id` varchar(255) DEFAULT NULL,
  `application_submitted_country` int NOT NULL,
  `bringing_family_count` int DEFAULT NULL,
  `is_citizen_of_aus_or_newz` tinyint(1) DEFAULT NULL,
  `hold_aus_visa` tinyint(1) DEFAULT NULL,
  `is_provided_documents` tinyint(1) DEFAULT NULL,
  `mibt_information_received` tinyint(1) DEFAULT NULL,
  `is_applying_for_recognition` tinyint(1) DEFAULT NULL,
  `declaration` tinyint(1) DEFAULT NULL,
  `created_date` date DEFAULT NULL,
  `signature` varchar(1000) DEFAULT NULL,
  `universal_approval_status_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_application_manager_student_org1_idx` (`student_org_id`),
  KEY `fk_student_application_manager_applying_scheme1_idx` (`applying_scheme_id`),
  KEY `fk_student_application_manager_country2_idx` (`application_submitted_country`),
  KEY `fk_student_application_manager_universal_approval_status_ma_idx` (`universal_approval_status_manager_id`),
  CONSTRAINT `fk_student_application_manager_applying_scheme1` FOREIGN KEY (`applying_scheme_id`) REFERENCES `applying_scheme` (`id`),
  CONSTRAINT `fk_student_application_manager_country2` FOREIGN KEY (`application_submitted_country`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_student_application_manager_student_org1` FOREIGN KEY (`student_org_id`) REFERENCES `student_org` (`id`),
  CONSTRAINT `fk_student_application_manager_universal_approval_status_mana1` FOREIGN KEY (`universal_approval_status_manager_id`) REFERENCES `universal_approval_status_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assesment_result
DROP TABLE IF EXISTS `student_assesment_result`;
CREATE TABLE IF NOT EXISTS `student_assesment_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marks` double DEFAULT NULL,
  `verified_marks` double DEFAULT NULL,
  `assesment_id` int NOT NULL,
  `accessed_by` int NOT NULL,
  `first_verification_by` int DEFAULT NULL,
  `second_verification_by` int DEFAULT NULL,
  `universal_result_type_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `accessor_feedback_form_id` int DEFAULT NULL,
  `student_assesment_result_status_id` int NOT NULL,
  `marks_release_date` date DEFAULT NULL,
  `marks_released_by` int DEFAULT NULL,
  `actual_mark` double DEFAULT NULL,
  `marked_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_assesment_result_assesment1_idx` (`assesment_id`),
  KEY `fk_student_assesment_result_employees1_idx` (`accessed_by`),
  KEY `fk_student_assesment_result_universal_result_type1_idx` (`universal_result_type_id`),
  KEY `fk_student_assesment_result_student1_idx` (`student_s_id`),
  KEY `fk_student_assesment_result_employees2_idx` (`first_verification_by`),
  KEY `fk_student_assesment_result_employees3_idx` (`second_verification_by`),
  KEY `fk_student_assesment_result_accessor_feedback_form1_idx` (`accessor_feedback_form_id`),
  KEY `fk_student_assesment_result_student_assesment_result_status_idx` (`student_assesment_result_status_id`),
  KEY `fk_student_assesment_result_employees4_idx` (`marks_released_by`),
  CONSTRAINT `fk_student_assesment_result_accessor_feedback_form1` FOREIGN KEY (`accessor_feedback_form_id`) REFERENCES `accessor_feedback_form` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_employees1` FOREIGN KEY (`accessed_by`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_employees2` FOREIGN KEY (`first_verification_by`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_employees3` FOREIGN KEY (`second_verification_by`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_employees4` FOREIGN KEY (`marks_released_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_student_assesment_result_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_student_assesment_result_status1` FOREIGN KEY (`student_assesment_result_status_id`) REFERENCES `student_assesment_result_status` (`id`),
  CONSTRAINT `fk_student_assesment_result_universal_result_type1` FOREIGN KEY (`universal_result_type_id`) REFERENCES `universal_result_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=82277 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assesment_result_doc
DROP TABLE IF EXISTS `student_assesment_result_doc`;
CREATE TABLE IF NOT EXISTS `student_assesment_result_doc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(245) DEFAULT NULL,
  `student_assesment_result_id` int NOT NULL,
  `universal_result_doc_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_assesment_result_doc_student_assesment_result1_idx` (`student_assesment_result_id`),
  KEY `fk_student_assesment_result_doc_universal_result_doc_type1_idx` (`universal_result_doc_type_id`),
  CONSTRAINT `fk_student_assesment_result_doc_student_assesment_result1` FOREIGN KEY (`student_assesment_result_id`) REFERENCES `student_assesment_result` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assesment_result_doc_universal_result_doc_type1` FOREIGN KEY (`universal_result_doc_type_id`) REFERENCES `universal_result_doc_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5279 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assesment_result_status
DROP TABLE IF EXISTS `student_assesment_result_status`;
CREATE TABLE IF NOT EXISTS `student_assesment_result_status` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '\n',
  `name` varchar(45) DEFAULT NULL COMMENT 'assingnment sumited\nyour assesment with the accesser\n\n\nMarks Entered\nRecomend To Re Assess\nFirst Verification Done\nSecond Verification Done\nReleased',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assessment_schedule_result_keeper
DROP TABLE IF EXISTS `student_assessment_schedule_result_keeper`;
CREATE TABLE IF NOT EXISTS `student_assessment_schedule_result_keeper` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_assesment_result_id` int DEFAULT NULL,
  `assessment_accessor_scheduler_id` int NOT NULL,
  `student_assignment_id` int NOT NULL,
  `universal_result_type_id` int NOT NULL,
  `student_assessment_schedule_result_keeper_id` int DEFAULT NULL,
  `assign_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_assessment_schedule_result_keeper_student_assesm_idx` (`student_assesment_result_id`),
  KEY `fk_student_assessment_schedule_result_keeper_assessment_acc_idx` (`assessment_accessor_scheduler_id`),
  KEY `fk_student_assessment_schedule_result_keeper_student_assign_idx` (`student_assignment_id`),
  KEY `fk_student_assessment_schedule_result_keeper_universal_resu_idx` (`universal_result_type_id`),
  KEY `fk_student_assessment_schedule_result_keeper_student_assess_idx` (`student_assessment_schedule_result_keeper_id`),
  CONSTRAINT `fk_student_assessment_schedule_result_keeper_student_assesmen1` FOREIGN KEY (`student_assesment_result_id`) REFERENCES `student_assesment_result` (`id`),
  CONSTRAINT `fk_student_assessment_schedule_result_keeper_universal_result1` FOREIGN KEY (`universal_result_type_id`) REFERENCES `universal_result_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=212778 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assignment
DROP TABLE IF EXISTS `student_assignment`;
CREATE TABLE IF NOT EXISTS `student_assignment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` date DEFAULT NULL,
  `uploaded_time` time DEFAULT NULL,
  `doc` text,
  `downloaded_count` int DEFAULT NULL,
  `agreed_as_not_submitted` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `assesment_id` int NOT NULL,
  `batches_b_id` int NOT NULL,
  `universal_result_type_id` int NOT NULL,
  `uploaded_by` int DEFAULT NULL,
  `is_late_submition` tinyint(1) DEFAULT NULL,
  `is_repeat_submition` tinyint(1) DEFAULT NULL,
  `other_url` text,
  `project_file_url` text,
  `student_assignment_group_id` int DEFAULT NULL,
  `submit_receipt` text,
  `receipt_submit_by` int DEFAULT NULL,
  `receipt_submit_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_assignment_student1_idx` (`student_s_id`),
  KEY `fk_student_assignment_assesment1_idx` (`assesment_id`),
  KEY `fk_student_assignment_batches1_idx` (`batches_b_id`),
  KEY `fk_student_assignment_universal_result_type1_idx` (`universal_result_type_id`),
  KEY `uploaded_by` (`uploaded_by`),
  KEY `student_assignment_group_id` (`student_assignment_group_id`),
  KEY `receipt_submit_by` (`receipt_submit_by`),
  CONSTRAINT `fk_student_assignment_assesment1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assignment_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_assignment_universal_result_type1` FOREIGN KEY (`universal_result_type_id`) REFERENCES `universal_result_type` (`id`),
  CONSTRAINT `student_assignment_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_assignment_ibfk_2` FOREIGN KEY (`student_assignment_group_id`) REFERENCES `student_assignment_group` (`id`),
  CONSTRAINT `student_assignment_ibfk_3` FOREIGN KEY (`receipt_submit_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=147751 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assignment_group
DROP TABLE IF EXISTS `student_assignment_group`;
CREATE TABLE IF NOT EXISTS `student_assignment_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `batchesb_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `group_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `batchesb_id` (`batchesb_id`) USING BTREE,
  KEY `course_cid` (`course_cid`) USING BTREE,
  CONSTRAINT `student_assignment_group_ibfk_1` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `student_assignment_group_ibfk_2` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assignment_plagiarism
DROP TABLE IF EXISTS `student_assignment_plagiarism`;
CREATE TABLE IF NOT EXISTS `student_assignment_plagiarism` (
  `id` int NOT NULL AUTO_INCREMENT,
  `plagiarism_manager_id` int NOT NULL,
  `student_assignment_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_assignment_plagiarism_plagiarism_manager1_idx` (`plagiarism_manager_id`),
  KEY `fk_student_assignment_plagiarism_student_assignment1_idx` (`student_assignment_id`),
  CONSTRAINT `fk_student_assignment_plagiarism_plagiarism_manager1` FOREIGN KEY (`plagiarism_manager_id`) REFERENCES `plagiarism_manager` (`id`),
  CONSTRAINT `fk_student_assignment_plagiarism_student_assignment1` FOREIGN KEY (`student_assignment_id`) REFERENCES `student_assignment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_assignment_sheduler
DROP TABLE IF EXISTS `student_assignment_sheduler`;
CREATE TABLE IF NOT EXISTS `student_assignment_sheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int DEFAULT NULL,
  `batch_assignment_sheduler_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `batch_assignment_sheduler_id` (`batch_assignment_sheduler_id`) USING BTREE,
  CONSTRAINT `student_assignment_sheduler_ibfk_1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_assignment_sheduler_ibfk_2` FOREIGN KEY (`batch_assignment_sheduler_id`) REFERENCES `batch_assignment_sheduler` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13558 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_attendance
DROP TABLE IF EXISTS `student_attendance`;
CREATE TABLE IF NOT EXISTS `student_attendance` (
  `sa_id` int NOT NULL AUTO_INCREMENT,
  `is_precent` int DEFAULT NULL,
  `attendance_sheet_as_id` int NOT NULL,
  `student_batches_sb_id` int NOT NULL,
  PRIMARY KEY (`sa_id`),
  KEY `FKstudent_at365143` (`attendance_sheet_as_id`),
  KEY `FKstudent_at436816` (`student_batches_sb_id`),
  KEY `FKstudent_at365144` (`attendance_sheet_as_id`),
  KEY `FKstudent_at436817` (`student_batches_sb_id`),
  CONSTRAINT `FKstudent_at365143` FOREIGN KEY (`attendance_sheet_as_id`) REFERENCES `attendance_sheet` (`as_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKstudent_at436816` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7698 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_attendance_by_time_table
DROP TABLE IF EXISTS `student_attendance_by_time_table`;
CREATE TABLE IF NOT EXISTS `student_attendance_by_time_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `is_attended` tinyint(1) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `time_table_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `comment` text,
  `zoom_link` text,
  `audio_file` varchar(255) DEFAULT NULL,
  `marked_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `marked_by` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_student_attendance_by_time_table_time_table1_idx` (`time_table_id`),
  KEY `fk_student_attendance_by_time_table_student1_idx` (`student_s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20444557 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_attendance_by_time_table_audit
DROP TABLE IF EXISTS `student_attendance_by_time_table_audit`;
CREATE TABLE IF NOT EXISTS `student_attendance_by_time_table_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `is_attended` tinyint(1) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `time_table_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `comment` text,
  `zoom_link` text,
  `audio_file` varchar(255) DEFAULT NULL,
  `marked_date` datetime DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `marked_by` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `is_active` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_student_attendance_by_time_table_time_table1_idx` (`time_table_id`),
  KEY `fk_student_attendance_by_time_table_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_audit` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_time_table_audit` FOREIGN KEY (`time_table_id`) REFERENCES `time_table_audit` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=135868 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_bank_loan
DROP TABLE IF EXISTS `student_bank_loan`;
CREATE TABLE IF NOT EXISTS `student_bank_loan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `total_amount` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `collected_all_docs` tinyint(1) DEFAULT NULL,
  `docs_hand_over_to_bank` tinyint(1) DEFAULT NULL,
  `loan_approved` tinyint(1) DEFAULT NULL,
  `cheque_issued` tinyint(1) DEFAULT NULL,
  `progress` int DEFAULT NULL,
  `bank_b_id` int NOT NULL,
  `bank_loan_status_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `login_session_session_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_bank_loan_bank1_idx` (`bank_b_id`),
  KEY `fk_student_bank_loan_bank_loan_status1_idx` (`bank_loan_status_id`),
  KEY `fk_student_bank_loan_student1_idx` (`student_s_id`),
  KEY `fk_student_bank_loan_login_session1_idx` (`login_session_session_id`),
  CONSTRAINT `fk_student_bank_loan_bank1` FOREIGN KEY (`bank_b_id`) REFERENCES `bank` (`b_id`),
  CONSTRAINT `fk_student_bank_loan_bank_loan_status1` FOREIGN KEY (`bank_loan_status_id`) REFERENCES `bank_loan_status` (`id`),
  CONSTRAINT `fk_student_bank_loan_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `fk_student_bank_loan_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_bank_loan_required_document
DROP TABLE IF EXISTS `student_bank_loan_required_document`;
CREATE TABLE IF NOT EXISTS `student_bank_loan_required_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) DEFAULT NULL,
  `bank_loan_required_document_id` int NOT NULL,
  `student_bank_loan_id` int NOT NULL,
  `document_url` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_bank_loan_required_document_bank_loan_required_d_idx` (`bank_loan_required_document_id`),
  KEY `fk_student_bank_loan_required_document_student_bank_loan1_idx` (`student_bank_loan_id`),
  CONSTRAINT `fk_student_bank_loan_required_document_bank_loan_required_doc1` FOREIGN KEY (`bank_loan_required_document_id`) REFERENCES `bank_loan_required_document` (`id`),
  CONSTRAINT `fk_student_bank_loan_required_document_student_bank_loan1` FOREIGN KEY (`student_bank_loan_id`) REFERENCES `student_bank_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=641 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_bank_loan_requirement
DROP TABLE IF EXISTS `student_bank_loan_requirement`;
CREATE TABLE IF NOT EXISTS `student_bank_loan_requirement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` tinyint(1) DEFAULT NULL,
  `bank_loan_requirement_id` int NOT NULL,
  `student_bank_loan_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_bank_loan_requirement_bank_loan_requirement1_idx` (`bank_loan_requirement_id`),
  KEY `fk_student_bank_loan_requirement_student_bank_loan1_idx` (`student_bank_loan_id`),
  CONSTRAINT `fk_student_bank_loan_requirement_bank_loan_requirement1` FOREIGN KEY (`bank_loan_requirement_id`) REFERENCES `bank_loan_requirement` (`id`),
  CONSTRAINT `fk_student_bank_loan_requirement_student_bank_loan1` FOREIGN KEY (`student_bank_loan_id`) REFERENCES `student_bank_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=475 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_bank_loan_status_manager
DROP TABLE IF EXISTS `student_bank_loan_status_manager`;
CREATE TABLE IF NOT EXISTS `student_bank_loan_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `note` text,
  `student_bank_loan_id` int NOT NULL,
  `bank_loan_status_id` int NOT NULL,
  `login_session_session_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_bank_loan_status_manager_student_bank_loan1_idx` (`student_bank_loan_id`),
  KEY `fk_student_bank_loan_status_manager_bank_loan_status1_idx` (`bank_loan_status_id`),
  KEY `fk_student_bank_loan_status_manager_login_session1_idx` (`login_session_session_id`),
  CONSTRAINT `fk_student_bank_loan_status_manager_bank_loan_status1` FOREIGN KEY (`bank_loan_status_id`) REFERENCES `bank_loan_status` (`id`),
  CONSTRAINT `fk_student_bank_loan_status_manager_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `fk_student_bank_loan_status_manager_student_bank_loan1` FOREIGN KEY (`student_bank_loan_id`) REFERENCES `student_bank_loan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_batches
DROP TABLE IF EXISTS `student_batches`;
CREATE TABLE IF NOT EXISTS `student_batches` (
  `sb_id` int NOT NULL AUTO_INCREMENT,
  `total_discount` double DEFAULT NULL,
  `total_due_fee` double DEFAULT NULL,
  `course_fee` double DEFAULT NULL,
  `total_paid_amount` double DEFAULT NULL,
  `total_paid_temp` double DEFAULT NULL,
  `current_course_fee` double DEFAULT NULL,
  `is_exam_complete` int DEFAULT NULL,
  `students_id` int NOT NULL,
  `batchesb_id` int NOT NULL,
  `vouchervid` int NOT NULL,
  `is_active` int NOT NULL,
  `voucher_item_vi_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `is_in_batch` tinyint(1) DEFAULT NULL COMMENT 'This is true when the student is following the course or student is completed the course',
  `student_batch_type_id` int DEFAULT NULL,
  `offer_manager_id` int DEFAULT NULL,
  `scholarship_payment_scheduler_id` int DEFAULT NULL,
  PRIMARY KEY (`sb_id`),
  KEY `FKstudent_ba198280` (`students_id`),
  KEY `FKstudent_ba380382` (`batchesb_id`),
  KEY `FKstudent_ba733497` (`vouchervid`),
  KEY `fk_student_batches_voucher_item1_idx` (`voucher_item_vi_id`),
  KEY `fk_student_batches_course1_idx` (`course_cid`),
  KEY `fk_student_batches_student_batch_type1_idx` (`student_batch_type_id`),
  KEY `fk_student_batches_offer_manager1_idx` (`offer_manager_id`),
  KEY `fk_student_batches_scholarship_payment_scheduler1_idx` (`scholarship_payment_scheduler_id`),
  CONSTRAINT `fk_student_batches_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_batches_offer_manager1` FOREIGN KEY (`offer_manager_id`) REFERENCES `offer_manager` (`id`),
  CONSTRAINT `fk_student_batches_scholarship_payment_scheduler1` FOREIGN KEY (`scholarship_payment_scheduler_id`) REFERENCES `scholarship_payment_scheduler` (`id`),
  CONSTRAINT `fk_student_batches_student_batch_type1` FOREIGN KEY (`student_batch_type_id`) REFERENCES `student_batch_type` (`id`),
  CONSTRAINT `FKstudent_ba380382` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6477499 DEFAULT CHARSET=utf8mb3 COMMENT='Pool : the pool status has been created to include students who are in the state of doughtful to continue the training program';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_batch_status_changed_history
DROP TABLE IF EXISTS `student_batch_status_changed_history`;
CREATE TABLE IF NOT EXISTS `student_batch_status_changed_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `is_completed` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `student_batches_sb_id` int NOT NULL,
  `batch_type_from` int NOT NULL,
  `batch_type_to` int NOT NULL,
  `login_session_session_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_batch_status_changed_history_student_batches1_idx` (`student_batches_sb_id`),
  KEY `fk_student_batch_status_changed_history_student_batch_type1_idx` (`batch_type_from`),
  KEY `fk_student_batch_status_changed_history_student_batch_type2_idx` (`batch_type_to`),
  KEY `fk_student_batch_status_changed_history_login_session1_idx` (`login_session_session_id`),
  CONSTRAINT `fk_student_batch_status_changed_history_login_session1` FOREIGN KEY (`login_session_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `fk_student_batch_status_changed_history_student_batch_type1` FOREIGN KEY (`batch_type_from`) REFERENCES `student_batch_type` (`id`),
  CONSTRAINT `fk_student_batch_status_changed_history_student_batch_type2` FOREIGN KEY (`batch_type_to`) REFERENCES `student_batch_type` (`id`),
  CONSTRAINT `fk_student_batch_status_changed_history_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_batch_type
DROP TABLE IF EXISTS `student_batch_type`;
CREATE TABLE IF NOT EXISTS `student_batch_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_bucket_manager
DROP TABLE IF EXISTS `student_bucket_manager`;
CREATE TABLE IF NOT EXISTS `student_bucket_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `buckets_id` int NOT NULL,
  `student_s_id` int DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `marketer_leads_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `general_user_profile_entered_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_bucket_manager_buckets1_idx` (`buckets_id`),
  KEY `fk_student_bucket_manager_student1_idx` (`student_s_id`),
  KEY `fk_student_bucket_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_bucket_manager_marketer_leads1_idx` (`marketer_leads_id`),
  KEY `fk_student_bucket_manager_general_user_profile2_idx` (`general_user_profile_entered_by`),
  CONSTRAINT `fk_student_bucket_manager_buckets1` FOREIGN KEY (`buckets_id`) REFERENCES `buckets` (`id`),
  CONSTRAINT `fk_student_bucket_manager_marketer_leads1` FOREIGN KEY (`marketer_leads_id`) REFERENCES `marketer_leads` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=246276 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_certificate
DROP TABLE IF EXISTS `student_certificate`;
CREATE TABLE IF NOT EXISTS `student_certificate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `cert_id` varchar(45) DEFAULT NULL,
  `file_path` varchar(250) DEFAULT NULL,
  `issued_date` date DEFAULT NULL,
  `time_from` date DEFAULT NULL,
  `time_to` date DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `certificate_id` int NOT NULL,
  `student_certificate_type_id` int NOT NULL,
  `effective_date` date DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `received_date` date DEFAULT NULL,
  `student_certificate_status_id` int DEFAULT NULL,
  `comment` text,
  `is_active` tinyint DEFAULT NULL,
  `student_certificate_pack_id` int DEFAULT NULL,
  `issued_by` int DEFAULT NULL,
  `avidence_url` text,
  `is_issued` tinyint(1) DEFAULT NULL,
  `is_email_sent` tinyint(1) DEFAULT NULL,
  `is_hold` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_student_certificate_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_certificate_certificate1_idx` (`certificate_id`),
  KEY `fk_student_certificate_student_certificate_type1_idx` (`student_certificate_type_id`),
  KEY `student_certificate_status_id` (`student_certificate_status_id`),
  KEY `student_certificate_pack_id` (`student_certificate_pack_id`),
  KEY `issued_by` (`issued_by`),
  CONSTRAINT `fk_student_certificate_certificate1` FOREIGN KEY (`certificate_id`) REFERENCES `certificate` (`id`),
  CONSTRAINT `fk_student_certificate_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_certificate_student_certificate_type1` FOREIGN KEY (`student_certificate_type_id`) REFERENCES `student_certificate_uploaded_type` (`id`),
  CONSTRAINT `student_certificate_ibfk_1` FOREIGN KEY (`student_certificate_status_id`) REFERENCES `student_certificate_status` (`id`),
  CONSTRAINT `student_certificate_ibfk_2` FOREIGN KEY (`student_certificate_pack_id`) REFERENCES `student_certificate_pack` (`id`),
  CONSTRAINT `student_certificate_ibfk_3` FOREIGN KEY (`issued_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9682 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_certificate_pack
DROP TABLE IF EXISTS `student_certificate_pack`;
CREATE TABLE IF NOT EXISTS `student_certificate_pack` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pack_id` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_certificate_status
DROP TABLE IF EXISTS `student_certificate_status`;
CREATE TABLE IF NOT EXISTS `student_certificate_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_certificate_uploaded_type
DROP TABLE IF EXISTS `student_certificate_uploaded_type`;
CREATE TABLE IF NOT EXISTS `student_certificate_uploaded_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'verification request, scanned and uploaded\n\ncertificates are uploaded by theird party organization for verification also  saved in this table under the type of verification request, when the  verification is confirmed type is changed from verification request to scanned and uploaded.',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_certificate_verification_request
DROP TABLE IF EXISTS `student_certificate_verification_request`;
CREATE TABLE IF NOT EXISTS `student_certificate_verification_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` date DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT NULL,
  `student_certificate_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_certificate_verification_request_student_certifi_idx` (`student_certificate_id`),
  KEY `fk_student_certificate_verification_request_general_organiz_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_student_certificate_verification_request_general_organizat1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_certificate_verification_request_student_certifica1` FOREIGN KEY (`student_certificate_id`) REFERENCES `student_certificate` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_checklist
DROP TABLE IF EXISTS `student_checklist`;
CREATE TABLE IF NOT EXISTS `student_checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_selected` tinyint(1) DEFAULT NULL,
  `student_application_manager_id` int NOT NULL,
  `application_checklist_id` int NOT NULL,
  `document_manager_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_checklist_student_application_manager1_idx` (`student_application_manager_id`),
  KEY `fk_student_checklist_appication_checklist1_idx` (`application_checklist_id`),
  KEY `fk_student_checklist_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_checklist_appication_checklist1` FOREIGN KEY (`application_checklist_id`) REFERENCES `application_checklist` (`id`),
  CONSTRAINT `fk_student_checklist_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_checklist_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_class_preferences
DROP TABLE IF EXISTS `student_class_preferences`;
CREATE TABLE IF NOT EXISTS `student_class_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_class_preferences_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_class_preferences_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_collections
DROP TABLE IF EXISTS `student_collections`;
CREATE TABLE IF NOT EXISTS `student_collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `payment_date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_collections_student1_idx` (`student_s_id`),
  KEY `fk_student_collections_voucher_item1_idx` (`voucher_item_vi_id`),
  KEY `fk_student_collections_branch1_idx` (`branch_bid`),
  CONSTRAINT `fk_student_collections_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_student_collections_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_collections_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_convocation_photo
DROP TABLE IF EXISTS `student_convocation_photo`;
CREATE TABLE IF NOT EXISTS `student_convocation_photo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `graduation_date` date DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `convocation_photo_type_id` int NOT NULL,
  `row` int DEFAULT NULL,
  `position` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_convocation_photo_student1_idx` (`student_s_id`),
  KEY `fk_student_convocation_photo_convocation_photo_type1_idx` (`convocation_photo_type_id`),
  CONSTRAINT `fk_student_convocation_photo_convocation_photo_type1` FOREIGN KEY (`convocation_photo_type_id`) REFERENCES `convocation_photo_type` (`id`),
  CONSTRAINT `fk_student_convocation_photo_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=509 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_counselling_history
DROP TABLE IF EXISTS `student_counselling_history`;
CREATE TABLE IF NOT EXISTS `student_counselling_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `remark` text,
  `employees_employee_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `token_generated_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_counselling_history_employees1_idx` (`employees_employee_id`),
  KEY `fk_student_counselling_history_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_counselling_history_token_generated1_idx` (`token_generated_id`),
  CONSTRAINT `fk_student_counselling_history_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_student_counselling_history_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_counselling_history_token_generated1` FOREIGN KEY (`token_generated_id`) REFERENCES `token_generated` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_course
DROP TABLE IF EXISTS `student_course`;
CREATE TABLE IF NOT EXISTS `student_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `registered_date` date DEFAULT NULL,
  `course_cid` int NOT NULL,
  `stp_student_id` int NOT NULL,
  `stp_branch_id` int NOT NULL,
  `is_full_time` tinyint(1) DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_course1_idx` (`course_cid`),
  KEY `fk_student_course_stp_student1_idx` (`stp_student_id`),
  KEY `fk_student_course_stp_branch1_idx` (`stp_branch_id`),
  CONSTRAINT `fk_student_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_stp_branch1` FOREIGN KEY (`stp_branch_id`) REFERENCES `stp_branch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_stp_student1` FOREIGN KEY (`stp_student_id`) REFERENCES `stp_student` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40672 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_course_attendance
DROP TABLE IF EXISTS `student_course_attendance`;
CREATE TABLE IF NOT EXISTS `student_course_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `is_attended` tinyint(1) DEFAULT NULL,
  `student_course_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_attendance_student_course_manager1_idx` (`student_course_manager_id`),
  CONSTRAINT `fk_student_course_attendance_student_course_manager1` FOREIGN KEY (`student_course_manager_id`) REFERENCES `student_course_manager` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_course_manager
DROP TABLE IF EXISTS `student_course_manager`;
CREATE TABLE IF NOT EXISTS `student_course_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `sm_course_id` int NOT NULL,
  `sm_hall_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_manager_student1_idx` (`student_s_id`),
  KEY `fk_student_course_manager_sm_course1_idx` (`sm_course_id`),
  KEY `fk_student_course_manager_sm_hall1_idx` (`sm_hall_id`),
  CONSTRAINT `fk_student_course_manager_sm_course1` FOREIGN KEY (`sm_course_id`) REFERENCES `sm_course` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_manager_sm_hall1` FOREIGN KEY (`sm_hall_id`) REFERENCES `sm_hall` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_course_payment
DROP TABLE IF EXISTS `student_course_payment`;
CREATE TABLE IF NOT EXISTS `student_course_payment` (
  `cac_id` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `invoice_receipt_amount` double DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `branchbid` int NOT NULL,
  `voucher_itemvi_id` int NOT NULL,
  `batchesb_id` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `sub_chart_of_accountis_sca` int DEFAULT NULL,
  PRIMARY KEY (`cac_id`),
  KEY `FKstudent_co922941` (`general_user_profilegup_id`),
  KEY `FKstudent_co184810` (`branchbid`),
  KEY `FKstudent_co12718` (`voucher_itemvi_id`),
  KEY `FKstudent_co203470` (`batchesb_id`),
  KEY `FKstudent_co842398` (`sub_chart_of_accountis_sca`),
  CONSTRAINT `FKstudent_co184810` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKstudent_co203470` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKstudent_co842398` FOREIGN KEY (`sub_chart_of_accountis_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=127791 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_currently_studying
DROP TABLE IF EXISTS `student_currently_studying`;
CREATE TABLE IF NOT EXISTS `student_currently_studying` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_results_are_expected` date DEFAULT NULL,
  `student_application_manager_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `course_cid` int NOT NULL,
  `state_id_s` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_currently_studying_student_application_manager2_idx` (`student_application_manager_id`),
  KEY `fk_student_currently_studying_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_currently_studying_course1_idx` (`course_cid`),
  KEY `fk_student_currently_studying_state1_idx` (`state_id_s`),
  CONSTRAINT `fk_student_currently_studying_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_student_currently_studying_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_currently_studying_state1` FOREIGN KEY (`state_id_s`) REFERENCES `state` (`id_s`),
  CONSTRAINT `fk_student_currently_studying_student_application_manager2` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_current_study
DROP TABLE IF EXISTS `student_current_study`;
CREATE TABLE IF NOT EXISTS `student_current_study` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_current_study_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_current_study_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_student_current_study_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_current_study_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_document_controller
DROP TABLE IF EXISTS `student_document_controller`;
CREATE TABLE IF NOT EXISTS `student_document_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_document_controller_student1_idx` (`student_s_id`),
  KEY `fk_student_document_controller_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_document_controller_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_document_controller_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_due_set_penalty_date
DROP TABLE IF EXISTS `student_due_set_penalty_date`;
CREATE TABLE IF NOT EXISTS `student_due_set_penalty_date` (
  `id` int NOT NULL AUTO_INCREMENT,
  `due_value` double DEFAULT NULL COMMENT 'The balance which should impose the penalty',
  `set_penalty_date` datetime DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `student_years_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_due_student_years1_idx` (`student_years_id`),
  KEY `fk_student_due_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_due_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_due_student_years1` FOREIGN KEY (`student_years_id`) REFERENCES `student_years` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb3 COMMENT='this table is used to set the penalty for year basis.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_employment_history
DROP TABLE IF EXISTS `student_employment_history`;
CREATE TABLE IF NOT EXISTS `student_employment_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_application_manager_id` int NOT NULL,
  `worked_history_id` int NOT NULL,
  `document_manager_id` int DEFAULT NULL,
  `description_of_responsibilities` text,
  PRIMARY KEY (`id`),
  KEY `fk_student_employment_history_student_application_manager1_idx` (`student_application_manager_id`),
  KEY `fk_student_employment_history_worked_history1_idx` (`worked_history_id`),
  KEY `fk_student_employment_history_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_employment_history_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_employment_history_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`),
  CONSTRAINT `fk_student_employment_history_worked_history1` FOREIGN KEY (`worked_history_id`) REFERENCES `worked_history` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_enrollment_registration
DROP TABLE IF EXISTS `student_enrollment_registration`;
CREATE TABLE IF NOT EXISTS `student_enrollment_registration` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `student_enrollment_type_id` int DEFAULT NULL,
  `registration_no` varchar(50) DEFAULT NULL,
  `proof_doc` varchar(255) DEFAULT NULL,
  `entered_by` int DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `overall_status` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_entrollment_registration_manager_student` (`student_id`),
  KEY `FK_student_entrollment_registration_universal_approve_status` (`overall_status`),
  KEY `FK_student_entrollment_registration_general_user_profile` (`entered_by`),
  KEY `FK_student_entrollment_registration_manager_entrollment_types` (`student_enrollment_type_id`) USING BTREE,
  CONSTRAINT `FK_student_entrollment_registration_general_user_profile` FOREIGN KEY (`entered_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_entrollment_registration_manager_entrollment_types` FOREIGN KEY (`student_enrollment_type_id`) REFERENCES `student_enrollment_types` (`id`),
  CONSTRAINT `FK_student_entrollment_registration_manager_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `FK_student_entrollment_registration_universal_approve_status` FOREIGN KEY (`overall_status`) REFERENCES `universal_approve_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_enrollment_registration_approval_manager
DROP TABLE IF EXISTS `student_enrollment_registration_approval_manager`;
CREATE TABLE IF NOT EXISTS `student_enrollment_registration_approval_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_enrollment_registration_id` int DEFAULT NULL,
  `verification_level_id` int DEFAULT NULL,
  `approval_status_id` int DEFAULT NULL,
  `action_by` int DEFAULT NULL,
  `action_date` datetime DEFAULT NULL,
  `reason` text,
  PRIMARY KEY (`id`),
  KEY `FK_seram_verification_level` (`verification_level_id`),
  KEY `FK_seram_universal_approve_status` (`approval_status_id`),
  KEY `FK_seram_general_user_profile` (`action_by`),
  KEY `FK_seram_student_entrollment_registration` (`student_enrollment_registration_id`) USING BTREE,
  CONSTRAINT `FK_seram_general_user_profile` FOREIGN KEY (`action_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_seram_student_entrollment_registration` FOREIGN KEY (`student_enrollment_registration_id`) REFERENCES `student_enrollment_registration` (`id`),
  CONSTRAINT `FK_seram_universal_approve_status` FOREIGN KEY (`approval_status_id`) REFERENCES `universal_approve_status` (`id`),
  CONSTRAINT `FK_seram_verification_level` FOREIGN KEY (`verification_level_id`) REFERENCES `verification_level` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_enrollment_types
DROP TABLE IF EXISTS `student_enrollment_types`;
CREATE TABLE IF NOT EXISTS `student_enrollment_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_entry_stream
DROP TABLE IF EXISTS `student_entry_stream`;
CREATE TABLE IF NOT EXISTS `student_entry_stream` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Before O/L\nAfter O/L\nAfter A/L\nUniversity Selected\nUndergraduate\nEmployed',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_evidences
DROP TABLE IF EXISTS `student_evidences`;
CREATE TABLE IF NOT EXISTS `student_evidences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `evidences_type_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  KEY `evidences_type_id` (`evidences_type_id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  KEY `course_cid` (`course_cid`),
  CONSTRAINT `student_evidences_ibfk_1` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_evidences_ibfk_2` FOREIGN KEY (`evidences_type_id`) REFERENCES `evidences_type` (`id`),
  CONSTRAINT `student_evidences_ibfk_3` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_evidences_ibfk_4` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam
DROP TABLE IF EXISTS `student_exam`;
CREATE TABLE IF NOT EXISTS `student_exam` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_attended` tinyint(1) DEFAULT NULL,
  `is_downloaded` tinyint(1) DEFAULT NULL,
  `batch_exam_sheduler_id` int NOT NULL,
  `student_s_id` int DEFAULT NULL,
  `is_exam_completed` tinyint(1) DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `can_be_downloaded` tinyint(1) DEFAULT NULL,
  `exam_type_id` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_batch_exam_sheduler1_idx` (`batch_exam_sheduler_id`),
  KEY `fk_student_exam_student2_idx` (`student_s_id`),
  KEY `fk_student_exam_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `exam_type_id` (`exam_type_id`),
  CONSTRAINT `fk_student_exam_batch_exam_sheduler1` FOREIGN KEY (`batch_exam_sheduler_id`) REFERENCES `batch_exam_sheduler` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_exam_student2` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_exam_ibfk_1` FOREIGN KEY (`exam_type_id`) REFERENCES `exam_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=438994 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_answers
DROP TABLE IF EXISTS `student_exam_answers`;
CREATE TABLE IF NOT EXISTS `student_exam_answers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_exam_questions_id` int NOT NULL,
  `exam_engine_answers_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_answers_student_exam_questions1_idx` (`student_exam_questions_id`),
  KEY `fk_student_exam_answers_exam_engine_answers1_idx` (`exam_engine_answers_id`),
  CONSTRAINT `fk_student_exam_answers_exam_engine_answers1` FOREIGN KEY (`exam_engine_answers_id`) REFERENCES `exam_engine_answers` (`id`),
  CONSTRAINT `fk_student_exam_answers_student_exam_questions1` FOREIGN KEY (`student_exam_questions_id`) REFERENCES `student_exam_questions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_evidence
DROP TABLE IF EXISTS `student_exam_evidence`;
CREATE TABLE IF NOT EXISTS `student_exam_evidence` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `exam_type_id` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `url` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_questions
DROP TABLE IF EXISTS `student_exam_questions`;
CREATE TABLE IF NOT EXISTS `student_exam_questions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `individual_exam_scheduler_id` int NOT NULL,
  `exam_engine_questions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_questions_individual_exam_scheduler1_idx` (`individual_exam_scheduler_id`),
  KEY `fk_student_exam_questions_exam_engine_questions1_idx` (`exam_engine_questions_id`),
  CONSTRAINT `fk_student_exam_questions_exam_engine_questions1` FOREIGN KEY (`exam_engine_questions_id`) REFERENCES `exam_engine_questions` (`id`),
  CONSTRAINT `fk_student_exam_questions_individual_exam_scheduler1` FOREIGN KEY (`individual_exam_scheduler_id`) REFERENCES `individual_exam_scheduler` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_result
DROP TABLE IF EXISTS `student_exam_result`;
CREATE TABLE IF NOT EXISTS `student_exam_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `marks` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `exam_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `accessed_by` int DEFAULT NULL,
  `checked_by` int DEFAULT NULL,
  `universal_result_type_id` int NOT NULL,
  `marks_released_date` datetime DEFAULT NULL,
  `marks_released_by` int DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `document_disposal_id` int DEFAULT NULL,
  `student_exam_result_id` int DEFAULT NULL,
  `paper_src` varchar(1000) DEFAULT NULL,
  `marks_entered_by` int DEFAULT NULL,
  `marks_entered_date` datetime DEFAULT NULL,
  `first_verification_by` int DEFAULT NULL,
  `second_verification_by` int DEFAULT NULL,
  `verified_marks` double DEFAULT NULL,
  `marks_verified_date` datetime DEFAULT NULL,
  `actual_marks` double DEFAULT NULL,
  `student_exam_result_status_id` int DEFAULT NULL,
  `first_marks` double DEFAULT NULL,
  `secound_marks` double DEFAULT NULL,
  `is_absent` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_exam1_idx` (`exam_id`),
  KEY `fk_student_exam_student1_idx` (`student_s_id`),
  KEY `fk_student_exam_result_employees1_idx` (`accessed_by`),
  KEY `fk_student_exam_result_employees2_idx` (`checked_by`),
  KEY `fk_student_exam_result_universal_result_type1_idx` (`universal_result_type_id`),
  KEY `fk_student_exam_result_employees3_idx` (`marks_released_by`),
  KEY `fk_student_exam_result_branch1_idx` (`branch_bid`),
  KEY `fk_student_exam_result_document_disposal1_idx` (`document_disposal_id`),
  KEY `fk_student_exam_result_student_exam_result1_idx` (`student_exam_result_id`),
  KEY `marks_entered_by` (`marks_entered_by`),
  KEY `second_verification_by` (`second_verification_by`),
  KEY `first_verification_by` (`first_verification_by`),
  KEY `student_assesment_result_status_id` (`student_exam_result_status_id`),
  CONSTRAINT `fk_student_exam_exam1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_result_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_student_exam_result_document_disposal1` FOREIGN KEY (`document_disposal_id`) REFERENCES `document_disposal` (`id`),
  CONSTRAINT `fk_student_exam_result_employees1` FOREIGN KEY (`accessed_by`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_result_employees2` FOREIGN KEY (`checked_by`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_result_employees3` FOREIGN KEY (`marks_released_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_student_exam_result_student_exam_result1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`),
  CONSTRAINT `fk_student_exam_result_universal_result_type1` FOREIGN KEY (`universal_result_type_id`) REFERENCES `universal_result_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_exam_result_ibfk_1` FOREIGN KEY (`marks_entered_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `student_exam_result_ibfk_2` FOREIGN KEY (`second_verification_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `student_exam_result_ibfk_3` FOREIGN KEY (`first_verification_by`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `student_exam_result_ibfk_4` FOREIGN KEY (`student_exam_result_status_id`) REFERENCES `student_assesment_result_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3636614 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_result_doc
DROP TABLE IF EXISTS `student_exam_result_doc`;
CREATE TABLE IF NOT EXISTS `student_exam_result_doc` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(245) DEFAULT NULL,
  `student_exam_result_id` int NOT NULL,
  `universal_result_doc_type_id` int NOT NULL,
  `created_date` datetime DEFAULT NULL,
  `general_user_profilegup_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_result_doc_student_exam_result1_idx` (`student_exam_result_id`),
  KEY `fk_student_exam_result_doc_universal_result_doc_type1_idx` (`universal_result_doc_type_id`),
  KEY `general_user_profilegup_id` (`general_user_profilegup_id`),
  CONSTRAINT `fk_student_exam_result_doc_student_exam_result1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_exam_result_doc_universal_result_doc_type1` FOREIGN KEY (`universal_result_doc_type_id`) REFERENCES `universal_result_doc_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_exam_result_doc_ibfk_1` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6369 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_result_enter_history
DROP TABLE IF EXISTS `student_exam_result_enter_history`;
CREATE TABLE IF NOT EXISTS `student_exam_result_enter_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `marks` double DEFAULT NULL,
  `actual_marks` double DEFAULT NULL,
  `marks_enter_by` int DEFAULT NULL,
  `marks_enter_date` datetime DEFAULT NULL,
  `student_exam_result` int DEFAULT NULL,
  `student_exam_result_enter_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_exam_result_enter_history_student_exam_result` (`student_exam_result`),
  KEY `FK_sereh_student_exam_result_enter_history_type` (`student_exam_result_enter_type_id`) USING BTREE,
  CONSTRAINT `FK_sereh_student_exam_result_enter_history_type` FOREIGN KEY (`student_exam_result_enter_type_id`) REFERENCES `student_exam_result_enter_type` (`id`),
  CONSTRAINT `FK_student_exam_result_enter_history_student_exam_result` FOREIGN KEY (`student_exam_result`) REFERENCES `student_exam_result` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27002 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_result_enter_type
DROP TABLE IF EXISTS `student_exam_result_enter_type`;
CREATE TABLE IF NOT EXISTS `student_exam_result_enter_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_exam_schedule_result_keeper
DROP TABLE IF EXISTS `student_exam_schedule_result_keeper`;
CREATE TABLE IF NOT EXISTS `student_exam_schedule_result_keeper` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_exam_result_id` int DEFAULT NULL,
  `exam_accessor_scheduler_id` int NOT NULL,
  `student_exam_id` int NOT NULL,
  `universal_result_type_id` int NOT NULL,
  `student_exam_schedule_result_keeper_id` int DEFAULT NULL,
  `assign_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_exam_schedule_result_keeper_student_assesm_idx` (`student_exam_result_id`),
  KEY `fk_student_exam_schedule_result_keeper_exam_acc_idx` (`exam_accessor_scheduler_id`),
  KEY `fk_student_exam_schedule_result_keeper_student_assign_idx` (`student_exam_id`),
  KEY `fk_student_exam_schedule_result_keeper_universal_resu_idx` (`universal_result_type_id`),
  KEY `fk_student_exam_schedule_result_keeper_student_assess_idx` (`student_exam_schedule_result_keeper_id`),
  CONSTRAINT `fk_student_exam_schedule_result_keeper_student_assesmen1` FOREIGN KEY (`student_exam_result_id`) REFERENCES `student_exam_result` (`id`),
  CONSTRAINT `fk_student_exam_schedule_result_keeper_universal_result1` FOREIGN KEY (`universal_result_type_id`) REFERENCES `universal_result_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15981 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_fcm_token
DROP TABLE IF EXISTS `student_fcm_token`;
CREATE TABLE IF NOT EXISTS `student_fcm_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `students_id` int DEFAULT NULL,
  `fcm_token` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  CONSTRAINT `student_fcm_token_ibfk_1` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3140 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_assignment_upload
DROP TABLE IF EXISTS `student_final_exam_assignment_upload`;
CREATE TABLE IF NOT EXISTS `student_final_exam_assignment_upload` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_final_exam_result_id` int DEFAULT NULL,
  `uploaded_document` varchar(255) DEFAULT NULL,
  `uploaded_date` timestamp NULL DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `uploaded_receipt` varchar(255) DEFAULT NULL,
  `receipt_uploaded_date` timestamp NULL DEFAULT NULL,
  `receipt_uploaded_by` int DEFAULT NULL,
  `uploaded_srs_document` varchar(255) DEFAULT NULL,
  `srs_document_uploaded_by` int DEFAULT NULL,
  `srs_document_uploaded_date` timestamp NULL DEFAULT NULL,
  `uploaded_project_document` varchar(255) DEFAULT NULL,
  `project_document_uploaded_date` timestamp NULL DEFAULT NULL,
  `project_document_uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sfeau_sfex` (`student_final_exam_result_id`),
  KEY `FK_student_final_exam_assignment_upload_general_user_profile` (`uploaded_by`),
  KEY `receipt_uploaded_by` (`receipt_uploaded_by`),
  KEY `project_document_uploaded_by` (`project_document_uploaded_by`),
  KEY `srs_document_uploaded_by` (`srs_document_uploaded_by`),
  CONSTRAINT `FK_sfeau_sfex` FOREIGN KEY (`student_final_exam_result_id`) REFERENCES `student_final_exam_result` (`id`),
  CONSTRAINT `FK_student_final_exam_assignment_upload_general_user_profile` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_final_exam_assignment_upload_ibfk_1` FOREIGN KEY (`receipt_uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_final_exam_assignment_upload_ibfk_2` FOREIGN KEY (`project_document_uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_final_exam_assignment_upload_ibfk_3` FOREIGN KEY (`srs_document_uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2405 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_paper
DROP TABLE IF EXISTS `student_final_exam_paper`;
CREATE TABLE IF NOT EXISTS `student_final_exam_paper` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int DEFAULT NULL,
  `paper` varchar(255) DEFAULT NULL,
  `final_submited_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__exam` (`exam_id`),
  CONSTRAINT `FK__exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_paper_new
DROP TABLE IF EXISTS `student_final_exam_paper_new`;
CREATE TABLE IF NOT EXISTS `student_final_exam_paper_new` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `paper` varchar(255) DEFAULT NULL,
  `is_moose` tinyint DEFAULT NULL,
  `is_mammoth` tinyint DEFAULT NULL,
  `is_cohort6` tinyint DEFAULT NULL,
  `is_poposal_upload` tinyint DEFAULT '0',
  `proposal_submited_date` datetime DEFAULT NULL,
  `is_proposal_guildline_show` tinyint DEFAULT '0',
  `is_srs_document_upload` tinyint DEFAULT '0',
  `is_project_document_upload` tinyint DEFAULT '0',
  `submited_date` datetime DEFAULT NULL,
  `is_receipt_upload` tinyint DEFAULT '0',
  `receipt_submited_date` datetime DEFAULT NULL,
  `is_guildline_show` tinyint DEFAULT '0',
  `is_viva` tinyint DEFAULT '0',
  `viva_date` datetime DEFAULT NULL,
  `is_viva_guildline_show` tinyint DEFAULT '0',
  `paper_handover_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_final_exam_paper_new_course` (`course_id`),
  KEY `FK_student_final_exam_paper_new_exam` (`exam_id`),
  CONSTRAINT `FK_student_final_exam_paper_new_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`),
  CONSTRAINT `FK_student_final_exam_paper_new_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_result
DROP TABLE IF EXISTS `student_final_exam_result`;
CREATE TABLE IF NOT EXISTS `student_final_exam_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `exam_status_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_final_exam_result_student` (`student_id`),
  KEY `FK_student_final_exam_result_exam` (`exam_id`),
  KEY `FK_student_final_exam_result_student_final_exam_status` (`exam_status_id`),
  KEY `FK_student_final_exam_result_general_user_profile` (`added_by`),
  CONSTRAINT `FK_student_final_exam_result_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `FK_student_final_exam_result_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_final_exam_result_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `FK_student_final_exam_result_student_final_exam_status` FOREIGN KEY (`exam_status_id`) REFERENCES `student_final_exam_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28891 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_status
DROP TABLE IF EXISTS `student_final_exam_status`;
CREATE TABLE IF NOT EXISTS `student_final_exam_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_viva_proposal
DROP TABLE IF EXISTS `student_final_exam_viva_proposal`;
CREATE TABLE IF NOT EXISTS `student_final_exam_viva_proposal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `document` varchar(255) DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `student_final_exam_result_id` int DEFAULT NULL,
  `student_final_exam_status_id` int DEFAULT NULL,
  `approve_date` datetime DEFAULT NULL,
  `approve_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__student_final_exam_result` (`student_final_exam_result_id`),
  KEY `FK_student_final_exam_viva_proposal_general_user_profile` (`uploaded_by`),
  KEY `FK__student_final_exam_status` (`student_final_exam_status_id`) USING BTREE,
  KEY `approve_by` (`approve_by`),
  CONSTRAINT `FK__student_final_exam_result` FOREIGN KEY (`student_final_exam_result_id`) REFERENCES `student_final_exam_result` (`id`),
  CONSTRAINT `FK__student_final_exam_status` FOREIGN KEY (`student_final_exam_status_id`) REFERENCES `student_final_exam_status` (`id`),
  CONSTRAINT `FK_student_final_exam_viva_proposal_general_user_profile` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_final_exam_viva_proposal_ibfk_1` FOREIGN KEY (`approve_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_exam_viva_result
DROP TABLE IF EXISTS `student_final_exam_viva_result`;
CREATE TABLE IF NOT EXISTS `student_final_exam_viva_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `exam_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `is_verify` tinyint DEFAULT NULL,
  `verify_by` int DEFAULT NULL,
  `verify_date` datetime DEFAULT NULL,
  `docs` varchar(255) DEFAULT NULL,
  `exam_status_id` int DEFAULT NULL,
  `url` text,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_final_exam_viva_result_exam` (`exam_id`),
  KEY `FK_student_final_exam_viva_result_student` (`student_id`),
  KEY `FK_student_final_exam_viva_result_general_user_profile` (`added_by`),
  KEY `FK_student_final_exam_viva_result_general_user_profile_2` (`verify_by`),
  KEY `FK_student_final_exam_viva_result_student_final_exam_status` (`exam_status_id`) USING BTREE,
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `FK_student_final_exam_viva_result_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `FK_student_final_exam_viva_result_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_final_exam_viva_result_general_user_profile_2` FOREIGN KEY (`verify_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_final_exam_viva_result_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `FK_student_final_exam_viva_result_student_final_exam_status` FOREIGN KEY (`exam_status_id`) REFERENCES `student_final_exam_status` (`id`),
  CONSTRAINT `student_final_exam_viva_result_ibfk_1` FOREIGN KEY (`updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_final_result
DROP TABLE IF EXISTS `student_final_result`;
CREATE TABLE IF NOT EXISTS `student_final_result` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `mark` double(11,0) DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  KEY `course_cid` (`course_cid`) USING BTREE,
  KEY `updated_by` (`updated_by`) USING BTREE,
  CONSTRAINT `student_final_result_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_final_result_ibfk_2` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_final_result_ibfk_3` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `student_final_result_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21261 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_for_nm
DROP TABLE IF EXISTS `student_for_nm`;
CREATE TABLE IF NOT EXISTS `student_for_nm` (
  `id_sfn` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id_sfn`),
  KEY `fk_student_for_nm_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_for_nm_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4948 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_further_information
DROP TABLE IF EXISTS `student_further_information`;
CREATE TABLE IF NOT EXISTS `student_further_information` (
  `id` int NOT NULL AUTO_INCREMENT,
  `furture_planes` text,
  `is_employee` tinyint(1) DEFAULT NULL,
  `company_name` varchar(145) DEFAULT NULL,
  `attitude` text,
  `studying_status` tinyint(1) DEFAULT NULL,
  `institute_name` varchar(145) DEFAULT NULL,
  `income_level_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_further_student_information_income_level1_idx` (`income_level_id`),
  KEY `fk_further_student_information_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_further_student_information_income_level1` FOREIGN KEY (`income_level_id`) REFERENCES `income_level` (`id`),
  CONSTRAINT `fk_further_student_information_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_group_project
DROP TABLE IF EXISTS `student_group_project`;
CREATE TABLE IF NOT EXISTS `student_group_project` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `marks` double DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_closed` int DEFAULT NULL,
  `is_paid` int DEFAULT NULL,
  `branchbid` int DEFAULT NULL,
  `groupgroup_id` int NOT NULL,
  `projectproject_id` int NOT NULL,
  PRIMARY KEY (`group_id`),
  KEY `FKstudent_gr994496` (`branchbid`),
  CONSTRAINT `FKstudent_gr994496` FOREIGN KEY (`branchbid`) REFERENCES `branch` (`bid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_guardian
DROP TABLE IF EXISTS `student_guardian`;
CREATE TABLE IF NOT EXISTS `student_guardian` (
  `id_sg` int NOT NULL AUTO_INCREMENT,
  `student` int NOT NULL,
  `guardian` int NOT NULL,
  `guardian_relationshipid_gt` int NOT NULL,
  PRIMARY KEY (`id_sg`),
  KEY `FKstudent_gu623185` (`student`),
  KEY `FKstudent_gu731529` (`guardian`),
  KEY `FKstudent_gu869978` (`guardian_relationshipid_gt`),
  CONSTRAINT `FKstudent_gu869978` FOREIGN KEY (`guardian_relationshipid_gt`) REFERENCES `guardian_relationship` (`id_gt`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28839 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_has_subject
DROP TABLE IF EXISTS `student_has_subject`;
CREATE TABLE IF NOT EXISTS `student_has_subject` (
  `idstudent_has_subject` int unsigned NOT NULL AUTO_INCREMENT,
  `subject_idsubject` int unsigned NOT NULL,
  `idGenaralUserProfile` int NOT NULL,
  PRIMARY KEY (`idstudent_has_subject`),
  KEY `FK_student_has_subject_1` (`subject_idsubject`),
  KEY `FK_student_has_subject_2` (`idGenaralUserProfile`),
  CONSTRAINT `FK_student_has_subject_1` FOREIGN KEY (`subject_idsubject`) REFERENCES `subject` (`idsubject`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_has_subject_2` FOREIGN KEY (`idGenaralUserProfile`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22966 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_id_request
DROP TABLE IF EXISTS `student_id_request`;
CREATE TABLE IF NOT EXISTS `student_id_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_issued` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `full_name` varchar(500) DEFAULT NULL,
  `mobile_no` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `url` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_id_request_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_id_request_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_iic_document
DROP TABLE IF EXISTS `student_iic_document`;
CREATE TABLE IF NOT EXISTS `student_iic_document` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `doc` varchar(255) DEFAULT NULL,
  `iic_document_type_id` int DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_iic_document_student` (`student_id`),
  KEY `FK_student_iic_document_iic_document_type` (`iic_document_type_id`),
  KEY `FK_student_iic_document_general_user_profile` (`uploaded_by`),
  CONSTRAINT `FK_student_iic_document_general_user_profile` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_iic_document_iic_document_type` FOREIGN KEY (`iic_document_type_id`) REFERENCES `iic_document_type` (`id`),
  CONSTRAINT `FK_student_iic_document_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=720 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_interview
DROP TABLE IF EXISTS `student_interview`;
CREATE TABLE IF NOT EXISTS `student_interview` (
  `id` int NOT NULL AUTO_INCREMENT,
  `link` text,
  `entered_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `interview_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_interview_student1_idx` (`student_s_id`),
  KEY `fk_student_interview_interview_type1_idx` (`interview_type_id`),
  CONSTRAINT `fk_student_interview_interview_type1` FOREIGN KEY (`interview_type_id`) REFERENCES `interview_type` (`id`),
  CONSTRAINT `fk_student_interview_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_interview_status
DROP TABLE IF EXISTS `student_interview_status`;
CREATE TABLE IF NOT EXISTS `student_interview_status` (
  `id_sis` int NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `interview_status_is_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `interview_id` int NOT NULL,
  PRIMARY KEY (`id_sis`),
  KEY `fk_student_interview_status_interview_status1_idx` (`interview_status_is_id`),
  KEY `fk_student_interview_status_student1_idx` (`student_s_id`),
  KEY `fk_student_interview_status_interview1_idx` (`interview_id`),
  CONSTRAINT `fk_student_interview_status_interview1` FOREIGN KEY (`interview_id`) REFERENCES `interview` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_interview_status_interview_status1` FOREIGN KEY (`interview_status_is_id`) REFERENCES `interview_status` (`is_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_interview_status_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13803 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_introduced_by
DROP TABLE IF EXISTS `student_introduced_by`;
CREATE TABLE IF NOT EXISTS `student_introduced_by` (
  `sc_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_in_pack
DROP TABLE IF EXISTS `student_in_pack`;
CREATE TABLE IF NOT EXISTS `student_in_pack` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pack_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_in_pack_pack1_idx` (`pack_id`),
  KEY `fk_student_in_pack_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_in_pack_pack1` FOREIGN KEY (`pack_id`) REFERENCES `pack` (`id`),
  CONSTRAINT `fk_student_in_pack_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_job_experience
DROP TABLE IF EXISTS `student_job_experience`;
CREATE TABLE IF NOT EXISTS `student_job_experience` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `designation_id_d` int NOT NULL,
  `responsibilities` text,
  PRIMARY KEY (`id`),
  KEY `fk_student_job_experience_student1_idx` (`student_s_id`),
  KEY `fk_student_job_experience_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_job_experience_designation1_idx` (`designation_id_d`),
  CONSTRAINT `fk_student_job_experience_designation1` FOREIGN KEY (`designation_id_d`) REFERENCES `designation` (`id_d`),
  CONSTRAINT `fk_student_job_experience_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_job_experience_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=342 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_language_proficiency
DROP TABLE IF EXISTS `student_language_proficiency`;
CREATE TABLE IF NOT EXISTS `student_language_proficiency` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_application_manager_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_language_proficiency_student_application_manager_idx` (`student_application_manager_id`),
  KEY `fk_student_language_proficiency_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_language_proficiency_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_language_proficiency_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_last_attendance
DROP TABLE IF EXISTS `student_last_attendance`;
CREATE TABLE IF NOT EXISTS `student_last_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `students_id` int DEFAULT NULL,
  `student_attendance_by_time_table_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  KEY `student_attendance_by_time_table_id` (`student_attendance_by_time_table_id`) USING BTREE,
  CONSTRAINT `student_last_attendance_ibfk_1` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_last_attendance_ibfk_2` FOREIGN KEY (`student_attendance_by_time_table_id`) REFERENCES `student_attendance_by_time_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29553 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_lecture_buckets
DROP TABLE IF EXISTS `student_lecture_buckets`;
CREATE TABLE IF NOT EXISTS `student_lecture_buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lecture_buckets_id` int DEFAULT NULL,
  `student_batches_sb_id` int DEFAULT NULL,
  `done_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `lecture_buckets_id` (`lecture_buckets_id`) USING BTREE,
  KEY `student_batches_sb_id` (`student_batches_sb_id`) USING BTREE,
  CONSTRAINT `student_lecture_buckets_ibfk_1` FOREIGN KEY (`lecture_buckets_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `student_lecture_buckets_ibfk_2` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2476458 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_lecture_buckets_history
DROP TABLE IF EXISTS `student_lecture_buckets_history`;
CREATE TABLE IF NOT EXISTS `student_lecture_buckets_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int DEFAULT NULL,
  `student_lecture_buckets_id` int DEFAULT NULL,
  `comment` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `general_user_profile_gup_id` (`general_user_profile_gup_id`) USING BTREE,
  KEY `student_lecture_buckets_id` (`student_lecture_buckets_id`) USING BTREE,
  CONSTRAINT `student_lecture_buckets_history_ibfk_1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_lecture_buckets_history_ibfk_2` FOREIGN KEY (`student_lecture_buckets_id`) REFERENCES `student_lecture_buckets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53022 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_letter_manager
DROP TABLE IF EXISTS `student_letter_manager`;
CREATE TABLE IF NOT EXISTS `student_letter_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` datetime DEFAULT NULL,
  `letter_manager_id` int DEFAULT NULL,
  `comment` text,
  `student_s_id` int DEFAULT NULL,
  `is_responded` tinyint(1) DEFAULT NULL,
  `responded_date` datetime DEFAULT NULL,
  `responded_by` int DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `response_comment` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `letter_manager_id` (`letter_manager_id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `responded_by` (`responded_by`) USING BTREE,
  CONSTRAINT `student_letter_manager_ibfk_1` FOREIGN KEY (`letter_manager_id`) REFERENCES `letter_manager` (`id`),
  CONSTRAINT `student_letter_manager_ibfk_2` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_letter_manager_ibfk_3` FOREIGN KEY (`responded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_lien
DROP TABLE IF EXISTS `student_lien`;
CREATE TABLE IF NOT EXISTS `student_lien` (
  `sl_id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL COMMENT 'FK to student.s_id',
  `lien_type_lt_id` int NOT NULL COMMENT 'FK to lien_type.lt_id',
  `lien_reason` text COLLATE utf8mb4_unicode_ci,
  `lien_amount` decimal(12,2) DEFAULT '0.00' COMMENT 'Outstanding amount that triggered lien',
  `lien_status` enum('ACTIVE','CLEARED','WAIVED') COLLATE utf8mb4_unicode_ci DEFAULT 'ACTIVE',
  `placed_date` date NOT NULL,
  `placed_by_gup_id` int DEFAULT NULL COMMENT 'Staff who placed the lien (FK to general_user_profile)',
  `cleared_date` date DEFAULT NULL,
  `cleared_by_gup_id` int DEFAULT NULL COMMENT 'Staff who cleared the lien',
  `cleared_reason` text COLLATE utf8mb4_unicode_ci,
  `is_certificate_release_eligible` tinyint(1) DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`sl_id`),
  KEY `idx_student_lien_student` (`student_s_id`),
  KEY `idx_student_lien_type` (`lien_type_lt_id`),
  KEY `idx_student_lien_status` (`lien_status`),
  KEY `idx_student_lien_placed_date` (`placed_date`),
  KEY `fk_student_lien_placed_by` (`placed_by_gup_id`),
  KEY `fk_student_lien_cleared_by` (`cleared_by_gup_id`),
  CONSTRAINT `fk_student_lien_cleared_by` FOREIGN KEY (`cleared_by_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_student_lien_placed_by` FOREIGN KEY (`placed_by_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_student_lien_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_lien_type` FOREIGN KEY (`lien_type_lt_id`) REFERENCES `lien_type` (`lt_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_marketing_manager
DROP TABLE IF EXISTS `student_marketing_manager`;
CREATE TABLE IF NOT EXISTS `student_marketing_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL COMMENT 'marketing org',
  `year_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_marketing_manager_student1_idx` (`student_s_id`),
  KEY `fk_student_marketing_manager_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_marketing_manager_year1_idx` (`year_id`),
  CONSTRAINT `fk_student_marketing_manager_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_marketing_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_marketing_manager_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49434 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_marketting_media
DROP TABLE IF EXISTS `student_marketting_media`;
CREATE TABLE IF NOT EXISTS `student_marketting_media` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `student_introduced_by_sc_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_marketting_media_student1_idx` (`student_s_id`),
  KEY `fk_student_marketting_media_student_introduced_by1_idx` (`student_introduced_by_sc_id`),
  CONSTRAINT `fk_student_marketting_media_student_introduced_by1` FOREIGN KEY (`student_introduced_by_sc_id`) REFERENCES `student_introduced_by` (`sc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27801 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_meal
DROP TABLE IF EXISTS `student_meal`;
CREATE TABLE IF NOT EXISTS `student_meal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_meal_controller
DROP TABLE IF EXISTS `student_meal_controller`;
CREATE TABLE IF NOT EXISTS `student_meal_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `student_meal_id` int NOT NULL,
  `student_batches_sb_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_meal_controller_student1_idx` (`student_s_id`),
  KEY `fk_student_meal_controller_student_meal1_idx` (`student_meal_id`),
  KEY `fk_student_meal_controller_student_batches1_idx` (`student_batches_sb_id`),
  CONSTRAINT `fk_student_meal_controller_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_meal_controller_student_batches1` FOREIGN KEY (`student_batches_sb_id`) REFERENCES `student_batches` (`sb_id`),
  CONSTRAINT `fk_student_meal_controller_student_meal1` FOREIGN KEY (`student_meal_id`) REFERENCES `student_meal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_name_verify_manager
DROP TABLE IF EXISTS `student_name_verify_manager`;
CREATE TABLE IF NOT EXISTS `student_name_verify_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `forename` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `surname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `proof_doc_url` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `uploaded_date` datetime DEFAULT NULL,
  `is_verify` tinyint(1) DEFAULT NULL,
  `verified_date` date DEFAULT NULL,
  `verified_by` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `updated_date` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `verified_ip_address` varchar(50) DEFAULT NULL,
  `verification_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `verified_by` (`verified_by`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `student_name_verify_manager_ibfk_1` FOREIGN KEY (`verified_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_name_verify_manager_ibfk_2` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_name_verify_manager_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4110 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_notification_message
DROP TABLE IF EXISTS `student_notification_message`;
CREATE TABLE IF NOT EXISTS `student_notification_message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_fcm_token_id` int DEFAULT NULL,
  `notification_message_id` int DEFAULT NULL,
  `is_seen` tinyint(1) DEFAULT NULL,
  `notification_response_type_id` int DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_fcm_token_id` (`student_fcm_token_id`) USING BTREE,
  KEY `notification_message_id` (`notification_message_id`) USING BTREE,
  KEY `notification_response_type_id` (`notification_response_type_id`),
  CONSTRAINT `student_notification_message_ibfk_1` FOREIGN KEY (`student_fcm_token_id`) REFERENCES `student_fcm_token` (`id`),
  CONSTRAINT `student_notification_message_ibfk_2` FOREIGN KEY (`notification_message_id`) REFERENCES `notification_message` (`id`),
  CONSTRAINT `student_notification_message_ibfk_3` FOREIGN KEY (`notification_response_type_id`) REFERENCES `notification_response_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5991 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_offer
DROP TABLE IF EXISTS `student_offer`;
CREATE TABLE IF NOT EXISTS `student_offer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_taken` tinyint(1) DEFAULT NULL,
  `offer_manager_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_offer_offer_manager1_idx` (`offer_manager_id`),
  KEY `fk_student_offer_student1_idx` (`student_s_id`),
  KEY `fk_student_offer_course1_idx` (`course_cid`),
  CONSTRAINT `fk_student_offer_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_student_offer_offer_manager1` FOREIGN KEY (`offer_manager_id`) REFERENCES `offer_manager` (`id`),
  CONSTRAINT `fk_student_offer_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1283 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_officer_history
DROP TABLE IF EXISTS `student_officer_history`;
CREATE TABLE IF NOT EXISTS `student_officer_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_gup_id` int DEFAULT NULL,
  `officer_gup_id` int DEFAULT NULL,
  `assigned_date` datetime DEFAULT NULL,
  `unassigned_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_gup_id` (`student_gup_id`) USING BTREE,
  KEY `officer_gup_id` (`officer_gup_id`) USING BTREE,
  CONSTRAINT `student_officer_history_ibfk_1` FOREIGN KEY (`student_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_officer_history_ibfk_2` FOREIGN KEY (`officer_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=44195 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_online_payment
DROP TABLE IF EXISTS `student_online_payment`;
CREATE TABLE IF NOT EXISTS `student_online_payment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `online_payment_type_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `payment_mode_payment_mode_id` int DEFAULT NULL,
  `student_batches_sb_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student-online-payment_student1_idx` (`student_s_id`),
  KEY `fk_student_online_payment_online_payment_type1_idx` (`online_payment_type_id`),
  KEY `fk_student_online_payment_payment_mode1_idx` (`payment_mode_payment_mode_id`),
  KEY `fk_student_online_payment_student_batches1_idx` (`student_batches_sb_id`),
  CONSTRAINT `fk_student_online_payment_online_payment_type1` FOREIGN KEY (`online_payment_type_id`) REFERENCES `online_payment_type` (`id`),
  CONSTRAINT `fk_student_online_payment_payment_mode1` FOREIGN KEY (`payment_mode_payment_mode_id`) REFERENCES `payment_mode` (`payment_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=113191 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_online_payment_transaction
DROP TABLE IF EXISTS `student_online_payment_transaction`;
CREATE TABLE IF NOT EXISTS `student_online_payment_transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_online_payment_id` int NOT NULL,
  `online_transactions_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_online_payment_transaction_student_online_paymen_idx` (`student_online_payment_id`),
  KEY `fk_student_online_payment_transaction_online_transactions1_idx` (`online_transactions_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26324 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_org
DROP TABLE IF EXISTS `student_org`;
CREATE TABLE IF NOT EXISTS `student_org` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `organization_type_id_ot` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_org_student1_idx` (`student_s_id`),
  KEY `fk_student_org_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_student_org_organization_type1_idx` (`organization_type_id_ot`),
  CONSTRAINT `fk_student_org_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_student_org_organization_type1` FOREIGN KEY (`organization_type_id_ot`) REFERENCES `organization_type` (`id_ot`),
  CONSTRAINT `fk_student_org_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1672 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_other_institutes_and_courses
DROP TABLE IF EXISTS `student_other_institutes_and_courses`;
CREATE TABLE IF NOT EXISTS `student_other_institutes_and_courses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `institute_name` varchar(145) DEFAULT NULL,
  `course` varchar(145) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_other_institutes_and_courses_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_other_institutes_and_courses_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_manager
DROP TABLE IF EXISTS `student_payment_manager`;
CREATE TABLE IF NOT EXISTS `student_payment_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doc` varchar(1000) DEFAULT NULL,
  `paid_date` date DEFAULT NULL,
  `entered_amount` double DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `universal_approval_status_manager_id` int DEFAULT NULL,
  `approved_amount` double DEFAULT NULL,
  `is_approved` int DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_manager_student1_idx` (`student_s_id`),
  KEY `fk_student_payment_manager_universal_approval_status_manage_idx` (`universal_approval_status_manager_id`),
  CONSTRAINT `fk_student_payment_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_payment_manager_universal_approval_status_manager1` FOREIGN KEY (`universal_approval_status_manager_id`) REFERENCES `universal_approval_status_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4221 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_manager_course
DROP TABLE IF EXISTS `student_payment_manager_course`;
CREATE TABLE IF NOT EXISTS `student_payment_manager_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_payment_manager_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `amount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_manager_course_student_payment_manager1_idx` (`student_payment_manager_id`),
  KEY `fk_student_payment_manager_course_course1_idx` (`course_cid`),
  CONSTRAINT `fk_student_payment_manager_course_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_student_payment_manager_course_student_payment_manager1` FOREIGN KEY (`student_payment_manager_id`) REFERENCES `student_payment_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4262 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_manager_voucher_item
DROP TABLE IF EXISTS `student_payment_manager_voucher_item`;
CREATE TABLE IF NOT EXISTS `student_payment_manager_voucher_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_payment_manager_id` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_manager_voucher_student_payment_manager1_idx` (`student_payment_manager_id`),
  KEY `fk_student_payment_manager_voucher_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_student_payment_manager_voucher_student_payment_manager1` FOREIGN KEY (`student_payment_manager_id`) REFERENCES `student_payment_manager` (`id`),
  CONSTRAINT `fk_student_payment_manager_voucher_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3047 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_method
DROP TABLE IF EXISTS `student_payment_method`;
CREATE TABLE IF NOT EXISTS `student_payment_method` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_method_history
DROP TABLE IF EXISTS `student_payment_method_history`;
CREATE TABLE IF NOT EXISTS `student_payment_method_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `univeral_payment_manager_id` int NOT NULL,
  `student_payment_method_id` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_payment_method_id` (`student_payment_method_id`),
  KEY `univeral_payment_manager_id` (`univeral_payment_manager_id`),
  KEY `added_by` (`added_by`),
  CONSTRAINT `student_payment_method_history_ibfk_1` FOREIGN KEY (`student_payment_method_id`) REFERENCES `student_payment_method` (`id`),
  CONSTRAINT `student_payment_method_history_ibfk_2` FOREIGN KEY (`univeral_payment_manager_id`) REFERENCES `universal_payment_manager` (`id`),
  CONSTRAINT `student_payment_method_history_ibfk_3` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_schedule
DROP TABLE IF EXISTS `student_payment_schedule`;
CREATE TABLE IF NOT EXISTS `student_payment_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `penalty` double DEFAULT NULL,
  `interest` double DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  `is_manual` tinyint(1) DEFAULT NULL,
  `student_payment_schedule_summary_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_schedule_student_payment_schedule_summar_idx` (`student_payment_schedule_summary_id`),
  CONSTRAINT `fk_student_payment_schedule_student_payment_schedule_summary1` FOREIGN KEY (`student_payment_schedule_summary_id`) REFERENCES `student_payment_schedule_summary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=403 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_scheduler
DROP TABLE IF EXISTS `student_payment_scheduler`;
CREATE TABLE IF NOT EXISTS `student_payment_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_loan` tinyint(1) DEFAULT NULL,
  `course_cid` int NOT NULL,
  `payment_option_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_scheduler_course1_idx` (`course_cid`),
  KEY `fk_student_payment_scheduler_payment_option1_idx` (`payment_option_id`),
  KEY `fk_student_payment_scheduler_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_payment_scheduler_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_student_payment_scheduler_payment_option1` FOREIGN KEY (`payment_option_id`) REFERENCES `payment_option` (`id`),
  CONSTRAINT `fk_student_payment_scheduler_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6638 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_scheduler_calling_history
DROP TABLE IF EXISTS `student_payment_scheduler_calling_history`;
CREATE TABLE IF NOT EXISTS `student_payment_scheduler_calling_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_payment_scheduler_dates_id` int NOT NULL,
  `calling_history_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_scheduler_calling_history_student_paymen_idx` (`student_payment_scheduler_dates_id`),
  KEY `fk_student_payment_scheduler_calling_history_calling_histor_idx` (`calling_history_id`),
  CONSTRAINT `fk_student_payment_scheduler_calling_history_calling_history1` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `fk_student_payment_scheduler_calling_history_student_payment_1` FOREIGN KEY (`student_payment_scheduler_dates_id`) REFERENCES `student_payment_scheduler_dates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_scheduler_dates
DROP TABLE IF EXISTS `student_payment_scheduler_dates`;
CREATE TABLE IF NOT EXISTS `student_payment_scheduler_dates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_to_be_paid` date DEFAULT NULL,
  `to_be_paid_amount` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `student_payment_scheduler_id` int NOT NULL,
  `discount` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_scheduler_dates_student_payment_schedule_idx` (`student_payment_scheduler_id`),
  CONSTRAINT `fk_student_payment_scheduler_dates_student_payment_scheduler1` FOREIGN KEY (`student_payment_scheduler_id`) REFERENCES `student_payment_scheduler` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24806 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_scheduler_dates_voucher_item
DROP TABLE IF EXISTS `student_payment_scheduler_dates_voucher_item`;
CREATE TABLE IF NOT EXISTS `student_payment_scheduler_dates_voucher_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_payment_scheduler_dates_id` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_payment_scheduler_dates_voucher_item_student_pay_idx` (`student_payment_scheduler_dates_id`),
  KEY `fk_student_payment_scheduler_dates_voucher_item_voucher_ite_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_student_payment_scheduler_dates_voucher_item_student_payme1` FOREIGN KEY (`student_payment_scheduler_dates_id`) REFERENCES `student_payment_scheduler_dates` (`id`),
  CONSTRAINT `fk_student_payment_scheduler_dates_voucher_item_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12755 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_payment_schedule_summary
DROP TABLE IF EXISTS `student_payment_schedule_summary`;
CREATE TABLE IF NOT EXISTS `student_payment_schedule_summary` (
  `id` int NOT NULL AUTO_INCREMENT,
  `initial_payment` double DEFAULT NULL,
  `paid_penalty` double DEFAULT NULL,
  `paid_installment` double DEFAULT NULL,
  `paid_interest` double DEFAULT NULL,
  `cf_balance` double DEFAULT NULL,
  `discount_percentage` double DEFAULT NULL,
  `discounted_amount` double DEFAULT NULL,
  `eligibility_for_interest_offer` tinyint(1) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_course_payment_summary_student1_idx` (`student_s_id`),
  KEY `fk_student_course_payment_summary_course1_idx` (`course_cid`),
  CONSTRAINT `fk_student_course_payment_summary_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_course_payment_summary_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_plan_voucher_manager
DROP TABLE IF EXISTS `student_plan_voucher_manager`;
CREATE TABLE IF NOT EXISTS `student_plan_voucher_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_payment_schedule_summary_id` int NOT NULL,
  `voucher_vid` int NOT NULL,
  `voucher_type_vt_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_plan_voucher_manager_student_payment_schedule_su_idx` (`student_payment_schedule_summary_id`),
  KEY `fk_student_plan_voucher_manager_voucher1_idx` (`voucher_vid`),
  KEY `fk_student_plan_voucher_manager_voucher_type1_idx` (`voucher_type_vt_id`),
  CONSTRAINT `fk_student_plan_voucher_manager_student_payment_schedule_summ1` FOREIGN KEY (`student_payment_schedule_summary_id`) REFERENCES `student_payment_schedule_summary` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_plan_voucher_manager_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_plan_voucher_manager_voucher_type1` FOREIGN KEY (`voucher_type_vt_id`) REFERENCES `voucher_type` (`vt_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_pool_batch
DROP TABLE IF EXISTS `student_pool_batch`;
CREATE TABLE IF NOT EXISTS `student_pool_batch` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL,
  `is_in_pool` tinyint(1) DEFAULT NULL COMMENT 'This is true when the student is eligible for batch transfer and untill transfer to the main pool when all the pools are true \nAlso if the student claim that course has been stopped',
  `student_pool_type_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  `pool_batch_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL COMMENT 'if a student giveup the course all the poolls will become false and is_deleted of the main pool will become false and is_active also will become false',
  `assign_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_pool_student1_idx` (`student_s_id`),
  KEY `fk_student_pool_student_pool_type1_idx` (`student_pool_type_id`),
  KEY `fk_student_pool_branch1_idx` (`branch_bid`),
  KEY `fk_student_pool_batch_pool_batch1_idx` (`pool_batch_id`),
  CONSTRAINT `fk_student_pool_batch_pool_batch1` FOREIGN KEY (`pool_batch_id`) REFERENCES `pool_batch` (`id`),
  CONSTRAINT `fk_student_pool_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_student_pool_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_student_pool_student_pool_type1` FOREIGN KEY (`student_pool_type_id`) REFERENCES `student_pool_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_pool_type
DROP TABLE IF EXISTS `student_pool_type`;
CREATE TABLE IF NOT EXISTS `student_pool_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Automatically\nRequest\nFrom Main Pool\nUnpaid Transfer',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_portfolio_attachment
DROP TABLE IF EXISTS `student_portfolio_attachment`;
CREATE TABLE IF NOT EXISTS `student_portfolio_attachment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `module_other_assignments_id` int NOT NULL,
  `general_user_profilegup_id` int DEFAULT NULL,
  `thumbnail_image` text,
  `social_media_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `fk_module_other_assignments_students_student1_idx` (`student_s_id`) USING BTREE,
  KEY `fk_module_other_assignments_students_module_other_assignmen_idx` (`module_other_assignments_id`) USING BTREE,
  KEY `general_user_profile_released_by` (`general_user_profilegup_id`) USING BTREE,
  CONSTRAINT `student_portfolio_attachment_ibfk_1` FOREIGN KEY (`module_other_assignments_id`) REFERENCES `module_other_assignments` (`id`),
  CONSTRAINT `student_portfolio_attachment_ibfk_2` FOREIGN KEY (`general_user_profilegup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=897 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_postpone_request_manager
DROP TABLE IF EXISTS `student_postpone_request_manager`;
CREATE TABLE IF NOT EXISTS `student_postpone_request_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `postpone_duration_id` int DEFAULT NULL,
  `duraion` varchar(50) DEFAULT NULL,
  `reason` text,
  `request_date` datetime DEFAULT NULL,
  `login_session_id` int DEFAULT NULL,
  `is_agreed` tinyint DEFAULT NULL,
  `is_paid` tinyint DEFAULT NULL,
  `online_tranaction_id` int DEFAULT NULL,
  `send_otp` int DEFAULT NULL,
  `is_otp_verified` tinyint DEFAULT NULL,
  `otp_verify_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_postpone_request_manager_student` (`student_id`),
  KEY `FK_student_postpone_request_manager_postpone_duration` (`postpone_duration_id`),
  KEY `FK_student_postpone_request_manager_login_session` (`login_session_id`),
  KEY `FK_student_postpone_request_manager_online_transactions` (`online_tranaction_id`),
  CONSTRAINT `FK_student_postpone_request_manager_login_session` FOREIGN KEY (`login_session_id`) REFERENCES `login_session` (`session_id`),
  CONSTRAINT `FK_student_postpone_request_manager_online_transactions` FOREIGN KEY (`online_tranaction_id`) REFERENCES `online_transactions` (`id`),
  CONSTRAINT `FK_student_postpone_request_manager_postpone_duration` FOREIGN KEY (`postpone_duration_id`) REFERENCES `postpone_duration` (`id`),
  CONSTRAINT `FK_student_postpone_request_manager_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_previous_education
DROP TABLE IF EXISTS `student_previous_education`;
CREATE TABLE IF NOT EXISTS `student_previous_education` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_application_manager_id` int NOT NULL,
  `student_course_id` int NOT NULL,
  `year_enrolled` int DEFAULT NULL,
  `state_id_s` int NOT NULL,
  `document_manager_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_previous_education_student_application_manager1_idx` (`student_application_manager_id`),
  KEY `fk_student_previous_education_student_course1_idx` (`student_course_id`),
  KEY `fk_student_previous_education_state1_idx` (`state_id_s`),
  KEY `fk_student_previous_education_document_manager1_idx` (`document_manager_id`),
  CONSTRAINT `fk_student_previous_education_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_student_previous_education_state1` FOREIGN KEY (`state_id_s`) REFERENCES `state` (`id_s`),
  CONSTRAINT `fk_student_previous_education_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`),
  CONSTRAINT `fk_student_previous_education_student_course1` FOREIGN KEY (`student_course_id`) REFERENCES `student_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_profile_completion
DROP TABLE IF EXISTS `student_profile_completion`;
CREATE TABLE IF NOT EXISTS `student_profile_completion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uploaded_by` (`uploaded_by`) USING BTREE,
  KEY `students_id` (`students_id`) USING BTREE,
  CONSTRAINT `student_profile_completion_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `student_profile_completion_ibfk_2` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_qualification
DROP TABLE IF EXISTS `student_qualification`;
CREATE TABLE IF NOT EXISTS `student_qualification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `year_of_award` int DEFAULT NULL,
  `gpa` double DEFAULT NULL,
  `is_completed` int DEFAULT NULL,
  `is_paid` int DEFAULT NULL,
  `qualification_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_qualification_qualification1_idx` (`qualification_id`),
  KEY `fk_student_qualification_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_qualification_qualification1` FOREIGN KEY (`qualification_id`) REFERENCES `qualification` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_qualification_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_receivable_enter
DROP TABLE IF EXISTS `student_receivable_enter`;
CREATE TABLE IF NOT EXISTS `student_receivable_enter` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `description` text,
  `entered_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `universal_payment_manager_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_receivable_enter_universal_payment_manager1_idx` (`universal_payment_manager_id`),
  KEY `fk_student_receivable_enter_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_student_receivable_enter_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_receivable_enter_universal_payment_manager1` FOREIGN KEY (`universal_payment_manager_id`) REFERENCES `universal_payment_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1754 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_request_access_manager
DROP TABLE IF EXISTS `student_request_access_manager`;
CREATE TABLE IF NOT EXISTS `student_request_access_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_request_type_id` int DEFAULT NULL,
  `general_user_profile_id` int DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_student_request_access_manager_student_request_type` (`student_request_type_id`),
  KEY `FK_student_request_access_manager_general_user_profile` (`general_user_profile_id`),
  KEY `FK_student_request_access_manager_general_user_profile_2` (`added_by`),
  CONSTRAINT `FK_student_request_access_manager_general_user_profile` FOREIGN KEY (`general_user_profile_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_request_access_manager_general_user_profile_2` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_request_access_manager_student_request_type` FOREIGN KEY (`student_request_type_id`) REFERENCES `student_request_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_request_manager
DROP TABLE IF EXISTS `student_request_manager`;
CREATE TABLE IF NOT EXISTS `student_request_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` datetime DEFAULT NULL,
  `description` text,
  `student_request_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `is_responded` tinyint(1) DEFAULT NULL,
  `responded_date` datetime DEFAULT NULL,
  `general_user_profile_responded_by` int DEFAULT NULL,
  `response` text,
  `email_response` text,
  `request_id` varchar(255) DEFAULT NULL,
  `student_request_manager_id` int DEFAULT NULL,
  `satisfaction_level_id` int DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `satisfaction_comment` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_request_manager_student_request_type1_idx` (`student_request_type_id`),
  KEY `fk_student_request_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_request_manager_general_user_profile2_idx` (`general_user_profile_responded_by`),
  KEY `fk_student_request_manager_student_request_manager1` (`student_request_manager_id`),
  KEY `FK_student_request_manager_satisfaction_level1` (`satisfaction_level_id`),
  CONSTRAINT `fk_student_request_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_request_manager_general_user_profile2` FOREIGN KEY (`general_user_profile_responded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_student_request_manager_satisfaction_level1` FOREIGN KEY (`satisfaction_level_id`) REFERENCES `satisfaction_level` (`id`),
  CONSTRAINT `fk_student_request_manager_student_request_manager1` FOREIGN KEY (`student_request_manager_id`) REFERENCES `student_request_manager` (`id`),
  CONSTRAINT `fk_student_request_manager_student_request_type1` FOREIGN KEY (`student_request_type_id`) REFERENCES `student_request_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25978 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_request_type
DROP TABLE IF EXISTS `student_request_type`;
CREATE TABLE IF NOT EXISTS `student_request_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_reserved_hall_floor_table
DROP TABLE IF EXISTS `student_reserved_hall_floor_table`;
CREATE TABLE IF NOT EXISTS `student_reserved_hall_floor_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reserved_date` date DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `hall_floor_table_id` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `time_slot_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hall_floor_table_id` (`hall_floor_table_id`),
  KEY `students_id` (`students_id`),
  KEY `time_slot_id` (`time_slot_id`),
  CONSTRAINT `student_reserved_hall_floor_table_ibfk_1` FOREIGN KEY (`hall_floor_table_id`) REFERENCES `hall_floor_table` (`id`),
  CONSTRAINT `student_reserved_hall_floor_table_ibfk_2` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_reserved_hall_floor_table_ibfk_3` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_reserved_hall_table
DROP TABLE IF EXISTS `student_reserved_hall_table`;
CREATE TABLE IF NOT EXISTS `student_reserved_hall_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reserved_date` date DEFAULT NULL,
  `is_active` tinyint DEFAULT NULL,
  `hall_table_id` int DEFAULT NULL,
  `students_id` int DEFAULT NULL,
  `time_slot_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__hall_table` (`hall_table_id`),
  KEY `FK__student` (`students_id`),
  KEY `time_slot_id` (`time_slot_id`),
  CONSTRAINT `FK__hall_table` FOREIGN KEY (`hall_table_id`) REFERENCES `hall_table` (`id`),
  CONSTRAINT `FK__student` FOREIGN KEY (`students_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `student_reserved_hall_table_ibfk_1` FOREIGN KEY (`time_slot_id`) REFERENCES `time_slot` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_result_finalizing_manager
DROP TABLE IF EXISTS `student_result_finalizing_manager`;
CREATE TABLE IF NOT EXISTS `student_result_finalizing_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int DEFAULT NULL,
  `student_result_finalizing_status_id` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_srfm_student` (`student_id`),
  KEY `FK_srfm_student_result_finalizing_status` (`student_result_finalizing_status_id`),
  KEY `FK_srfm_general_user_profile` (`update_by`),
  CONSTRAINT `FK_srfm_general_user_profile` FOREIGN KEY (`update_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_srfm_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `FK_srfm_student_result_finalizing_status` FOREIGN KEY (`student_result_finalizing_status_id`) REFERENCES `student_result_finalizing_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=804 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_result_finalizing_marks
DROP TABLE IF EXISTS `student_result_finalizing_marks`;
CREATE TABLE IF NOT EXISTS `student_result_finalizing_marks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `mark` double DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_srfmark_course` (`course_id`),
  KEY `FK_srfmark_general_user_profile` (`added_by`),
  KEY `FK_srfmark_student_result_finalizing_manager` (`student_id`) USING BTREE,
  CONSTRAINT `FK_srfmark_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`cid`),
  CONSTRAINT `FK_srfmark_general_user_profile` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_srfmark_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12230 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_result_finalizing_status
DROP TABLE IF EXISTS `student_result_finalizing_status`;
CREATE TABLE IF NOT EXISTS `student_result_finalizing_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_risk_score
DROP TABLE IF EXISTS `student_risk_score`;
CREATE TABLE IF NOT EXISTS `student_risk_score` (
  `srs_id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int NOT NULL COMMENT 'FK to student.s_id',
  `risk_score` int NOT NULL DEFAULT '100' COMMENT 'Score 0-100, higher is better',
  `risk_category_rc_id` int DEFAULT NULL COMMENT 'FK to risk_category.rc_id',
  `payment_behavior_score` int DEFAULT '100' COMMENT 'Based on payment timeliness',
  `outstanding_ratio_score` int DEFAULT '100' COMMENT 'Based on outstanding vs total fee',
  `days_overdue` int DEFAULT '0' COMMENT 'Current days overdue',
  `missed_payments_count` int DEFAULT '0' COMMENT 'Total missed payment deadlines',
  `last_calculated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `calculation_notes` text COLLATE utf8mb4_unicode_ci,
  `is_active` tinyint(1) DEFAULT '1',
  `version` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`srs_id`),
  UNIQUE KEY `idx_student_risk_score_student` (`student_s_id`),
  KEY `idx_student_risk_score_value` (`risk_score`),
  KEY `idx_student_risk_score_category` (`risk_category_rc_id`),
  KEY `idx_student_risk_score_overdue` (`days_overdue`),
  CONSTRAINT `fk_student_risk_score_category` FOREIGN KEY (`risk_category_rc_id`) REFERENCES `risk_category` (`rc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_student_risk_score_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_scholarship_marks
DROP TABLE IF EXISTS `student_scholarship_marks`;
CREATE TABLE IF NOT EXISTS `student_scholarship_marks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scholaship_marking_criteria_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `marketer_leads_id` int DEFAULT NULL,
  `marks` double DEFAULT NULL,
  `marks_entered_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_scholarship_marks_scholaship_marking_criteria1_idx` (`scholaship_marking_criteria_id`),
  KEY `fk_student_scholarship_marks_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_student_scholarship_marks_marketer_leads1_idx` (`marketer_leads_id`),
  CONSTRAINT `fk_student_scholarship_marks_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_student_scholarship_marks_marketer_leads1` FOREIGN KEY (`marketer_leads_id`) REFERENCES `marketer_leads` (`id`),
  CONSTRAINT `fk_student_scholarship_marks_scholaship_marking_criteria1` FOREIGN KEY (`scholaship_marking_criteria_id`) REFERENCES `scholaship_marking_criteria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=336864 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_status
DROP TABLE IF EXISTS `student_status`;
CREATE TABLE IF NOT EXISTS `student_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_status_manager
DROP TABLE IF EXISTS `student_status_manager`;
CREATE TABLE IF NOT EXISTS `student_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_status_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `changed_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_status_manager_student_status1_idx` (`student_status_id`),
  KEY `fk_student_status_manager_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_student_status_manager_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_status_manager_student_status1` FOREIGN KEY (`student_status_id`) REFERENCES `student_status` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_temporary_invoice
DROP TABLE IF EXISTS `student_temporary_invoice`;
CREATE TABLE IF NOT EXISTS `student_temporary_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `invoice_id` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `description` varchar(245) DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `course_cid` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_student_temporary_invoice_student1_idx` (`student_s_id`),
  KEY `fk_student_temporary_invoice_course1_idx` (`course_cid`),
  KEY `fk_student_temporary_invoice_employees1_idx` (`employees_employee_id`),
  KEY `fk_student_temporary_invoice_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_student_temporary_invoice_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_temporary_invoice_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_temporary_invoice_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_student_temporary_invoice_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=680 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.student_years
DROP TABLE IF EXISTS `student_years`;
CREATE TABLE IF NOT EXISTS `student_years` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subject
DROP TABLE IF EXISTS `subject`;
CREATE TABLE IF NOT EXISTS `subject` (
  `idsubject` int unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(45) NOT NULL,
  PRIMARY KEY (`idsubject`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber
DROP TABLE IF EXISTS `subscriber`;
CREATE TABLE IF NOT EXISTS `subscriber` (
  `id` int NOT NULL AUTO_INCREMENT,
  `confirm_code` varchar(145) DEFAULT NULL,
  `subscription_time` datetime DEFAULT NULL,
  `unsubscribe_time` varchar(45) DEFAULT NULL,
  `unsubscribe_reason` text,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscriber_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_subscriber_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscribers
DROP TABLE IF EXISTS `subscribers`;
CREATE TABLE IF NOT EXISTS `subscribers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `subscriber_type_id` int NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `last_updated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscribers_subscriber_type1_idx` (`subscriber_type_id`),
  CONSTRAINT `fk_subscribers_subscriber_type1` FOREIGN KEY (`subscriber_type_id`) REFERENCES `subscriber_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20275 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber_category
DROP TABLE IF EXISTS `subscriber_category`;
CREATE TABLE IF NOT EXISTS `subscriber_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber_category_controller
DROP TABLE IF EXISTS `subscriber_category_controller`;
CREATE TABLE IF NOT EXISTS `subscriber_category_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscriber_category_id` int NOT NULL,
  `subscriber_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscriber_category_controller_subscriber_category1_idx` (`subscriber_category_id`),
  KEY `fk_subscriber_category_controller_subscriber1_idx` (`subscriber_id`),
  CONSTRAINT `fk_subscriber_category_controller_subscriber1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`id`),
  CONSTRAINT `fk_subscriber_category_controller_subscriber_category1` FOREIGN KEY (`subscriber_category_id`) REFERENCES `subscriber_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber_status
DROP TABLE IF EXISTS `subscriber_status`;
CREATE TABLE IF NOT EXISTS `subscriber_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber_status_controller
DROP TABLE IF EXISTS `subscriber_status_controller`;
CREATE TABLE IF NOT EXISTS `subscriber_status_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscriber_status_id` int NOT NULL,
  `subscriber_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscriber_status_controller_subscriber_status1_idx` (`subscriber_status_id`),
  KEY `fk_subscriber_status_controller_subscriber1_idx` (`subscriber_id`),
  CONSTRAINT `fk_subscriber_status_controller_subscriber1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`id`),
  CONSTRAINT `fk_subscriber_status_controller_subscriber_status1` FOREIGN KEY (`subscriber_status_id`) REFERENCES `subscriber_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscriber_type
DROP TABLE IF EXISTS `subscriber_type`;
CREATE TABLE IF NOT EXISTS `subscriber_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_category_controller
DROP TABLE IF EXISTS `subscription_category_controller`;
CREATE TABLE IF NOT EXISTS `subscription_category_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `subscriber_id` int NOT NULL,
  `post_category_id` int NOT NULL,
  `selected` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscription_category_controller_subscriber1_idx` (`subscriber_id`),
  CONSTRAINT `fk_subscription_category_controller_subscriber1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_email
DROP TABLE IF EXISTS `subscription_email`;
CREATE TABLE IF NOT EXISTS `subscription_email` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `is_subscribed` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1154 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_frequency
DROP TABLE IF EXISTS `subscription_frequency`;
CREATE TABLE IF NOT EXISTS `subscription_frequency` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL,
  `description` text,
  `is_active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_sent_mail
DROP TABLE IF EXISTS `subscription_sent_mail`;
CREATE TABLE IF NOT EXISTS `subscription_sent_mail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `subscriber_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscription_sent_mail_subscriber1_idx` (`subscriber_id`),
  CONSTRAINT `fk_subscription_sent_mail_subscriber1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_sent_mail_post
DROP TABLE IF EXISTS `subscription_sent_mail_post`;
CREATE TABLE IF NOT EXISTS `subscription_sent_mail_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `subscription_sent_mail_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscription_sent_mail_post_subscription_sent_mail1_idx` (`subscription_sent_mail_id`),
  CONSTRAINT `fk_subscription_sent_mail_post_subscription_sent_mail1` FOREIGN KEY (`subscription_sent_mail_id`) REFERENCES `subscription_sent_mail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.subscription_sent_time
DROP TABLE IF EXISTS `subscription_sent_time`;
CREATE TABLE IF NOT EXISTS `subscription_sent_time` (
  `id` int NOT NULL AUTO_INCREMENT,
  `selected` tinyint(1) NOT NULL,
  `subscriber_id` int NOT NULL,
  `subscription_frequency_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_subscription_sent_time_subscriber1_idx` (`subscriber_id`),
  KEY `fk_subscription_sent_time_subscription_frequency1_idx` (`subscription_frequency_id`),
  CONSTRAINT `fk_subscription_sent_time_subscriber1` FOREIGN KEY (`subscriber_id`) REFERENCES `subscriber` (`id`),
  CONSTRAINT `fk_subscription_sent_time_subscription_frequency1` FOREIGN KEY (`subscription_frequency_id`) REFERENCES `subscription_frequency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sub_chart_of_account
DROP TABLE IF EXISTS `sub_chart_of_account`;
CREATE TABLE IF NOT EXISTS `sub_chart_of_account` (
  `is_sca` int NOT NULL AUTO_INCREMENT,
  `reference` varchar(255) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL COMMENT '1-10',
  `sub_account_name` varchar(255) DEFAULT NULL,
  `chart_of_accountcoa_id` int DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  `scoa_type_id_st` int DEFAULT NULL,
  `sub_chart_of_account_is_sca` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  PRIMARY KEY (`is_sca`),
  KEY `FKsub_chart_277677` (`chart_of_accountcoa_id`),
  KEY `fk_sub_chart_of_account_scoa_type1_idx` (`scoa_type_id_st`),
  KEY `fk_sub_chart_of_account_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_sub_chart_of_account_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_sub_chart_of_account_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_sub_chart_of_account_scoa_type1` FOREIGN KEY (`scoa_type_id_st`) REFERENCES `scoa_type` (`id_st`),
  CONSTRAINT `fk_sub_chart_of_account_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`),
  CONSTRAINT `FKsub_chart_277677` FOREIGN KEY (`chart_of_accountcoa_id`) REFERENCES `chart_of_account` (`coa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=219177 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sub_policy
DROP TABLE IF EXISTS `sub_policy`;
CREATE TABLE IF NOT EXISTS `sub_policy` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(450) DEFAULT NULL,
  `code` varchar(45) DEFAULT NULL,
  `policy_doc_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sub_policy_policy_doc1_idx` (`policy_doc_id`),
  CONSTRAINT `fk_sub_policy_policy_doc1` FOREIGN KEY (`policy_doc_id`) REFERENCES `policy_doc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.sub_policy_doc_content
DROP TABLE IF EXISTS `sub_policy_doc_content`;
CREATE TABLE IF NOT EXISTS `sub_policy_doc_content` (
  `id` int NOT NULL AUTO_INCREMENT,
  `version_id` varchar(45) DEFAULT NULL,
  `path` varchar(450) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `iso_gop_id` int NOT NULL,
  `sub_policy_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sub_policy_doc_iso_gop1_idx` (`iso_gop_id`),
  KEY `fk_sub_policy_doc_content_sub_policy1_idx` (`sub_policy_id`),
  CONSTRAINT `fk_sub_policy_doc_content_sub_policy1` FOREIGN KEY (`sub_policy_id`) REFERENCES `sub_policy` (`id`),
  CONSTRAINT `fk_sub_policy_doc_iso_gop1` FOREIGN KEY (`iso_gop_id`) REFERENCES `iso_gop` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.survey
DROP TABLE IF EXISTS `survey`;
CREATE TABLE IF NOT EXISTS `survey` (
  `id` int NOT NULL AUTO_INCREMENT,
  `survey_name` text,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `decription` text,
  `total_participants` int DEFAULT NULL,
  `total_questions` int DEFAULT NULL,
  `total_response` int DEFAULT NULL,
  `total_viewed` int DEFAULT NULL,
  `is_sent` tinyint(1) DEFAULT NULL,
  `servey_type_id` int NOT NULL,
  `exam_id` int DEFAULT NULL,
  `assesment_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_survey_servey_type1_idx` (`servey_type_id`),
  KEY `exam_id` (`exam_id`),
  KEY `assesment_id` (`assesment_id`),
  CONSTRAINT `fk_survey_servey_type1` FOREIGN KEY (`servey_type_id`) REFERENCES `servey_type` (`id`),
  CONSTRAINT `survey_ibfk_1` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  CONSTRAINT `survey_ibfk_2` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2572 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.survey_participants
DROP TABLE IF EXISTS `survey_participants`;
CREATE TABLE IF NOT EXISTS `survey_participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sent_date` datetime DEFAULT NULL,
  `is_responed` tinyint(1) DEFAULT NULL,
  `is_viewed` tinyint(1) DEFAULT NULL,
  `comment` text,
  `survey_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_survey_participants_survey1_idx` (`survey_id`),
  KEY `fk_survey_participants_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_survey_participants_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_survey_participants_survey1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=151782 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.survey_question
DROP TABLE IF EXISTS `survey_question`;
CREATE TABLE IF NOT EXISTS `survey_question` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question_order` int DEFAULT NULL,
  `question_id` int NOT NULL,
  `survey_id` int NOT NULL,
  `answer_group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_survey_question_question1_idx` (`question_id`),
  KEY `fk_survey_question_survey1_idx` (`survey_id`),
  KEY `fk_question_answer_answer_group1_idx` (`answer_group_id`),
  CONSTRAINT `fk_question_answer_answer_group1` FOREIGN KEY (`answer_group_id`) REFERENCES `answer_group` (`id`),
  CONSTRAINT `fk_survey_question_question1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`),
  CONSTRAINT `fk_survey_question_survey1` FOREIGN KEY (`survey_id`) REFERENCES `survey` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60101 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.survey_question_answer
DROP TABLE IF EXISTS `survey_question_answer`;
CREATE TABLE IF NOT EXISTS `survey_question_answer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `score` double DEFAULT NULL,
  `is_selected` tinyint(1) DEFAULT NULL,
  `survey_question_id` int NOT NULL,
  `asnwer_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_survey_question_survey_question1_idx` (`survey_question_id`),
  KEY `fk_survey_question_asnwer1_idx` (`asnwer_id`),
  CONSTRAINT `fk_survey_question_asnwer1` FOREIGN KEY (`asnwer_id`) REFERENCES `asnwer` (`id`),
  CONSTRAINT `fk_survey_question_survey_question1` FOREIGN KEY (`survey_question_id`) REFERENCES `survey_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251929 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.system_interface
DROP TABLE IF EXISTS `system_interface`;
CREATE TABLE IF NOT EXISTS `system_interface` (
  `si_id` int NOT NULL AUTO_INCREMENT,
  `interface_name` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `interface_menu_if_id` int NOT NULL,
  `interface_sub_menu_ifs_id` int DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`si_id`),
  KEY `FKsystem_int570996` (`interface_menu_if_id`),
  KEY `FKsystem_int597127` (`interface_sub_menu_ifs_id`),
  KEY `FKsystem_int570997` (`interface_menu_if_id`),
  KEY `FKsystem_int597128` (`interface_sub_menu_ifs_id`),
  CONSTRAINT `fk_system_interface_interface_menu1` FOREIGN KEY (`interface_menu_if_id`) REFERENCES `interface_menu` (`if_id`),
  CONSTRAINT `fk_system_interface_interface_sub_menu1` FOREIGN KEY (`interface_sub_menu_ifs_id`) REFERENCES `interface_sub_menu` (`ifs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=488 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.table_manager
DROP TABLE IF EXISTS `table_manager`;
CREATE TABLE IF NOT EXISTS `table_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `package_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_table_manager_package_manager1_idx` (`package_manager_id`),
  CONSTRAINT `fk_table_manager_package_manager1` FOREIGN KEY (`package_manager_id`) REFERENCES `package_manager` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.task
DROP TABLE IF EXISTS `task`;
CREATE TABLE IF NOT EXISTS `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.temco_loan_master
DROP TABLE IF EXISTS `temco_loan_master`;
CREATE TABLE IF NOT EXISTS `temco_loan_master` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gup_id` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_temco_loan_master_general_user_profile` (`gup_id`),
  CONSTRAINT `FK_temco_loan_master_general_user_profile` FOREIGN KEY (`gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.temco_loan_master_manager
DROP TABLE IF EXISTS `temco_loan_master_manager`;
CREATE TABLE IF NOT EXISTS `temco_loan_master_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `temco_loan_master_id` int DEFAULT NULL,
  `temco_loan_master_status_id` int DEFAULT NULL,
  `is_complete` tinyint DEFAULT NULL,
  `inactive_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tlmm_temco_loan_master` (`temco_loan_master_id`),
  KEY `FK_tlmm_temco_loan_master_status` (`temco_loan_master_status_id`),
  CONSTRAINT `FK_tlmm_temco_loan_master` FOREIGN KEY (`temco_loan_master_id`) REFERENCES `temco_loan_master` (`id`),
  CONSTRAINT `FK_tlmm_temco_loan_master_status` FOREIGN KEY (`temco_loan_master_status_id`) REFERENCES `temco_loan_master_status` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.temco_loan_master_status
DROP TABLE IF EXISTS `temco_loan_master_status`;
CREATE TABLE IF NOT EXISTS `temco_loan_master_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_slot
DROP TABLE IF EXISTS `time_slot`;
CREATE TABLE IF NOT EXISTS `time_slot` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table
DROP TABLE IF EXISTS `time_table`;
CREATE TABLE IF NOT EXISTS `time_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `lecturer_in_time` time DEFAULT NULL,
  `lecturer_out_time` time DEFAULT NULL,
  `head_count` int DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT NULL,
  `hall_id_h` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `batches_b_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `employees_employee_id` int DEFAULT NULL,
  `time_table_type_id` int NOT NULL,
  `note` text,
  `batch_intake` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time_table_src` varchar(1000) DEFAULT NULL,
  `lecturer_log_src` varchar(1000) DEFAULT NULL,
  `link` text,
  `meeting_id` varchar(45) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `calling_officer` int DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_zoom_sheet_upload` tinyint DEFAULT NULL,
  `zoom_sheet_report` text,
  `is_student_inform` tinyint DEFAULT '0',
  `is_sms_sent` tinyint DEFAULT '0',
  `halls_in_floor_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_time_table_hall1_idx` (`hall_id_h`),
  KEY `fk_time_table_lesson1_idx` (`lesson_id`),
  KEY `fk_time_table_course1_idx` (`course_cid`),
  KEY `fk_time_table_batches1_idx` (`batches_b_id`),
  KEY `fk_time_table_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_time_table_employees1_idx` (`employees_employee_id`),
  KEY `fk_time_table_time_table_type1_idx` (`time_table_type_id`),
  KEY `fk_time_table_batches2_idx` (`batch_intake`),
  KEY `calling_officer` (`calling_officer`),
  CONSTRAINT `fk_time_table_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_batches2` FOREIGN KEY (`batch_intake`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_time_table_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_hall1` FOREIGN KEY (`hall_id_h`) REFERENCES `hall` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_lesson1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_time_table_type1` FOREIGN KEY (`time_table_type_id`) REFERENCES `time_table_type` (`id`),
  CONSTRAINT `time_table_ibfk_1` FOREIGN KEY (`calling_officer`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=527463 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_approved_by
DROP TABLE IF EXISTS `time_table_approved_by`;
CREATE TABLE IF NOT EXISTS `time_table_approved_by` (
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_audit
DROP TABLE IF EXISTS `time_table_audit`;
CREATE TABLE IF NOT EXISTS `time_table_audit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `lecturer_in_time` time DEFAULT NULL,
  `lecturer_out_time` time DEFAULT NULL,
  `head_count` int DEFAULT NULL,
  `is_done` tinyint(1) DEFAULT NULL,
  `hall_id_h` int DEFAULT NULL,
  `lesson_id` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `batches_b_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `employees_employee_id` int DEFAULT NULL,
  `time_table_type_id` int NOT NULL,
  `note` text,
  `batch_intake` int DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `time_table_src` varchar(1000) DEFAULT NULL,
  `lecturer_log_src` varchar(1000) DEFAULT NULL,
  `link` text,
  `meeting_id` varchar(45) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `calling_officer` int DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `is_zoom_sheet_upload` tinyint DEFAULT NULL,
  `zoom_sheet_report` text,
  `is_student_inform` tinyint DEFAULT '0',
  `is_sms_sent` tinyint DEFAULT '0',
  `halls_in_floor_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_time_table_hall1_idx` (`hall_id_h`),
  KEY `fk_time_table_lesson1_idx` (`lesson_id`),
  KEY `fk_time_table_course1_idx` (`course_cid`),
  KEY `fk_time_table_batches1_idx` (`batches_b_id`),
  KEY `fk_time_table_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_time_table_employees1_idx` (`employees_employee_id`),
  KEY `fk_time_table_time_table_type1_idx` (`time_table_type_id`),
  KEY `fk_time_table_batches2_idx` (`batch_intake`),
  KEY `calling_officer` (`calling_officer`),
  CONSTRAINT `fk_time_table_audit_batches1` FOREIGN KEY (`batches_b_id`) REFERENCES `batches` (`b_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_batches2` FOREIGN KEY (`batch_intake`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `fk_time_table_audit_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_hall1` FOREIGN KEY (`hall_id_h`) REFERENCES `hall` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_lesson1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_time_table_audit_time_table_type1` FOREIGN KEY (`time_table_type_id`) REFERENCES `time_table_type` (`id`),
  CONSTRAINT `time_table_audit_ibfk_1` FOREIGN KEY (`calling_officer`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3044 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_buckets
DROP TABLE IF EXISTS `time_table_buckets`;
CREATE TABLE IF NOT EXISTS `time_table_buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int DEFAULT NULL,
  `buckets_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `time_table_id` (`time_table_id`) USING BTREE,
  KEY `buckets_id` (`buckets_id`) USING BTREE,
  CONSTRAINT `time_table_buckets_ibfk_1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`),
  CONSTRAINT `time_table_buckets_ibfk_2` FOREIGN KEY (`buckets_id`) REFERENCES `buckets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1168 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_calling_history
DROP TABLE IF EXISTS `time_table_calling_history`;
CREATE TABLE IF NOT EXISTS `time_table_calling_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `time_table_id` int NOT NULL,
  `calling_history_id` int NOT NULL,
  `time_table_calling_history_type_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_time_table_calling_history_time_table1_idx` (`time_table_id`),
  KEY `fk_time_table_calling_history_calling_history1_idx` (`calling_history_id`),
  KEY `fk_time_table_calling_history_time_table_calling_history_ty_idx` (`time_table_calling_history_type_id`),
  KEY `fk_time_table_calling_history_student1_idx` (`student_s_id`),
  CONSTRAINT `fk_time_table_calling_history_calling_history1` FOREIGN KEY (`calling_history_id`) REFERENCES `calling_history` (`id`),
  CONSTRAINT `fk_time_table_calling_history_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_time_table_calling_history_time_table1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`),
  CONSTRAINT `fk_time_table_calling_history_time_table_calling_history_type1` FOREIGN KEY (`time_table_calling_history_type_id`) REFERENCES `time_table_calling_history_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=630 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_calling_history_type
DROP TABLE IF EXISTS `time_table_calling_history_type`;
CREATE TABLE IF NOT EXISTS `time_table_calling_history_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Last Day Absent\nLast 2 Days Absent\nLast 2 Days Absent',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_class_video
DROP TABLE IF EXISTS `time_table_class_video`;
CREATE TABLE IF NOT EXISTS `time_table_class_video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `time_table_id` int DEFAULT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `time_table_id` (`time_table_id`) USING BTREE,
  KEY `uploaded_by` (`uploaded_by`) USING BTREE,
  CONSTRAINT `time_table_class_video_ibfk_1` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`),
  CONSTRAINT `time_table_class_video_ibfk_2` FOREIGN KEY (`uploaded_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4781 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_lecture_buckets
DROP TABLE IF EXISTS `time_table_lecture_buckets`;
CREATE TABLE IF NOT EXISTS `time_table_lecture_buckets` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lecture_buckets_id` int DEFAULT NULL,
  `time_table_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `lecture_buckets_id` (`lecture_buckets_id`) USING BTREE,
  KEY `time_table_id` (`time_table_id`) USING BTREE,
  CONSTRAINT `time_table_lecture_buckets_ibfk_1` FOREIGN KEY (`lecture_buckets_id`) REFERENCES `lecture_buckets` (`id`),
  CONSTRAINT `time_table_lecture_buckets_ibfk_2` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=452222 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_lecture_video
DROP TABLE IF EXISTS `time_table_lecture_video`;
CREATE TABLE IF NOT EXISTS `time_table_lecture_video` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `time_table_id` int DEFAULT NULL,
  `lecture_video_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  KEY `time_table_id` (`time_table_id`) USING BTREE,
  KEY `lecture_video_id` (`lecture_video_id`) USING BTREE,
  CONSTRAINT `time_table_lecture_video_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `time_table_lecture_video_ibfk_2` FOREIGN KEY (`time_table_id`) REFERENCES `time_table` (`id`),
  CONSTRAINT `time_table_lecture_video_ibfk_3` FOREIGN KEY (`lecture_video_id`) REFERENCES `lecture_video` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=434 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.time_table_type
DROP TABLE IF EXISTS `time_table_type`;
CREATE TABLE IF NOT EXISTS `time_table_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.token_generated
DROP TABLE IF EXISTS `token_generated`;
CREATE TABLE IF NOT EXISTS `token_generated` (
  `id` int NOT NULL AUTO_INCREMENT,
  `datetime` datetime DEFAULT NULL,
  `token_index` int DEFAULT NULL,
  `course_cid` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_token_generated_course1_idx` (`course_cid`),
  KEY `fk_token_generated_employees1_idx` (`employees_employee_id`),
  KEY `fk_token_generated_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_token_generated_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_token_generated_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_token_generated_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_token_generated_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_token_generated_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.total_course_fee_paid_count
DROP TABLE IF EXISTS `total_course_fee_paid_count`;
CREATE TABLE IF NOT EXISTS `total_course_fee_paid_count` (
  `id` int NOT NULL AUTO_INCREMENT,
  `count` int DEFAULT NULL,
  `affiliate_user_id` int NOT NULL,
  `affiliate_reward_plans_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_total_course_fee_count_affiliate_user1_idx` (`affiliate_user_id`),
  KEY `fk_total_course_fee_count_affiliate_reward_plans1_idx` (`affiliate_reward_plans_id`),
  CONSTRAINT `fk_total_course_fee_count_affiliate_reward_plans1` FOREIGN KEY (`affiliate_reward_plans_id`) REFERENCES `affiliate_reward_plans` (`id`),
  CONSTRAINT `fk_total_course_fee_count_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='this table added to sortout the business issue, payments are issued based on number of refarals through each affiliate. count of paid refarals are kept in this table. that count is related to meny payments planes table.';

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.transaction_management
DROP TABLE IF EXISTS `transaction_management`;
CREATE TABLE IF NOT EXISTS `transaction_management` (
  `id_shg` int NOT NULL AUTO_INCREMENT,
  `transaction_id` int DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` int DEFAULT NULL,
  `general_journal_entry_gje_id` int NOT NULL,
  `sub_chart_of_account_is_sca` int NOT NULL,
  `gup_for_am_id_gfa` int NOT NULL,
  `chart_of_account_coa_id` int DEFAULT NULL,
  `gop_for_am_id_gfa` int DEFAULT NULL,
  `account_type_manager_id` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `voucher_vid` int DEFAULT NULL,
  PRIMARY KEY (`id_shg`),
  KEY `fk_transaction_management_general_journal_entry1_idx` (`general_journal_entry_gje_id`),
  KEY `fk_transaction_management_sub_chart_of_account1_idx` (`sub_chart_of_account_is_sca`),
  KEY `fk_transaction_management_gup_for_am1_idx` (`gup_for_am_id_gfa`),
  KEY `fk_transaction_management_chart_of_account1_idx` (`chart_of_account_coa_id`),
  KEY `fk_transaction_management_gop_for_am1_idx` (`gop_for_am_id_gfa`),
  KEY `fk_transaction_management_account_type_manager1_idx` (`account_type_manager_id`),
  KEY `fk_transaction_management_voucher1_idx` (`voucher_vid`),
  CONSTRAINT `fk_transaction_management_account_type_manager1` FOREIGN KEY (`account_type_manager_id`) REFERENCES `account_type_manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_general_journal_entry1` FOREIGN KEY (`general_journal_entry_gje_id`) REFERENCES `general_journal_entry` (`gje_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_gop_for_am1` FOREIGN KEY (`gop_for_am_id_gfa`) REFERENCES `gop_for_am` (`id_gfa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_gup_for_am1` FOREIGN KEY (`gup_for_am_id_gfa`) REFERENCES `gup_for_am` (`id_gfa`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_sub_chart_of_account1` FOREIGN KEY (`sub_chart_of_account_is_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_transaction_management_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=328348 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.transfer_type
DROP TABLE IF EXISTS `transfer_type`;
CREATE TABLE IF NOT EXISTS `transfer_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'Batch\nYear\nBranch\nSemister',
  `fee` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tt_course
DROP TABLE IF EXISTS `tt_course`;
CREATE TABLE IF NOT EXISTS `tt_course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_units_id` int NOT NULL,
  `tt_employee_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tt_course_course_units1_idx` (`course_units_id`),
  KEY `fk_tt_course_tt_employee1_idx` (`tt_employee_id`),
  CONSTRAINT `fk_tt_course_course_units1` FOREIGN KEY (`course_units_id`) REFERENCES `course_units` (`id`),
  CONSTRAINT `fk_tt_course_tt_employee1` FOREIGN KEY (`tt_employee_id`) REFERENCES `tt_employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=458 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tt_employee
DROP TABLE IF EXISTS `tt_employee`;
CREATE TABLE IF NOT EXISTS `tt_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tt_employee_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_tt_employee_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tvec_attendance
DROP TABLE IF EXISTS `tvec_attendance`;
CREATE TABLE IF NOT EXISTS `tvec_attendance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `students_id` int NOT NULL,
  `course_id` int NOT NULL,
  `date` date NOT NULL,
  `status` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20533 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tvec_eligible_student
DROP TABLE IF EXISTS `tvec_eligible_student`;
CREATE TABLE IF NOT EXISTS `tvec_eligible_student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_s_id` int DEFAULT NULL,
  `is_sheet_downloaded` tinyint(1) DEFAULT NULL,
  `sheet_downloaded_date` date DEFAULT NULL,
  `is_registered` tinyint(1) DEFAULT NULL,
  `registered_no` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `registered_date` date DEFAULT NULL,
  `course_cid` int DEFAULT NULL,
  `tvec_status_id` int DEFAULT NULL,
  `tvec_intake_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `student_s_id` (`student_s_id`) USING BTREE,
  KEY `course_cid` (`course_cid`) USING BTREE,
  KEY `tvec_status_id` (`tvec_status_id`) USING BTREE,
  KEY `tvec_intake_id` (`tvec_intake_id`) USING BTREE,
  CONSTRAINT `tvec_eligible_student_ibfk_1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `tvec_eligible_student_ibfk_2` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `tvec_eligible_student_ibfk_3` FOREIGN KEY (`tvec_status_id`) REFERENCES `tvec_status` (`id`),
  CONSTRAINT `tvec_eligible_student_ibfk_4` FOREIGN KEY (`tvec_intake_id`) REFERENCES `tvec_intake` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tvec_intake
DROP TABLE IF EXISTS `tvec_intake`;
CREATE TABLE IF NOT EXISTS `tvec_intake` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.tvec_status
DROP TABLE IF EXISTS `tvec_status`;
CREATE TABLE IF NOT EXISTS `tvec_status` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.type_chart_of_account_controller
DROP TABLE IF EXISTS `type_chart_of_account_controller`;
CREATE TABLE IF NOT EXISTS `type_chart_of_account_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chart_of_account_coa_id` int NOT NULL,
  `account_type_a_id` int NOT NULL,
  `gop_for_am_id_gfa` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_type_chart_of_account_controller_chart_of_account1_idx` (`chart_of_account_coa_id`),
  KEY `fk_type_chart_of_account_controller_account_type1_idx` (`account_type_a_id`),
  KEY `fk_type_chart_of_account_controller_gop_for_am1_idx` (`gop_for_am_id_gfa`),
  CONSTRAINT `fk_type_chart_of_account_controller_account_type1` FOREIGN KEY (`account_type_a_id`) REFERENCES `account_type` (`a_id`),
  CONSTRAINT `fk_type_chart_of_account_controller_chart_of_account1` FOREIGN KEY (`chart_of_account_coa_id`) REFERENCES `chart_of_account` (`coa_id`),
  CONSTRAINT `fk_type_chart_of_account_controller_gop_for_am1` FOREIGN KEY (`gop_for_am_id_gfa`) REFERENCES `gop_for_am` (`id_gfa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.unit_of_measure
DROP TABLE IF EXISTS `unit_of_measure`;
CREATE TABLE IF NOT EXISTS `unit_of_measure` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_approval_status_manager
DROP TABLE IF EXISTS `universal_approval_status_manager`;
CREATE TABLE IF NOT EXISTS `universal_approval_status_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `comment` text,
  `universal_approve_status_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_approval_status_manager_universal_approve_stat_idx` (`universal_approve_status_id`),
  KEY `fk_universal_approval_status_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_universal_approval_status_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_universal_approval_status_manager_universal_approve_status1` FOREIGN KEY (`universal_approve_status_id`) REFERENCES `universal_approve_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1294 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_approve_status
DROP TABLE IF EXISTS `universal_approve_status`;
CREATE TABLE IF NOT EXISTS `universal_approve_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_bucket_manager
DROP TABLE IF EXISTS `universal_bucket_manager`;
CREATE TABLE IF NOT EXISTS `universal_bucket_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `general_user_profile_gup_id` int NOT NULL,
  `email_verified` tinyint(1) DEFAULT NULL,
  `data_verified` tinyint(1) DEFAULT NULL,
  `portal_issued` tinyint(1) DEFAULT NULL,
  `kyc_done` tinyint(1) DEFAULT NULL,
  `id_card_issued` tinyint(1) DEFAULT NULL,
  `selection_program_inform` tinyint(1) DEFAULT NULL,
  `robo_pack_purchased` tinyint(1) DEFAULT NULL,
  `robo_pack_sent` tinyint(1) DEFAULT NULL,
  `robo_pack_received` tinyint(1) DEFAULT NULL,
  `robo_day1` tinyint(1) DEFAULT NULL,
  `robo_day2` tinyint(1) DEFAULT NULL,
  `robo_day3` tinyint(1) DEFAULT NULL,
  `robo_day4` tinyint(1) DEFAULT NULL,
  `individual_session` tinyint(1) DEFAULT NULL,
  `robo_day5` tinyint(1) DEFAULT NULL,
  `robo_day6` tinyint(1) DEFAULT NULL,
  `robo_pet_finalizing` tinyint(1) DEFAULT NULL,
  `scholarship_marks_entered` tinyint(1) DEFAULT NULL,
  `scholarship_awarded` tinyint(1) DEFAULT NULL,
  `offer_letter_sent` tinyint(1) DEFAULT NULL,
  `oopc1_started` tinyint(1) DEFAULT NULL,
  `webp_started` tinyint(1) DEFAULT NULL,
  `total_marks` double DEFAULT NULL,
  `scholarship` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `comment` text,
  `guardian_verified` tinyint(1) DEFAULT NULL,
  `portal_accessed` tinyint(1) DEFAULT NULL,
  `is_attendance` tinyint(1) DEFAULT NULL,
  `seminar_date` date DEFAULT NULL,
  `seminar_participated` tinyint(1) DEFAULT NULL,
  `parents_meeting_participated` tinyint(1) DEFAULT NULL,
  `netbeans_done` tinyint(1) DEFAULT NULL,
  `seminar_id` int DEFAULT NULL,
  `enrollment_type_id` int DEFAULT NULL,
  `sent_email_verification` tinyint DEFAULT NULL,
  `sent_data_verification` tinyint DEFAULT NULL,
  `sent_portal_issue` tinyint DEFAULT NULL,
  `web_day_1` tinyint DEFAULT NULL,
  `web_day_2` tinyint DEFAULT NULL,
  `web_day_3` tinyint DEFAULT NULL,
  `web_day_4` tinyint DEFAULT NULL,
  `web_day_5` tinyint DEFAULT NULL,
  `web_day_6` tinyint DEFAULT NULL,
  `web_day_7` tinyint DEFAULT NULL,
  `web_day_8` tinyint DEFAULT NULL,
  `web_day_9` tinyint DEFAULT NULL,
  `web_day_10` tinyint DEFAULT NULL,
  `web_game_finalizing` tinyint DEFAULT NULL,
  `oop_day_1` tinyint(1) DEFAULT NULL,
  `oop_day_2` tinyint(1) DEFAULT NULL,
  `oop_day_3` tinyint(1) DEFAULT NULL,
  `oop_day_4` tinyint(1) DEFAULT NULL,
  `oop_day_5` tinyint(1) DEFAULT NULL,
  `introduction_to_neuroscience` tinyint(1) DEFAULT NULL,
  `introduction_to_academic_writing` tinyint(1) DEFAULT NULL,
  `introduction_to_bioinformatics` tinyint(1) DEFAULT NULL,
  `introduction_to_sem` tinyint(1) DEFAULT NULL,
  `batchesb_id` int DEFAULT NULL,
  `ns_day_1` tinyint DEFAULT NULL,
  `ns_day_2` tinyint DEFAULT NULL,
  `ns_day_3` tinyint DEFAULT NULL,
  `ns_day_4` tinyint DEFAULT NULL,
  `ns_day_5` tinyint DEFAULT NULL,
  `ns_day_6` tinyint DEFAULT NULL,
  `ns_day_7` tinyint DEFAULT NULL,
  `ns_day_8` tinyint DEFAULT NULL,
  `ns_day_9` tinyint DEFAULT NULL,
  `ns_day_10` tinyint DEFAULT NULL,
  `aw_day_1` tinyint DEFAULT NULL,
  `aw_day_2` tinyint DEFAULT NULL,
  `aw_day_3` tinyint DEFAULT NULL,
  `aw_day_4` tinyint DEFAULT NULL,
  `aw_day_5` tinyint DEFAULT NULL,
  `bio_day_1` tinyint DEFAULT NULL,
  `bio_day_2` tinyint DEFAULT NULL,
  `sem_day_1` tinyint DEFAULT NULL,
  `web_game_url` text,
  `google_review_url` text,
  `facebook_review_url` text,
  `lecturer_id` int DEFAULT NULL,
  `student_service_officer` int DEFAULT NULL,
  `academic_officer` int DEFAULT NULL,
  `is_postpond` tinyint DEFAULT NULL,
  `is_not_answered` tinyint DEFAULT NULL,
  `reject_type_id` int DEFAULT NULL,
  `ns_day_11` tinyint(1) DEFAULT NULL,
  `leads_student_id` int DEFAULT NULL,
  `oop_introduction_se` tinyint(1) DEFAULT NULL,
  `screenshot_review_url` varchar(255) DEFAULT NULL,
  `social_media_url` varchar(255) DEFAULT NULL,
  `web_game_video_url` text,
  `oop_day_6` tinyint DEFAULT NULL,
  `oop_day_7` tinyint DEFAULT NULL,
  `oop_day_8` tinyint DEFAULT NULL,
  `oop_day_9` tinyint DEFAULT NULL,
  `oop_day_10` tinyint DEFAULT NULL,
  `oop_day_11` tinyint DEFAULT NULL,
  `oop_day_12` tinyint DEFAULT NULL,
  `is_suspend` tinyint DEFAULT NULL,
  `revolver_course_cid` int DEFAULT NULL,
  `revolver_status_id` int DEFAULT NULL,
  `web_day_11` tinyint(1) DEFAULT NULL,
  `web_day_12` tinyint DEFAULT NULL,
  `scholarship_releasing_parents_meeting` tinyint DEFAULT NULL,
  `last_comment` text,
  `last_calling_status_id` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `is_mobile_app_download` tinyint DEFAULT NULL,
  `td_day1` tinyint DEFAULT NULL,
  `td_day2` tinyint DEFAULT NULL,
  `robo_day7` tinyint DEFAULT NULL,
  `td_day3` tinyint DEFAULT NULL,
  `td_day4` tinyint DEFAULT NULL,
  `3mpra_day01` tinyint DEFAULT NULL,
  `3mpra_day02` tinyint DEFAULT NULL,
  `3mpra_day03` tinyint DEFAULT NULL,
  `3mpra_day04` tinyint DEFAULT NULL,
  `3mpra_day05` tinyint DEFAULT NULL,
  `3mpra_day06` tinyint DEFAULT NULL,
  `3mpra_day07` tinyint DEFAULT NULL,
  `3mpra_day08` tinyint DEFAULT NULL,
  `3mpra_day09` tinyint DEFAULT NULL,
  `3mpra_day10` tinyint DEFAULT NULL,
  `commission` double DEFAULT NULL,
  `recording_uploaded` tinyint DEFAULT NULL,
  `recording_verified` tinyint DEFAULT NULL,
  `special_web_game_day1` tinyint DEFAULT NULL,
  `special_web_game_day2` tinyint DEFAULT NULL,
  `special_web_game_day3` tinyint DEFAULT NULL,
  `special_web_game_day4` tinyint DEFAULT NULL,
  `special_web_game_day5` tinyint DEFAULT NULL,
  `special_web_game_day6` tinyint DEFAULT NULL,
  `scholarship_marking_criteria_type_id` int DEFAULT NULL,
  `individual_scholarship_releasing_parents_meeting` tinyint DEFAULT NULL,
  `apply_loan` tinyint DEFAULT NULL,
  `apply_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_bucket_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `seminar_id` (`seminar_id`),
  KEY `enrollment_type_id` (`enrollment_type_id`),
  KEY `batchesb_id` (`batchesb_id`),
  KEY `academic_officer` (`academic_officer`),
  KEY `student_service_officer` (`student_service_officer`),
  KEY `reject_type_id` (`reject_type_id`),
  KEY `revolver_course_cid` (`revolver_course_cid`),
  KEY `revolver_status_id` (`revolver_status_id`),
  KEY `last_calling_status_id` (`last_calling_status_id`),
  KEY `student_s_id` (`student_s_id`),
  KEY `scholarship_marking_criteria_type_id` (`scholarship_marking_criteria_type_id`),
  CONSTRAINT `enrollment_type_id` FOREIGN KEY (`enrollment_type_id`) REFERENCES `enrollment_type` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_1` FOREIGN KEY (`seminar_id`) REFERENCES `seminar` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_10` FOREIGN KEY (`scholarship_marking_criteria_type_id`) REFERENCES `scholarship_marking_criteria_type` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_2` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `universal_bucket_manager_ibfk_3` FOREIGN KEY (`academic_officer`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `universal_bucket_manager_ibfk_4` FOREIGN KEY (`student_service_officer`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `universal_bucket_manager_ibfk_5` FOREIGN KEY (`reject_type_id`) REFERENCES `reject_type` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_6` FOREIGN KEY (`revolver_course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `universal_bucket_manager_ibfk_7` FOREIGN KEY (`revolver_status_id`) REFERENCES `revolver_status` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_8` FOREIGN KEY (`last_calling_status_id`) REFERENCES `calling_status` (`id`),
  CONSTRAINT `universal_bucket_manager_ibfk_9` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=133900 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_gpa_manager
DROP TABLE IF EXISTS `universal_gpa_manager`;
CREATE TABLE IF NOT EXISTS `universal_gpa_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `certification_eligible_list_student_id` int NOT NULL,
  `evidences_type_id` int NOT NULL,
  `assessment_status_id` int NOT NULL,
  `assesment_id` int DEFAULT NULL,
  `exam_id` int DEFAULT NULL,
  `marks` double NOT NULL,
  `is_active` tinyint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assesment_id` (`assesment_id`),
  KEY `assessment_status_id` (`assessment_status_id`),
  KEY `certification_eligible_list_student_id` (`certification_eligible_list_student_id`),
  KEY `evidences_type_id` (`evidences_type_id`),
  KEY `exam_id` (`exam_id`),
  CONSTRAINT `universal_gpa_manager_ibfk_1` FOREIGN KEY (`assesment_id`) REFERENCES `assesment` (`id`),
  CONSTRAINT `universal_gpa_manager_ibfk_2` FOREIGN KEY (`assessment_status_id`) REFERENCES `assessment_status` (`id`),
  CONSTRAINT `universal_gpa_manager_ibfk_3` FOREIGN KEY (`certification_eligible_list_student_id`) REFERENCES `certification_eligible_list_student` (`id`),
  CONSTRAINT `universal_gpa_manager_ibfk_4` FOREIGN KEY (`evidences_type_id`) REFERENCES `evidences_type` (`id`),
  CONSTRAINT `universal_gpa_manager_ibfk_5` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_notification
DROP TABLE IF EXISTS `universal_notification`;
CREATE TABLE IF NOT EXISTS `universal_notification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `is_viewed` tinyint(1) DEFAULT NULL,
  `link` varchar(450) DEFAULT NULL,
  `description` text,
  `universal_notification_type_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_notification_universal_notification_type1_idx` (`universal_notification_type_id`),
  CONSTRAINT `fk_universal_notification_universal_notification_type1` FOREIGN KEY (`universal_notification_type_id`) REFERENCES `universal_notification_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_notification_type
DROP TABLE IF EXISTS `universal_notification_type`;
CREATE TABLE IF NOT EXISTS `universal_notification_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_notification_users
DROP TABLE IF EXISTS `universal_notification_users`;
CREATE TABLE IF NOT EXISTS `universal_notification_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_viewed` tinyint(1) DEFAULT NULL,
  `viewed_time` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `universal_notification_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_notification_users_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_universal_notification_users_universal_notification1_idx` (`universal_notification_id`),
  CONSTRAINT `fk_universal_notification_users_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_universal_notification_users_universal_notification1` FOREIGN KEY (`universal_notification_id`) REFERENCES `universal_notification` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_manager
DROP TABLE IF EXISTS `universal_payment_manager`;
CREATE TABLE IF NOT EXISTS `universal_payment_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `scholarship` double DEFAULT NULL,
  `full_payment` double DEFAULT NULL,
  `payable_amount` double DEFAULT NULL,
  `total_due` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `scholarship_released_date` date DEFAULT NULL,
  `extended_comment` varchar(45) DEFAULT NULL,
  `last_comment` text,
  `is_portal_paid` tinyint(1) DEFAULT NULL,
  `is_id_card_paid` tinyint(1) DEFAULT NULL,
  `is_university_paid` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `loan_started_date` date DEFAULT NULL,
  `payment_option_id` int DEFAULT NULL,
  `payment_option_type_id` int DEFAULT NULL,
  `payment_option_comment` text,
  `branch_bid` int DEFAULT NULL,
  `paying_amount1` double DEFAULT NULL,
  `paying_amount2` double DEFAULT NULL,
  `paying_amount3` double DEFAULT NULL,
  `is_postpone` tinyint(1) DEFAULT NULL,
  `is_sent_covid_mail_option_1` tinyint(1) DEFAULT NULL,
  `is_sent_covid_mail_option_2` tinyint(1) DEFAULT NULL,
  `last_comment_2` text,
  `last_comment_3` text,
  `is_sent_offer_mail_new` text,
  `is_pending_reject` tinyint(1) DEFAULT '0',
  `parent_meeting_date` date DEFAULT NULL,
  `finance_officer_id` int DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `scholarship_groups_id` int DEFAULT NULL,
  `batchesb_id` int DEFAULT NULL,
  `parent_comment` text,
  `is_agreement_read` tinyint DEFAULT NULL,
  `student_payment_method_id` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_universal_payment_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_universal_payment_manager_payment_option1_idx` (`payment_option_id`),
  KEY `fk_universal_payment_manager_payment_option_type1_idx` (`payment_option_type_id`),
  KEY `branch_bid` (`branch_bid`),
  KEY `finance_officer_id` (`finance_officer_id`),
  KEY `group_id` (`group_id`),
  KEY `batchesb_id` (`batchesb_id`),
  KEY `scholarship_groups_id` (`scholarship_groups_id`),
  KEY `student_payment_method_id` (`student_payment_method_id`),
  CONSTRAINT `fk_universal_payment_manager_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_universal_payment_manager_payment_option1` FOREIGN KEY (`payment_option_id`) REFERENCES `payment_option` (`id`),
  CONSTRAINT `fk_universal_payment_manager_payment_option_type1` FOREIGN KEY (`payment_option_type_id`) REFERENCES `payment_option_type` (`id`),
  CONSTRAINT `universal_payment_manager_ibfk_1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `universal_payment_manager_ibfk_2` FOREIGN KEY (`finance_officer_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `universal_payment_manager_ibfk_3` FOREIGN KEY (`group_id`) REFERENCES `intake_group` (`id`),
  CONSTRAINT `universal_payment_manager_ibfk_4` FOREIGN KEY (`batchesb_id`) REFERENCES `batches` (`b_id`),
  CONSTRAINT `universal_payment_manager_ibfk_5` FOREIGN KEY (`scholarship_groups_id`) REFERENCES `scholarship_groups` (`id`),
  CONSTRAINT `universal_payment_manager_ibfk_6` FOREIGN KEY (`student_payment_method_id`) REFERENCES `student_payment_method` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16486 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_manager_request
DROP TABLE IF EXISTS `universal_payment_manager_request`;
CREATE TABLE IF NOT EXISTS `universal_payment_manager_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `requested_date` date DEFAULT NULL,
  `requested_url` varchar(255) DEFAULT NULL,
  `requested_by` int DEFAULT NULL,
  `universal_payment_manager_id` int DEFAULT NULL,
  `universal_payment_manager_request_type_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `requested_by` (`requested_by`) USING BTREE,
  KEY `universal_payment_manager_id` (`universal_payment_manager_id`) USING BTREE,
  KEY `universal_payment_manager_request_type_id` (`universal_payment_manager_request_type_id`),
  CONSTRAINT `universal_payment_manager_request_ibfk_1` FOREIGN KEY (`requested_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `universal_payment_manager_request_ibfk_2` FOREIGN KEY (`universal_payment_manager_id`) REFERENCES `universal_payment_manager` (`id`),
  CONSTRAINT `universal_payment_manager_request_ibfk_3` FOREIGN KEY (`universal_payment_manager_request_type_id`) REFERENCES `universal_payment_manager_request_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_manager_request_type
DROP TABLE IF EXISTS `universal_payment_manager_request_type`;
CREATE TABLE IF NOT EXISTS `universal_payment_manager_request_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_manager_response
DROP TABLE IF EXISTS `universal_payment_manager_response`;
CREATE TABLE IF NOT EXISTS `universal_payment_manager_response` (
  `id` int NOT NULL AUTO_INCREMENT,
  `responded_date` date DEFAULT NULL,
  `responded_url` varchar(255) DEFAULT NULL,
  `responded_by` int DEFAULT NULL,
  `universal_payment_manager_request_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `requested_by` (`responded_by`) USING BTREE,
  KEY `universal_payment_manager_id` (`universal_payment_manager_request_id`) USING BTREE,
  CONSTRAINT `universal_payment_manager_response_ibfk_1` FOREIGN KEY (`responded_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `universal_payment_manager_response_ibfk_2` FOREIGN KEY (`universal_payment_manager_request_id`) REFERENCES `universal_payment_manager_request` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_scheduler
DROP TABLE IF EXISTS `universal_payment_scheduler`;
CREATE TABLE IF NOT EXISTS `universal_payment_scheduler` (
  `id` int NOT NULL AUTO_INCREMENT,
  `to_be_paid_amount` double DEFAULT NULL,
  `paid_amount` double DEFAULT NULL,
  `due` double DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `universal_payment_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_payment_scheduler_universal_payment_manager1_idx` (`universal_payment_manager_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75328 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payment_voucher_item
DROP TABLE IF EXISTS `universal_payment_voucher_item`;
CREATE TABLE IF NOT EXISTS `universal_payment_voucher_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `universal_payment_manager_id` int DEFAULT NULL,
  `voucher_item_vi_id` int NOT NULL,
  `student_s_id` int NOT NULL,
  `branch_bid` int NOT NULL,
  `course_cid` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_payment_voucher_item_universal_payment_manager_idx` (`universal_payment_manager_id`),
  KEY `fk_universal_payment_voucher_item_voucher_item1_idx` (`voucher_item_vi_id`),
  KEY `fk_universal_payment_voucher_item_student1_idx` (`student_s_id`),
  KEY `fk_universal_payment_voucher_item_branch1_idx` (`branch_bid`),
  KEY `fk_universal_payment_voucher_item_course1_idx` (`course_cid`),
  CONSTRAINT `fk_universal_payment_voucher_item_branch1` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`),
  CONSTRAINT `fk_universal_payment_voucher_item_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_universal_payment_voucher_item_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_universal_payment_voucher_item_universal_payment_manager1` FOREIGN KEY (`universal_payment_manager_id`) REFERENCES `universal_payment_manager` (`id`),
  CONSTRAINT `fk_universal_payment_voucher_item_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25385 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_payroll_manager
DROP TABLE IF EXISTS `universal_payroll_manager`;
CREATE TABLE IF NOT EXISTS `universal_payroll_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employees_employee_id` int NOT NULL,
  `basic_salary` double DEFAULT NULL,
  `br` double DEFAULT NULL,
  `no_pay` double DEFAULT NULL,
  `gross_salary` double DEFAULT NULL,
  `epf_8` double DEFAULT NULL,
  `epf_12` double DEFAULT NULL,
  `etf_3` double DEFAULT NULL,
  `attendance` double DEFAULT NULL,
  `performance` double DEFAULT NULL,
  `incentive` double DEFAULT NULL,
  `traveling` double DEFAULT NULL,
  `house_rental` double DEFAULT NULL,
  `salary_advance` double DEFAULT NULL,
  `other_deductions` double DEFAULT NULL,
  `total_salary` double DEFAULT NULL,
  `salary_date` date DEFAULT NULL,
  `record_added_date` datetime DEFAULT NULL,
  `last_update_time` datetime DEFAULT NULL,
  `general_user_profile_gup_id_added_by` int NOT NULL,
  `general_user_profile_gup_id_updated_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_universal_payroll_manager_employees1_idx` (`employees_employee_id`),
  KEY `fk_universal_payroll_manager_general_user_profile1_idx` (`general_user_profile_gup_id_added_by`),
  KEY `fk_universal_payroll_manager_general_user_profile2_idx` (`general_user_profile_gup_id_updated_by`),
  CONSTRAINT `fk_universal_payroll_manager_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_universal_payroll_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id_added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_universal_payroll_manager_general_user_profile2` FOREIGN KEY (`general_user_profile_gup_id_updated_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_person_or_org_type_manager
DROP TABLE IF EXISTS `universal_person_or_org_type_manager`;
CREATE TABLE IF NOT EXISTS `universal_person_or_org_type_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_result_doc_type
DROP TABLE IF EXISTS `universal_result_doc_type`;
CREATE TABLE IF NOT EXISTS `universal_result_doc_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.universal_result_type
DROP TABLE IF EXISTS `universal_result_type`;
CREATE TABLE IF NOT EXISTS `universal_result_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'New\nRepeat\nMarking Reassess\nRecorrection\nRecorrection Reassess\nAppeal',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.university_students
DROP TABLE IF EXISTS `university_students`;
CREATE TABLE IF NOT EXISTS `university_students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` date DEFAULT NULL,
  `student_s_id` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  `year_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_university_students_student1_idx` (`student_s_id`),
  KEY `fk_university_students_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_university_students_year1_idx` (`year_id`),
  CONSTRAINT `fk_university_students_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_university_students_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_university_students_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=663 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.university_students_document_controller
DROP TABLE IF EXISTS `university_students_document_controller`;
CREATE TABLE IF NOT EXISTS `university_students_document_controller` (
  `id` int NOT NULL AUTO_INCREMENT,
  `university_students_id` int NOT NULL,
  `document_manager_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_university_students_document_controller_university_stude_idx` (`university_students_id`),
  KEY `fk_university_students_document_controller_document_manager_idx` (`document_manager_id`),
  KEY `fk_university_students_document_controller_general_user_pro_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_university_students_document_controller_document_manager1` FOREIGN KEY (`document_manager_id`) REFERENCES `document_manager` (`id`),
  CONSTRAINT `fk_university_students_document_controller_general_user_profi1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_university_students_document_controller_university_students1` FOREIGN KEY (`university_students_id`) REFERENCES `university_students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.university_students_marks
DROP TABLE IF EXISTS `university_students_marks`;
CREATE TABLE IF NOT EXISTS `university_students_marks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `university_students_id` int NOT NULL,
  `year_course_credits_id` int NOT NULL,
  `is_paper_available` tinyint(1) DEFAULT NULL,
  `paper_mark` double DEFAULT NULL,
  `is_mapping_available` tinyint(1) DEFAULT NULL,
  `mapping_mark` double DEFAULT NULL,
  `final_mark` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_university_students_marks_university_students1_idx` (`university_students_id`),
  KEY `fk_university_students_marks_year_course_credits1_idx` (`year_course_credits_id`),
  CONSTRAINT `fk_university_students_marks_university_students1` FOREIGN KEY (`university_students_id`) REFERENCES `university_students` (`id`),
  CONSTRAINT `fk_university_students_marks_year_course_credits1` FOREIGN KEY (`year_course_credits_id`) REFERENCES `year_course_credits` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21857 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_achievement
DROP TABLE IF EXISTS `user_achievement`;
CREATE TABLE IF NOT EXISTS `user_achievement` (
  `id_user_achievement` int NOT NULL AUTO_INCREMENT,
  `achievement_type_id` int DEFAULT NULL,
  `general_user_profile_id` int DEFAULT NULL,
  `comment` text,
  `added_by` int DEFAULT NULL,
  `added_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user_achievement`) USING BTREE,
  KEY `FK_user_achiument_general_user_profile_2` (`added_by`),
  KEY `FK_user _achievement_achievement_type` (`achievement_type_id`),
  KEY `idx_user_type` (`general_user_profile_id`,`achievement_type_id`),
  CONSTRAINT `FK_user _achievement_achievement_type` FOREIGN KEY (`achievement_type_id`) REFERENCES `achievement_type` (`id_achievement_type`),
  CONSTRAINT `FK_user_achiument_general_user_profile` FOREIGN KEY (`general_user_profile_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `FK_user_achiument_general_user_profile_2` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_address
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE IF NOT EXISTS `user_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no` varchar(1000) DEFAULT NULL,
  `street` varchar(1000) DEFAULT NULL,
  `city` varchar(1000) DEFAULT NULL,
  `user_address_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `province_id_p` int NOT NULL,
  `district_id_d` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_address_user_address_type1_idx` (`user_address_type_id`),
  KEY `fk_user_address_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_user_address_province1_idx` (`province_id_p`),
  KEY `fk_user_address_district1_idx` (`district_id_d`),
  CONSTRAINT `fk_user_address_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_address_province1` FOREIGN KEY (`province_id_p`) REFERENCES `province` (`id_p`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_address_user_address_type1` FOREIGN KEY (`user_address_type_id`) REFERENCES `user_address_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27959 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_address_type
DROP TABLE IF EXISTS `user_address_type`;
CREATE TABLE IF NOT EXISTS `user_address_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_banner_info
DROP TABLE IF EXISTS `user_banner_info`;
CREATE TABLE IF NOT EXISTS `user_banner_info` (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_of_visits` int DEFAULT NULL,
  `no_of_signups` int DEFAULT NULL,
  `nos_course_fee_paid` int DEFAULT NULL,
  `paid_course_fee_total` double DEFAULT NULL,
  `total_rewards` double DEFAULT NULL,
  `received_rewards` double DEFAULT NULL,
  `balannce_rewards` double DEFAULT NULL,
  `banner_id` int NOT NULL,
  `affiliate_user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_banner_page_visits_banner1_idx` (`banner_id`),
  KEY `fk_user_banner_info_affiliate_user1_idx` (`affiliate_user_id`),
  CONSTRAINT `fk_banner_page_visits_banner1` FOREIGN KEY (`banner_id`) REFERENCES `banner` (`id`),
  CONSTRAINT `fk_user_banner_info_affiliate_user1` FOREIGN KEY (`affiliate_user_id`) REFERENCES `affiliate_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_contact_no
DROP TABLE IF EXISTS `user_contact_no`;
CREATE TABLE IF NOT EXISTS `user_contact_no` (
  `id` int NOT NULL AUTO_INCREMENT,
  `c_no` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  `verified_date` datetime DEFAULT NULL,
  `user_contact_no_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_contact_no_user_contact_no_type1_idx` (`user_contact_no_type_id`),
  KEY `fk_user_contact_no_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_user_contact_no_user_contact_no_type1` FOREIGN KEY (`user_contact_no_type_id`) REFERENCES `user_contact_no_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59514 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_contact_no_type
DROP TABLE IF EXISTS `user_contact_no_type`;
CREATE TABLE IF NOT EXISTS `user_contact_no_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_course_manager
DROP TABLE IF EXISTS `user_course_manager`;
CREATE TABLE IF NOT EXISTS `user_course_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_cid` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `is_active` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_course_manager_course1_idx` (`course_cid`),
  KEY `fk_user_course_manager_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_user_course_manager_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`),
  CONSTRAINT `fk_user_course_manager_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_email
DROP TABLE IF EXISTS `user_email`;
CREATE TABLE IF NOT EXISTS `user_email` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  `verified_date` datetime DEFAULT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_email_general_user_profile1_idx` (`general_user_profile_gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=138699 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_gender
DROP TABLE IF EXISTS `user_gender`;
CREATE TABLE IF NOT EXISTS `user_gender` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE IF NOT EXISTS `user_login` (
  `login_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `is_multiple_login` int DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `system_interface_si_id` int NOT NULL,
  `user_role_ur_id` int NOT NULL,
  `max_login_attempt` int DEFAULT NULL,
  `generated_password` varchar(255) DEFAULT NULL,
  `is_first_time` int DEFAULT NULL,
  `count_attempt` int DEFAULT NULL,
  `security_questionid_sq` int DEFAULT NULL,
  `answer` text,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `last_reset` datetime DEFAULT NULL,
  `user_login_type_id` int DEFAULT NULL,
  `is_due` int DEFAULT NULL,
  PRIMARY KEY (`login_id`),
  KEY `FKuser_login752358` (`general_user_profilegup_id`),
  KEY `FKuser_login271674` (`system_interface_si_id`),
  KEY `FKuser_login532835` (`user_role_ur_id`),
  KEY `FKuser_login271675` (`system_interface_si_id`),
  KEY `FKuser_login532836` (`user_role_ur_id`),
  KEY `FKuser_login670183` (`security_questionid_sq`),
  KEY `fk_user_login_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_user_login_user_login_type1_idx` (`user_login_type_id`),
  CONSTRAINT `fk_user_login_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_login_system_interface1` FOREIGN KEY (`system_interface_si_id`) REFERENCES `system_interface` (`si_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_login_user_login_type1` FOREIGN KEY (`user_login_type_id`) REFERENCES `user_login_type` (`id`),
  CONSTRAINT `FKuser_login532836` FOREIGN KEY (`user_role_ur_id`) REFERENCES `user_role` (`ur_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKuser_login670183` FOREIGN KEY (`security_questionid_sq`) REFERENCES `security_question` (`id_sq`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40982 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_group
DROP TABLE IF EXISTS `user_login_group`;
CREATE TABLE IF NOT EXISTS `user_login_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_active` int DEFAULT NULL,
  `max_login_attempt` int DEFAULT NULL,
  `is_first_time` int DEFAULT NULL,
  `count_attempt` int DEFAULT NULL,
  `user_login_login_id` int NOT NULL,
  `user_role_ur_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_login_group_user_login1_idx` (`user_login_login_id`),
  KEY `fk_user_login_group_user_role1_idx` (`user_role_ur_id`),
  KEY `fk_user_login_group_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_user_login_group_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_user_login_group_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`),
  CONSTRAINT `fk_user_login_group_user_role1` FOREIGN KEY (`user_role_ur_id`) REFERENCES `user_role` (`ur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2316 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_has_privileges
DROP TABLE IF EXISTS `user_login_has_privileges`;
CREATE TABLE IF NOT EXISTS `user_login_has_privileges` (
  `id` int NOT NULL AUTO_INCREMENT,
  `privileges_id` int NOT NULL,
  `user_login_login_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_login_has_privileges_privileges1_idx` (`privileges_id`),
  KEY `fk_user_login_has_privileges_user_login1_idx` (`user_login_login_id`),
  CONSTRAINT `fk_user_login_has_privileges_privileges1` FOREIGN KEY (`privileges_id`) REFERENCES `privileges` (`id`),
  CONSTRAINT `fk_user_login_has_privileges_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2261 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_has_system_interface
DROP TABLE IF EXISTS `user_login_has_system_interface`;
CREATE TABLE IF NOT EXISTS `user_login_has_system_interface` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_interface_si_id` int NOT NULL,
  `user_login_login_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_login_has_system_interface_system_interface1_idx` (`system_interface_si_id`),
  KEY `fk_user_login_has_system_interface_user_login1_idx` (`user_login_login_id`),
  CONSTRAINT `fk_user_login_has_system_interface_system_interface1` FOREIGN KEY (`system_interface_si_id`) REFERENCES `system_interface` (`si_id`),
  CONSTRAINT `fk_user_login_has_system_interface_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1751 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_has_usecase
DROP TABLE IF EXISTS `user_login_has_usecase`;
CREATE TABLE IF NOT EXISTS `user_login_has_usecase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `use_case_uc_id` int NOT NULL,
  `user_login_login_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_login_has_usecase_use_case1_idx` (`use_case_uc_id`),
  KEY `fk_user_login_has_usecase_user_login1_idx` (`user_login_login_id`),
  CONSTRAINT `fk_user_login_has_usecase_use_case1` FOREIGN KEY (`use_case_uc_id`) REFERENCES `use_case` (`uc_id`),
  CONSTRAINT `fk_user_login_has_usecase_user_login1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_password_history
DROP TABLE IF EXISTS `user_login_password_history`;
CREATE TABLE IF NOT EXISTS `user_login_password_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `user_login_login_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_login_login_id` (`user_login_login_id`) USING BTREE,
  CONSTRAINT `user_login_password_history_ibfk_1` FOREIGN KEY (`user_login_login_id`) REFERENCES `user_login` (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22133 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_login_type
DROP TABLE IF EXISTS `user_login_type`;
CREATE TABLE IF NOT EXISTS `user_login_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_mail_category
DROP TABLE IF EXISTS `user_mail_category`;
CREATE TABLE IF NOT EXISTS `user_mail_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mail_category_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_mail_category_mail_category1_idx` (`mail_category_id`),
  KEY `fk_user_mail_category_general_user_profile1_idx` (`general_user_profile_gup_id`),
  CONSTRAINT `fk_user_mail_category_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `fk_user_mail_category_mail_category1` FOREIGN KEY (`mail_category_id`) REFERENCES `mail_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_qualifications
DROP TABLE IF EXISTS `user_qualifications`;
CREATE TABLE IF NOT EXISTS `user_qualifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` varchar(145) DEFAULT NULL,
  `score` double DEFAULT NULL,
  `year` int DEFAULT NULL,
  `period_from` date DEFAULT NULL,
  `period_to` date DEFAULT NULL,
  `user_qualifications_type_id` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `user_qualifications_category_id` int NOT NULL,
  `country_id_c` int NOT NULL,
  `comment` text,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `student_s_id` int DEFAULT NULL,
  `qualification_id` int DEFAULT NULL,
  `entered_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `english_grade` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_qualifications_user_qualifications_type1_idx` (`user_qualifications_type_id`),
  KEY `fk_user_qualifications_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_user_qualifications_user_qualifications_category1_idx` (`user_qualifications_category_id`),
  KEY `fk_user_qualifications_country1_idx` (`country_id_c`),
  KEY `fk_user_qualifications_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `fk_user_qualifications_student1_idx` (`student_s_id`),
  KEY `fk_user_qualifications_qualification1_idx` (`qualification_id`),
  KEY `english_grade` (`english_grade`),
  CONSTRAINT `fk_user_qualifications_country1` FOREIGN KEY (`country_id_c`) REFERENCES `country` (`id_c`),
  CONSTRAINT `fk_user_qualifications_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_user_qualifications_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_qualifications_qualification1` FOREIGN KEY (`qualification_id`) REFERENCES `qualification` (`id`),
  CONSTRAINT `fk_user_qualifications_student1` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`),
  CONSTRAINT `fk_user_qualifications_user_qualifications_category1` FOREIGN KEY (`user_qualifications_category_id`) REFERENCES `user_qualifications_category` (`id`),
  CONSTRAINT `fk_user_qualifications_user_qualifications_type1` FOREIGN KEY (`user_qualifications_type_id`) REFERENCES `user_qualifications_type` (`id`),
  CONSTRAINT `user_qualifications_ibfk_1` FOREIGN KEY (`english_grade`) REFERENCES `module_grade` (`idModuleGrade`)
) ENGINE=InnoDB AUTO_INCREMENT=46078 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_qualifications_category
DROP TABLE IF EXISTS `user_qualifications_category`;
CREATE TABLE IF NOT EXISTS `user_qualifications_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_qualifications_respond
DROP TABLE IF EXISTS `user_qualifications_respond`;
CREATE TABLE IF NOT EXISTS `user_qualifications_respond` (
  `id` int NOT NULL AUTO_INCREMENT,
  `added_date` datetime DEFAULT NULL,
  `added_by` int DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `user_qualifications_id` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `added_by` (`added_by`) USING BTREE,
  KEY `user_qualifications_id` (`user_qualifications_id`) USING BTREE,
  CONSTRAINT `user_qualifications_respond_ibfk_1` FOREIGN KEY (`added_by`) REFERENCES `general_user_profile` (`gup_id`),
  CONSTRAINT `user_qualifications_respond_ibfk_2` FOREIGN KEY (`user_qualifications_id`) REFERENCES `user_qualifications` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_qualifications_type
DROP TABLE IF EXISTS `user_qualifications_type`;
CREATE TABLE IF NOT EXISTS `user_qualifications_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_role
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE IF NOT EXISTS `user_role` (
  `ur_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) DEFAULT NULL,
  `role_order` int DEFAULT NULL,
  PRIMARY KEY (`ur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_role_coins
DROP TABLE IF EXISTS `user_role_coins`;
CREATE TABLE IF NOT EXISTS `user_role_coins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(100) DEFAULT NULL,
  `coins` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_role_employee
DROP TABLE IF EXISTS `user_role_employee`;
CREATE TABLE IF NOT EXISTS `user_role_employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_role_coins_id` int NOT NULL,
  `employees_employee_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role_employee_user_role_coins1_idx` (`user_role_coins_id`),
  KEY `fk_user_role_employee_employees1_idx` (`employees_employee_id`),
  CONSTRAINT `fk_user_role_employee_employees1` FOREIGN KEY (`employees_employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_user_role_employee_user_role_coins1` FOREIGN KEY (`user_role_coins_id`) REFERENCES `user_role_coins` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_role_has_system_interface
DROP TABLE IF EXISTS `user_role_has_system_interface`;
CREATE TABLE IF NOT EXISTS `user_role_has_system_interface` (
  `id` int NOT NULL AUTO_INCREMENT,
  `system_interface_si_id` int NOT NULL,
  `user_role_ur_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role_has_system_interface_system_interface1_idx` (`system_interface_si_id`),
  KEY `fk_user_role_has_system_interface_user_role1_idx` (`user_role_ur_id`),
  CONSTRAINT `fk_user_role_has_system_interface_system_interface1` FOREIGN KEY (`system_interface_si_id`) REFERENCES `system_interface` (`si_id`),
  CONSTRAINT `fk_user_role_has_system_interface_user_role1` FOREIGN KEY (`user_role_ur_id`) REFERENCES `user_role` (`ur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1305 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.user_title
DROP TABLE IF EXISTS `user_title`;
CREATE TABLE IF NOT EXISTS `user_title` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.use_case
DROP TABLE IF EXISTS `use_case`;
CREATE TABLE IF NOT EXISTS `use_case` (
  `uc_id` int NOT NULL AUTO_INCREMENT,
  `case_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`uc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.use_case_has_system_interface
DROP TABLE IF EXISTS `use_case_has_system_interface`;
CREATE TABLE IF NOT EXISTS `use_case_has_system_interface` (
  `uc_si_id` int NOT NULL AUTO_INCREMENT,
  `system_interface_si_id` int NOT NULL,
  `use_case_uc_id` int NOT NULL,
  PRIMARY KEY (`uc_si_id`),
  KEY `FKuse_case_h322805` (`system_interface_si_id`),
  KEY `FKuse_case_h432410` (`use_case_uc_id`),
  KEY `FKuse_case_h322806` (`system_interface_si_id`),
  KEY `FKuse_case_h432411` (`use_case_uc_id`),
  CONSTRAINT `FKuse_case_h322805` FOREIGN KEY (`system_interface_si_id`) REFERENCES `system_interface` (`si_id`),
  CONSTRAINT `FKuse_case_h432410` FOREIGN KEY (`use_case_uc_id`) REFERENCES `use_case` (`uc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.use_case_has_user_role
DROP TABLE IF EXISTS `use_case_has_user_role`;
CREATE TABLE IF NOT EXISTS `use_case_has_user_role` (
  `uc_ur_id` int NOT NULL AUTO_INCREMENT,
  `use_case_uc_id` int NOT NULL,
  `user_role_ur_id` int NOT NULL,
  PRIMARY KEY (`uc_ur_id`),
  KEY `FKuse_case_h986427` (`use_case_uc_id`),
  KEY `FKuse_case_h708476` (`user_role_ur_id`),
  KEY `FKuse_case_h986428` (`use_case_uc_id`),
  KEY `FKuse_case_h708477` (`user_role_ur_id`),
  CONSTRAINT `FKuse_case_h708476` FOREIGN KEY (`user_role_ur_id`) REFERENCES `user_role` (`ur_id`),
  CONSTRAINT `FKuse_case_h986427` FOREIGN KEY (`use_case_uc_id`) REFERENCES `use_case` (`uc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1051 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.verification_level
DROP TABLE IF EXISTS `verification_level`;
CREATE TABLE IF NOT EXISTS `verification_level` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.verification_type
DROP TABLE IF EXISTS `verification_type`;
CREATE TABLE IF NOT EXISTS `verification_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(145) DEFAULT NULL COMMENT 'Marking\nFirst Verification\nRe Assess\nRe Assess Verification\n\n\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.visa_type
DROP TABLE IF EXISTS `visa_type`;
CREATE TABLE IF NOT EXISTS `visa_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.visa_type_manager
DROP TABLE IF EXISTS `visa_type_manager`;
CREATE TABLE IF NOT EXISTS `visa_type_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `expiry_date` date DEFAULT NULL,
  `visa_type_id` int NOT NULL,
  `student_application_manager_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_visa_type_manager_visa_type1_idx` (`visa_type_id`),
  KEY `fk_visa_type_manager_student_application_manager1_idx` (`student_application_manager_id`),
  CONSTRAINT `fk_visa_type_manager_student_application_manager1` FOREIGN KEY (`student_application_manager_id`) REFERENCES `student_application_manager` (`id`),
  CONSTRAINT `fk_visa_type_manager_visa_type1` FOREIGN KEY (`visa_type_id`) REFERENCES `visa_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher
DROP TABLE IF EXISTS `voucher`;
CREATE TABLE IF NOT EXISTS `voucher` (
  `vid` int NOT NULL AUTO_INCREMENT,
  `id` varchar(255) DEFAULT NULL,
  `description` varchar(6000) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `voucher_total` double DEFAULT NULL,
  `general_user_profilegup_id` int NOT NULL,
  `voucher_typevt_id` int NOT NULL,
  `login_sessionsession_id` int NOT NULL,
  `user_loginlogin_id` int DEFAULT NULL,
  `branch_bid` int NOT NULL,
  `is_active` int DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `due` double DEFAULT NULL,
  `total_paid` double DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  `payment_mode_payment_mode_id` int DEFAULT NULL,
  `general_organization_profile_id_gop` int DEFAULT NULL,
  `shipping_fee` double DEFAULT NULL,
  `time` time DEFAULT NULL,
  `online_transactions_id` int DEFAULT NULL,
  PRIMARY KEY (`vid`),
  KEY `FKvoucher744599` (`general_user_profilegup_id`),
  KEY `FKvoucher619151` (`voucher_typevt_id`),
  KEY `FKvoucher293781` (`login_sessionsession_id`),
  KEY `FKvoucher382397` (`user_loginlogin_id`),
  KEY `FKvoucher721809` (`branch_bid`),
  KEY `FKvoucher721810` (`branch_bid`),
  KEY `fk_voucher_payment_mode1_idx` (`payment_mode_payment_mode_id`),
  KEY `fk_voucher_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  KEY `online_transactions_id` (`online_transactions_id`),
  CONSTRAINT `fk_voucher_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_voucher_payment_mode1` FOREIGN KEY (`payment_mode_payment_mode_id`) REFERENCES `payment_mode` (`payment_mode_id`),
  CONSTRAINT `FKvoucher619151` FOREIGN KEY (`voucher_typevt_id`) REFERENCES `voucher_type` (`vt_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKvoucher721809` FOREIGN KEY (`branch_bid`) REFERENCES `branch` (`bid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `voucher_ibfk_1` FOREIGN KEY (`online_transactions_id`) REFERENCES `online_transactions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6507179 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_bank_account
DROP TABLE IF EXISTS `voucher_bank_account`;
CREATE TABLE IF NOT EXISTS `voucher_bank_account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bank_account_ba_id` int NOT NULL,
  `voucher_vid` int NOT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_bank_account_bank_account1_idx` (`bank_account_ba_id`),
  KEY `fk_voucher_bank_account_voucher1_idx` (`voucher_vid`),
  KEY `fk_voucher_bank_account_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_voucher_bank_account_bank_account1` FOREIGN KEY (`bank_account_ba_id`) REFERENCES `bank_account` (`ba_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29492 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_contact
DROP TABLE IF EXISTS `voucher_contact`;
CREATE TABLE IF NOT EXISTS `voucher_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) DEFAULT NULL,
  `address1` varchar(1000) DEFAULT NULL,
  `address2` varchar(1000) DEFAULT NULL,
  `address3` varchar(1000) DEFAULT NULL,
  `contact_no` varchar(45) DEFAULT NULL,
  `voucher_contact_type_id` int NOT NULL,
  `voucher_vid` int NOT NULL,
  `contact_no2` varchar(45) DEFAULT NULL,
  `district_id_d` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_contact_voucher_contact_type1_idx` (`voucher_contact_type_id`),
  KEY `fk_voucher_contact_voucher1_idx` (`voucher_vid`),
  KEY `fk_voucher_contact_district1_idx` (`district_id_d`),
  CONSTRAINT `fk_voucher_contact_district1` FOREIGN KEY (`district_id_d`) REFERENCES `district` (`id_d`),
  CONSTRAINT `fk_voucher_contact_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`),
  CONSTRAINT `fk_voucher_contact_voucher_contact_type1` FOREIGN KEY (`voucher_contact_type_id`) REFERENCES `voucher_contact_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21369 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_contact_type
DROP TABLE IF EXISTS `voucher_contact_type`;
CREATE TABLE IF NOT EXISTS `voucher_contact_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_image
DROP TABLE IF EXISTS `voucher_image`;
CREATE TABLE IF NOT EXISTS `voucher_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `url` text,
  `voucher_vid` int NOT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_image_voucher1_idx` (`voucher_vid`),
  CONSTRAINT `fk_voucher_image_voucher1` FOREIGN KEY (`voucher_vid`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=2266 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_item
DROP TABLE IF EXISTS `voucher_item`;
CREATE TABLE IF NOT EXISTS `voucher_item` (
  `vi_id` int NOT NULL AUTO_INCREMENT,
  `id` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `is_active` int DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `vouchervid` int NOT NULL,
  `voucher_typevt_id` int NOT NULL,
  `user_loginlogin_id` int DEFAULT NULL,
  `login_sessionsession_id` int NOT NULL,
  `sub_chart_of_accountis_sca` int DEFAULT NULL,
  `voucher_item_vi_id` int DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT NULL,
  `nbt_amount` double DEFAULT NULL,
  `is_completed` tinyint(1) DEFAULT NULL,
  `org_item_id` int DEFAULT NULL,
  `qty` double DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `payment_mode_payment_mode_id` int DEFAULT NULL,
  `to_be_paid_amount` double DEFAULT NULL,
  `discount_percentage` double DEFAULT NULL,
  `discount_value` double DEFAULT NULL,
  `discounted_amount` double DEFAULT NULL,
  `due_amount` double DEFAULT NULL,
  `offer_manager_id` int DEFAULT NULL,
  `time` time DEFAULT NULL,
  `other_currency_amount` double DEFAULT NULL,
  `bank_reference_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vi_id`),
  KEY `FKvoucher_it196944` (`vouchervid`),
  KEY `FKvoucher_it244247` (`voucher_typevt_id`),
  KEY `FKvoucher_it274205` (`user_loginlogin_id`),
  KEY `FKvoucher_it401973` (`login_sessionsession_id`),
  KEY `FKvoucher_it128933` (`sub_chart_of_accountis_sca`),
  KEY `fk_voucher_item_voucher_item1_idx` (`voucher_item_vi_id`),
  KEY `fk_voucher_item_org_item1_idx` (`org_item_id`),
  KEY `fk_voucher_item_payment_mode1_idx` (`payment_mode_payment_mode_id`),
  KEY `fk_voucher_item_offer_manager1_idx` (`offer_manager_id`),
  CONSTRAINT `fk_voucher_item_offer_manager1` FOREIGN KEY (`offer_manager_id`) REFERENCES `offer_manager` (`id`),
  CONSTRAINT `fk_voucher_item_org_item1` FOREIGN KEY (`org_item_id`) REFERENCES `org_item` (`id`),
  CONSTRAINT `FK_voucher_item_voucher` FOREIGN KEY (`vouchervid`) REFERENCES `voucher` (`vid`),
  CONSTRAINT `FKvoucher_it128933` FOREIGN KEY (`sub_chart_of_accountis_sca`) REFERENCES `sub_chart_of_account` (`is_sca`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKvoucher_it244247` FOREIGN KEY (`voucher_typevt_id`) REFERENCES `voucher_type` (`vt_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=246213 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_item_inactive
DROP TABLE IF EXISTS `voucher_item_inactive`;
CREATE TABLE IF NOT EXISTS `voucher_item_inactive` (
  `id_vii` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `voucher_itemvi_id` int NOT NULL,
  `login_sessionsession_id` int NOT NULL,
  `is_approved` int DEFAULT NULL,
  `request_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_vii`),
  KEY `FKvoucher_it15497` (`voucher_itemvi_id`),
  KEY `FKvoucher_it143654` (`login_sessionsession_id`),
  CONSTRAINT `FKvoucher_it143654` FOREIGN KEY (`login_sessionsession_id`) REFERENCES `login_session` (`session_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKvoucher_it15497` FOREIGN KEY (`voucher_itemvi_id`) REFERENCES `voucher_item` (`vi_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1712 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_item_print
DROP TABLE IF EXISTS `voucher_item_print`;
CREATE TABLE IF NOT EXISTS `voucher_item_print` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `voucher_item_vi_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_item_print_voucher_item1_idx` (`voucher_item_vi_id`),
  CONSTRAINT `fk_voucher_item_print_voucher_item1` FOREIGN KEY (`voucher_item_vi_id`) REFERENCES `voucher_item` (`vi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115117 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_item_received_cheques
DROP TABLE IF EXISTS `voucher_item_received_cheques`;
CREATE TABLE IF NOT EXISTS `voucher_item_received_cheques` (
  `id_vic` int NOT NULL AUTO_INCREMENT,
  `voucher_itemvi_id` int NOT NULL,
  `received_chequesid_rc` int NOT NULL,
  PRIMARY KEY (`id_vic`),
  KEY `FKvoucher_it643448` (`voucher_itemvi_id`),
  KEY `FKvoucher_it842597` (`received_chequesid_rc`),
  CONSTRAINT `FKvoucher_it643448` FOREIGN KEY (`voucher_itemvi_id`) REFERENCES `voucher_item` (`vi_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKvoucher_it842597` FOREIGN KEY (`received_chequesid_rc`) REFERENCES `received_cheques` (`id_rc`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=329 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_receipt_manager
DROP TABLE IF EXISTS `voucher_receipt_manager`;
CREATE TABLE IF NOT EXISTS `voucher_receipt_manager` (
  `id` int NOT NULL AUTO_INCREMENT,
  `voucher_by_voucher` int NOT NULL,
  `voucher_by_receipt` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voucher_receipt_manager_voucher1_idx` (`voucher_by_voucher`),
  KEY `fk_voucher_receipt_manager_voucher2_idx` (`voucher_by_receipt`),
  CONSTRAINT `fk_voucher_receipt_manager_voucher1` FOREIGN KEY (`voucher_by_voucher`) REFERENCES `voucher` (`vid`),
  CONSTRAINT `fk_voucher_receipt_manager_voucher2` FOREIGN KEY (`voucher_by_receipt`) REFERENCES `voucher` (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=10982 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.voucher_type
DROP TABLE IF EXISTS `voucher_type`;
CREATE TABLE IF NOT EXISTS `voucher_type` (
  `vt_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `id_abbreviation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.webhook_event
DROP TABLE IF EXISTS `webhook_event`;
CREATE TABLE IF NOT EXISTS `webhook_event` (
  `we_id` bigint NOT NULL AUTO_INCREMENT,
  `event_type` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'e.g., PAYMENT_RECEIVED, LOAN_APPROVED',
  `event_source` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'TEMCO, INTERNAL, BANK, etc.',
  `direction` enum('INBOUND','OUTBOUND') COLLATE utf8mb4_unicode_ci DEFAULT 'INBOUND',
  `payload` json NOT NULL,
  `student_s_id` int DEFAULT NULL COMMENT 'FK to student.s_id (if applicable)',
  `reference_id` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'External reference ID',
  `processing_status` enum('PENDING','PROCESSING','COMPLETED','FAILED') COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
  `retry_count` int DEFAULT '0',
  `max_retries` int DEFAULT '3',
  `last_error` text COLLATE utf8mb4_unicode_ci,
  `processed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`we_id`),
  KEY `idx_webhook_event_type` (`event_type`),
  KEY `idx_webhook_event_source` (`event_source`),
  KEY `idx_webhook_event_status` (`processing_status`),
  KEY `idx_webhook_event_student` (`student_s_id`),
  KEY `idx_webhook_event_reference` (`reference_id`),
  KEY `idx_webhook_event_created` (`created_at`),
  CONSTRAINT `fk_webhook_event_student` FOREIGN KEY (`student_s_id`) REFERENCES `student` (`s_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.worked_history
DROP TABLE IF EXISTS `worked_history`;
CREATE TABLE IF NOT EXISTS `worked_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date_from` date DEFAULT NULL,
  `date_to` date DEFAULT NULL,
  `designation_id_d` int NOT NULL,
  `general_user_profile_gup_id` int NOT NULL,
  `general_organization_profile_id_gop` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_worked_history_designation1_idx` (`designation_id_d`),
  KEY `fk_worked_history_general_user_profile1_idx` (`general_user_profile_gup_id`),
  KEY `fk_worked_history_general_organization_profile1_idx` (`general_organization_profile_id_gop`),
  CONSTRAINT `fk_worked_history_designation1` FOREIGN KEY (`designation_id_d`) REFERENCES `designation` (`id_d`),
  CONSTRAINT `fk_worked_history_general_organization_profile1` FOREIGN KEY (`general_organization_profile_id_gop`) REFERENCES `general_organization_profile` (`id_gop`),
  CONSTRAINT `fk_worked_history_general_user_profile1` FOREIGN KEY (`general_user_profile_gup_id`) REFERENCES `general_user_profile` (`gup_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.work_shop
DROP TABLE IF EXISTS `work_shop`;
CREATE TABLE IF NOT EXISTS `work_shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_ended` tinyint(1) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `course_cid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_work_shop_course1_idx` (`course_cid`),
  CONSTRAINT `fk_work_shop_course1` FOREIGN KEY (`course_cid`) REFERENCES `course` (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.year
DROP TABLE IF EXISTS `year`;
CREATE TABLE IF NOT EXISTS `year` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` int DEFAULT NULL COMMENT '2016\n2017\n2018\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.year_course_credits
DROP TABLE IF EXISTS `year_course_credits`;
CREATE TABLE IF NOT EXISTS `year_course_credits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_code` varchar(45) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `credit` double DEFAULT NULL,
  `year_id` int NOT NULL,
  `course_levels_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_year_course_credits_year1_idx` (`year_id`),
  KEY `fk_year_course_credits_course_levels1_idx` (`course_levels_id`),
  CONSTRAINT `fk_year_course_credits_course_levels1` FOREIGN KEY (`course_levels_id`) REFERENCES `course_levels` (`id`),
  CONSTRAINT `fk_year_course_credits_year1` FOREIGN KEY (`year_id`) REFERENCES `year` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.year_semester
DROP TABLE IF EXISTS `year_semester`;
CREATE TABLE IF NOT EXISTS `year_semester` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_years_id` int NOT NULL,
  `semester_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_year_semester_student_years1_idx` (`student_years_id`),
  KEY `fk_year_semester_semester1_idx` (`semester_id`),
  CONSTRAINT `fk_year_semester_semester1` FOREIGN KEY (`semester_id`) REFERENCES `semester` (`id`),
  CONSTRAINT `fk_year_semester_student_years1` FOREIGN KEY (`student_years_id`) REFERENCES `student_years` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

-- Dumping structure for table ijts_system.zoon
DROP TABLE IF EXISTS `zoon`;
CREATE TABLE IF NOT EXISTS `zoon` (
  `id_z` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_z`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- Data exporting was unselected.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
