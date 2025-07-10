# Power Apps Components

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

This folder contains the Power Apps canvas application source code and exports for the Employee Recognition project.

## Structure

- `EmployeeRecognitionApp_Unpacked/` - Unpacked source code from Power Apps
- `app_Variables_and_Collections.yml` - Application variables and collections configuration
- `*.zip` - Exported Power Apps packages for different versions

## Development Guidelines

### Naming Conventions
- Controls: Use descriptive names (btnSubmit, lblTitle, galItems)
- Variables: Use camelCase (currentUser, selectedRecord)
- Collections: Use PascalCase (EmployeeCollection, AwardTypes)

### Best Practices
- Group related controls in containers
- Use consistent color themes and fonts
- Implement proper error handling with User() and IsError() functions
- Use collections efficiently and avoid excessive delegation warnings
- Structure formulas for readability with proper indentation

## File Descriptions

### app_Variables_and_Collections.yml
Contains the configuration for:
- Global variables used across the app
- Collections and their structure
- Default values and initialization logic

## Version Control
- Keep unpacked source code in version control
- Tag major releases
- Document changes in commit messages
