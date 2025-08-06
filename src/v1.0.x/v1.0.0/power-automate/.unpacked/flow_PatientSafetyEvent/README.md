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

This folder contains the unpacked source files for the **Patient Safety Event ChatBot Flow**, which automatically detects potential patient safety events from employee recognition submissions and prompts users to report them through the Joint Patient Safety Reporting (JPSR) system.

## Folder Contents

| File | Description |
|------|-------------|
| `PatientSafetyEvent_definition.json` | **Core flow logic** - Complete workflow definition with triggers, actions, and conditions |
| `PatientSafetyEvent_connections.json` | **Connection mappings** - Maps flow connections to specific SharePoint sites and Teams channels |
| `PatientSafetyEvent_apis.json` | **API mappings** - References to external APIs (SharePoint, Teams, etc.) |
| `PatientSafetyEvent_manifest.json` | **Flow metadata** - Flow properties, dependencies, and configuration settings |

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
