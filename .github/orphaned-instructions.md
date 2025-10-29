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

# Orphaned Instruction Items (Historical Reference)

> Purpose: Preserve verbatim legacy content blocks that were intentionally NOT migrated verbatim to path-specific instruction files. Each block below includes: (a) Original Text (b) Why It Is Orphaned (c) Recommended Disposition Options (d) Impact If Deleted.

## Disposition Legend
- KEEP-AS-IS: Retain verbatim in universal file (rare; only if global & still current)
- CONDENSE: Replace with shorter summary in path-specific file (already done elsewhere)
- MOVE: Relocate verbatim into specific path file (apps / scripts / release / docs)
- ARCHIVE: Keep only here for historical audit; remove from active files
- DROP: Safe to delete (no functional effect)

---

## 1. VS Code Tasks Catalog (Verbatim)

### Original Text
```
### **🔧 VS Code Tasks (Ctrl+Shift+P → "Tasks: Run Task")**
**32 Custom Tasks Organized by Category:**

#### **Power Platform Development (8 tasks):**
- **📦 Package Power App v0.9.0** - Creates deployment `.msapp` from source using `pac canvas pack`
- **📤 Unpack Power App** - Extracts source files for version control using `pac canvas unpack`
- **🌐 Open Power Apps Web Portal** - Direct link to https://make.powerapps.com for web-based development
- **📁 Open App Source in VS Code** - Quick access to source files for editing
- **� Power Apps Web Development Helper** - Interactive PowerShell helper for common tasks

#### **Repository Management (6 tasks):**
- **🔍 Repository Health Check (Enhanced)** - Comprehensive health analysis and validation
- **🚀 Launch Repository Manager** - Advanced repository operations interface
- **🌐 Open GitHub Repository** - Direct access to GitHub project page

#### **CHANGELOG & Documentation (5 tasks):**
- **� Update CHANGELOG (Required Before Commit)** - Interactive CHANGELOG management
- **📋 Validate CHANGELOG (Comprehensive)** - Format and compliance validation
- **🔧 Fix CHANGELOG Format** - Automated formatting correction

#### **Workspace Management (5 tasks):**
- **🧹 Clean Workspace (Auto Before Commit)** - Automated cleanup and organization
- **🧹 Clean Workspace (Safe Mode - Dry Run)** - Preview cleanup actions
- **🧹 Clean Workspace (Interactive Mode)** - User-guided cleanup process

#### **Git & Version Control (4 tasks):**
- **�️ Safe Commit with CHANGELOG Check** - Validated commit workflow
- **Initialize Git Repository** - One-time repository setup
- **Create Git Ignore for Power Platform** - Generate appropriate .gitignore

#### **Utility Tasks (4 tasks):**
- **📊 Generate Project Report** - File analysis and statistics
- **💾 Backup Project** - Timestamped archive creation
- **🔧 Show Active Extensions** - Workspace-optimized extension management
```

### Why Orphaned
This enumerated list is descriptive, not procedural. Task behavior now documented in `scripts.instructions.md` (automation flows) and `actions.instructions.md` (validation). Keeping verbatim list is optional.

### Recommended Disposition
CONDENSE (already done) or ARCHIVE here; do not duplicate into active universal file long-term.

### Impact If Deleted
No loss of functional automation logic—tasks themselves remain defined in `tasks.json`. Minimal discoverability loss.

---

## 2. PowerShell Scripts Catalog (Verbatim)

### Original Text
```
### **� PowerShell Scripts (17 Scripts)**
**Comprehensive Automation Suite:**

#### **Core Development Scripts:**
- `workspace-cleanup.ps1` - Advanced workspace organization with safety patterns
- `repo-health-check.ps1` - Multi-layer repository validation and reporting
- `validate-changelog.ps1` - CHANGELOG format validation with auto-fix capabilities
- `safe-commit.ps1` - Interactive commit process with quality gates

#### **Environment Management:**
- `config.psm1` - Multi-environment configuration management
- `prepare-release.ps1` - Release preparation and artifact generation
- `powerapps-web.ps1` - Web development workflow helper
```

### Why Orphaned
Superseded by richer procedural guidance in `scripts.instructions.md` and by the new Script Reference Table in v2 (which added `add-license-headers.ps1`).

### Recommended Disposition
ARCHIVE. Consider moving any missing script purposes into inline comments inside the scripts themselves.

### Impact If Deleted
No functional loss; helps reduce duplication.

---

## 3. VA USGov Environment Reference (Verbatim)

