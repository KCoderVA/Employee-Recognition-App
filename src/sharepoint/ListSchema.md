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

# SharePoint List Schema

## Employee Recognition List

This SharePoint list serves as the primary data storage for employee recognitions and awards.

### List Structure

| Column Name | Type | Required | Description |
|------------|------|----------|-------------|
| Title | Single line of text | Yes | Recognition title/subject |
| EmployeeName | Person or Group | Yes | Employee being recognized |
| EmployeeEmail | Single line of text | Yes | Employee's email address |
| NominatorName | Person or Group | Yes | Person submitting the recognition |
| NominatorEmail | Single line of text | Yes | Nominator's email address |
| RecognitionType | Choice | Yes | Type of recognition (Exceptional Service, Team Player, Innovation, Leadership, Customer Service) |
| AwardLevel | Choice | Yes | Award level (Spot Award, Outstanding Performance, Excellence Award) |
| Description | Multiple lines of text | Yes | Detailed description of the recognition |
| Justification | Multiple lines of text | Yes | Why the employee deserves this recognition |
| DateOfAction | Date and Time | Yes | Date when the recognized action occurred |
| Department | Choice | No | Employee's department |
| ServiceLine | Choice | No | Service line/division |
| Supervisor | Person or Group | No | Employee's immediate supervisor |
| ApprovalStatus | Choice | Yes | Approval workflow status (Pending, Approved, Rejected, More Info Needed) |
| ApproverComments | Multiple lines of text | No | Comments from approvers |
| Level1Approver | Person or Group | No | First level approver |
| Level1ApprovalDate | Date and Time | No | Date of first approval |
| Level2Approver | Person or Group | No | Second level approver |
| Level2ApprovalDate | Date and Time | No | Date of second approval |
| AwardAmount | Currency | No | Monetary award amount if applicable |
| AwardDeliveryStatus | Choice | No | Status of award delivery (Pending, Delivered, Completed) |
| NotificationSent | Yes/No | No | Whether notification has been sent |
| FollowUpRequired | Yes/No | No | Whether follow-up is required |
| FollowUpDate | Date and Time | No | Scheduled follow-up date |
| CompletionDate | Date and Time | No | Date when recognition was fully processed |
| Notes | Multiple lines of text | No | Additional notes or comments |

### Choice Field Options

**RecognitionType:**
- Exceptional Service
- Team Player
- Innovation and Creativity
- Leadership Excellence
- Customer Service Excellence
- Going Above and Beyond
- Continuous Improvement

**AwardLevel:**
- Spot Award ($25-$100)
- Outstanding Performance Award ($100-$250)
- Excellence Award ($250-$500)
- Special Recognition (Non-monetary)

**ApprovalStatus:**
- Draft
- Pending Review
- Level 1 Approved
- Level 2 Approved
- Approved
- Rejected
- More Information Needed
- Withdrawn

**Department:**
- Administration
- Clinical Services
- Emergency Services
- Nursing
- Pharmacy
- Laboratory
- Radiology
- Support Services
- IT Services
- Human Resources
- Finance

**AwardDeliveryStatus:**
- Pending
- Approved for Processing
- In Process
- Delivered
- Completed

### Permissions

- **All Staff**: Read access to view approved recognitions
- **Nominators**: Create new recognition submissions
- **Supervisors**: Read and edit items for their team members
- **Approvers**: Read and approve items assigned to them
- **HR Administrators**: Full control

### Views

1. **All Items** - Default view showing all recognitions
2. **My Nominations** - Filtered view for current user's submissions
3. **Pending Approvals** - Items awaiting approval
4. **Approved This Month** - Recently approved recognitions
5. **By Department** - Grouped by department
6. **By Award Level** - Grouped by award level
7. **Delivery Pending** - Awards awaiting delivery

### List Settings

- Enable versioning (major versions only)
- Content approval: Required
- Enable attachments: Yes (for supporting documentation)
- Require checkout: No

