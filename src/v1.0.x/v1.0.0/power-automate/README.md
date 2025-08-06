# Power Automate Flows (v1.0.1 Production Pilot)

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

This folder contains Power Automate flows for the Employee Recognition App v1.0.1 Production Pilot. These flows automate award triage, approvals, notifications, and patient safety event detection, fully integrated with Power Apps and SharePoint.

## Structure

- `.unpacked/` – Unpacked flow source code organized by individual flows
  - `flow_PatientSafetyEvent/` – Patient Safety Event ChatBot flow source files
  - `flow_TriageAndApproval/` – Triage and Approval workflow source files
- `exports/` – Exported flow packages (.zip files for import)
- `syntax-extracts/` – Code snippets and syntax experiments

## Flow Components

### Triage and Approval Flow
- Routes award nominations for approval
- Implements multi-level approval workflows
- Updates SharePoint records based on decisions
- Sends notifications via Teams and Outlook
- Enhanced error handling and triage logic (v1.0.1)

### Patient Safety Event Flow (New in v1.0.1)
- Detects potential patient safety events from nominations
- Initiates Teams-based ChatBot for Joint Patient Safety Reporting
- Notifies safety officers and logs events

### Great Catch Flow
- Handles Great Catch award nominations
- Integrates with SharePoint lists
- Sends notifications via email/Teams

### Combined Workflow
- Unified flow handling multiple award types
- Streamlined approval process
- Enhanced error handling

## Development & Compliance Guidelines

### Naming Conventions
- Actions: Use descriptive names (Get_Employee_Record, Send_Approval_Email)
- Variables: Use camelCase (approvalStatus, employeeEmail)
- Connections: Use environment-specific references

### Best Practices
- Implement proper error handling with try-catch patterns
- Use parallel branches where possible for performance
- Document business logic with comments
- Use compose actions for complex expressions
- Test flows thoroughly in development and pilot environments
- Maintain audit logs for all critical actions (v1.0.1)

## Error Handling & Security
- Always include error handling for external API calls
- Use proper retry policies for transient failures
- Log errors to SharePoint or other monitoring systems
- Secure all connections and sensitive data
- Comply with VA Healthcare and organizational security policies

---
*Last updated: January 28, 2025 for v1.0.1 Production Pilot release.*
