# Patient Safety Event Flow (v1.0.1)

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

This folder contains the unpacked source files for the **Patient Safety Event ChatBot Flow** from the Employee Recognition App v1.0.1. This flow detects potential patient safety events from employee recognition submissions and initiates an interactive Teams-based ChatBot to guide users through the Joint Patient Safety Reporting (JPSR) system.

## Flow Source Files

### Core Files
- **`PatientSafetyEvent_definition.json`** – Complete flow definition with all triggers, actions, and business logic
- **`PatientSafetyEvent_connections.json`** – Connection mappings for SharePoint Online and Microsoft Teams
- **`PatientSafetyEvent_apis.json`** – API connector mappings and references
- **`PatientSafetyEvent_manifest.json`** – Flow metadata, properties, and configuration

## What This Flow Does

### Primary Functions
1. **Safety Event Detection** – Monitors SharePoint list for new employee recognition submissions
2. **Automated ChatBot Interaction** – Sends Teams messages to submitters about potential safety events
3. **JPSR Integration Guidance** – Guides users through the Joint Patient Safety Reporting process
4. **Audit Trail Management** – Updates SharePoint records based on user responses
5. **Multi-Level Reminders** – Implements progressive reminder system for non-responsive users

### Business Logic Flow
1. Triggers when new items are created in the Employee Recognition SharePoint list
2. Delays 15 seconds to allow item creation to complete
3. Retrieves refreshed item information from SharePoint
4. Sends initial "Thank You" message to submitter via Teams
5. Checks the `SafetyBoolean` field to determine safety-related responses:
   - **"No"** – Sends reminder about optional JPSR reporting
   - **"Yes"** – Initiates interactive ChatBot with response options
   - **"Unsure"** – Provides guidance and prompts for JPSR submission
6. For safety-related events, presents three response options:
   - "Yes, I have already submitted the event to JPSR!"
   - "No, I will submit this event to JPSR now!"
   - "My event was actually NOT RELATED TO PATIENT SAFETY!"
7. Implements retry logic with up to 7 reminder attempts
8. Updates SharePoint records based on user responses

## How to Use These Source Files

### Option 1: Import Complete Flow Package
The recommended approach is to use the packaged flow export from the `../exports/` directory:
1. Go to Power Automate → My Flows → Import
2. Select the Patient Safety Event flow package (.zip file)
3. Follow the import wizard to configure connections and environment variables

### Option 2: Manual Recreation from Source
If you need to recreate the flow manually or understand its structure:

1. **Review the Definition** – Open `PatientSafetyEvent_definition.json` to understand:
   - Trigger configuration (SharePoint list monitoring)
   - Action sequences and conditional logic
   - Variable initialization and manipulation
   - Teams integration and ChatBot responses

2. **Understand Connections** – Check `PatientSafetyEvent_connections.json` for:
   - SharePoint Online connection requirements
   - Microsoft Teams connection configuration
   - Connection reference names and IDs

3. **API Dependencies** – Review `PatientSafetyEvent_apis.json` for:
   - Required API connectors (SharePoint Online, Teams)
   - API operation IDs and parameters

4. **Configuration Requirements** – Examine `PatientSafetyEvent_manifest.json` for:
   - Flow metadata and properties
   - Publisher information and versioning
   - Environment-specific configurations

### Manual Flow Creation Steps
1. **Create New Flow** in Power Automate
2. **Configure SharePoint Trigger**:
   - Site: Your Employee Recognition SharePoint site
   - List: Employee Recognition submissions list
   - Trigger: "When an item is created"
3. **Set Up Variables**:
   - `reminderCount_FlowVariable` (Integer, initial value: 1)
4. **Add Actions** following the sequence in the definition file:
   - Delay actions for timing control
   - SharePoint "Get item" operations
   - Teams message posting actions
   - Conditional logic for safety responses
   - Do-Until loops for reminder systems
5. **Configure Teams Integration**:
   - Teams connection for ChatBot responses
   - User message with options for interactive responses
   - Response handling and routing logic
6. **Set Up SharePoint Updates**:
   - Item update operations based on user responses
   - Field mapping for safety boolean updates

## Environment Configuration

### Required Connections
- **SharePoint Online** – Access to Employee Recognition site and lists
- **Microsoft Teams** – ChatBot message posting and interactive responses

### Required Permissions
- SharePoint list read/write access
- Teams chat posting permissions
- Access to user email addresses for message routing

### Environment Variables
Configure these in your Power Platform environment:
- SharePoint site URL for Employee Recognition app
- SharePoint list GUID for recognition submissions
- Teams notification recipients (admin/safety officers)
- JPSR system URL for patient safety reporting

## Testing and Validation

### Test Scenarios
1. **Safety Event: "No"** – Verify reminder message about optional JPSR reporting
2. **Safety Event: "Yes"** – Test full ChatBot interaction with all response options
3. **Safety Event: "Unsure"** – Validate guidance and prompting logic
4. **Non-Responsive Users** – Test reminder system up to 7 attempts
5. **Response Processing** – Verify SharePoint updates based on user selections

