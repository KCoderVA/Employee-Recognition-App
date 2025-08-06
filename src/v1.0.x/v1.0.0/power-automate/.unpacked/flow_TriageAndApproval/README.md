# Triage and Approval Flow (v1.0.1)

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

This folder contains the unpacked source files for the **Triage and Approval Workflow** from the Employee Recognition App v1.0.1. This flow manages the complete approval process for employee recognition submissions, including routing, multi-level approvals, notifications, and final processing.

## Flow Source Files

### Core Files
- **`TriageAndApproval_definition.json`** – Complete flow definition with all triggers, actions, and approval logic
- **`TriageAndApproval_connections.json`** – Connection mappings for SharePoint, Outlook, Teams, and Approvals
- **`TriageAndApproval_apis.json`** – API connector mappings and references
- **`TriageAndApproval_manifest.json`** – Flow metadata, properties, and configuration

## What This Flow Does

### Primary Functions
1. **Award Triage** – Automatically categorizes and routes recognition submissions by award type
2. **Multi-Level Approvals** – Implements hierarchical approval workflows for different award categories
3. **Notification Management** – Sends emails and Teams messages to stakeholders throughout the process
4. **Status Tracking** – Updates SharePoint records with approval status and decision history
5. **Final Processing** – Handles approved awards and routes to appropriate fulfillment teams

### Award Types Supported
- **HeRO Awards** – Heroes of Recovery and Outreach recognition
- **Great Catch Awards** – Safety and quality improvement recognition
- **Starfish Awards** – Peer-to-peer appreciation and teamwork recognition
- **I CARE Awards** – Integrity, Commitment, Advocacy, Respect, Excellence values-based recognition

### Business Logic Flow
1. **Trigger** – Activates when new items are created in the Employee Recognition SharePoint list
2. **Initial Triage** – Categorizes submission by award type and determines routing path
3. **Data Validation** – Verifies required fields and submission completeness
4. **Approval Routing** – Routes to appropriate approvers based on:
   - Award type and value
   - Organizational hierarchy
   - Department-specific requirements
   - Special handling criteria
5. **Approval Processing** – Manages approval responses and decision logic
6. **Notification System** – Sends status updates to submitters and stakeholders
7. **Final Actions** – Processes approved awards and updates all relevant systems

## How to Use These Source Files

### Option 1: Import Complete Flow Package
The recommended approach is to use the packaged flow export from the `../exports/` directory:
1. Go to Power Automate → My Flows → Import
2. Select the Triage and Approval flow package (.zip file)
3. Follow the import wizard to configure connections and environment variables
4. Set up approval connections and user mappings

### Option 2: Manual Recreation from Source
If you need to recreate the flow manually or customize its behavior:

1. **Review the Definition** – Open `TriageAndApproval_definition.json` to understand:
   - Trigger configuration (SharePoint list monitoring)
   - Triage logic and award type detection
   - Approval workflow sequences and conditional routing
   - Notification templates and recipient logic
   - Error handling and retry mechanisms

2. **Understand Connections** – Check `TriageAndApproval_connections.json` for:
   - SharePoint Online connection requirements
   - Microsoft Approvals service configuration
   - Outlook/Exchange connection for email notifications
   - Teams connection for chat notifications

3. **API Dependencies** – Review `TriageAndApproval_apis.json` for:
   - Required API connectors (SharePoint, Approvals, Outlook, Teams)
   - API operation IDs and parameters
   - Custom connector requirements (if any)

4. **Configuration Requirements** – Examine `TriageAndApproval_manifest.json` for:
   - Flow metadata and properties
   - Publisher information and versioning
   - Environment-specific configurations

### Manual Flow Creation Steps

#### 1. Create New Flow and Configure Trigger
- **New automated cloud flow** in Power Automate
- **SharePoint trigger**: "When an item is created"
- Configure for your Employee Recognition SharePoint list

#### 2. Set Up Initial Variables
```
- awardType (String) – Detected award category
- approvalLevel (Integer) – Current approval level
- approverEmail (String) – Current approver email address
- submissionStatus (String) – Current processing status
```

#### 3. Add Triage Logic
- **Condition actions** to detect award type from submission fields
- **Switch statements** for award-specific routing
- **Compose actions** for data transformation and validation

#### 4. Configure Approval Workflows
- **Microsoft Approvals** actions for formal approval requests
- **Parallel branches** for multiple approvers when required
- **Timeout handling** for approval delays
- **Escalation logic** for overdue approvals

#### 5. Set Up Notification System
- **Email actions** for formal notifications
- **Teams messages** for instant updates
- **Dynamic content** for personalized messages
- **HTML formatting** for professional appearance

#### 6. Implement Status Tracking
- **SharePoint updates** for status changes
- **History logging** for audit trails
- **Dashboard updates** for management reporting

