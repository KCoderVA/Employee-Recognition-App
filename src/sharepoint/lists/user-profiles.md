# User Profiles SharePoint List

## List Configuration

**List Name**: User_Profiles
**Description**: Stores employee profile information and app-specific settings
**Template**: Custom List
**Content Types**: User Profile

## Column Schema

### Core Profile Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Title | Single Line Text | Yes | Employee display name |
| UserEmail | Single Line Text | Yes | Employee email address (unique) |
| EmployeeID | Single Line Text | Yes | VA employee ID number |
| FirstName | Single Line Text | Yes | Employee first name |
| LastName | Single Line Text | Yes | Employee last name |
| Department | Single Line Text | No | Employee department |
| ServiceLine | Single Line Text | No | Employee service line |
| JobTitle | Single Line Text | No | Employee job title |
| ManagerEmail | Single Line Text | No | Direct manager's email |
| IsActive | Yes/No | Yes | Active employee status |

### Role and Permissions
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| UserRole | Choice | Yes | Standard, Manager, Committee, Admin |
| PermissionLevel | Choice | Yes | Read, Contribute, Edit, FullControl |
| CommitteeAssignments | Multiple Lines Text | No | Assigned committees (JSON) |
| DelegatedApprovals | Multiple Lines Text | No | Delegation settings |
| LastLoginDate | Date/Time | No | Last app access date |

### Preferences and Settings
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| EmailNotifications | Yes/No | Yes | Receive email notifications |
| TeamsNotifications | Yes/No | Yes | Receive Teams notifications |
| PreferredLanguage | Choice | No | Language preference |
| TimeZone | Choice | No | User time zone |
| DashboardLayout | Multiple Lines Text | No | Custom dashboard settings |

### Audit and Tracking
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| ProfileCreated | Date/Time | Yes | Profile creation date |
| ProfileUpdated | Date/Time | No | Last profile update |
| UpdatedBy | Person/Group | No | Who updated the profile |
| AccessCount | Number | No | Total app access count |
| LastNominationDate | Date/Time | No | Last nomination submitted |

## Choice Field Values

### UserRole Choices
- Standard User
- Manager
- Committee Member
- Administrator
- System Account

### PermissionLevel Choices
- Read Only
- Contribute
- Edit
- Full Control
- Custom

### PreferredLanguage Choices
- English
- Spanish
- French

### TimeZone Choices
- Eastern Time (US & Canada)
- Central Time (US & Canada)
- Mountain Time (US & Canada)
- Pacific Time (US & Canada)
- Alaska Time
- Hawaii Time

## Views

### Default Views
1. **All Users** - Complete user directory
2. **Active Users** - Currently active employees only
3. **By Department** - Grouped by department
4. **By Role** - Grouped by user role
5. **Managers Only** - Users with manager role
6. **Committee Members** - Users with committee access
7. **Recent Logins** - Users active in last 30 days

### Administrative Views
1. **Inactive Users** - Users marked as inactive
2. **Permission Audit** - Users by permission level
3. **Missing Profiles** - Users without complete profiles
4. **Delegation Report** - Users with delegation settings

## Permissions

### Permission Levels
- **Read**: All authenticated users (view basic directory)
- **Contribute**: HR administrators (create/update profiles)
- **Edit**: IT administrators (modify system settings)
- **Full Control**: System administrators

### Security Groups
- **EmployeeRecognition_HRAdmins**: Profile management rights
- **EmployeeRecognition_ITAdmins**: System configuration rights
- **EmployeeRecognition_Users**: Read-only directory access
- **EmployeeRecognition_Delegates**: Delegation management rights

## Workflows

### Power Automate Integration
- **On User Created**: Setup default preferences and permissions
- **On Profile Updated**: Sync changes to related lists
- **Daily Sync**: Update from Active Directory
- **Cleanup Process**: Archive inactive users

### Business Rules
- User email must be unique across the list
- Employee ID must be unique and valid
- Active directory sync updates basic fields automatically
- Role changes trigger permission updates
- Profile deletion requires manager approval

## Data Integration

### Active Directory Sync
- **Frequency**: Daily at 2:00 AM
- **Fields Synced**: Name, Email, Department, Manager, Job Title
- **Conflict Resolution**: AD data takes precedence for core fields
- **New User Detection**: Auto-create profiles for new employees

### Related Lists
- **Employee_Nominations**: Links via UserEmail/NomineeEmail
- **Admin_Settings**: User-specific configuration overrides
- **Audit_Log**: All profile changes logged

## Backup and Maintenance

### Regular Tasks
- **Daily**: Sync with Active Directory
- **Weekly**: Clean up duplicate or orphaned profiles
- **Monthly**: Archive profiles for terminated employees
- **Quarterly**: Permission and delegation audit

### Data Retention
- **Active**: Indefinite for current employees
- **Terminated**: 2 years after termination date
- **Archived**: 7 years per VA data retention policy

### Performance Optimization
- Indexed columns: UserEmail, EmployeeID, Department, UserRole
- Regular list maintenance and cleanup
- Monitor for delegation bottlenecks

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
**Related Documentation**: [Admin Settings](./admin-settings.md), [Employee Nominations](./employee-nominations.md)
