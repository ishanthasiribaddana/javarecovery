# JIAT Recovery System

AI-powered Recovery Management System for Java Institute for Advanced Technology.

## Overview

This system calculates accurate student dues based on payment structures and scholarships, reconciles bank deposits with system records, generates professional financial statements, and provides an AI agent for student interaction and grievance handling.

## Technology Stack

| Component | Technology |
|-----------|------------|
| **Backend** | Java EE / Jakarta EE 10 |
| **Business Logic** | EJB 3.x (Stateless Session Beans) |
| **ORM** | JPA with Hibernate |
| **REST API** | JAX-RS |
| **Application Server** | WildFly |
| **Database** | MySQL 8.x |
| **Build Tool** | Maven |
| **Report Generation** | JasperReports |
| **Frontend** | React.js (separate project) |

## Project Structure

```
jiat-recovery-system/
├── jiat-recovery-ear/          # Enterprise Archive (EAR)
├── jiat-recovery-ejb/          # EJB Module (Business Logic)
│   └── src/main/java/com/jiat/recovery/
│       ├── entity/             # JPA Entities
│       │   ├── enums/          # Enum types
│       │   └── readonly/       # Read-only entities (ijts_system)
│       ├── service/            # EJB Services
│       └── dto/                # Data Transfer Objects
├── jiat-recovery-web/          # WAR Module (REST API)
│   └── src/main/java/com/jiat/recovery/rest/
├── database/
│   └── schema/                 # SQL scripts
├── config/
│   └── wildfly/                # WildFly configuration
└── pom.xml                     # Parent POM
```

## Prerequisites

1. **Java 17** or higher
2. **Maven 3.8+**
3. **WildFly 30** (or compatible version)
4. **MySQL 8.x**
5. **NetBeans IDE** (recommended)

## Database Setup

1. Create the database:
```sql
CREATE DATABASE ijts_recovery_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Import the ijts_system dump (for existing data):
```bash
mysql -u root -p ijts_recovery_db < jiat_recovery_dump.sql
```

3. Run the recovery schema script:
```bash
mysql -u root -p ijts_recovery_db < database/schema/V1.0.0__create_recovery_tables.sql
```

4. Create database user:
```sql
CREATE USER 'recovery_user'@'localhost' IDENTIFIED BY 'recovery_password';
GRANT ALL PRIVILEGES ON ijts_recovery_db.* TO 'recovery_user'@'localhost';
FLUSH PRIVILEGES;
```

## WildFly Setup

1. **Install MySQL Driver Module:**
   - Create directory: `WILDFLY_HOME/modules/com/mysql/main/`
   - Download `mysql-connector-j-8.0.33.jar` and place in that directory
   - Create `module.xml` (see `config/wildfly/standalone-recovery-ds.xml` for details)

2. **Configure DataSource:**
   - Add the datasource configuration from `config/wildfly/standalone-recovery-ds.xml` to your `standalone.xml`

3. **Start WildFly:**
```bash
./standalone.sh  # Linux/Mac
standalone.bat   # Windows
```

## Build & Deploy

1. **Build the project:**
```bash
mvn clean package
```

2. **Deploy to WildFly:**
```bash
mvn wildfly:deploy -pl jiat-recovery-ear
```

Or copy `jiat-recovery-ear/target/jiat-recovery.ear` to `WILDFLY_HOME/standalone/deployments/`

## API Endpoints

Base URL: `http://localhost:8080/recovery-api/api`

### Students
- `GET /students/{id}` - Get student by internal ID
- `GET /students/by-student-id/{studentId}` - Get by student ID
- `GET /students/search?name={name}` - Search by name
- `GET /students/{id}/payment-manager` - Get payment info

### Recovery Cases
- `POST /cases` - Create new case
- `GET /cases/{id}` - Get case by ID
- `GET /cases/open` - Get all open cases
- `GET /cases/by-status/{status}` - Get by status
- `PUT /cases/{id}/status` - Update status
- `PUT /cases/{id}/assign` - Assign to officer
- `POST /cases/{id}/calculate` - Calculate dues
- `GET /cases/{id}/calculations` - Get calculations

## Scholarship Percentages

| Payment Option | Scholarship % | Payable Amount (on Rs. 3M) |
|----------------|---------------|----------------------------|
| Full Payment | 70% | Rs. 900,000 |
| Yearly Payment | 65% | Rs. 1,050,000 |
| Semester Payment | 60% | Rs. 1,200,000 |

## Fee Configuration

| Fee Code | Description | Amount | Currency |
|----------|-------------|--------|----------|
| UK_AWARDS_L1 | UK Awards Level 1 | 100 | GBP |
| UK_AWARDS_L2 | UK Awards Level 2 | 110 | GBP |
| UK_AWARDS_L3 | UK Awards Level 3 | 130 | GBP |
| CONVOCATION | Convocation Fee | 35,000 | LKR |
| PORTAL_YEARLY | Student Portal (per year) | 3,000 | LKR |
| ID_CARD | Student ID Card | 1,200 | LKR |

## Development

### Running in Development Mode

1. Import project into NetBeans as Maven project
2. Configure WildFly server in NetBeans
3. Run/Debug from IDE

### Adding New Features

1. Create JPA entity in `jiat-recovery-ejb/src/main/java/com/jiat/recovery/entity/`
2. Create EJB service in `jiat-recovery-ejb/src/main/java/com/jiat/recovery/service/`
3. Create REST endpoint in `jiat-recovery-web/src/main/java/com/jiat/recovery/rest/`

## License

Proprietary - Java Institute for Advanced Technology

## Contact

For support, contact the IT department.