### Original Text
```
### VA USGov Power Platform Environment Reference

| Parameter                | Value                                                                  |
| ------------------------ | ---------------------------------------------------------------------- |
| Environment ID           | e95f1b23-abaf-45ee-821d-b7ab251ab3bf                                   |
| Tenant ID                | e95f1b23-abaf-45ee-821d-b7ab251ab3bf                                   |
| Organization Unique Name | org34322538                                                            |
| Organization Friendly    | Department of Veterans Affairs (default)                               |
| Cloud                    | UsGov                                                                  |
| Authority                | https://login.microsoftonline.com/e95f1b23-abaf-45ee-821d-b7ab251ab3bf |
| User                     | Kyle.Coder@va.gov                                                      |
```

### Why Orphaned
Potentially sensitive identifiers; not required in every AI context. Path-specific Power Apps file already documents authentication pattern without full table.

### Recommended Disposition
ARCHIVE or MOVE to a new `environment.instructions.md` if frequent reuse is needed.

### Impact If Deleted
Loss of quick copy/paste reference; no behavioral impact.

---

## 4. CLI Authorization Onboarding Steps (Verbatim)

### Original Text
```
### How to Set Up CLI Authorization for Future Users (VA USGov)

1. **Install Power Platform CLI:**
   - Download and install from: https://aka.ms/PowerPlatformCLI

2. **Open PowerShell and run:**
   pac auth create --environment "e95f1b23-abaf-45ee-821d-b7ab251ab3bf" --tenant "e95f1b23-abaf-45ee-821d-b7ab251ab3bf" --cloud "UsGov" --name "<YOUR_PROFILE_NAME>"
   - Sign in with your VA credentials when prompted.

3. **Verify your connection:**
   pac auth who
   - Confirm the output matches the environment and user info above.

4. **Troubleshooting:**
   - If you get an environment error, try using just the GUID for `--environment`.
   - Always use `--cloud "UsGov"` for government tenants.
   - For multiple profiles, use `pac auth list` and `pac auth select --index <n>`.

5. **Reference:**
   - Power Platform CLI Docs: https://aka.ms/PowerPlatformCLI
```

### Why Orphaned
Detailed onboarding seldom needed in day-to-day AI completions; core command standardized in path-specific file.

### Recommended Disposition
CONDENSE in `power-apps.instructions.md` (already partially) & ARCHIVE verbatim here.

### Impact If Deleted
Slight onboarding friction for new contributors; no runtime impact.

---

## 5. Standard Response Phrases (Verbatim)

### Original Text
```
Standard Security Response: "This operation requires administrator privileges which are restricted on VA Healthcare enterprise systems. I'll provide user-scope alternatives that comply with your security policies."
Standard Workspace Cleanup Response: "Executing comprehensive workspace cleanup and file organization..."
Standard Repository Health Response: "Executing comprehensive repository health check and validation..."
Standard Commit Workflow Response: "Executing automated local git commit workflow..."
Standard Continuation Response: "Continuing with the remaining tasks to complete the full workflow..."
Standard Execution Response: "Executing [task name] to continue the workflow..."
Standard Recovery Response: "I encountered a content filter issue with my previous response. Let me complete your request using a summarized approach that avoids the filtering problem while still accomplishing your original goal."
```

### Why Orphaned
Semantic variants now implied by protocols; duplicating every phrase increases maintenance overhead.

### Recommended Disposition
CONDENSE: Keep one canonical phrasing per protocol in active files; ARCHIVE originals here.

### Impact If Deleted
No functional loss; minor reduction in wording consistency reference.

---

## Guidance Summary Table
| Orphan Item | Reason | Suggested Action | Functional Risk if Removed |
|-------------|--------|------------------|-----------------------------|
| VS Code Tasks Catalog | Descriptive only | Archive | None |
| Scripts Catalog | Superseded by table | Archive | None |
| Environment Reference | Sensitive / rarely needed | Archive or Move | None |
| CLI Onboarding Steps | Duplicate detail | Archive (condense kept) | Low |
| Standard Response Phrases | Redundant wording | Condense & Archive | None |

---

## Next Steps Decisions
1. Accept defaults (Archive all).
2. Promote any item to active universal file (remove from orphan list & embed in v2 permanently).
3. Create new specialized file (e.g., `environment.instructions.md`) for environment table if used often.
4. Delete items after confirmation (final cleanup prior to activation).

Please mark decisions per item before activation; no behavior changes occur until legacy file is archived.

---
END OF ORPHANED INSTRUCTIONS REFERENCE
