
# Employee Recognition App

[![Power Platform](https://img.shields.io/badge/Power%20Platform-Canvas%20App-blue)](https://powerapps.microsoft.com/)
[![Version](https://img.shields.io/badge/Version-1.0.7-green)](./CHANGELOG.md)
[![Implementation](https://img.shields.io/badge/Implementation%20-PowerShell-green)](./src/powershell/README.md)
[![GitHub Automation](https://img.shields.io/badge/CI%2FCD-Automated-blue)](./.github/workflows/)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache%202.0-blue)](https://opensource.org/licenses/Apache-2.0)

---

## Project Overview (Currently: v1.0.7 | Published: October 28, 2025)

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

## 🚀 What's New in v1.0.6
## 🚀 What's New in v1.0.7
- Documentation & Governance Focused Release (no functional Canvas App or Flow logic changes)
- Consolidated alternative README content into the primary README (Usage, Architecture, Config, Support, Roadmap)
- Adopted component-first source layout (`src/power-apps/v1.0.6`, `src/power-automate/v1.0.1`, `src/powershell`, `src/sharepoint`)
- Refactored `.github/CODEOWNERS` patterns to explicit component roots; added assets ownership
- Cleaned `.gitattributes` (removed non-standard whitespace attributes; clarified normalization policy)
- Removed obsolete `README_alternative.md` (retained historical path references only inside `CHANGELOG.md`)
- Updated version badge and Project Overview to 1.0.7, added legacy path preservation rationale

---

## 🚀 What's New in v1.0.6
- View Submissions toolbar improvements: HRO and Hines Hero now initialize a clean in-app new-submission flow (no external links), resetting variables/controls and navigating to Screen_NewSubmission.
- Triage workflow: Form2 now binds to Gallery1.Selected; submit resets Gallery1 and clears selection state; layout tuned.
- App version groundwork: Commented version metadata scaffolding using PowerAppsforMakers.GetAppVersions; profile lookup updated to SearchUserV2.

See [CHANGELOG.md](CHANGELOG.md) for full details.

---

## ⭐ Previously in v1.0.4
- **Visual Modernization:** Complete refresh with modern approved VA seal, logos, and professional visual assets replacing placeholder content
- **Tutorial Integration:** SharePoint-hosted end user tutorial video with embedded access buttons on Update/Help screen and submission popups
- **Enhanced Loading Experience:** Professional animated progress bars and spinning loaders improving user engagement during app interactions
- **Navigation Improvements:** All hyperlink URLs validated and 404 errors resolved for seamless user navigation
- **Display Logic Fixes:** Resolved dynamic variable conflicts on "View Submissions" screen preventing ICARE Values self-hiding behavior
- **User Experience Enhancement:** Comprehensive interface improvements maintaining production stability with enhanced usability and visual appeal

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

### Directory Structure (Component-First Model – Oct 28, 2025)
```
📁 Employee Recognition App/
├── 📂 .github/                  # Workflows, issue templates, CODEOWNERS
│   ├── 📂 workflows/            # CI/CD automation
│   └── 📄 copilot-instructions.md
├──  src/                      # Component-first source tree
│   ├── 📂 power-apps/
│   │   └── 📂 v1.0.6/           # Current Canvas App version
│   │        ├── 📂 .unpacked/   # Source-controlled YAML/JSON/XML
│   │        ├── 📂 .msapp/      # Packaged app artifact
│   │        ├── � app-config.json
│   │        └── 📄 README.md
│   ├── 📂 power-automate/
│   │   └── 📂 v1.0.1/           # Current flow set version
│   │        ├── 📄 flow-config.json
│   │        └── 📄 README.md
│   ├── 📂 sharepoint/           # List schemas & provisioning docs
│   │   ├── � lists/
│   │   └── 📄 README.md
│   ├── � powershell/           # Public automation scripts
│   ├── 📄 INSTALLATION_GUIDE.md
│   └── 📄 RELEASE_NOTES.md
├── 📂 docs/                     # Extended documentation set
│   ├── 📄 PROJECT_STATUS.md
│   ├── 📄 PROJECT_MIGRATION_PLAN.md
│   ├── 📄 SECURITY.md
│   ├── 📄 CONTRIBUTING.md
│   ├── 📄 NOTICE
│   └── 📄 SECRET_SCANNING_CHECKLIST.md
├── 📂 assets/                   # Non-code assets (images/videos)
├── 📄 CHANGELOG.md              # Historical log (legacy paths retained for audit)
├── 📄 LICENSE
├── 📄 README.md                 # Authoritative overview (merged)
└── (removed) README_alternative.md  # Legacy file merged then removed (Oct 28 2025)
```
> Legacy `src/v1.0.x/v1.0.0/...` references remain only in CHANGELOG & historical docs for traceability.

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
For immediate deployment without source modifications:
- **Pre-built Application Package**: `src/power-apps/v1.0.6/.msapp/v1.0.6.msapp`
- **Enhanced Features**: Modern VA branding, integrated tutorial videos, animated loading components
- **Public PowerShell Scripts**: `src/powershell/` (pack/unpack, validation, diagnostics)
- **Deployment Utilities**: CLI automation & validation scripts for enterprise environments
- **Installation Documentation**: [INSTALLATION_GUIDE.md](src/INSTALLATION_GUIDE.md)

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
| [INSTALLATION_GUIDE.md](src/INSTALLATION_GUIDE.md) | Installation and setup instructions        |
| [RELEASE_NOTES.md](src/RELEASE_NOTES.md)           | Release notes and highlights               |

---

## Usage Overview

### Nominators
1. Select award directly or use "Help Me Choose" guided flow.
2. Enter nominee, context, justification (dynamic fields per award).
3. Track statuses from My Nominations panel.

### Approvers
1. Review queued submissions in Approvals.
2. Act within SLA windows (Level 1: 5 days, Level 2: 3 days).
3. Use escalation or info requests; overdue items auto-escalate.

### Administrators
1. Monitor flow runs & error logs.
2. Adjust minimal config JSONs (avoid mid-cycle source edits).
3. Review monthly KPIs and backlog metrics.

## Architecture Snapshot
```
┌─────────────────────────┐
│ Canvas App (v1.0.6)     │
└────────────┬────────────┘
             │
┌────────────▼────────────┐
│ Flows (v1.0.1)          │
└────────────┬────────────┘
             │
┌────────────▼────────────┐
│ SharePoint Data Layer   │
└─────────────────────────┘
```
Independent versioning reduces coupling; minimal configs decrease drift risk.

## Configuration Samples
`src/power-apps/v1.0.6/app-config.json` (excerpt):
```json
{ "version": "1.0.6", "features": { "enableHelpMeChoose": true }, "validation": { "maxDescriptionLength": 4000 } }
```
`src/power-automate/v1.0.1/flow-config.json` (excerpt):
```json
{ "releaseVersion": "1.0.1", "approval": { "level1TimeoutDays": 5, "level2TimeoutDays": 3 }, "reminders": { "intervalDays": 2 } }
```

## Support & Contact
| Purpose | Contact |
| ------- | ------- |
| General Project | https://github.com/KCoderVA/Employee-Recognition-App |
| VA Internal (SharePoint) | https://dvagov.sharepoint.com/sites/vhahin/svc/ci/ |
| Development / Analytics | HINClinicalAnalytics@va.gov |

## Roadmap Highlights
- Teams adaptive card notifications
- Advanced Power BI dashboards
- Bulk approval tooling
- Certificate generation automation
- Localization & multi-language UI
- Extended recognition analytics

## Project Information

**Organization:** Edward Hines Jr. VA Hospital (Station 578), VISN 12, Veterans Health Administration (VHA), U.S Department of Veterans Affairs (VA)
**Development Team:** Advanced Analytics & Clinical Informatics
**Project Lead:** Kyle J. Coder (Developer/Program Analyst)
**Primary Stakeholder:** Christina Conway (Health Systems Specialist)
**Executive Sponsor:** James Doelling (Executive Director/CEO)
**Project Timeline:** April 9, 2025 – August 12, 2025 (125 days of active development)
**Total Releases:** 100+ incremental development releases with complete traceability
**Repository Statistics:** 1,800+ lines in CHANGELOG.md documenting complete project history (legacy paths retained for historical accuracy)
**License:** Apache License, Version 2.0 – See [LICENSE](LICENSE) for complete terms and conditions
**Contact:**
- [PREFERRED] GitHub Repository: https://github.com/KCoderVA/Employee-Recognition-App
- [VA INTERNAL ONLY] SharePoint site: https://dvagov.sharepoint.com/sites/vhahin/svc/ci/
- [ALTERNATE] Email: HINClinicalAnalytics@va.gov

---

### Legacy Path Preservation Note
Historical releases referenced a monolithic directory (`src/v1.0.x/v1.0.0/...`). During the Oct 28, 2025 restructure we adopted a component-first model (`src/power-apps/v1.0.6`, `src/power-automate/v1.0.1`, etc.). Legacy paths are intentionally retained in:
- CHANGELOG.md entries
- Archived release documentation
- Older release notes

They should NOT be globally replaced to preserve audit fidelity and traceability of historical build outputs. All forward-looking guidance now uses the component-first structure.
