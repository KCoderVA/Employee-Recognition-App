<!--
  Employee Recognition App Changelog
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

# Employee Recognition App – Pub## 📦 Contribution & Support

To suggest improvements or report issues, please use the GitHub repository's Issues or Security tab. For private or sensitive concerns, follow the project's security reporting process.

---

*This script library is part of the Employee Recognition App v1.0.1 public release. Last updated: August 5, 2025.*ipt Library

This directory contains public-facing PowerShell scripts and modules for workspace automation, validation, deployment, and compliance. These scripts are provided as part of the Employee Recognition App v1.0.1 release for end users, administrators, and solution implementers.

> **Note:** This folder is a curated, public copy of the original project scripts. Only files in this directory are intended for public use and support. Do not use or expose scripts from the private root `scripts/` folder.

## 📑 Script Reference Table

| Script Name                                | Description                                                          |
| ------------------------------------------ | -------------------------------------------------------------------- |
| diagnose-yaml-issues.ps1                   | Diagnoses YAML issues in app source files                            |
| fix-form-accessibility-properties.ps1      | Fixes accessibility properties in Power Apps forms                   |
| fix-orphaned-properties.ps1                | Repairs orphaned properties in app source                            |
| fix-remaining-orphaned-properties.ps1      | Final pass to fix orphaned properties                                |
| fix-yaml-properties.ps1                    | Fixes YAML property formatting issues                                |
| Import-Copilot-Instructions-Template.ps1   | Imports and merges Copilot instructions template into workspace      |
| PowerApp_Recursive_Variable_Extraction.ps1 | Extracts Power Fx variables/components recursively for documentation |
| PowerPlatformUtils.psm1                    | Power Platform utility functions module                              |
| prepare-release.ps1                        | Prepares release artifacts                                           |
| Test-VASecurityCompliance.ps1              | Checks for VA Healthcare security compliance                         |
| update-changelog.ps1                       | Updates CHANGELOG.md with new entries                                |
| validate-changelog.ps1                     | Checks and fixes CHANGELOG format                                    |

## 📝 Usage & Help

Each script includes a standard header with usage, synopsis, and examples. Run any script with `-?` or `-Help` for detailed instructions:

```powershell
pwsh -ExecutionPolicy Bypass -File ./workspace-cleanup.ps1 -Help
```

## 🔐 Security & Compliance

All scripts in this directory are reviewed for security and compliance with VA Healthcare and federal requirements. For more information, see the main [SECURITY.md](../../../docs/SECURITY.md).

## 📦 Contribution & Support

To suggest improvements or report issues, please use the GitHub repository's Issues or Security tab. For private or sensitive concerns, follow the project's security reporting process.

---

*This script library is part of the Employee Recognition App v1.0.1 public release. Last updated: August 5, 2025.*
