# Power Automate Flows

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

This folder contains Power Automate flows for the Employee Recognition project.

## Structure

- `flows/` - Individual flow source code (when unpacked)
- `exports/` - Exported flow packages (.zip files)
- `syntax-extracts/` - Code snippets and syntax experiments

## Flow Components

### Great Catch Flow
- Handles Great Catch award nominations
- Integrates with SharePoint lists
- Sends notifications via email/Teams

### Triage and Approval Flow
- Routes award nominations for approval
- Implements approval workflows
- Updates SharePoint records based on decisions

### Combined Workflow
- Unified flow handling multiple award types
- Streamlined approval process
- Enhanced error handling

## Development Guidelines

### Naming Conventions
- Actions: Use descriptive names (Get_Employee_Record, Send_Approval_Email)
- Variables: Use camelCase (approvalStatus, employeeEmail)
- Connections: Use environment-specific references

### Best Practices
- Implement proper error handling with try-catch patterns
- Use parallel branches where possible for performance
- Document business logic with comments
- Use compose actions for complex expressions
- Test flows thoroughly in development environment

## Error Handling
- Always include error handling for external API calls
- Use proper retry policies for transient failures
- Log errors to SharePoint or other monitoring systems
