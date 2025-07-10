# Employee Recognition App - Canvas App Source Code v0.9.0

## 📱 Application Overview
**Version**: 0.9.0
**Export Date**: July 10, 2025
**Status**: Pre-production source control setup
**Source Format**: Power Platform CLI v0.24

## 📁 Source Code Structure

### **Core Application Files** (`/Source/Src/`)
- **`App.fx.yaml`** - Main application configuration and global variables
- **`Themes.json`** - Application theme and styling definitions

### **Screen Definitions** (`/Source/Src/`)
- **`Loading_Screen.fx.yaml`** - Application loading and initialization
- **`Screen_NewSubmission.fx.yaml`** - New nomination submission form
- **`ViewSubmissions_Screen.fx.yaml`** - View and manage submissions
- **`Update_Screen.fx.yaml`** - Edit existing submissions
- **`CONSTRUCTION_Screen.fx.yaml`** - Under construction/maintenance screen

### **Award-Specific Screens** (`/Source/Src/`)
- **`Screen_Submissions_HinesHero.fx.yaml`** - Hines Hero award submissions
- **`Screen_Submissions_HROSafetyStory.fx.yaml`** - HRO Safety Story submissions
- **`Screen_Submission_ICARE.fx.yaml`** - I*CARE Values award submissions
- **`Submission_Screen_Nursing.fx.yaml`** - Nursing awards (Daisy/Bee)

### **Components** (`/Source/Src/Components/`)
- Reusable UI components and custom controls

### **Application Metadata**
- **`CanvasManifest.json`** - Canvas app manifest and properties
- **`ComponentReferences.json`** - Component library references
- **`ControlTemplates.json`** - Custom control templates

### **Data & Connections** (`/Source/`)
- **`DataSources/`** - SharePoint list and external data connections
- **`Connections/`** - Connection metadata and configuration
- **`Assets/`** - Images, icons, and media files
- **`Other/`** - Additional app metadata

## 🛠️ Development Workflow (Web-Based Power Apps Only)

### **Editing Source Code**
1. **Edit YAML files directly** in VS Code or your preferred editor
2. **Use IntelliSense** - The .fx.yaml files support Power Fx formula syntax
3. **Version control** - All files are now text-based and git-friendly

### **Building & Deploying (Web-Based Workflow)**
```powershell
# Step 1: Pack source code back into .msapp for deployment
pac canvas pack --sources "src/power-apps/EmployeeRecognitionApp_v0.9.0/Source" --msapp "releases/v0.9.0/EmployeeRecognitionApp_v0.9.0.msapp"

# Step 2: Import to Power Apps web (manual upload required)
# - Navigate to https://make.powerapps.com
# - Click "Apps" → "Import canvas app"
# - Upload the generated .msapp file
# - Follow import wizard
```

### **Web-Based Testing & Development Cycle**
1. **Edit source code** in VS Code (this workspace)
2. **Pack to .msapp** using VS Code task or command line
3. **Upload to Power Apps web** at https://make.powerapps.com
4. **Test in web editor** - Edit and test your changes
5. **Export updated version** when satisfied
6. **Unpack new export** to continue source code development

### **Important Web-Only Considerations**
- ⚠️ **No direct save from web to source** - Always export from web, then unpack
- ✅ **Manual import process** - Upload .msapp files through the web interface
- ✅ **Web editor testing** - Full functionality available in browser
- ✅ **Source control workflow** - Edit YAML → Pack → Upload → Test → Export → Repeat

### **Key Development Files to Focus On**

#### **Application Logic** (`App.fx.yaml`)
- Global variables and collections
- OnStart logic and initialization
- Theme and styling configuration

#### **Screen Logic** (Screen_*.fx.yaml)
- Form controls and data binding
- Navigation and user interaction logic
- Screen-specific variables and collections

#### **Data Integration** (`DataSources/`)
- SharePoint list connections
- External API integrations
- Data source schema definitions

## 🔍 Important Notes

### **Power Fx Formulas**
- All formulas are now in human-readable YAML format
- Use VS Code with Power Platform extensions for best editing experience
- Formula IntelliSense works with .fx.yaml files

### **Source Control Best Practices**
- **Commit frequently** - Each logical change should be a separate commit
- **Meaningful commit messages** - Reference the specific screen/functionality changed
- **Branch strategy** - Use feature branches for major changes

### **Testing Changes**
1. Pack the source code back to .msapp
2. Import into Power Apps Studio for testing
3. Validate all functionality before committing

## 🚀 Getting Started with Code Development

### **1. Open VS Code**
```bash
code "src/power-apps/EmployeeRecognitionApp_v0.9.0/Source"
```

### **2. Install Recommended Extensions**
- Power Platform Tools
- YAML Language Support
- Power Fx Language Support (if available)

### **3. Start Editing**
- Begin with `App.fx.yaml` to understand global structure
- Move to individual screen files for specific functionality
- Use search (Ctrl+F) to find specific controls or formulas

## 📊 Version History
- **v0.9.0**: Source control setup with 95 version releases documented
- **Export Source**: Power Platform CLI unpacked format
- **Previous Binary**: Available in `releases/v0.8.x/`

---

**🎯 You can now start actual code development on your Canvas App using standard development tools and practices!**
