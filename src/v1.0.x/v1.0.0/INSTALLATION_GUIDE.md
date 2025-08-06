
# Employee Recognition App – Installation Guide (v1.0.1 Public Release)

Welcome to the Employee Recognition App! This guide will help you install, configure, and launch the full Power Platform solution for digital employee recognition, automated approvals, and secure data management.

## Prerequisites
- Microsoft Power Platform environment (with admin rights)
- SharePoint Online site (for data storage and audit)
- Power Automate premium license (for approval and safety flows)
- Appropriate permissions to import apps, flows, and create SharePoint lists

## Directory Structure
- `power-apps/` – Canvas App source and packaged .msapp file
- `power-automate/` – Exported Power Automate flows (.zip) and unpacked source
- `sharepoint/` – List templates and configuration files
- `scripts/` – PowerShell automation and validation scripts
- `docs/` – Documentation, compliance, and user guides

## Quick Start
1. **Extract the Release Package**
   - Download and extract all files to a local directory
   - Review the `RELEASE_NOTES.md` and `SECURITY.md` files
2. **Environment Preparation**
   - Ensure your Power Platform and SharePoint environments are ready
   - Confirm you have the required permissions and licenses
3. **Import Power Apps Canvas App**
   - Go to Power Apps > Apps > Import Canvas App
   - Select the `.msapp` file from the `power-apps/` folder
   - Follow prompts to complete import
4. **Import Power Automate Flows**
   - Go to Power Automate > My Flows > Import
   - Select each flow package from the `power-automate/exports/` folder
   - Reconnect all connections and update environment variables as needed
5. **Configure SharePoint Lists**
   - Use templates in the `sharepoint/lists/` folder to create required lists
   - Set permissions and enable versioning/audit as described in documentation
6. **Update Connections & Environment Variables**
   - Update all connection references in Power Apps and Power Automate
   - Configure environment variables for URLs, emails, and SharePoint sites
7. **Security & Compliance**
   - Review and apply security settings per `SECURITY.md`
   - Set up security groups and access controls
8. **Testing & Validation**
   - Run all basic functionality tests (app load, flow execution, SharePoint integration)
   - Test approval workflows and notifications
   - Validate audit trails and compliance features

## Detailed Documentation
For step-by-step setup, configuration, and troubleshooting, see the `docs/` folder and user guides included in the release package.

## Support & Feedback
- For questions or support, visit: https://github.com/KCoderVA/Employee-Recognition-App/issues
- For security or compliance concerns, see `SECURITY.md` and follow the reporting process

---

*This guide is for the Employee Recognition App v1.0.1 public release. Last updated: January 28, 2025.*