#### 7. Add Error Handling
- **Try-catch blocks** for external service calls
- **Retry policies** for transient failures
- **Error notifications** to administrators
- **Graceful degradation** for service outages

## Environment Configuration

### Required Connections
- **SharePoint Online** – Access to Employee Recognition site and lists
- **Microsoft Approvals** – Approval workflow processing
- **Office 365 Outlook** – Email notifications
- **Microsoft Teams** – Instant messaging and chat notifications

### Required Permissions
- SharePoint list read/write access
- Approval creation and management permissions
- Email sending permissions
- Teams posting permissions
- User profile access for approver lookup

### Environment Variables
Configure these in your Power Platform environment:

#### SharePoint Configuration
- Employee Recognition site URL
- Recognition submissions list GUID
- Approval history list GUID
- User profile list (if used for approver lookup)

#### Approval Configuration
- Approval timeout periods by award type
- Escalation rules and timelines
- Approval delegation settings
- Holiday/absence handling rules

#### Notification Configuration
- Email templates and formatting
- Teams channel IDs for notifications
- Distribution lists for different award types
- Executive notification thresholds

## Award-Specific Routing Logic

### HeRO Awards
- **Level 1**: Department supervisor approval
- **Level 2**: Service chief approval
- **Level 3**: Executive leadership approval (for high-value awards)
- **Notifications**: HR, Public Affairs, submitter

### Great Catch Awards
- **Level 1**: Safety officer review
- **Level 2**: Department head approval
- **Level 3**: Quality improvement committee (if system-wide impact)
- **Notifications**: Patient Safety team, Quality department

### Starfish Awards
- **Level 1**: Immediate supervisor approval
- **Level 2**: Department head (for monetary awards)
- **Notifications**: HR, submitter, recipient

### I CARE Awards
- **Level 1**: Values committee review
- **Level 2**: Service line director approval
- **Level 3**: Chief of Staff (for facility-wide recognition)
- **Notifications**: Leadership team, Communications office

## Testing and Validation

### Test Scenarios
1. **Award Type Detection** – Submit different award types and verify correct routing
2. **Approval Workflows** – Test each approval level and decision path
3. **Notification Delivery** – Verify all stakeholders receive appropriate communications
4. **Status Updates** – Confirm SharePoint records are updated correctly
5. **Error Handling** – Test failure scenarios and recovery mechanisms
6. **Timeout Handling** – Verify escalation and reminder systems
7. **Bulk Processing** – Test multiple simultaneous submissions

### Validation Points
- Correct approvers are identified and notified
- Approval requests contain all necessary information
- Status updates are timely and accurate
- Email templates render correctly
- Teams notifications are properly formatted
- SharePoint data integrity is maintained
- Audit trails are complete and accessible

## Performance Optimization

### Best Practices
- **Parallel Processing** – Use parallel branches for independent operations
- **Efficient Queries** – Optimize SharePoint list operations
- **Connection Pooling** – Reuse connections where possible
- **Conditional Logic** – Minimize unnecessary actions with proper conditions
- **Bulk Operations** – Use batch operations for multiple updates

### Monitoring
- Flow run analytics and performance metrics
- Approval processing times by award type
- Notification delivery success rates
- Error rates and failure patterns
- User satisfaction with approval experience

## Troubleshooting

### Common Issues
- **Approval Delays** – Check approver availability and delegation settings
- **Notification Failures** – Verify email addresses and Teams permissions
- **Permission Errors** – Ensure service account has proper SharePoint access
- **Timeout Issues** – Review approval timeout configurations
- **Data Inconsistencies** – Check SharePoint list field mappings

### Monitoring and Diagnostics
- Flow run history with detailed execution logs
- SharePoint list audit trails
- Email delivery confirmations
- Teams message status
- Approval service logs and analytics

### Support Escalation
- Level 1: Flow administrator review and basic troubleshooting
- Level 2: Power Platform administrator involvement
- Level 3: Microsoft support for platform-level issues

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For comprehensive documentation and support, visit the main project repository.*

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

This folder contains the unpacked source files for the **Triage and Approval Flow**, which automates the routing, review, and approval process for employee recognition nominations across multiple award types (HeRO, Great Catch, Starfish, I CARE).

## Folder Contents

| File                                 | Description                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------------ |
| `TriageAndApproval_definition.json`  | **Core flow logic** - Complete workflow definition with multi-level approval routing |
| `TriageAndApproval_connections.json` | **Connection mappings** - Maps flow connections to SharePoint, Teams, and Outlook    |
| `TriageAndApproval_apis.json`        | **API mappings** - References to external APIs and services                          |
| `TriageAndApproval_manifest.json`    | **Flow metadata** - Flow properties, dependencies, and configuration settings        |

## Flow Functionality

### Primary Purpose
- **Automated Triage**: Intelligently routes award nominations based on type and criteria
- **Multi-Level Approvals**: Implements cascading approval workflows for different award types
- **Notification Management**: Sends notifications via Teams, Outlook, and SharePoint
- **Status Tracking**: Updates submission status throughout the approval process

