# Award Categories SharePoint List

## List Configuration

**List Name**: Award_Categories
**Description**: Master list of available award types and their configuration parameters
**Template**: Custom List
**Content Types**: Award Category

## Column Schema

### Core Category Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Title | Single Line Text | Yes | Award category display name |
| CategoryCode | Single Line Text | Yes | Unique identifier code |
| Description | Multiple Lines Text | Yes | Detailed award description |
| Purpose | Multiple Lines Text | Yes | Purpose and intent of the award |
| IsActive | Yes/No | Yes | Whether category is currently available |
| SortOrder | Number | Yes | Display order in application |
| IconUrl | Hyperlink | No | URL to award category icon |
| Color | Single Line Text | No | Hex color code for UI theming |

### Workflow Configuration
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| RequiresApproval | Yes/No | Yes | Requires approval workflow |
| ApprovalStages | Multiple Lines Text | No | JSON array of approval stages |
| AutoApprove | Yes/No | Yes | Can be auto-approved |
| ApprovalTimeoutDays | Number | No | Days before approval times out |
| EscalationRules | Multiple Lines Text | No | Escalation configuration |
| NotificationTemplate | Single Line Text | No | Email template to use |

### Form Configuration
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| FormFields | Multiple Lines Text | Yes | JSON configuration of form fields |
| RequiredFields | Multiple Lines Text | No | Comma-separated required field names |
| ConditionalLogic | Multiple Lines Text | No | JSON rules for conditional fields |
| ValidationRules | Multiple Lines Text | No | Custom validation configuration |
| HelpText | Multiple Lines Text | No | Help text for this award type |
| CharacterLimits | Multiple Lines Text | No | Field character limit overrides |

### Business Rules
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| EligibilityCriteria | Multiple Lines Text | No | Who can submit this award type |
| SubmissionLimits | Multiple Lines Text | No | Frequency/quantity limits |
| ReviewerRoles | Multiple Lines Text | No | Roles that can review this type |
| ManagerApprovalRequired | Yes/No | Yes | Requires manager approval |
| CommitteeReviewRequired | Yes/No | Yes | Requires committee review |
| PublicRecognition | Yes/No | Yes | Award is publicly recognized |

### Compliance and Tracking
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| ComplianceFlags | Multiple Lines Text | No | Compliance requirements |
| TrackingRequired | Yes/No | Yes | Requires detailed tracking |
| ReportingCategory | Single Line Text | No | Category for reporting purposes |
| DataRetentionYears | Number | Yes | Years to retain nomination data |
| PIIDataCollected | Yes/No | Yes | Collects personally identifiable info |
| ApprovalHistory | Yes/No | Yes | Maintain detailed approval history |

## Pre-configured Award Categories

### HRO Award (High Reliability Organization)
```json
{
  "Title": "HRO Award",
  "CategoryCode": "HRO",
  "Description": "Recognizes contributions to patient safety and quality care through High Reliability Organization principles",
  "RequiresApproval": true,
  "ApprovalStages": "[\"Triage\", \"Committee Review\", \"Final Approval\"]",
  "FormFields": "[{\"name\":\"context\",\"type\":\"textarea\",\"required\":true}, {\"name\":\"actions\",\"type\":\"textarea\",\"required\":true}, {\"name\":\"results\",\"type\":\"textarea\",\"required\":true}]"
}
```

### Hines Hero Award
```json
{
  "Title": "Hines Hero Award",
  "CategoryCode": "HERO",
  "Description": "Recognizes exceptional service and going above and beyond normal duties",
  "RequiresApproval": true,
  "ApprovalStages": "[\"Manager Review\", \"Department Review\", \"Final Approval\"]",
  "FormFields": "[{\"name\":\"eventSummary\",\"type\":\"textarea\",\"required\":true}, {\"name\":\"impactAssessment\",\"type\":\"textarea\",\"required\":true}]"
}
```

### Starfish Award
```json
{
  "Title": "Starfish Award",
  "CategoryCode": "STARFISH",
  "Description": "Peer-to-peer recognition for daily excellence demonstrating I-CARE values",
  "RequiresApproval": false,
  "AutoApprove": true,
  "FormFields": "[{\"name\":\"integrity\",\"type\":\"textarea\"}, {\"name\":\"commitment\",\"type\":\"textarea\"}, {\"name\":\"advocacy\",\"type\":\"textarea\"}, {\"name\":\"respect\",\"type\":\"textarea\"}, {\"name\":\"excellence\",\"type\":\"textarea\"}]"
}
```

