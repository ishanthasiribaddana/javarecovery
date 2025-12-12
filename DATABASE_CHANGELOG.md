# Database Changelog

All notable database changes for the JIAT Recovery System will be documented in this file.

## [Unreleased]

---

## [1.0.1] - 2025-12-12

### Summary
Database data migration for BCU Degree Payment tracking.

### Changes

#### Data Updates
- **Table:** `student_batches`
  - Updated 534 records where `course_cid = 360` (BCU Degree)
  - Verified voucher item associations for BCU payments

#### Queries Used
```sql
-- Count BCU students
SELECT COUNT(*) FROM student_batches WHERE course_cid IN (360, 424);

-- Verify voucher items for BCU courses
SELECT course_id, COUNT(*) AS count 
FROM voucher_item 
WHERE course_id IN (360, 424) 
GROUP BY course_id;
```

### Verification
- Total records in `student_batches` for course 360: **534**
- Total records in `student_batches` for course 424: **0**

### Related Code Changes
- Commit: `a73c6ad`
- Added Student Recovery Report API endpoint
- Updated BCU card to show actual due amounts from payment table

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