### Key Features
- **Smart Routing**: Routes nominations to appropriate reviewers based on award type
- **Parallel Processing**: Handles multiple nominations simultaneously
- **Approval Workflows**: Implements Microsoft Approvals for executive-level decisions
- **Audit Trails**: Maintains complete history of approval decisions and actions

## Award Types Supported

### HeRO Awards
- Executive-level approval required
- Multi-step review process
- Special notification requirements

### Great Catch Awards
- Department-level approval
- Safety-focused evaluation criteria
- Integration with patient safety systems

### Starfish Awards
- Peer recognition workflow
- Simplified approval process
- Team-based notifications

### I CARE Awards
- Values-based recognition
- Department manager approval
- Organizational culture focus

## Using These Source Files

### For Analysis & Customization
1. **Review Flow Logic**: Open `TriageAndApproval_definition.json` to understand the complete workflow
2. **Understand Routing**: Check the conditional logic for award type routing
3. **Approval Mappings**: Review approval assignments and escalation paths
4. **Notification Settings**: Examine Teams and Outlook integration points

### For Import Into Your Environment

#### Option 1: Manual Recreation
1. Create a new Power Automate flow
2. Use the `definition.json` as a reference to recreate the approval logic
3. Configure approval assignments for your organization
4. Update connection references and test thoroughly

#### Option 2: Package-Based Import
To import this flow into your Power Platform environment:

1. **Repackage the Flow**:
   ```powershell
   # Use Power Platform CLI to package the source files
   pac solution add-reference --path "src/Microsoft.Flow/flows/[flow-id]"
   pac solution export --path "./exports/TriageAndApproval.zip"
   ```

2. **Environment Preparation**:
   - Update connection references in `connections.json`
   - Modify SharePoint site URLs and list IDs
   - Configure approval assignments for your organization
   - Update Teams channels and notification recipients

3. **Import Process**:
   - Go to Power Automate > My Flows > Import
   - Upload the packaged .zip file
   - Reconnect all connections during import
   - Configure approvers and notification settings

#### Required Environment Setup
Before importing, ensure your environment has:
- **SharePoint Online**: Lists for employee recognition data and approval tracking
- **Microsoft Approvals**: Service for handling approval workflows
- **Microsoft Teams**: Integration for notifications and collaboration
- **Outlook**: Email notification capabilities
- **Power Automate Premium**: Required for complex workflows and approvals

### Customization Guidelines

#### Approval Configuration
- **Approver Assignments**: Update approver mappings in the definition.json
- **Escalation Rules**: Modify timeout and escalation logic as needed
- **Award Criteria**: Adjust routing conditions based on your organization's criteria
- **Notification Templates**: Customize email and Teams message templates

#### Business Logic Modifications
- **Routing Rules**: Update conditional logic for award type routing
- **Approval Thresholds**: Modify approval requirements and criteria
- **Timeout Settings**: Adjust wait times and escalation triggers
- **Status Updates**: Customize SharePoint field updates and tracking

#### Integration Points
- **SharePoint Lists**: Update list references and field mappings
- **Teams Channels**: Configure appropriate notification channels
- **Outlook Integration**: Set up email templates and distribution lists
- **External Systems**: Add integrations to HR or other organizational systems

## Development Notes

### Flow Architecture
- **Trigger-Based**: Activated by SharePoint list item creation or modification
- **Conditional Routing**: Uses complex branching based on award types and criteria
- **Parallel Processing**: Implements parallel branches for efficiency
- **Error Handling**: Comprehensive error management with retry logic

### Technical Dependencies
- **SharePoint Lists**: Award nomination data storage and tracking
- **Microsoft Approvals**: Core approval workflow engine
- **Microsoft Teams**: Real-time notifications and collaboration
- **Outlook**: Email notifications and communication
- **Power Platform**: Core automation and workflow infrastructure

### Performance Considerations
- **Parallel Branches**: Used to optimize processing time
- **Delegation**: Ensures efficient data operations with large datasets
- **Caching**: Implements compose actions for complex expressions
- **Retry Logic**: Built-in resilience for external service calls

## Troubleshooting

### Common Issues
- **Connection Failures**: Verify all connections are properly authenticated
- **Approval Delays**: Check approver assignments and availability
- **Notification Problems**: Validate Teams and Outlook integration settings
- **Data Sync Issues**: Ensure SharePoint list permissions are correct

### Monitoring & Maintenance
- **Flow History**: Monitor run history for errors and performance
- **Connection Health**: Regularly check connection status
- **Approver Updates**: Maintain current approver assignments
- **Performance Metrics**: Track approval times and bottlenecks

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For support or questions, visit the [GitHub repository](https://github.com/KCoderVA/Employee-Recognition-App) or contact the development team.*
