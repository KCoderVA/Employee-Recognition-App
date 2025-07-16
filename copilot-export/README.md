# Copilot Instructions Export Package

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

This package contains a complete exportable/importable set of GitHub Copilot instructions and supporting automation scripts that can be easily transferred to other VS Code workspace projects.

## 📦 Package Contents

### 🤖 Core Copilot Configuration
- **`.github/copilot-instructions.md`** - Complete Copilot instructions with quick command triggers and autonomous protocols

### 💻 PowerShell Automation Scripts
- **`scripts/workspace-cleanup.ps1`** - Automated workspace organization with safety protection patterns
- **`scripts/repo-health-check.ps1`** - Comprehensive repository health validation and status reporting
- **`scripts/validate-changelog.ps1`** - Advanced CHANGELOG format validation with fixing capabilities
- **`scripts/safe-commit.ps1`** - Commit process with automatic CHANGELOG and health checks
- **`scripts/prepare-release.ps1`** - Interactive release preparation with version management
- **`scripts/update-changelog.ps1`** - Interactive CHANGELOG.md update with enhanced prompts
- **`scripts/pre-commit-hook.ps1`** - Standard Git pre-commit validation
- **`scripts/pre-commit-safety-hook.ps1`** - Enhanced pre-commit hook with critical file protection verification
- **`scripts/powerapps-web.ps1`** - Interactive web development workflow commands (Power Platform specific)
- **`scripts/PowerPlatformUtils.psm1`** - PowerShell module with Power Platform utilities

### 🔧 VS Code Tasks
- **`.vscode/tasks.json`** - Core VS Code tasks that integrate with Copilot commands:
  - Power Platform packaging and unpacking tasks
  - Project management and reporting tasks
  - Git and repository health tasks
  - CHANGELOG and release management tasks
  - Workspace cleanup and safety tasks

### 🔄 GitHub Workflows
- **`.github/workflows/changelog-enforcement.yml`** - Enforces CHANGELOG updates on pull requests and commits
- **`.github/workflows/changelog-validation.yml`** - Validates CHANGELOG format and compliance
- **`.github/workflows/repository-health.yml`** - Continuous integration health checks for repository

## 🚀 Installation Instructions

### Option 1: Complete Import (Recommended)
Copy all files to your target workspace, maintaining the folder structure:

```powershell
# Navigate to your target workspace root
cd "C:\Path\To\Your\Target\Workspace"

# Copy entire copilot-export folder contents
Copy-Item "C:\Path\To\copilot-export\*" -Destination "." -Recurse -Force
```

### Option 2: Selective Import
Copy only specific components you need:

#### For Copilot Instructions Only:
```powershell
# Copy just the copilot instructions
Copy-Item "copilot-export\.github\copilot-instructions.md" ".github\" -Force
```

#### For Core Automation:
```powershell
# Copy scripts and VS Code tasks
Copy-Item "copilot-export\scripts\*" "scripts\" -Recurse -Force
Copy-Item "copilot-export\.vscode\tasks.json" ".vscode\" -Force
```

#### For CI/CD Workflows:
```powershell
# Copy GitHub workflows
Copy-Item "copilot-export\.github\workflows\*" ".github\workflows\" -Recurse -Force
```

## ⚙️ Configuration Requirements

### Prerequisites
1. **PowerShell 7+** (pwsh) - Required for all automation scripts
2. **Git** - Required for repository health checks and safe commit functionality
3. **VS Code** with GitHub Copilot extension
4. **Power Platform CLI** (if using Power Platform tasks) - Install with: `winget install Microsoft.PowerPlatformCLI`

### Environment Setup
1. Ensure PowerShell execution policy allows script execution:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

2. Create required folder structure in your target workspace:
   ```
   your-workspace/
   ├── .github/
   ├── .vscode/
   ├── scripts/
   ├── src/
   ├── docs/
   ├── archive/
   └── releases/
   ```

### First-Time Setup Steps
1. **Import the package** using one of the installation options above
2. **Customize the copilot-instructions.md** file to match your project specifics:
   - Update project architecture descriptions
   - Modify file paths to match your project structure
   - Adjust naming conventions and standards
   - Update any project-specific URLs or references
3. **Test the VS Code tasks**:
   ```
   Ctrl+Shift+P → "Tasks: Run Task" → Select a task to test
   ```
4. **Verify PowerShell scripts** work in your environment:
   ```powershell
   # Test repository health check
   .\scripts\repo-health-check.ps1 -Detailed
   ```

## 🔧 Customization Guide

### Adapting for Your Project Type

#### For Non-Power Platform Projects:
1. Remove or modify Power Platform specific tasks in `.vscode/tasks.json`
2. Update file paths in `scripts/powerapps-web.ps1` or remove if not needed
3. Adjust project architecture section in `copilot-instructions.md`

