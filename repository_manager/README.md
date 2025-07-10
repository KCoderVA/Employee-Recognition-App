# Repository Manager

This folder contains all files related to the GitHub Repository Manager system for the Employee Recognition App project.

## 📁 Contents

### **🚀 Executable Files**
- **`GitHub-Repository-Manager.bat`** - Windows Batch file for one-click repository management
- **`GitHub-Repository-Manager.ps1`** - Enhanced PowerShell version with advanced features

### **📋 Scripts**
- **`dual-repo-manager.ps1`** - Dual repository management for local/GitHub separation

### **📚 Documentation**
- **`QUICK_START_GUIDE.md`** - Complete usage instructions for repository manager
- **`WORKSPACE_CLEANUP_SYSTEM.md`** - Detailed documentation of workspace cleanup system

## 🚀 Quick Start

### **Easiest Method (Windows)**
1. **Double-click** `GitHub-Repository-Manager.bat` from this folder
2. Follow the on-screen prompts
3. Choose your commit option (1-4)

### **PowerShell Method (Enhanced)**
1. **Right-click** `GitHub-Repository-Manager.ps1`
2. Select **"Run with PowerShell"**
3. Follow the interactive prompts

## 🔄 What It Does

### **Automatic Steps**
1. **🧹 Workspace Cleanup** - Removes redundant/outdated files
2. **📋 Repository Status Check** - Validates git repository
3. **🔍 File Change Detection** - Shows current file changes

### **Interactive Steps**
4. **📝 Commit Preparation** - Choose from multiple commit options:
   - Interactive safe commit (recommended)
   - Quick commit with timestamp
   - Preview only (dry run)
   - Cancel

## ⚡ Advanced Usage

### **Dual Repository Management**
```powershell
# Run from project root
.\repository_manager\dual-repo-manager.ps1 -Status
.\repository_manager\dual-repo-manager.ps1 -Both -CommitMessage "Update project files"
.\repository_manager\dual-repo-manager.ps1 -GitHubOnly -CommitMessage "Public release"
```

## 🛡️ Safety Features

- **🔒 Protected Files** - Critical files are never deleted
- **📋 CHANGELOG Enforcement** - Requires CHANGELOG updates before commits
- **🧪 Dry Run Mode** - Preview changes without executing
- **✅ Validation** - Comprehensive error checking and validation

## 📂 File Relationships

These repository manager files work with scripts in the main `scripts/` folder:
- `scripts/workspace-cleanup.ps1` - Automated cleanup functionality
- `scripts/safe-commit.ps1` - Safe commit with validation
- `scripts/validate-changelog.ps1` - CHANGELOG validation
- `scripts/update-changelog.ps1` - Interactive CHANGELOG updates

## 📖 For Detailed Instructions

See **`QUICK_START_GUIDE.md`** in this folder for complete usage instructions and troubleshooting.

---

**🎯 Result**: One-click repository preparation with automated cleanup, documentation enforcement, and safe commit procedures!
