# Admin Settings SharePoint List

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

**List Name**: Admin_Settings
**Description**: Stores application configuration settings and administrative parameters
**Template**: Custom List
**Content Types**: Configuration Setting

## Column Schema

### Core Configuration Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Title | Single Line Text | Yes | Setting name/key |
| SettingCategory | Choice | Yes | General, Notifications, Approvals, Security |
| SettingValue | Multiple Lines Text | Yes | Configuration value (JSON/text) |
| DataType | Choice | Yes | String, Number, Boolean, JSON, Array |
| Description | Multiple Lines Text | Yes | Setting purpose and usage |
| IsActive | Yes/No | Yes | Whether setting is currently active |
| Environment | Choice | Yes | Development, Testing, Production, All |

### Validation and Constraints
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| DefaultValue | Multiple Lines Text | No | Default value if not set |
| ValidationType | Choice | No | None, Range, List, Regex, Custom |
| ValidationRule | Multiple Lines Text | No | Validation pattern or rule |
| MinValue | Number | No | Minimum allowed value |
| MaxValue | Number | No | Maximum allowed value |
| AllowedValues | Multiple Lines Text | No | Comma-separated allowed values |
| IsSensitive | Yes/No | Yes | Contains sensitive information |

### Management and Auditing
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Owner | Person/Group | Yes | Setting owner/responsible party |
| LastModified | Date/Time | Yes | Last modification date |
| ModifiedBy | Person/Group | Yes | Who last modified the setting |
| ChangeReason | Multiple Lines Text | No | Reason for last change |
| ApprovalRequired | Yes/No | Yes | Requires approval to change |
| ApprovedBy | Person/Group | No | Who approved the change |
| VersionNumber | Number | Yes | Setting version number |

### Dependencies and References
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| DependsOn | Multiple Lines Text | No | Other settings this depends on |
| AffectedComponents | Multiple Lines Text | No | Components using this setting |
| RelatedFlows | Multiple Lines Text | No | Power Automate flows affected |
| Documentation | Hyperlink | No | Link to detailed documentation |

## Choice Field Values

### SettingCategory Choices
- General Configuration
- Email Notifications
- Teams Integration
- Approval Workflows
- Security Settings
- User Interface
- Data Management
- Performance Tuning
- External Integrations
- Compliance Settings

### DataType Choices
- String
- Number
- Boolean
- JSON Object
- Array
- Date/Time
- Hyperlink
- Email

### Environment Choices
- Development
- Testing
- Staging
- Production
- All Environments

### ValidationType Choices
- None
- Number Range
- Value List
- Regular Expression
- Email Format
- URL Format
- Custom Function

## Pre-configured Settings

### Application Settings
```json
{
  "Title": "AppTitle",
  "SettingValue": "Employee Recognition Application",
  "SettingCategory": "General Configuration",
  "Description": "Main application title displayed to users"
}
```

### Email Notification Settings
```json
{
  "Title": "NotificationFromEmail",
  "SettingValue": "noreply@va.gov",
  "SettingCategory": "Email Notifications",
  "Description": "From email address for automated notifications"
}
```

### Approval Workflow Settings
```json
{
  "Title": "HROApprovalStages",
  "SettingValue": "[\"Triage\", \"Committee Review\", \"Final Approval\"]",
  "SettingCategory": "Approval Workflows",
  "Description": "Required approval stages for HRO awards"
}
```

### Performance Settings
```json
{
  "Title": "MaxRecordsPerView",
  "SettingValue": "100",
  "SettingCategory": "Performance Tuning",
  "Description": "Maximum records to display in list views"
}
```

## Views

### Default Views
1. **All Settings** - Complete configuration list
2. **By Category** - Grouped by setting category
3. **Active Settings** - Currently active settings only
4. **By Environment** - Filtered by environment
5. **Pending Changes** - Settings awaiting approval
6. **Recent Modifications** - Recently changed settings

### Administrative Views
1. **Sensitive Settings** - Settings marked as sensitive
2. **Validation Required** - Settings with validation rules
3. **Dependency Map** - Settings with dependencies
4. **Approval Queue** - Settings needing approval
5. **Version History** - Settings with version tracking

## Permissions

### Permission Levels
- **Read**: Application users (limited view of non-sensitive settings)
- **Contribute**: System administrators (modify non-critical settings)
- **Edit**: Senior administrators (modify all settings)
- **Full Control**: IT management (full administrative access)

### Security Groups
- **EmployeeRecognition_ConfigReaders**: Read access to configuration
- **EmployeeRecognition_SysAdmins**: System administrator access
- **EmployeeRecognition_ITManagers**: Full configuration management
- **EmployeeRecognition_Auditors**: Read-only audit access

## Workflows

### Power Automate Integration
- **On Setting Created**: Validate new configuration settings
- **On Setting Modified**: Notify affected stakeholders and update dependent systems
- **Approval Required**: Route changes through approval process
- **Daily Backup**: Export critical settings for backup

### Business Rules
- Changes to sensitive settings require approval
- Version numbers increment automatically on modification
- Dependencies are validated before changes
- Environment-specific settings cannot conflict
- All changes must include a reason
- Critical settings require two-person authorization

## Security and Compliance

### Data Classification
- **Public**: General application settings
- **Internal**: Configuration parameters
- **Confidential**: API keys, connection strings
- **Restricted**: Security tokens, passwords

### Access Controls
- Sensitive settings hidden from general users
- Change approval required for production settings
- Audit trail for all configuration changes
- Role-based access to different categories

### Encryption
- Sensitive values encrypted at rest
- Connection strings stored securely
- API keys managed through Azure Key Vault

## Integration Points

### Power Platform Components
- **Power Apps**: Reads UI and behavior settings
- **Power Automate**: Uses notification and workflow settings
- **SharePoint**: Applies security and performance settings
- **Teams**: Uses integration and notification settings

### External Systems
- **Active Directory**: Authentication and user settings
- **Azure Key Vault**: Secure credential storage
- **Monitoring Tools**: Performance and alert settings
- **Backup Systems**: Data retention and backup settings

## Backup and Maintenance

### Regular Tasks
- **Daily**: Export critical settings for backup
- **Weekly**: Validate setting consistency across environments
- **Monthly**: Review and cleanup unused settings
- **Quarterly**: Security audit of sensitive settings

### Data Retention
- **Current**: Indefinite retention for active settings
- **Historical**: 2 years of change history
- **Audit**: 7 years of modification logs per VA policy

### Disaster Recovery
- Critical settings backed up to Azure Key Vault
- Configuration export/import procedures documented
- Environment rebuild procedures tested quarterly

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
**Related Documentation**: [User Profiles](./user-profiles.md), [Audit Log](./audit-log.md)
