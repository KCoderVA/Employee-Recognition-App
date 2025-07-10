# Workspace Cleanup & CHANGELOG Enforcement System

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

## 🎯 Overview

This system enforces **two mandatory requirements** before any GitHub commits:

1. **📝 CHANGELOG.md Updates** - All significant changes must be documented
2. **🧹 Automatic Workspace Cleanup** - Remove redundant/outdated files before upload

## 🔧 System Components

### **1. Enhanced Safe Commit Script** (`scripts/safe-commit.ps1`)
- **NEW**: Automatic workspace cleanup before CHANGELOG validation
- Interactive CHANGELOG updating
- Comprehensive validation and commit process
- Dual repository management (local vs. GitHub)

### **2. Workspace Cleanup Script** (`scripts/workspace-cleanup.ps1`)
- **Automatically removes**:
  - Files with `_OLD`, `_BACKUP`, `_ARCHIVE` patterns
  - Temporary files (`.tmp`, `.temp`, `.bak`)
  - Outdated documentation (`DEVELOPMENT_TASKS.md`, etc.)
  - Empty directories
  - Files containing cleanup keywords
- **Protects critical files**:
  - Active source code
  - Current documentation
  - Configuration files
  - Security/compliance files

### **3. Enhanced Pre-commit Hook** (`.git/hooks/pre-commit`)
- **NEW**: Runs workspace cleanup before CHANGELOG validation
- Validates CHANGELOG.md updates
- Provides detailed error messages and fix instructions

### **4. VS Code Tasks** (`.vscode/tasks.json`)
- **NEW**: `🧹 Clean Workspace (Auto Before Commit)`
- **NEW**: `🧹 Clean Workspace (Dry Run Preview)`
- Existing CHANGELOG management tasks

## 🚀 Usage

### **Recommended: Safe Commit Process**
```powershell
# Automatic cleanup + CHANGELOG + commit
./scripts/safe-commit.ps1 -Message "Your commit message"

# Interactive mode for guided process
./scripts/safe-commit.ps1 -Interactive

# Preview what would be cleaned and committed
./scripts/safe-commit.ps1 -DryRun
```

### **Manual Workspace Cleanup**
```powershell
# Clean workspace now
./scripts/workspace-cleanup.ps1

# Preview what would be cleaned
./scripts/workspace-cleanup.ps1 -DryRun -Verbose

# Interactive cleanup with confirmations
./scripts/workspace-cleanup.ps1 -Interactive
```

### **VS Code Integration**
1. Press `Ctrl+Shift+P`
2. Type "Tasks: Run Task"
3. Select:
   - `🧹 Clean Workspace (Auto Before Commit)` - Clean now
   - `🧹 Clean Workspace (Dry Run Preview)` - Preview cleanup
   - `🛡️ Safe Commit with CHANGELOG Check` - Full process

## 📋 Cleanup Rules

### **Files Always Removed**
```
*_OLD.*          *_BACKUP.*       *_ARCHIVE.*
*_TEMP.*         *.tmp            *.temp
*.bak            *.backup         README_NEW.md
DEVELOPMENT_TASKS.md             GITHUB_OPTIMIZATION_PLAN.md
WORKSPACE_SAVED.md               MIGRATION_VERIFICATION.md
OPTIMIZATION_COMPLETE.md         IMPLEMENTATION_COMPLETE.md
```

### **Directories Cleaned**
```
temp/            tmp/             backup/
old/             archive_old/     reference_only/
```

### **Keyword-based Cleanup**
Files containing these phrases (case-insensitive):
- "one-time"
- "reference only"
- "delete me"
- "outdated"
- "deprecated"
- "no longer needed"

### **Protected Items (Never Removed)**
```
src/*            docs/*           assets/*
releases/*       security/*       environments/*
testing/*        .git/*           .github/*
.vscode/*        scripts/*        README.md
CHANGELOG.md     LICENSE          SECURITY.md
CONTRIBUTING.md  PROJECT_*.md     *.code-workspace
```

## ⚡ Benefits

### **For GitHub Repository**
- ✅ **Clean, professional structure** - Only relevant files uploaded
- ✅ **No redundant documentation** - Eliminates outdated reference materials
- ✅ **Optimal organization** - Maintains focus on current project state
- ✅ **Complete documentation** - All changes properly tracked in CHANGELOG

### **For Local Development**
- ✅ **Full workspace backup** - Local repository keeps everything
- ✅ **Automatic maintenance** - No manual cleanup required
- ✅ **Protected critical files** - Smart filtering prevents accidents
- ✅ **Enhanced workflow** - Integrated into existing commit process

## 🔧 Configuration

### **Skip Cleanup (if needed)**
```powershell
# Skip workspace cleanup for one commit
./scripts/safe-commit.ps1 -SkipWorkspaceCleanup -Message "Emergency fix"

# Bypass both cleanup and CHANGELOG (NOT recommended)
git commit --no-verify -m "Emergency commit"
```

### **Customize Cleanup Rules**
Edit `scripts/workspace-cleanup.ps1` to modify:
- `$CleanupRules.RemovePatterns` - File patterns to remove
- `$CleanupRules.RemoveDirectories` - Directory patterns to clean
- `$CleanupRules.ProtectedPatterns` - Files/folders to protect

## 📊 Impact on Repository

### **Before Enhancement**
- Manual cleanup required
- Risk of uploading outdated files
- Inconsistent repository organization
- Missing documentation of changes

### **After Enhancement**
- 🔄 **Automatic cleanup** before every GitHub commit
- 🛡️ **Protected critical files** with smart filtering
- 📋 **Enforced documentation** via CHANGELOG validation
- ✨ **Professional repository** with optimal organization

---

**Result**: Every GitHub commit now represents a clean, well-documented, and professionally organized project state while maintaining complete local backups.
