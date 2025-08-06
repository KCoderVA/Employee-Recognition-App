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

This folder contains the unpacked source files for the **Triage and Approval Flow**, which automates the routing, review, and approval process for employee recognition nominations across multiple award types (HeRO, Great Catch, Starfish, I CARE).

## Folder Contents

| File | Description |
|------|-------------|
| `TriageAndApproval_definition.json` | **Core flow logic** - Complete workflow definition with multi-level approval routing |
| `TriageAndApproval_connections.json` | **Connection mappings** - Maps flow connections to SharePoint, Teams, and Outlook |
| `TriageAndApproval_apis.json` | **API mappings** - References to external APIs and services |
| `TriageAndApproval_manifest.json` | **Flow metadata** - Flow properties, dependencies, and configuration settings |

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
