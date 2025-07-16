# 🤖 Copilot Quick Reference Card

## 🚀 Quick Installation
```powershell
# Complete installation
.\Install-CopilotPackage.ps1 -TargetWorkspace "C:\Path\To\Your\Workspace"

# Copilot instructions only
.\Install-CopilotPackage.ps1 -TargetWorkspace "C:\Path\To\Your\Workspace" -CopilotOnly

# Preview installation (dry run)
.\Install-CopilotPackage.ps1 -TargetWorkspace "C:\Path\To\Your\Workspace" -DryRun
```

## 🎯 Copilot Voice Commands
Once installed, say these phrases to GitHub Copilot:

| Voice Command | Action |
|---------------|--------|
| **"Clean workspace"** | 🧹 Execute full workspace cleanup and organization |
| **"Health check"** | 🔍 Run comprehensive repository health analysis |
| **"Organize files"** | 📁 Reorganize files to logical locations |
| **"Fix workspace"** | 🔧 Analyze and fix workspace organization issues |

## ⌨️ VS Code Tasks (Ctrl+Shift+P → Tasks: Run Task)

### 🧹 Workspace Management
- **🧹 Clean Workspace (Auto Before Commit)** - Safe automated cleanup
- **🧹 Clean Workspace (Dry Run Preview)** - Preview cleanup without changes

### 🔍 Health & Validation
- **🔍 Repository Health Check** - Comprehensive health analysis
- **📋 Validate CHANGELOG (Comprehensive)** - Format and compliance validation

### 📝 Documentation & Release
- **📝 Update CHANGELOG (Required Before Commit)** - Interactive CHANGELOG management
- **🛡️ Safe Commit with CHANGELOG Check** - Protected commit process
- **🚀 Prepare Release** - Interactive release preparation
- **🔧 Fix CHANGELOG Format** - Auto-fix CHANGELOG formatting

### 📦 Power Platform (if applicable)
- **📦 Package Power App** - Create .msapp from source
- **📤 Unpack Power App** - Extract source from .msapp
- **🌐 Open Power Apps Web Portal** - Launch Power Apps maker portal

## 🔧 Key Scripts Reference

### Core Automation
```powershell
# Workspace cleanup with dry run
.\scripts\workspace-cleanup.ps1 -DryRun -Verbose

# Repository health check
.\scripts\repo-health-check.ps1 -Detailed

# Validate CHANGELOG format
.\scripts\validate-changelog.ps1 -Detailed -ShowStatus

# Safe commit with checks
.\scripts\safe-commit.ps1 -Interactive
```

### Pre-commit Hooks
```powershell
# Install enhanced pre-commit hook
.\scripts\install-pre-commit-hook.ps1

# Test pre-commit hook
.\scripts\pre-commit-safety-hook.ps1
```

## 🛡️ Safety Features
- ✅ **Multi-layer file protection** - Critical files never deleted
- ✅ **Dry-run capabilities** - Preview changes before execution
- ✅ **Pre-commit validation** - Automatic checks before commits
- ✅ **CHANGELOG enforcement** - All changes must be documented
- ✅ **Error recovery protocols** - Automatic retry and fallback handling

## 📋 Customization Checklist

After installation, customize these files for your project:

### 🤖 Copilot Instructions (`.github/copilot-instructions.md`)
- [ ] Update project architecture description
- [ ] Modify file paths to match your structure
- [ ] Adjust naming conventions
- [ ] Update technology stack references

### 🔧 VS Code Tasks (`.vscode/tasks.json`)
- [ ] Update file paths in packaging commands
- [ ] Modify backup paths to target your key folders
- [ ] Adjust build commands for your technology stack

### 💻 PowerShell Scripts (`scripts/`)
- [ ] Update protection patterns in workspace-cleanup.ps1
- [ ] Adjust validation rules in repo-health-check.ps1
- [ ] Modify release patterns in prepare-release.ps1

## 🚨 Emergency Commands

If automation goes wrong:
```powershell
# Immediate dry run to see what would be cleaned
.\scripts\workspace-cleanup.ps1 -DryRun -Verbose

# Check repository health for issues
.\scripts\repo-health-check.ps1 -Detailed

# Restore from git if needed
git status
git restore <filename>
```

## 📞 Quick Troubleshooting

**Copilot not responding to commands:**
1. Ensure `.github/copilot-instructions.md` exists
2. Restart VS Code: Ctrl+Shift+P → "Developer: Reload Window"

**PowerShell script errors:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**VS Code tasks not found:**
1. Verify `.vscode/tasks.json` is in workspace root
2. Reload window: Ctrl+Shift+P → "Developer: Reload Window"

---
**Generated:** July 16, 2025 | **Source:** Employee Recognition App Workspace
