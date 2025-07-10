# Employee Recognition Application

[![Power Platform](https://img.shields.io/badge/Power%20Platform-Canvas%20App-blue)](https://powerapps.microsoft.com/)
[![Version](https://img.shields.io/badge/Version-0.9.0-green)](./CHANGELOG.md)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success)](./CHANGELOG.md)
[![Documentation](https://img.shields.io/badge/Documentation-Complete-brightgreen)](./docs/)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue)](https://opensource.org/licenses/Apache-2.0)

> **A comprehensive Power Platform solution for streamlining employee recognition workflows in healthcare organizations. Built for the VA healthcare system with enterprise-grade security, automated approvals, and professional documentation.**

## Overview

A production-ready **Power Platform application** that transforms traditional paper-based employee recognition into an intelligent, automated digital workflow. Developed through 3 months of iterative design with complete stakeholder collaboration.

### 🏆 Award Types Supported
- **HeRO Awards** - Healthcare Recognition & Outcomes excellence
- **Great Catch** - Safety and process improvement recognition
- **Starfish Awards** - Peer-to-peer recognition and collaboration
- **I CARE Values** - Values-based recognition aligned with organizational mission

### ⭐ Key Features
- **Smart Workflows** - Award-specific forms with dynamic question sets
- **Automated Approvals** - Multi-level routing with intelligent triage
- **Mobile Responsive** - Works seamlessly across all devices
- **Teams Integration** - Native collaboration and notifications
- **Analytics Dashboard** - Comprehensive recognition metrics and reporting
- **Security Compliant** - Enterprise-grade security with audit trails

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Power Apps    │───▶│ Power Automate  │───▶│   SharePoint    │
│  Canvas App     │    │     Flows       │    │     Lists       │
│                 │    │                 │    │                 │
│ • Award Forms   │    │ • Auto Routing  │    │ • Data Storage  │
│ • Mobile UI     │    │ • Notifications │    │ • Audit Trails  │
│ • Validation    │    │ • AI Chatbot    │    │ • Analytics     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 ▼
                    ┌─────────────────┐
                    │ Microsoft       │
                    │ Approvals +     │
                    │ Teams/Outlook   │
                    └─────────────────┘
```

### Core Components
- **🎨 Power Apps** - Responsive canvas application with award-specific workflows
- **⚡ Power Automate** - Automated triage, approval routing, and AI safety chatbot
- **📋 SharePoint** - Secure data storage with privacy controls and audit trails
- **✅ Microsoft Approvals** - Multi-level approval processes with executive routing
- **👥 Teams & Outlook** - Seamless collaboration and notification systems

## Getting Started

### Quick Setup
```bash
# Clone the repository
git clone https://github.com/KCoderVA/Employee-Recognition-App.git
cd Employee-Recognition-App

# Open in VS Code
code .
```

### Prerequisites
- **Power Platform CLI** - Install from [Microsoft Learn](https://learn.microsoft.com/power-platform/developer/cli/introduction)
- **VS Code** - With recommended Power Platform extensions
- **Power Platform Environment** - Admin access to target environment
- **SharePoint Site** - With proper permissions structure
- **Git** - For version control operations

### 🎯 Repository Management
For local development, additional management tools are available:

- **VS Code Tasks** - Comprehensive automation through VS Code (`Ctrl+Shift+P` → "Tasks")
- **Power Platform CLI** - Install from [Microsoft Learn](https://learn.microsoft.com/power-platform/developer/cli/introduction)

**Available VS Code tasks**:
- ✅ Package/Unpack Power Apps
- ✅ Repository health checks
- ✅ CHANGELOG validation

### VS Code Tasks
Access automation through VS Code tasks (`Ctrl+Shift+P` → "Tasks: Run Task"):

| Task | Description |
|------|-------------|
| 📦 **Package Power App** | Create deployment-ready .msapp packages |
| 📤 **Unpack Power App** | Extract source files for version control |
| � **Generate Project Report** | Complete project file analysis |
| �️ **Show Active Extensions** | Display workspace-optimized extensions |
- **VS Code Integration** - Built-in tasks for CHANGELOG management and validation

## Project Structure

```
📁 Employee Recognition App/
├── 📂 .github/                  # GitHub workflows and templates
├── 📂 src/                     # Source code and configurations
│   ├── 📂 power-apps/         # Canvas app source control
│   ├── 📂 power-automate/     # Flow documentation
│   └── 📂 sharepoint/         # Lists, pages, and permissions
├── 📂 docs/                    # Documentation and guides
├── � CHANGELOG.md            # Complete development history
├── � CONTRIBUTING.md         # Contribution guidelines
├── � SECURITY.md             # Security policy
└── � README.md               # This file
```

## Development Metrics

**Version**: 0.9.0 (Production Ready) | **Timeline**: 3 months | **Releases**: 95 versions

### Key Achievements
- ✅ **95 Incremental Releases** - Complete semantic versioning with stakeholder collaboration
- ✅ **31 Change Requests** - All stakeholder requirements implemented
- ✅ **Enterprise Security** - VA IT compliance with audit trails
- ✅ **Professional Documentation** - Complete technical and user guides
- ✅ **ALM Best Practices** - Multi-environment deployment with automated workflows

## Technical Architecture

### Power Apps Canvas Application
- **Features**: Award-specific workflows, mobile-responsive design, intelligent validation
- **Integration**: Native SharePoint connectivity with optimized performance
- **User Experience**: Dynamic forms based on award type with guided submission process

### Power Automate Flows
- **Triage & Routing**: Intelligent approval routing based on award type and organizational hierarchy
- **Notifications**: Automated Teams/Outlook integration with status updates
- **AI Safety Chatbot**: Intelligent safety reporting guidance with JPSR integration

### SharePoint Data Layer
- **Storage**: Centralized data with structured lists for nominations, categories, and audit logs
- **Security**: Role-based access control with audit trails for compliance
- **Analytics**: Built-in reporting and metrics dashboard for recognition patterns

## Deployment & Environment Management

### Multi-Environment Strategy
```
Development → Testing → Staging → Production
```

- **🔧 Development** - Feature development and initial testing
- **🧪 Testing** - User acceptance testing and stakeholder review
- **🎭 Staging** - Pre-production validation and final testing
- **🌟 Production** - Live system with full user access

### Release Management
- **📦 Solution Packaging** - Automated Power Platform solution management
- **🏷️ Version Tagging** - Git tags aligned with semantic versioning
- **📋 Release Notes** - Comprehensive change documentation
- **⚙️ Environment Configuration** - Environment-specific settings management

## Security & Compliance

### Enterprise Security Standards
- **🔐 Data Protection** - Complete privacy policy compliance with PII handling
- **👤 Access Control** - Role-based permissions with principle of least privilege
- **📊 Audit Logging** - Complete activity tracking for compliance reporting
- **📋 Regulatory Compliance** - FISMA, Privacy Act, and HIPAA requirements

### Power Platform Security
- **🔒 Environment Security** - Enterprise tenant with facility-specific access controls
- **🔑 Authentication** - Active Directory integration with multi-factor authentication
- **🛡️ Data Loss Prevention** - DLP policies for sensitive information protection
- **📱 Mobile Security** - Secure mobile app deployment with device compliance

*Complete security documentation: [`SECURITY.md`](SECURITY.md)*

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details on:

- 📋 **Issue Templates** - Structured bug reports and feature requests
- 🔄 **Pull Request Workflow** - Code review and quality assurance processes
- 📏 **Code Standards** - Power Platform best practices and naming conventions
- 🧪 **Testing Requirements** - Comprehensive testing and validation procedures

## Documentation

### Core Documentation
| Document | Description |
|----------|-------------|
| [`CHANGELOG.md`](CHANGELOG.md) | Complete 95-version development history |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Contribution guidelines and best practices |
| [`SECURITY.md`](SECURITY.md) | Security policy and compliance framework |
| [`PROJECT_ORGANIZATION.md`](PROJECT_ORGANIZATION.md) | Repository structure and organization |

### Technical Guides
- **[Development Guide](docs/DEVELOPMENT_GUIDE.md)** - Technical development procedures
- **[Flow Maps & Diagrams](docs/flow-maps/)** - Visual workflow documentation
- **[Training Materials](docs/training/)** - User education and presentations

## Project Information

**Organization**: Edward Hines Jr. VA Hospital (Station #578), VISN #12
**Development Team**: Advanced Analytics & Informatics
**Project Lead**: Kyle J. Coder
**Primary Stakeholder**: Christina Conway
**Timeline**: April 9, 2025 - July 10, 2025 (3 months)

## License & Contact

**Copyright**: 2025 Kyle J. Coder
**License**: Apache License, Version 2.0 - See [LICENSE](LICENSE) for details

**Contact Information**:
- **Team Email**: HINClinicalAnalytics@va.gov
- **GitHub Repository**: https://github.com/KCoderVA/Employee-Recognition-App
- **SharePoint Site**: https://dvagov.sharepoint.com/sites/vhahin/svc/ci *(VA network access required)*
- **Developer**: Kyle J. Coder (Advanced Analytics & Informatics)
- **Organization**: Edward Hines Jr. VA Hospital (Station #578), VISN #12

## 🎨 Power Apps Development (Web-Only Workflow)

### **📱 Canvas App Source Code Development**
This project uses a **web-based Power Apps development workflow** with source control through VS Code:

```powershell
# 1. Edit source code in VS Code (this workspace)
code "./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source"

# 2. Package source to .msapp for deployment
# Use VS Code task: "📦 Package Power App v0.9.0 (Source Control)"
# OR command line:
pac canvas pack --sources "./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source" --msapp "./releases/v0.9.x/EmployeeRecognitionApp_v0.9.0.msapp"

# 3. Import to Power Apps web manually:
# - Navigate to https://make.powerapps.com
# - Click "Apps" → "Import canvas app"
# - Upload the generated .msapp file
# - Test and validate in web editor

# 4. Export updated version when satisfied
# - Download .msapp from Power Apps web
# - Unpack new version for continued development
```

### **🌐 Web-Only Development Cycle**
1. **Source Code Editing** → VS Code (.fx.yaml files)
2. **Packaging** → Power Platform CLI (`pac canvas pack`)
3. **Manual Upload** → https://make.powerapps.com (Import canvas app)
4. **Testing & Validation** → Power Apps web editor
5. **Export for Updates** → Download .msapp, unpack, repeat

### **⚠️ Important Web-Only Limitations**
- **No direct save** from Power Apps web to source control
- **Manual import required** - Upload .msapp files through web interface
- **Desktop Studio unavailable** - All editing through web browser only
- **Source control workflow** - Always: Edit YAML → Pack → Upload → Test → Export

### **📂 Canvas App Structure**
- **Source Files**: `src/power-apps/EmployeeRecognitionApp_v0.9.0/Source/`
- **Packaged Apps**: `releases/v0.9.x/`
- **Documentation**: `src/power-apps/EmployeeRecognitionApp_v0.9.0/README.md`
- **Web Reference**: `docs/POWER_APPS_WEB_REFERENCE.md` (Quick workflow guide)

### **🛠️ Web Development Tools**
- **PowerShell Helper**: `scripts/powerapps-web.ps1` (Interactive commands)
- **VS Code Tasks**: Multiple tasks for packaging, portal access, and reference
- **Quick Reference**: Use VS Code task "📖 Open Power Apps Web Reference"
