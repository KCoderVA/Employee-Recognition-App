# Copilot Instructions

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

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

## Project Context
This is a Power Platform development workspace for an Employee Recognition application project. The project includes:
- Power Apps canvas applications
- Power Automate flows
- SharePoint lists and pages
- Microsoft Approvals workflows
- Teams and Outlook integrations
- Supporting documentation and assets

## Code Style Guidelines
- Use clear, descriptive variable and function names
- Include comments for complex logic
- Follow consistent indentation and formatting
- Write modular, reusable code

## Preferred Practices
- Use modern language features and best practices
- Include error handling where appropriate
- Write testable code with clear separation of concerns
- Document functions and classes with clear descriptions

## Development Environment
- This workspace is configured for multi-language development
- Prefer cross-platform solutions when possible
- Use relative paths for project files

## Power Platform Specific Guidelines
- Follow Power Platform ALM (Application Lifecycle Management) best practices
- Use consistent naming conventions across all components (PascalCase for apps, camelCase for variables)
- Document all flows with clear descriptions and comments
- Use environment variables and connection references for deployability
- Structure formulas for readability with proper indentation
- Follow the principle of least privilege for permissions and security

## Component Standards
### Power Apps
- Use descriptive control names (btnSubmit, lblTitle, galItems)
- Group related controls in containers
- Use consistent color themes and fonts
- Implement proper error handling with User() and IsError() functions
- Use collections efficiently and avoid excessive delegation warnings

### Power Automate
- Use descriptive action names
- Implement proper error handling with try-catch patterns
- Use parallel branches where possible for performance
- Document business logic with comments
- Use compose actions for complex expressions

### SharePoint
- Follow consistent list and column naming conventions
- Use content types for structured data
- Implement proper permissions and security
- Document list relationships and dependencies

## File Organization
- Separate source files from documentation
- Version control exported solutions
- Maintain clear folder structure for different asset types
- Keep training materials and reference docs organized
