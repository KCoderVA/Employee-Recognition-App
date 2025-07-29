# Audit Log SharePoint List

<!--
   Copyright 2025 Kyle J. Coder

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

## List Configuration

**List Name**: Audit_Log
**Description**: Comprehensive audit trail for all application activities and system events
**Template**: Custom List
**Content Types**: Audit Entry

## Column Schema

### Core Audit Fields
| Column Name       | Type                | Required | Description                                  |
| ----------------- | ------------------- | -------- | -------------------------------------------- |
| Title             | Single Line Text    | Yes      | Auto-generated audit entry ID                |
| EventDateTime     | Date/Time           | Yes      | When the event occurred                      |
| EventType         | Choice              | Yes      | Login, Create, Update, Delete, Approve, etc. |
| EventCategory     | Choice              | Yes      | User Action, System Event, Security, Error   |
| UserEmail         | Single Line Text    | Yes      | Email of user who performed action           |
| UserDisplayName   | Single Line Text    | Yes      | Display name of acting user                  |
| ActionDescription | Multiple Lines Text | Yes      | Detailed description of what happened        |
| SourceComponent   | Choice              | Yes      | PowerApp, Flow, SharePoint, Teams, etc.      |

### Target and Context
| Column Name       | Type                | Required | Description                                 |
| ----------------- | ------------------- | -------- | ------------------------------------------- |
| TargetEntity      | Single Line Text    | No       | Entity affected (Nomination, User, Setting) |
| TargetEntityID    | Single Line Text    | No       | ID of affected entity                       |
| TargetEntityTitle | Single Line Text    | No       | Title/name of affected entity               |
| BeforeValues      | Multiple Lines Text | No       | Values before change (JSON)                 |
| AfterValues       | Multiple Lines Text | No       | Values after change (JSON)                  |
| ChangeFields      | Multiple Lines Text | No       | Comma-separated list of changed fields      |
| ParentEntityID    | Single Line Text    | No       | Parent entity if applicable                 |

### Technical Details
| Column Name   | Type                | Required | Description                      |
| ------------- | ------------------- | -------- | -------------------------------- |
| SessionID     | Single Line Text    | No       | User session identifier          |
| IPAddress     | Single Line Text    | No       | User IP address                  |
| UserAgent     | Multiple Lines Text | No       | Browser/client information       |
| DeviceType    | Choice              | No       | Desktop, Mobile, Tablet, Unknown |
| RequestID     | Single Line Text    | No       | System request identifier        |
| CorrelationID | Single Line Text    | No       | Cross-system correlation ID      |
| Duration      | Number              | No       | Action duration in milliseconds  |

### Result and Status
| Column Name    | Type                | Required | Description                     |
| -------------- | ------------------- | -------- | ------------------------------- |
| ResultStatus   | Choice              | Yes      | Success, Warning, Error, Failed |
| ErrorMessage   | Multiple Lines Text | No       | Error details if applicable     |
| ErrorCode      | Single Line Text    | No       | System error code               |
| WarningMessage | Multiple Lines Text | No       | Warning details if applicable   |
| AdditionalData | Multiple Lines Text | No       | Extra context data (JSON)       |
| Severity       | Choice              | Yes      | Low, Medium, High, Critical     |

### Security and Compliance
| Column Name        | Type                | Required | Description                                  |
| ------------------ | ------------------- | -------- | -------------------------------------------- |
| SecurityLevel      | Choice              | Yes      | Public, Internal, Confidential, Restricted   |
| ComplianceFlags    | Multiple Lines Text | No       | Compliance-related tags                      |
| DataClassification | Choice              | No       | Public, Internal, Confidential, Restricted   |
| PIIInvolved        | Yes/No              | Yes      | Contains personally identifiable information |
| RetentionCategory  | Choice              | Yes      | Standard, Extended, Permanent                |
| ArchiveDate        | Date/Time           | No       | When to archive this entry                   |

## Choice Field Values

### EventType Choices
- User Login
- User Logout
- Create Nomination
- Update Nomination
- Delete Nomination
- Submit Nomination
- Approve Nomination
- Reject Nomination
- Route Nomination
- Create User
- Update User
- Deactivate User
- Change Permissions
- Update Settings
- Export Data
- Import Data
- System Backup
- System Restore
- Password Reset
- Account Lockout
- Security Violation

### EventCategory Choices
- User Authentication
- Data Creation
- Data Modification
- Data Deletion
- Workflow Action
- Permission Change
- System Configuration
- Security Event
- Error Event
- Performance Event
- Integration Event

### SourceComponent Choices
## How to Import/Set Up This List in SharePoint

**Version Applicability:**
This template is for Employee Recognition App v0.9.x and later. Use the CSV/XLSX template provided in the repository.

**Import Steps:**
1. In SharePoint, create a new list from Excel or CSV.
2. Upload the audit-log template file.
3. Map columns to match the schema below.
4. Complete the import and check the list structure.
5. Set permissions and enable audit/versioning as needed.

