# One-Click Repository Manager - Usage Instructions

## 🎯 Overview

You now have **two executable files** that provide one-click repository management:

1. **`repository_manager\GitHub-Repository-Manager.bat`** - Windows Batch file (double-click to run)
2. **`repository_manager\GitHub-Repository-Manager.ps1`** - PowerShell script (enhanced version)

## 🚀 How to Use

### **Option 1: Batch File (Recommended for simplicity)**
1. Navigate to your project root folder in Windows File Explorer
2. **Double-click** `repository_manager\GitHub-Repository-Manager.bat`
3. Follow the on-screen prompts
4. Choose your commit option (1-4)

### **Option 2: PowerShell Script (Enhanced features)**
1. **Right-click** `repository_manager\GitHub-Repository-Manager.ps1`
2. Select **"Run with PowerShell"**
3. If prompted about execution policy, choose **"Yes"**
4. Follow the interactive prompts

## 🔧 What Each Script Does

### **Automatic Steps (No user input required)**
1. **🧹 Workspace Cleanup**
   - Removes redundant/outdated files
   - Protects all important project files
   - Shows summary of files cleaned

2. **📋 Repository Status Check**
   - Validates git repository
   - Shows current file changes
   - Confirms changes need committing

### **Interactive Steps (User chooses)**
3. **📝 Commit Preparation**
   - **Option 1**: Interactive safe commit (recommended)
     - Guides you through CHANGELOG updates
     - Validates all changes
     - Commits with proper documentation

   - **Option 2**: Quick commit
     - Auto-generates commit message with timestamp
     - Fast commit for minor changes

   - **Option 3**: Preview only (dry run)
     - Shows what would be cleaned/committed
     - No actual changes made

   - **Option 4**: Cancel
     - Exit without making changes

## ✅ Benefits

- **🖱️ One-click execution** - No need to remember complex commands
- **🧹 Automatic cleanup** - Maintains clean repository structure
- **📝 Enforced documentation** - Ensures CHANGELOG is updated
- **🛡️ Safe operation** - Protects critical files from accidental deletion
- **🔍 Preview mode** - Test what would happen before making changes
- **⚡ Multiple options** - Choose the right approach for your needs

## 🔧 Troubleshooting

### **"Execution Policy" Error (PowerShell)**
If you get an execution policy error:
1. **Right-click** the PowerShell script
2. Select **"Run with PowerShell"**
3. When prompted, type **"Y"** to allow execution

### **"Not in git repository" Error**
- Make sure you're running the script from the project root folder
- The folder should contain `CHANGELOG.md` and `.git` folder

### **"Script not found" Error**
- Ensure the `scripts` folder exists with all required files
- Make sure you haven't moved or deleted any script files

## 🎯 Quick Reference

| **What you want to do** | **Which option to choose** |
|--------------------------|----------------------------|
| Regular updates with documentation | Option 1 (Interactive) |
| Quick fixes or minor changes | Option 2 (Quick commit) |
| See what would change without committing | Option 3 (Preview) |
| Just clean workspace without committing | Run Option 3, then Option 4 |

## 📞 Need Help?

If you encounter issues:
1. Check the error messages displayed in the console
2. Ensure all required files are present in the project
3. Verify you're running from the correct directory
4. Contact the development team if problems persist

---

**🎯 Result**: One double-click gives you a clean, documented, and properly committed repository ready for GitHub!

## 🎨 Power Apps Web Development Workflow

In addition to repository management, your workspace includes specialized support for **web-only Power Apps development**:

### **Quick Power Apps Tasks (VS Code)**
- **🌐 Open Power Apps Web Portal** - Direct link to https://make.powerapps.com
- **📦 Package Power App v0.9.0** - Convert source code to .msapp for upload
- **📁 Open App Source in VS Code** - Quick access to source files
- **📋 Show Web Development Quick Reference** - Display workflow reminders

### **Power Apps Development Cycle**
1. **Edit source code** - Work with .fx.yaml files in VS Code
2. **Package app** - Use VS Code task to create .msapp file
3. **Upload manually** - Import .msapp to Power Apps web portal
4. **Test & validate** - Use Power Apps web editor for testing
5. **Export when satisfied** - Download updated .msapp for next cycle

### **Important Web-Only Notes**
- ⚠️ **Manual upload required** - No automated deployment to Power Apps
- ⚠️ **No direct save** from Power Apps web to source control
- ✅ **Full functionality** available through web browser
- ✅ **Source control friendly** - All files are text-based YAML

### **Key Folders for Power Apps**
- `src/power-apps/EmployeeRecognitionApp_v0.9.0/Source/` - Editable source code
- `releases/v0.9.x/` - Packaged .msapp files ready for upload
- `src/power-apps/EmployeeRecognitionApp_v0.9.0/README.md` - Detailed development guide
