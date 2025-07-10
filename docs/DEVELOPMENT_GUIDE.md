# Power Platform Development Guide
## Employee Recognition Application

### Quick Start for Developers

#### Prerequisites
1. **Power Platform CLI** - Install from [Microsoft Docs](https://docs.microsoft.com/powerapps/developer/data-platform/powerapps-cli)
2. **VS Code** with Power Platform Tools extension
3. **Git** for version control
4. **PowerShell 7+** for automation scripts

#### Authentication Setup
```powershell
# Create authentication profile
pac auth create --url https://your-environment.crm.dynamics.com

# List available profiles
pac auth list

# Select profile for development
pac auth select --index 0
```

#### Development Workflow

1. **Unpack Power App for Editing**
   ```powershell
   # Use VS Code task or run directly
   pac canvas unpack --msapp "./path/to/app.msapp" --sources "./src/power-apps/AppName_Unpacked"
   ```

2. **Make Changes**
   - Edit source files in `./src/power-apps/AppName_Unpacked`
   - Use VS Code with Power Platform extensions for IntelliSense
   - Follow naming conventions in `.github/copilot-instructions.md`

3. **Package for Testing**
   ```powershell
   # Use VS Code task "Package Power App" or run:
   pac canvas pack --sources "./src/power-apps/AppName_Unpacked" --msapp "./releases/AppName.msapp"
   ```

4. **Deploy to Environment**
   ```powershell
   # Import using Power Platform CLI
   pac application import --path "./releases/AppName.msapp"
   ```

#### VS Code Tasks Available

- **Package Power App** - Create .msapp file from source
- **Unpack Power App** - Extract source from .msapp
- **Validate Power App** - Test packaging without deployment
- **Environment Health Check** - Verify CLI and authentication
- **Create Solution Package** - Build complete solution
- **Backup Project** - Create timestamped backup

#### Source Control Best Practices

1. **Never commit .msapp files** - Use unpacked source only
2. **Commit frequently** - Small, logical changes
3. **Use descriptive commit messages**
4. **Branch for features** - Create feature branches for new functionality
5. **Review before merge** - Use pull requests for quality control

#### Environment Management

- **Development** - Use for active development and testing
- **Staging** - Pre-production validation
- **Production** - Live application

Environment configurations are in `./environments/config.psm1`

#### Common Tasks

**Import Latest from Production:**
```powershell
# Export from production environment
pac application export --path "./backup/prod-export.msapp" --name "EmployeeRecognitionApp"

# Unpack for source control
pac canvas unpack --msapp "./backup/prod-export.msapp" --sources "./src/power-apps/Latest_Unpacked"
```

**Create Release Package:**
```powershell
./scripts/deploy.ps1 -Environment "production" -Validate
```

**Health Check:**
```powershell
Import-Module ./scripts/PowerPlatformUtils.psm1
Get-PowerPlatformStatus
```

#### Troubleshooting

**Common Issues:**
1. **Authentication Expired** - Run `pac auth create` again
2. **Packaging Errors** - Check for syntax errors in formulas
3. **Import Failures** - Verify connection references and dependencies

**Log Locations:**
- PAC CLI logs: `%USERPROFILE%\.pac\logs`
- VS Code Output: View → Output → Power Platform Tools

#### Code Quality Guidelines

1. **Formula Formatting** - Use proper indentation and line breaks
2. **Error Handling** - Always include IsError() checks
3. **Performance** - Minimize delegation warnings
4. **Security** - Follow principle of least privilege
5. **Documentation** - Comment complex logic

#### Power Automate Development

1. **Export Flows** - Always export as packages for version control
2. **Connection References** - Use parameterized connections
3. **Error Handling** - Implement try-catch patterns
4. **Testing** - Test all branches and error conditions

#### Resources

- [Power Platform ALM Guide](https://docs.microsoft.com/power-platform/alm/)
- [Canvas App Coding Standards](https://docs.microsoft.com/powerapps/maker/canvas-apps/coding-standards)
- [Power Automate Best Practices](https://docs.microsoft.com/power-automate/guidance/planning/best-practices)
