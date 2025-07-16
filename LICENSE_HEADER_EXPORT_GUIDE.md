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

# License Header Automation Export Guide

## 📦 Components to Export

### 1. **Core Configuration File**
```
Source: `.github/copilot-instructions.md` (line 114)
Target: Copy to new workspace's `.github/copilot-instructions.md`
```

Add this section to your target workspace's copilot instructions:
```markdown
### Security & Compliance
- **License**: Apache 2.0 with copyright headers on all files
```

### 2. **License Template**
```
Source: `LICENSE` file (complete file)
Target: Copy entire file to new workspace root
```
This provides the official Apache 2.0 template that automation tools reference.

### 3. **GitHub Workflow Automation**
```
Source: `.github/workflows/repository-health.yml` (lines 76-87)
Target: Create or update workflow in new workspace
```

Key section that checks license header coverage:
- Scans markdown files for license headers
- Calculates coverage percentage
- Reports compliance status
- Enforces 80% minimum coverage

### 4. **Safe Commit Script Integration**
```
Source: CHANGELOG.md reference (line 68)
Feature: "License header checking for source files"
```

If you have PowerShell automation scripts, ensure they include license header validation.

### 5. **VS Code Task Integration** (Optional)
Any VS Code tasks that reference license checking or validation.

## 🔧 Implementation Steps

### Step 1: Copy License Framework
1. Copy the `LICENSE` file to your new workspace root
2. Update copyright year/name if different project

### Step 2: Update Copilot Instructions
Add the license requirement to `.github/copilot-instructions.md`:
```markdown
- **License**: Apache 2.0 with copyright headers on all files
```

### Step 3: Set Up GitHub Workflow
Create or update `.github/workflows/repository-health.yml` with license checking logic.

### Step 4: Configure Development Scripts
If using PowerShell automation, add license header validation to commit scripts.

## 📋 Header Format Template

For new files, use this format:
```
<!--
   Copyright [YEAR] [YOUR NAME]

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
```

## ✅ Verification

After setup, the system should:
- Automatically prompt for license headers on new files
- Check header compliance in workflows
- Integrate with commit automation
- Report coverage statistics

## 🎯 Quick Export Package

The minimal export package consists of:
1. `LICENSE` file (complete)
2. GitHub workflow license checking section
3. Copilot instruction line about license headers
4. Header template documentation

This will give you the core automation framework for license header management in any new workspace.
