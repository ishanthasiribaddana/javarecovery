# Database Changelog

All notable database changes for the JIAT Recovery System will be documented in this file.

## [Unreleased]

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