#### For Different Technology Stacks:
1. **Replace Power Platform CLI commands** with your stack's build tools
2. **Update naming conventions** in copilot-instructions.md
3. **Modify file organization patterns** to match your project structure
4. **Adjust code standards** section for your languages/frameworks

#### For Different Repository Structures:
1. **Update file paths** in all scripts and tasks
2. **Modify folder organization** patterns in workspace-cleanup.ps1
3. **Adjust backup commands** in VS Code tasks to target your key folders

### Quick Command Triggers Customization
The copilot instructions include these default triggers:
- **"Clean workspace"** → Executes comprehensive workspace cleanup
- **"Health check"** → Runs repository health analysis
- **"Organize files"** → Reorganizes files to logical locations
- **"Fix workspace"** → Analyzes and fixes workspace organization

You can add your own triggers by following this pattern in `copilot-instructions.md`:
```markdown
### **🎯 Your Custom Commands**
When the user types any of these short commands, automatically execute your custom workflow:

- **"Your trigger"** - Description of what happens
- **"Another trigger"** - Execute specific tasks

**Actions Include:**
1. Run specific VS Code task
2. Execute custom script
3. Perform validation checks
4. Generate reports
```

## 🛡️ Safety Features

The automation includes multiple safety layers:

### File Protection
- **Critical file patterns** that are never deleted during cleanup
- **Multi-layer protection checks** before any file operations
- **Dry-run modes** for testing changes before execution

### Git Safety
- **Pre-commit hooks** that validate changes before commits
- **CHANGELOG enforcement** to ensure all changes are documented
- **Repository health checks** to catch issues early

### Error Recovery
- **Autonomous error handling** that automatically retries failed operations
- **Content filter bypass** protocols for Copilot when encountering blocks
- **Graceful degradation** when tools or dependencies are unavailable

## 📋 Quick Command Reference

Once installed, these commands work with GitHub Copilot:

| Copilot Command | Action |
|----------------|--------|
| "Clean workspace" | Execute full workspace cleanup and organization |
| "Health check" | Run comprehensive repository health analysis |
| "Organize files" | Reorganize files to logical locations |
| "Fix workspace" | Analyze and fix workspace organization issues |

### VS Code Tasks (Ctrl+Shift+P → Tasks: Run Task):
- **🧹 Clean Workspace (Auto Before Commit)** - Safe automated cleanup
- **🔍 Repository Health Check** - Comprehensive health analysis
- **📝 Update CHANGELOG** - Interactive CHANGELOG management
- **🛡️ Safe Commit with CHANGELOG Check** - Protected commit process
- **📋 Validate CHANGELOG** - Format and compliance validation

## 🔄 Maintenance and Updates

### Keeping Scripts Updated
The scripts in this package are designed to be self-maintaining, but you should:
1. **Periodically review** the protection patterns in workspace-cleanup.ps1
2. **Update file paths** if your project structure changes
3. **Adjust validation rules** in the health check scripts as needed

### Version Control Integration
The package includes GitHub workflows that automatically:
- **Enforce CHANGELOG updates** on pull requests
- **Validate repository health** on commits
- **Check compliance** with coding standards

### Extension and Enhancement
You can extend the functionality by:
1. **Adding new PowerShell scripts** to the scripts/ folder
2. **Creating additional VS Code tasks** that reference your scripts
3. **Enhancing the copilot instructions** with project-specific commands
4. **Adding new GitHub workflows** for additional automation

## 📞 Support and Troubleshooting

### Common Issues

**PowerShell Execution Policy Errors:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**VS Code Tasks Not Found:**
- Ensure `.vscode/tasks.json` is in your workspace root
- Reload VS Code window: Ctrl+Shift+P → "Developer: Reload Window"

**Script Path Issues:**
- Verify all file paths in scripts match your project structure
- Update relative paths in tasks.json if needed

**Copilot Not Responding to Commands:**
- Ensure `.github/copilot-instructions.md` is present and properly formatted
- Restart VS Code to reload Copilot instructions

### Performance Optimization
- **Exclude large folders** from health checks by updating the scripts
- **Adjust cleanup frequency** based on your development patterns
- **Customize validation depth** for faster execution

## 📄 License and Attribution

This package is licensed under the Apache License 2.0. When using this package:
1. **Maintain copyright headers** in all script files
2. **Attribute the original source** if redistributing
3. **Include the license text** with your project

---

**Package Created:** July 16, 2025
**Original Source:** Employee Recognition App Workspace
**Copyright:** 2025 Kyle J. Coder
**License:** Apache 2.0

For the latest updates and additional automation packages, visit the original repository.
