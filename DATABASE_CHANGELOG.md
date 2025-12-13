# Database Changelog

All notable database changes for the JIAT Recovery System will be documented in this file.

## [Unreleased]

---

## [1.0.3] - 2025-12-13

### Summary
Major improvements to Course Overdue Report with accurate balance calculations and UI enhancements.

### Course Overdue Report Improvements

#### Backend Changes
- **Filter by Active Batches** - Only includes `student_batches` records where `is_active != 0`
- **Calculated Balance Column** - Added `(payable_fee - total_paid)` as accurate balance calculation
- **Data Analysis Endpoint** - New `/api/students/reports/overpaid-students` endpoint to identify data discrepancies

#### SQL Query Updates
```sql
-- Added is_active filter to student_batches subquery
WHERE sb.total_due_fee != 0
  AND sb.course_cid IN (321, 328, 331, 340)
  AND sb.is_active != 0

-- Added calculated balance column
(payable_fee - total_paid) as calculated_balance
```

#### Frontend Changes
- **Sticky Table Header** - Header row stays fixed when scrolling
- **New Balance Column** - Shows accurate `payableFee - totalPaid` calculation
- **Column Rename** - "Payable" → "Course Fee Payable"
- **Compact Summary Cards** - Reduced height by ~50%
- **Removed Color Legend** - Cleaner UI
- **NIC Links Open in New Tab** - `target="_blank"` for student links

#### Data Quality Findings
- Identified **27 students** with negative calculated balance (overpaid)
- `student_batches.total_due_fee` contains stale/unreliable data
- Recommended using `calculatedBalance` for accurate due amounts

### API Endpoints Added
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/students/reports/overpaid-students` | Analyze students with negative balance |

---

## [1.0.2] - 2025-12-13

### Summary
Added Java Institute API integration for real-time financial data synchronization.

### New Tables

#### `sync_log`
Tracks synchronization status with Java Institute API.

```sql
CREATE TABLE sync_log (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    sync_type VARCHAR(50) NOT NULL,
    sync_time DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    records_synced INT,
    students_synced INT,
    payments_synced INT,
    enrollments_synced INT,
    fee_structures_synced INT,
    offers_synced INT,
    error_message VARCHAR(1000),
    duration_ms BIGINT,
    triggered_by VARCHAR(100),
    api_response_code INT
);
```

### New Features
- **Java Institute API Client** - HTTP client for consuming external API
- **Finance Sync Service** - Service for synchronizing financial data
- **Sync Dashboard UI** - Admin interface for monitoring and triggering syncs
- **Mock API Server** - Local development server simulating Java Institute API

### API Endpoints Added
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/sync/health` | Check Java Institute API health |
| GET | `/api/sync/status` | Get sync status with last sync info |
| GET | `/api/sync/history` | Get sync history |
| POST | `/api/sync/full` | Trigger full data sync |
| POST | `/api/sync/incremental` | Trigger incremental sync |

### Configuration
```properties
# Mock API (Development)
javainstitute.api.url=http://localhost:8081/api/v1
javainstitute.api.key=JIAT-MOCK-API-KEY-2025

# Production (when available)
# javainstitute.api.url=https://api.javainstitute.lk/api/v1
# javainstitute.api.key=<production-key>
```

---

## [1.0.1] - 2025-12-12

### Summary
Updated `voucher_item` records to map international payment types using `voucher_typevt_id` field.

### Changes

#### Data Updates
- **Table:** `voucher_item`
  - Updated `voucher_typevt_id` field to categorize international payments
  - Mapped records to appropriate voucher types for UK Awards, BCU, and IIC payments

#### Voucher Types Used
| vt_id | Voucher Type Name | Records Updated |
|-------|-------------------|-----------------|
| 40 | UK Award 1 | 2,855 |
| 41 | UK Award 2 | 1,698 |
| 42 | UK Award 3 | 697 |
| 43 | BCU Payment | 555 |
| 44 | IIC Payment | 349 |
| **Total** | | **6,154** |

#### Queries Used
```sql
-- Verify voucher item counts by type
SELECT vt.name, COUNT(*) as count 
FROM voucher_item vi 
JOIN voucher_type vt ON vi.voucher_typevt_id = vt.vt_id 
WHERE vi.voucher_typevt_id IN (40, 41, 42, 43, 44) 
GROUP BY vi.voucher_typevt_id, vt.name 
ORDER BY vi.voucher_typevt_id;
```

### Verification
- UK Award 1 (vt_id=40): **2,855 records**
- UK Award 2 (vt_id=41): **1,698 records**
- UK Award 3 (vt_id=42): **697 records**
- BCU Payment (vt_id=43): **555 records**
- IIC Payment (vt_id=44): **349 records**

### Related Code Changes
- Commit: `a73c6ad`
- Added Student Recovery Report API endpoint
- Updated BCU card to show actual due amounts from payment table

---
---

## [1.0.0] - 2025-12-01

### Summary
Initial database schema for JIAT Recovery System.

### Tables
- `student` - Student records
- `general_user_profile` - User profile information (NIC, name, contact)
- `voucher` - Payment vouchers
- `voucher_item` - Individual payment items
- `universal_payment_manager` - Payment tracking and scholarship info
- `student_batches` - Student course batch enrollments
- `course` - Course definitions

### Key Relationships
- `student.general_user_profilegup_id` → `general_user_profile.gup_id`
- `voucher_item.voucher_vid` → `voucher.vid`
- `student_batches.course_cid` → `course.cid`
- `universal_payment_manager.general_user_profile_gup_id` → `general_user_profile.gup_id`

---

## Template for Future Entries

```markdown
## [X.X.X] - YYYY-MM-DD

### Summary
Brief description of changes.

### Changes

#### Schema Changes
- Added/Modified/Removed table: `table_name`
- Added/Modified/Removed column: `column_name` in `table_name`

#### Data Updates
- Description of data migration
- Number of records affected

#### Queries Used
\`\`\`sql
-- SQL queries used for migration
\`\`\`

### Verification
- Verification steps and results

### Rollback
\`\`\`sql
-- Rollback queries if needed
\`\`\`
```
