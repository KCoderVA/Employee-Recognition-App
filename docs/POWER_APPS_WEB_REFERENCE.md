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

# Power Apps Web Development - Quick Reference Card

## 🎯 Web-Only Development Workflow

### **1. 📝 Edit Source Code**
```bash
# Open source files in VS Code
code "./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source"

# Key files to edit:
# - App.fx.yaml (global settings, variables)
# - Screen_*.fx.yaml (individual screens)
# - Components/*.fx.yaml (reusable components)
```

### **2. 📦 Package for Upload**
```powershell
# VS Code Task: "📦 Package Power App v0.9.0 (Source Control)"
# OR Command Line:
pac canvas pack --sources "./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source" --msapp "./releases/v0.9.x/EmployeeRecognitionApp_v0.9.0.msapp"

# OR Helper Script:
.\scripts\powerapps-web.ps1 package
```

### **3. 🌐 Upload to Power Apps Web**
```
1. Open: https://make.powerapps.com
2. Click: "Apps" → "Import canvas app"
3. Upload: ./releases/v0.9.x/EmployeeRecognitionApp_v0.9.0.msapp
4. Follow import wizard
```

### **4. 🧪 Test in Web Editor**
- Edit formulas and controls in browser
- Test functionality thoroughly
- Validate all screens and features

### **5. 💾 Export Updated Version**
```
1. In Power Apps web: Click "..." → "Export package"
2. Download the .msapp file
3. Save to: ./releases/v0.9.x/EmployeeRecognitionApp_v0.9.x.msapp
4. Unpack for next development cycle
```

## ⚡ Quick Commands

### **VS Code Tasks (Ctrl+Shift+P → "Tasks: Run Task")**
- `🌐 Open Power Apps Web Portal` - Direct link to portal
- `📦 Package Power App v0.9.0` - Create .msapp from source
- `📁 Open App Source in VS Code` - Quick access to source files
- `📋 Show Web Development Quick Reference` - Display workflow
- `🚀 Power Apps Web Development Helper` - Interactive helper script

### **PowerShell Helper Script**
```powershell
# Package app for upload
.\scripts\powerapps-web.ps1 package

# Open Power Apps portal
.\scripts\powerapps-web.ps1 open-portal

# Open source code in VS Code
.\scripts\powerapps-web.ps1 open-source

# Check development status
.\scripts\powerapps-web.ps1 status

# Show help
.\scripts\powerapps-web.ps1 help
```

## 📂 Key Directories

| **Path** | **Purpose** |
|----------|-------------|
| `src/power-apps/EmployeeRecognitionApp_v0.9.0/Source/` | Editable source code (.fx.yaml files) |
| `releases/v0.9.x/` | Packaged .msapp files ready for upload |
| `src/power-apps/EmployeeRecognitionApp_v0.9.0/README.md` | Detailed development documentation |

## ⚠️ Web-Only Limitations

- **❌ No direct save** from Power Apps web to source control
- **❌ No automated deployment** - manual upload required
- **❌ Desktop Power Apps Studio** unavailable (web browser only)
- **✅ Full functionality** available through web editor
- **✅ Source control friendly** - text-based .fx.yaml files

## 🔍 Important Notes

### **Power Fx Formulas**
- All formulas are in YAML format for version control
- IntelliSense works with .fx.yaml files in VS Code
- Changes must be tested in Power Apps web after packaging

### **Source Control Best Practices**
- Commit after each logical change
- Use meaningful commit messages
- Test packaged app before committing source changes
- Keep releases folder for deployment history

### **Development Cycle**
```
Edit Source → Package → Upload → Test → Export → Unpack → Repeat
   ↓           ↓        ↓        ↓       ↓        ↓
VS Code → CLI/Task → Web → Browser → Web → CLI → VS Code
```

---

**🎯 Remember**: Always package source code before uploading to Power Apps web, and always export/unpack after making changes in the web editor!
