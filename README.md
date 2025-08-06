
# Employee Recognition App

[![Power Platform](https://img.shields.io/badge/Power%20Platform-Canvas%20App-blue)](https://powerapps.microsoft.com/)
[![Version](https://img.shields.io/badge/Version-1.0.1-green)](./CHANGELOG.md)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success)](./CHANGELOG.md)
[![GitHub Automation](https://img.shields.io/badge/CI%2FCD-Automated-blue)](./.github/workflows/)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue)](https://opensource.org/licenses/Apache-2.0)

> **A comprehensive Power Platform solution for streamlining employee recognition workflows in healthcare organizations. Built for the VA healthcare system with enterprise-grade security, automated approvals, and professional documentation.**

---

## 🚀 What's New in v1.0.1
- **Production Release**: App is now live and accessible for real-world use with full feature set
- **Embedded Tutorial**: Step-by-step video tutorial integrated in Help/Info tab
- **User Feedback System**: Microsoft Forms integration for ratings and feature requests
- **Enhanced Automation**: Improved Power Automate flows with safety nets and intelligent triage routing
- **AI Safety Integration**: Patient Safety Event detection with Teams ChatBot for incident reporting
- **SharePoint Integration**: Updated intranet homepage with direct app access links
- **Bug Reporting**: In-app bug reporting feature for direct developer communication
- **Workflow Completion**: All triage, approval, and award workflows finalized and tested
- **Error Resolution**: All known PowerApps YAML and Power Automate flow errors resolved
- **Documentation**: Complete documentation suite updated for public release

See [CHANGELOG.md](CHANGELOG.md) for full details.

---

## Overview

The Employee Recognition App is a production-ready Power Platform application that transforms traditional paper-based employee recognition into an intelligent, automated digital workflow. Developed with full stakeholder collaboration and comprehensive GitHub automation and CI/CD workflows.

**Current Version:** v1.0.1 (January 28, 2025)
**Status:** Production Ready

---

## ⭐ Key Features
- **Smart Forms**: Award-specific forms with dynamic question sets and intelligent validation
- **Automated Workflows**: Multi-level approvals with intelligent triage and routing
- **Mobile-First Design**: Responsive and accessible across all devices and platforms
- **Enterprise Integration**: Teams and Outlook integration with Patient Safety Event ChatBot
- **Analytics & Reporting**: Comprehensive dashboard for recognition metrics and insights
- **Security & Compliance**: Enterprise-grade security with complete audit trails
- **DevOps Pipeline**: Complete CI/CD automation and professional documentation
- **User Experience**: Embedded video tutorials, feedback system, and bug reporting

---

## Solution Architecture

The Employee Recognition App is built on:
- **Power Apps Canvas App** – Responsive, award-specific workflows
- **Power Automate Flows** – Automated triage, approval routing, and AI safety chatbot
- **SharePoint** – Secure data storage, privacy controls, and audit trails
- **Microsoft Approvals** – Multi-level approval processes
- **Teams & Outlook** – Collaboration and notification systems

### Directory Structure
```
📁 Employee Recognition App/
├── 📂 .github/                  # GitHub workflows and automation
├── 📂 src/                     # Source code and configurations
│   ├── 📂 v1.0.x/v1.0.0/       # v1.0.1 release artifacts and documentation
│   │   ├── 📂 power-apps/      # Packaged .msapp files for deployment
│   │   │   └── 📂 .msapp/      # Ready-to-deploy application packages
│   │   ├── 📂 powershell/      # Public PowerShell scripts and utilities
│   │   ├── 📄 INSTALLATION_GUIDE.md
│   │   └── 📄 RELEASE_NOTES.md
│   ├── 📂 power-apps/         # Canvas app source control (YAML files)
│   ├── 📂 power-automate/     # Flow documentation and exports
│   └── 📂 sharepoint/         # Lists, pages, and permissions
├── 📂 docs/                    # Public documentation and guides
├──  CHANGELOG.md             # Complete development history
├── 📄 CONTRIBUTING.md          # Contribution guidelines
├── 📄 SECURITY.md              # Security policy and compliance
├── 📄 LICENSE                  # Apache 2.0 license
└── 📄 README.md                # This file
```

---

## Getting Started

### Prerequisites
- Power Platform CLI – [Microsoft Learn](https://learn.microsoft.com/power-platform/developer/cli/introduction)
- Visual Studio Code with Power Platform extensions
- Power Platform environment (admin access)
- SharePoint site (with permissions)
- Git for version control

### Quick Setup
```bash
git clone https://github.com/KCoderVA/Employee-Recognition-App.git
cd Employee-Recognition-App
code .
```

### Download Ready-to-Use App
For immediate deployment, download the packaged app:
- **Pre-built App**: Navigate to `src/v1.0.x/v1.0.0/power-apps/.msapp/v1.0.1_FullRelease.msapp`
- **Public PowerShell Scripts**: Available in `src/v1.0.x/v1.0.0/powershell/` for automation and deployment
- Import the .msapp directly to your Power Platform environment
- See [INSTALLATION_GUIDE.md](src/v1.0.x/v1.0.0/INSTALLATION_GUIDE.md) for step-by-step setup instructions

### Installation & Deployment
See [INSTALLATION_GUIDE.md](src/v1.0.x/v1.0.0/INSTALLATION_GUIDE.md) for full setup instructions.

---

## Development Workflow

This project supports multiple development approaches:

### Option 1: Ready-to-Deploy Package (Recommended)
1. Navigate to `src/v1.0.x/v1.0.0/power-apps/.msapp/` and download `v1.0.1_FullRelease.msapp`
2. Import to Power Platform environment at https://make.powerapps.com
3. Configure SharePoint connections and permissions using scripts in `src/v1.0.x/v1.0.0/powershell/`
4. Deploy and customize as needed

### Option 2: Source-Based Development (Advanced)
1. Edit source code in VS Code (`src/power-apps/EmployeeRecognitionApp_v1.0.1/Source/`)
2. Package source to .msapp using Power Platform CLI or VS Code tasks
3. Import .msapp to Power Apps web (https://make.powerapps.com)
4. Test and validate in web editor
5. Export updated .msapp, unpack, and commit to version control

**Important Notes:**
- Ready-to-use .msapp file included for immediate deployment
- Source code available for advanced customization and development
- No direct save from Power Apps web to source control (for source-based development)
- Manual import/export required for .msapp files when working with source code

---

## Security & Compliance

The Employee Recognition App is fully compliant with VA Healthcare, FISMA, Privacy Act, and HIPAA requirements. See [SECURITY.md](SECURITY.md) for details.

---

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines, code standards, and review process.

---

## Documentation

| Document                                                         | Description                                |
| ---------------------------------------------------------------- | ------------------------------------------ |
| [CHANGELOG.md](CHANGELOG.md)                                     | Complete development history               |
| [CONTRIBUTING.md](CONTRIBUTING.md)                               | Contribution guidelines and best practices |
| [SECURITY.md](SECURITY.md)                                       | Security policy and compliance framework   |
| [PROJECT_STATUS.md](docs/PROJECT_STATUS.md)                      | Project status and roadmap                 |
| [INSTALLATION_GUIDE.md](src/v1.0.x/v1.0.0/INSTALLATION_GUIDE.md) | Installation and setup instructions        |
| [RELEASE_NOTES.md](src/v1.0.x/v1.0.0/RELEASE_NOTES.md)           | Release notes and highlights               |

---

## Project Information

**Organization:** Edward Hines Jr. VA Hospital (Station #578), VISN #12
**Development Team:** Advanced Analytics & Informatics
**Project Lead:** Kyle J. Coder
**Primary Stakeholder:** Christina Conway
**Timeline:** April 9, 2025 – August 4, 2025

**License:** Apache License, Version 2.0 – See [LICENSE](LICENSE) for details

**Contact:**
- GitHub Repository: https://github.com/KCoderVA/Employee-Recognition-App
- Developer: Kyle J. Coder (Advanced Analytics & Informatics)
- Organization: Edward Hines Jr. VA Hospital (Station #578), VISN #12