### Validation Points
- Teams messages are properly formatted and delivered
- ChatBot options are presented correctly
- User responses are captured and processed accurately
- SharePoint updates reflect user choices correctly
- Error handling works for failed operations
- Audit trails are maintained throughout the process

## Troubleshooting

### Common Issues
- **Connection Failures** – Verify SharePoint and Teams connections are active
- **Permission Errors** – Ensure service account has proper SharePoint and Teams permissions
- **Message Delivery** – Check Teams policies and user availability
- **Timeout Issues** – Review Do-Until loop configurations and timeouts

### Monitoring and Logs
- Flow run history in Power Automate
- SharePoint list changes and audit logs
- Teams message delivery confirmations
- Error logs and failure notifications

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For support and documentation, visit the main project repository.*

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

This folder contains the unpacked source files for the **Patient Safety Event ChatBot Flow**, which automatically detects potential patient safety events from employee recognition submissions and prompts users to report them through the Joint Patient Safety Reporting (JPSR) system.

## Folder Contents

| File                                  | Description                                                                                     |
| ------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `PatientSafetyEvent_definition.json`  | **Core flow logic** - Complete workflow definition with triggers, actions, and conditions       |
| `PatientSafetyEvent_connections.json` | **Connection mappings** - Maps flow connections to specific SharePoint sites and Teams channels |
| `PatientSafetyEvent_apis.json`        | **API mappings** - References to external APIs (SharePoint, Teams, etc.)                        |
| `PatientSafetyEvent_manifest.json`    | **Flow metadata** - Flow properties, dependencies, and configuration settings                   |

## Flow Functionality

### Primary Purpose
- **Automated Safety Detection**: Monitors employee recognition submissions for potential patient safety events
- **Interactive ChatBot**: Engages users via Microsoft Teams to gather additional safety information
- **JPSR Integration**: Prompts users to submit events to the Joint Patient Safety Reporting system
- **Compliance Tracking**: Updates SharePoint records to reflect safety reporting status

### Key Features
- **Smart Triggers**: Activates when new recognition submissions indicate safety concerns
- **Multi-Option ChatBot**: Provides users with choices for how they want to handle safety reporting
- **Retry Logic**: Implements timeout and retry mechanisms for user responses
- **Error Handling**: Comprehensive error management with notifications to administrators

## Using These Source Files

### For Analysis & Customization
1. **Review Flow Logic**: Open `PatientSafetyEvent_definition.json` to understand the complete workflow
2. **Understand Connections**: Check `PatientSafetyEvent_connections.json` to see SharePoint and Teams integrations
3. **API Dependencies**: Review `PatientSafetyEvent_apis.json` for external service requirements
4. **Configuration**: Examine `PatientSafetyEvent_manifest.json` for flow properties and settings

### For Import Into Your Environment

#### Option 1: Manual Recreation
1. Create a new Power Automate flow
2. Use the `definition.json` as a reference to recreate triggers and actions
3. Update connection references to match your environment
4. Test thoroughly before deploying

#### Option 2: Package-Based Import
To import this flow into your Power Platform environment, you'll need to:

1. **Repackage the Flow**:
   ```powershell
   # Use Power Platform CLI to package the source files back into a .zip
   pac solution add-reference --path "src/Microsoft.Flow/flows/[flow-id]"
   pac solution export --path "./exports/PatientSafetyEvent.zip"
   ```

2. **Prepare for Import**:
   - Update connection references in `connections.json` to match your environment
   - Modify SharePoint site URLs and list IDs as needed
   - Update Teams channel references and user emails

3. **Import Process**:
   - Go to Power Automate > My Flows > Import
   - Upload the packaged .zip file
   - Reconnect all connections during import
   - Update environment variables and connection references

#### Required Environment Setup
Before importing, ensure your environment has:
- **SharePoint Online**: Lists for employee recognition data storage
- **Microsoft Teams**: Access for ChatBot functionality
- **Power Automate Premium**: Required for complex workflows and connectors
- **Appropriate Permissions**: Flow creator needs access to SharePoint and Teams

### Customization Guidelines

#### Common Modifications
- **SharePoint URLs**: Update dataset references in the definition.json
- **Teams Channels**: Modify recipient references for ChatBot interactions
- **Business Logic**: Adjust conditions and branching logic as needed
- **Timeout Values**: Modify wait actions and timeout periods

#### Security Considerations
- **Connection Security**: Ensure all connections use appropriate authentication
- **Data Privacy**: Review data handling practices for sensitive information
- **Audit Requirements**: Maintain audit trails as required by your organization
- **VA Compliance**: If using in VA environments, ensure compliance with VA security policies

## Development Notes

### Flow Architecture
- **Event-Driven**: Triggered by SharePoint list item creation
- **Conditional Logic**: Uses complex branching based on safety indicators
- **User Interaction**: Implements Microsoft Teams adaptive cards for user responses
- **Data Updates**: Modifies SharePoint records based on user feedback

### Technical Dependencies
- **SharePoint Lists**: Employee recognition data storage
- **Microsoft Teams**: ChatBot messaging and user interaction
- **Power Platform**: Core automation and workflow engine
- **VA Security**: Compliance with government security requirements

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For support or questions, visit the [GitHub repository](https://github.com/KCoderVA/Employee-Recognition-App) or contact the development team.*