### I-CARE Values Award
```json
{
  "Title": "I-CARE Values Award",
  "CategoryCode": "ICARE",
  "Description": "Recognizes demonstration of VA core values in daily work",
  "RequiresApproval": false,
  "ApprovalStages": "[\"Manager Review\"]",
  "FormFields": "[{\"name\":\"primaryValue\",\"type\":\"choice\",\"choices\":[\"Integrity\",\"Commitment\",\"Advocacy\",\"Respect\",\"Excellence\"]}, {\"name\":\"description\",\"type\":\"textarea\",\"required\":true}]"
}
```

## Choice Field Values

### SortOrder Values
- HRO Award: 1
- Hines Hero Award: 2
- Starfish Award: 3
- I-CARE Values Award: 4

### ReportingCategory Choices
- Patient Safety
- Quality Improvement
- Peer Recognition
- Values Demonstration
- Service Excellence
- Innovation
- Leadership
- Teamwork

### DataRetentionYears Choices
- 5 years
- 7 years
- 10 years
- Permanent

## Form Field Configuration Schema

### Supported Field Types
```json
{
  "text": "Single line text input",
  "textarea": "Multi-line text area",
  "choice": "Dropdown selection",
  "multichoice": "Multiple selection checkboxes",
  "date": "Date picker",
  "datetime": "Date and time picker",
  "number": "Numeric input",
  "email": "Email address input",
  "phone": "Phone number input",
  "url": "URL input",
  "file": "File attachment",
  "boolean": "Yes/No checkbox",
  "rating": "Star rating control"
}
```

### Field Configuration Properties
```json
{
  "name": "Field internal name",
  "type": "Field type from supported types",
  "displayName": "User-friendly label",
  "required": "Boolean - field is required",
  "placeholder": "Placeholder text",
  "helpText": "Help text for field",
  "maxLength": "Maximum character count",
  "choices": "Array of choice options",
  "validation": "Validation pattern or rule",
  "conditionalOn": "Field that controls visibility",
  "conditionalValue": "Value that shows this field"
}
```

## Views

### Default Views
1. **Active Categories** - Currently available award types
2. **All Categories** - Complete list including inactive
3. **By Approval Type** - Grouped by approval requirements
4. **By Sort Order** - Ordered for application display
5. **Configuration Review** - Technical configuration details

### Administrative Views
1. **Inactive Categories** - Disabled award types
2. **Complex Approvals** - Multi-stage approval workflows
3. **Form Configuration** - Field and validation setup
4. **Compliance Requirements** - Awards with special compliance needs
5. **Recent Changes** - Recently modified categories

## Permissions

### Permission Levels
- **Read**: All users (view active award categories)
- **Contribute**: HR administrators (create new categories)
- **Edit**: System administrators (modify existing categories)
- **Full Control**: IT managers (full category management)

### Security Groups
- **EmployeeRecognition_Users**: Read access to active categories
- **EmployeeRecognition_HRAdmins**: Category creation and basic editing
- **EmployeeRecognition_SysAdmins**: Full category configuration
- **EmployeeRecognition_ITManagers**: Complete administrative access

## Workflows

### Power Automate Integration
- **On Category Created**: Validate configuration and setup related components
- **On Category Modified**: Update dependent systems and notify stakeholders
- **Category Activation**: Enable/disable category in application
- **Configuration Sync**: Sync changes to Power Apps and other components

### Business Rules
- CategoryCode must be unique across all categories
- At least one approval stage required if RequiresApproval is true
- FormFields must contain valid JSON configuration
- Cannot deactivate categories with pending nominations
- Changes to active categories require approval
- Sort order automatically adjusts on new category creation

## Integration Points

### Power Apps Canvas Application
- Reads active categories for award type selection
- Uses form field configuration to build dynamic forms
- Applies validation rules and conditional logic
- Displays help text and guidance

### Power Automate Flows
- Uses approval stage configuration for workflow routing
- Applies notification templates for communications
- Enforces business rules and eligibility criteria
- Implements escalation rules for approvals

### SharePoint Lists
- **Employee_Nominations**: Links via AwardType field
- **Admin_Settings**: Global overrides for category settings
- **User_Profiles**: Role-based access to categories
- **Audit_Log**: Tracks all category modifications

## Backup and Maintenance

### Regular Tasks
- **Weekly**: Review and validate form field configurations
- **Monthly**: Audit approval workflows and business rules
- **Quarterly**: Review category performance and usage analytics
- **Annually**: Full configuration review and optimization

### Data Retention
- **Active**: Indefinite retention for current categories
- **Historical**: 7 years of configuration change history
- **Usage Data**: 5 years of category usage statistics

### Performance Optimization
- Cache frequently accessed category configurations
- Index on CategoryCode and IsActive fields
- Regular cleanup of unused form field configurations
- Monitor and optimize complex conditional logic

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
**Related Documentation**: [Employee Nominations](./employee-nominations.md), [Admin Settings](./admin-settings.md)
