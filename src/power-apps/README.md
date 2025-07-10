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

- `EmployeeRecognitionApp_v0.9.0/` - **ACTIVE DEVELOPMENT** - Latest source code for editing
- `EmployeeRecognitionApp_Unpacked/` - Legacy unpacked source code
- `app_Variables_and_Collections.yml` - Application variables and collections configuration
- `*.zip` - Exported Power Apps packages for different versions

## Web-Based Development Workflow

### 🌐 **Power Apps Web Editor Only**
Since desktop Power Apps Studio is restricted, all development uses the web-based workflow:

1. **Source Code Development** (VS Code)
   - Edit `.fx.yaml` files in `EmployeeRecognitionApp_v0.9.0/Source/Src/`
   - Use version control for all changes

2. **Packaging** (Command Line)
   - Pack source to `.msapp` using Power Platform CLI
   - Use VS Code task: `📦 Package Power App v0.9.0 (Source Control)`

3. **Import to Web** (https://make.powerapps.com)
   - Upload `.msapp` file manually through web interface
   - Test and refine in web editor

4. **Export from Web** (when ready)
   - Download updated `.msapp` from web editor
   - Unpack to source control for continued development

### 🔄 **Development Cycle**
```
Edit YAML → Pack → Upload → Test in Web → Export → Unpack → Repeat
```

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
