# Employee Nominations SharePoint List

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

**List Name**: Employee_Nominations
**Description**: Stores all employee award nominations and their status
**Template**: Custom List
**Content Types**: Award Nomination

## Column Schema

### Core Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Title | Single Line Text | Yes | Nomination title/summary |
| NomineeEmail | Single Line Text | Yes | Email of nominated employee |
| NomineeName | Single Line Text | Yes | Full name of nominee |
| NominatorEmail | Single Line Text | Yes | Email of person submitting |
| NominatorName | Single Line Text | Yes | Full name of nominator |
| AwardType | Choice | Yes | HeRO, Great Catch, Starfish, I-CARE |
| SubmissionDate | Date/Time | Yes | When nomination was submitted |
| Status | Choice | Yes | Pending, In Review, Approved, Rejected |

### Award-Specific Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| HROPrinciple1 | Multiple Lines Text | No | First HRO principle (for HRO awards) |
| HROPrinciple2 | Multiple Lines Text | No | Second HRO principle (for HRO awards) |
| ContextDescription | Multiple Lines Text | No | Context section (HRO awards) |
| ActionsDescription | Multiple Lines Text | No | Actions section (HRO awards) |
| ResultsDescription | Multiple Lines Text | No | Results section (HRO awards) |
| ICareValue | Choice | No | I, C, A, R, E value (for I-CARE awards) |
| SafetyImpact | Multiple Lines Text | No | Safety impact description |

### Workflow Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| ApprovalStage | Choice | No | Triage, Committee, Final |
| AssignedReviewer | Person/Group | No | Current reviewer |
| ReviewComments | Multiple Lines Text | No | Reviewer feedback |
| ApprovalDate | Date/Time | No | Date of approval |
| RejectionReason | Multiple Lines Text | No | Reason if rejected |

### Metadata Fields
| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| SubmissionID | Single Line Text | Yes | Unique identifier |
| Department | Single Line Text | No | Nominee's department |
| ServiceLine | Single Line Text | No | Nominee's service line |
| Priority | Choice | No | Low, Medium, High, Urgent |
| Tags | Multiple Lines Text | No | Searchable keywords |

## Choice Field Values

### AwardType Choices
- HeRO Award
- Great Catch
- Starfish Award
- I-CARE Values Award

### Status Choices
- Draft
- Submitted
- In Triage
- Committee Review
- Pending Approval
- Approved
- Rejected
- Closed

### ApprovalStage Choices
- Initial Triage
- Department Review
- Committee Review
- Final Approval
- Closed

### Priority Choices
- Low
- Medium
- High
- Urgent

### ICareValue Choices
- Integrity
- Commitment
- Advocacy
- Respect
- Excellence

## Views

### Default Views
1. **All Nominations** - Shows all submissions
2. **My Submissions** - Filtered to current user's submissions
3. **Pending Review** - Items needing attention
4. **Approved Awards** - Completed approvals
5. **By Award Type** - Grouped by award category

### Committee Views
1. **Triage Queue** - New submissions for initial review
2. **Committee Assignments** - Items assigned to committees
3. **Approval Pending** - Final approval stage
4. **Rejected Items** - Returned nominations

## Permissions

### Permission Levels
- **Read**: All authenticated users (view approved awards)
- **Contribute**: Standard users (create/edit own submissions)
- **Edit**: Managers (edit team submissions)
- **Full Control**: Administrators and committee members

### Security Groups
- **EmployeeRecognition_Users**: Standard submission rights
- **EmployeeRecognition_Managers**: Department review rights
- **EmployeeRecognition_Committee**: Full review and approval rights
- **EmployeeRecognition_Admins**: Administrative rights

## Workflows

### Power Automate Integration
- **On Item Created**: Triggers notification workflow
- **On Item Modified**: Updates approval routing
- **Scheduled Reminders**: Daily review queue notifications

### Business Rules
- Nominations cannot be edited after submission
- Only submitter can modify draft nominations
- Approval stages must be completed in order
- Rejected nominations can be resubmitted with modifications

## Backup and Maintenance

### Regular Tasks
- **Daily**: Export new submissions
- **Weekly**: Cleanup draft items older than 30 days
- **Monthly**: Archive completed nominations older than 12 months
- **Quarterly**: Permission audit and cleanup

### Data Retention
- **Active**: 12 months in primary list
- **Archive**: 7 years in separate archive list
- **Purge**: After 7 years per VA policy

---

**Last Updated**: July 9, 2025
**Maintained By**: VHA Informatics Data Team
