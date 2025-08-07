
# Employee Recognition App

[![Power Platform](https://img.shields.io/badge/Power%20Platform-Canvas%20App-blue)](https://powerapps.microsoft.com/)
[![Version](https://img.shields.io/badge/Version-1.0.3-green)](./CHANGELOG.md)
[![Implementation](https://img.shields.io/badge/Implementation%20-PowerShell-green)](./src/v1.0.x/v1.0.0/powershell/README.md)
[![GitHub Automation](https://img.shields.io/badge/CI%2FCD-Automated-blue)](./.github/workflows/)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue)](https://opensource.org/licenses/Apache-2.0)

---

## Project Overview (Currently: v1.0.3 | Published: August 7, 2025)

The Employee Recognition App is a production-ready Power Platform application that transforms traditional paper-based employee recognition into an intelligent, automated digital workflow. Developed with full stakeholder collaboration, 100+ incremental releases, and comprehensive GitHub automation with CI/CD workflows. Features seven distinct award recognition types allowing consolidated submission, automated routing/triage, ChatBot safety checks, automated documentation storage, and enterprise-grade security compliance for VA Healthcare environments.

---

## ⭐ Key Features
- **Smart Forms**: Award-specific forms with dynamic question sets and intelligent validation
- **Automated Workflows**: Multi-level approvals with intelligent triage and routing
- **Mobile-First Design**: Responsive and accessible across all devices and platforms
- **Enterprise Integration**: Teams and Outlook integration with a "Patient Safety Event" ChatBot
- **Analytics & Reporting**: Comprehensive dashboard for recognition metrics and insights
- **Security & Compliance**: Enterprise-grade security with complete audit trails
- **DevOps Pipeline**: Complete CI/CD automation and professional documentation
- **User Experience**: Embedded video tutorials, feedback system, and bug reporting

---

## 🚀 What's New in v1.0.3
- **.gitignore Optimization:** Fixed critical rule conflicts preventing `.msapp` deployment artifacts from being tracked in the public repository
- **Repository File Management:** Resolved invalid syntax error `!src/** */` → `!src/**` and added specific override `!src/**/*.msapp` for Power Platform artifacts
- **Documentation Enhancement:** Updated all supporting documentation files and scripts with comprehensive current information and exact quantified metrics
- **Version Alignment:** All documentation and references updated to reflect v1.0.3 release status
- **Repository Health:** Enhanced file inclusion/exclusion balance ensuring proper source control for deployment artifacts

See [CHANGELOG.md](CHANGELOG.md) for full details.

---

## Solution Architecture

The Employee Recognition App is built on a comprehensive Power Platform foundation with enterprise-grade automation:
- **Power Apps Canvas App** – Mobile-first responsive design supporting 4 award recognition types with accessibility compliance
- **Power Automate Flows** – Automated triage, multi-level approval routing, and AI safety chatbot integration
- **SharePoint Lists** – Secure data storage with structured content types, privacy controls, and comprehensive audit trails
- **PowerShell Automation** – 19 local development scripts + 14 public deployment scripts for comprehensive lifecycle management
- **GitHub Actions** – 2 active CI/CD workflows (changelog-enforcement.yml, repository-health.yml) with automated quality gates
- **VS Code Integration** – 32 custom tasks across 6 categories for complete development workflow automation
- **Microsoft Approvals** – Multi-level approval processes with executive routing capabilities
- **Teams & Outlook** – Collaboration and notification systems with embedded safety chatbot integration

### Directory Structure
```
📁 Employee Recognition App/
├── 📂 .github/                             # GitHub workflows and automation (2 active workflows)
│   ├── 📂 ISSUE_TEMPLATE/                  # Issue templates for consistent bug reports and feature requests
│   └── 📂 workflows/                       # CI/CD automation (changelog-enforcement.yml, repository-health.yml)
│   ├── 📄 copilot-instructions.md          # Instructions for using GitHub Copilot
│   ├── 📄 pull_request_template.md         # Template for pull requests
├── 📂 src/                                 # Source code and configurations (production-ready components)
│   ├── 📂 v1.0.x/v1.0.0/                   # v1.0.1 release artifacts and documentation
│   │   ├── 📂 power-apps/                  # Canvas app files for deployment
    │   │   ├── 📂 .unpacked/               # Unpacked raw source code files
│   │   │   └── 📂 .msapp/                  # Ready-to-deploy application packages (v1.0.1_FullRelease.msapp)
│   │   ├── 📂 powershell/                  # Public PowerShell scripts and utilities (14 production scripts)
│   │   ├── 📂 power-automate/              # Flow definitions and deployment configurations
│   │   ├── 📂 sharepoint/                  # List templates and content type configurations
│   │   ├── 📄 INSTALLATION_GUIDE.md        # Complete installation and setup instructions
│   │   ├── 📄 RELEASE_NOTES.md             # v1.0.1 release notes and feature highlights
│   │   └── 📄 solution.xml                 # Power Platform solution package metadata
├── 📂 docs/                                # Public documentation and guides documents)
│   ├── 📄 NOTICE                           # Project attribution and copyright information
│   ├── 📄 PROJECT_STATUS.md                # Detailed project status dashboard and roadmap
│   ├── 📄 SECURITY.md                      # Security policy and compliance framework
│   └── 📄 CONTRIBUTING.md                  # Community contribution guidelines and standards
├── 📄 CHANGELOG.md                         # Complete development history
├── 📄 LICENSE                              # Apache 2.0 license terms and conditions
└── 📄 README.md                            # This comprehensive project documentation
```

---

## Getting Started

### Implementation & Deployment Prerequisites
- **Power Platform CLI** – [Microsoft Learn](https://learn.microsoft.com/power-platform/developer/cli/introduction) (required for packaging and deployment)
- **Visual Studio Code** with recommended Power Platform extensions (Power Platform Tools, Power Apps CLI)
- **Power Platform Environment** (admin access required for solution import and configuration)
- **SharePoint Site** (with list creation and permission management capabilities)
- **Git** (for version control and repository management)
- **PowerShell 5.1+** (for automation scripts and deployment utilities)

### Quick Setup
```bash
# Clone the repository
git clone https://github.com/KCoderVA/Employee-Recognition-App.git
cd Employee-Recognition-App

# Open in Visual Studio Code with workspace configuration
code EmployeeRecognitionApp.code-workspace

# Authenticate to Power Platform (required for CLI operations)
pac auth create --environment [your-environment-id] --tenant [your-tenant-id]
```

### Download Ready-to-Use App
For immediate deployment without source code modifications:
- **Pre-built Application Package**: `src/v1.0.x/v1.0.0/power-apps/.msapp/v1.0.1_FullRelease.msapp`
- **Public PowerShell Scripts**: Available in `src/v1.0.x/v1.0.0/powershell/` (14 production-ready scripts)
- **Deployment Utilities**: CLI automation and validation scripts for enterprise environments
- **Installation Documentation**: Complete step-by-step setup instructions in [INSTALLATION_GUIDE.md](src/v1.0.x/v1.0.0/INSTALLATION_GUIDE.md)

### Power Platform Environment Configuration
**VA USGov Cloud Users:** The application is configured for VA USGov environments with specific tenant and authentication requirements:

---

## Security & Compliance

The Employee Recognition App maintains comprehensive security and compliance standards for enterprise healthcare environments:

- **VA Healthcare Compliance**: Full compliance with Veterans Affairs security requirements, FISMA controls, Privacy Act regulations, and HIPAA standards
- **Enterprise Security**: 50+ VA Healthcare enterprise restrictions implemented and validated through automated security compliance scripts
- **Data Protection**: Zero sensitive data, PHI, or PII included in repository - only sanitized template files and configuration examples
- **Audit Trails**: Complete audit capabilities with SharePoint integration for all recognition submissions and approval workflows
- **Access Controls**: Role-based permissions and principle of least privilege implementation throughout all components
- **Secure Deployment**: All deployment artifacts undergo security validation before public release

See [SECURITY.md](docs/SECURITY.md) for comprehensive security policy, threat model, and compliance framework documentation.

---

## Contributing

We welcome community contributions! The Employee Recognition App follows comprehensive contribution standards:

- **Code Standards**: Power Fx best practices, delegation-aware patterns, and enterprise-grade naming conventions
- **Documentation Requirements**: Complete documentation for all contributions with license header compliance
- **Testing Protocols**: Multi-device testing, integration validation, and security compliance verification
- **Review Process**: 2-step review with automated quality gates and manual stakeholder approval
- **Community Guidelines**: Professional collaboration standards with VA Healthcare compliance requirements

See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for detailed guidelines, code standards, submission process, and community expectations.

---

## Documentation

| Document                                                         | Description                                |
| ---------------------------------------------------------------- | ------------------------------------------ |
| [CHANGELOG.md](CHANGELOG.md)                                     | Complete development history               |
| [CONTRIBUTING.md](docs/CONTRIBUTING.md)                          | Contribution guidelines and best practices |
| [SECURITY.md](docs/SECURITY.md)                                  | Security policy and compliance framework   |
| [PROJECT_STATUS.md](docs/PROJECT_STATUS.md)                      | Project status and roadmap                 |
| [INSTALLATION_GUIDE.md](src/v1.0.x/v1.0.0/INSTALLATION_GUIDE.md) | Installation and setup instructions        |
| [RELEASE_NOTES.md](src/v1.0.x/v1.0.0/RELEASE_NOTES.md)           | Release notes and highlights               |

---

## Project Information

**Organization:** Edward Hines Jr. VA Hospital (Station 578), VISN 12, Veterans Health Administration (VHA), U.S Department of Veterans Affairs (VA)
**Development Team:** Advanced Analytics & Clinical Informatics
**Project Lead:** Kyle J. Coder (Developer/Program Analyst)
**Primary Stakeholder:** Christina Conway (Health Systems Specialist)
**Executive Sponsor:** James Doelling (Executive Director/CEO)
**Project Timeline:** April 9, 2025 – August 7, 2025 (121 days of active development)
**Total Releases:** 100+ incremental development releases with complete traceability
**Repository Statistics:** 1,879 lines in CHANGELOG.md documenting complete project history
**License:** Apache License, Version 2.0 – See [LICENSE](LICENSE) for complete terms and conditions
**Contact:**
- [PREFERRED] GitHub Repository: https://github.com/KCoderVA/Employee-Recognition-App
- [VA INTERNAL ONLY] SharePoint site: https://dvagov.sharepoint.com/sites/vhahin/svc/ci/
- [ALTERNATE] Email: HINClinicalAnalytics@va.gov