**Note:**
For compliance, ensure audit log access is restricted to authorized users only.
- Power Apps Canvas
- SharePoint List
- Teams Integration
- Email System
- Active Directory
- Azure Services
- External API
- Manual Entry
- System Process

### ResultStatus Choices
- Success
- Partial Success
- Warning
- Error
- Failed
- Timeout
- Cancelled
- Unauthorized

### Severity Choices
- Informational
- Low
- Medium
- High
- Critical

### SecurityLevel Choices
- Public
- Internal Use
- Confidential
- Restricted

### DeviceType Choices
- Desktop Computer
- Mobile Phone
- Tablet
- Kiosk
- Unknown

### RetentionCategory Choices
- Standard (7 years)
- Extended (10 years)
- Permanent
- Custom

## Automated Audit Events

### User Actions
- Login/logout activities with session tracking
- All nomination submissions and modifications
- Approval and rejection actions
- Permission and role changes
- Data exports and reports generated

### System Events
- Scheduled job executions
- Data synchronization activities
- Backup and restore operations
- Performance threshold breaches
- Integration failures

### Security Events
- Failed login attempts
- Unauthorized access attempts
- Permission escalations
- Data access violations
- Suspicious activity patterns

## Views

### Default Views
1. **Recent Activity** - Last 24 hours of activity
2. **By User** - Activity grouped by user
3. **By Event Type** - Activity grouped by event type
4. **Error Events** - Failed or error events only
5. **Security Events** - Security-related events
6. **Critical Events** - High and critical severity events

### Administrative Views
1. **Full Audit Trail** - Complete chronological log
2. **Compliance Report** - Compliance-flagged events
3. **Performance Issues** - Performance-related events
4. **Data Access Log** - All data access events
5. **System Events** - System and automated events
6. **User Behavior** - User activity patterns

### Specialized Views
1. **PII Access Log** - Events involving PII data
2. **Failed Logins** - Authentication failures
3. **Permission Changes** - Role and permission modifications
4. **Export Activities** - All data export events
5. **Integration Errors** - External system integration issues

## Permissions

### Permission Levels
- **No Access**: Standard users (cannot view audit logs)
- **Read**: Compliance officers and auditors
- **Contribute**: Not applicable (automated entries only)
- **Edit**: Not applicable (immutable audit trail)
- **Full Control**: Chief Information Officer and designated security personnel

### Security Groups
- **EmployeeRecognition_Auditors**: Read access to relevant audit data
- **EmployeeRecognition_Compliance**: Full audit trail access
- **EmployeeRecognition_Security**: Security event access
- **EmployeeRecognition_CIO**: Complete audit administration

## Automated Logging

### Power Automate Integration
- **Real-time Logging**: All user actions logged immediately
- **Batch Processing**: System events logged in batches
- **Error Handling**: Failed logging attempts retry automatically
- **Performance Monitoring**: Log performance metrics

### Data Sources
- Power Apps telemetry and user actions
- Power Automate flow execution logs
- SharePoint access and modification logs
- Teams integration activity
- External system API calls

## Compliance and Retention

### Regulatory Requirements
- **VA Directive 6500.1**: Information security requirements
- **VA Handbook 6500.6**: Risk management requirements
- **FISMA**: Federal information security requirements
- **HIPAA**: Healthcare data protection (where applicable)

### Retention Policies
- **Standard Events**: 7 years retention
- **Security Events**: 10 years retention
- **Compliance Events**: Permanent retention
- **Error Events**: 7 years retention with performance analysis

### Data Protection
- Audit logs are immutable after creation
- Encrypted storage for sensitive audit data
- Access logging for audit log access
- Regular integrity checks and validation

## Performance and Optimization

### Indexing Strategy
- Primary indexes on EventDateTime, UserEmail, EventType
- Secondary indexes on TargetEntityID, Severity, ResultStatus
- Composite indexes for common query patterns

### Archival Process
- Monthly archival of logs older than 1 year
- Quarterly compression of archived data
- Annual migration to long-term storage
- Performance impact monitoring

### Query Optimization
- Pre-built views for common audit queries
- Caching for frequently accessed reports
- Pagination for large result sets
- Background processing for complex reports

## Monitoring and Alerting

### Real-time Alerts
- Critical security events trigger immediate alerts
- System errors generate automated notifications
- Performance degradation alerts
- Compliance violation notifications

### Reporting
- Daily summary reports for administrators
- Weekly compliance reports
- Monthly security trend analysis
- Quarterly audit summaries

## Backup and Recovery

### Regular Tasks
- **Real-time**: Continuous replication to backup storage
- **Daily**: Snapshot backup of all audit data
- **Weekly**: Validation of backup integrity
- **Monthly**: Disaster recovery testing

### Data Retention
- **Active**: Current year data in primary storage
- **Archive**: 2-6 years in secondary storage
- **Long-term**: 7+ years in compliance storage

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
**Security Classification**: Internal Use
**Related Documentation**: [User Profiles](./user-profiles.md), [Admin Settings](./admin-settings.md)
