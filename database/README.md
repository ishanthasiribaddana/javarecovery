# JIAT Recovery System - Database

## Database Files

### v1.0.0

- **jiat_recovery_schema_v1.0.0.sql** - Main recovery database schema (structure only)
- **ijts_system_structure_v1.0.0.sql** - IJTS system structure (read-only tables referenced by recovery system)
- **schema/V1.0.0__create_recovery_tables.sql** - Recovery-specific tables (Flyway migration format)

## Setup Instructions

### Prerequisites
- MySQL 8.0+
- Database: `jiat_abortionfee` (main IJTS database)

### Installation

1. **Import IJTS System Structure** (if not already present):
   ```sql
   mysql -u root -p < ijts_system_structure_v1.0.0.sql
   ```

2. **Import Recovery Database Schema**:
   ```sql
   mysql -u root -p jiat_abortionfee < jiat_recovery_schema_v1.0.0.sql
   ```

3. **Or run Flyway migrations** (for recovery tables only):
   ```sql
   mysql -u root -p jiat_abortionfee < schema/V1.0.0__create_recovery_tables.sql
   ```

## Key Tables

### Recovery System Tables (new)
- `recovery_case` - Recovery case tracking
- `recovery_calculation` - Fee calculations
- `recovery_exchange_rate` - Currency exchange rates
- `recovery_audit_log` - Audit trail
- `recovery_grievance` - Student grievances

### Referenced Tables (read-only from IJTS)
- `student` - Student records
- `general_user_profile` - User profiles
- `voucher` / `voucher_item` - Payment records
- `student_batches` - Batch enrollments
- `scholarship_payment_scheduler` - Scholarship data
- `course` / `branch` / `intake` - Academic structure

## Notes

- The recovery system connects to the existing `jiat_abortionfee` database
- Recovery tables are prefixed with `recovery_`
- All IJTS tables are accessed in read-only mode
