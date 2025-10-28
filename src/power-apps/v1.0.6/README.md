# Employee Recognition Canvas App (v1.0.6)

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

Unified and authoritative documentation for the Power Apps Canvas sub‑component of the Employee Recognition Platform. It consolidates prior separate docs (`AppDesign.md`, `README_alternate.md`) into a single maintained source. Do **not** recreate those files—update this one instead.

---
## 1. Overview
The Canvas App enables employees to submit, track, approve, and report on recognition nominations across multiple award types (e.g., HeRO, Great Catch, Starfish, I CARE). It integrates with SharePoint for data persistence and Power Automate for approval routing, notifications, and operational automation. This release (v1.0.6) focuses on triage workflow refinements, toolbar-driven new submission flows, and groundwork for version telemetry.

Core attributes:
- Multi-role experience: Submitter, Approver, Administrator
- Config-driven behavior (see `app-config.json` / `flow-config.json`)
- Enterprise alignment: VA branding, accessibility (Section 508), audit readiness
- Extensible structure supporting additional award categories and flows

---
## 2. Source & Packaging Layout
```
src/v1.0.x/v1.0.0/power-apps/
  README.md                # This consolidated document
  app-config.json          # UI + feature + validation + branding config
  AppDesign (merged)       # (Removed – content in sections below)
  README_alternate (merged) # (Removed)
  / (Unpacked source lives in versioned higher-level directories during pack/unpack cycles)
```
Packaged artifacts (.msapp) are stored under release directories (e.g., `releases/v1.0.x/EmployeeRecognitionApp_v1.0.6.msapp`) using `pac canvas pack`. Unpacked sources stay in versioned folders (`src/power-apps/EmployeeRecognitionApp_v1.0.x/Source` pattern in earlier versions) and are committed for diff-based review.

---
## 3. Feature Summary
Category | Highlights
---------|-----------
Submission | Dynamic form adapting to award level & type, draft mode, attachment support
Approval | Role-based approval views, escalation-ready configuration via flows
Reporting | Dashboard charts (type, department, volume, cycle time)
Guidance | Contextual help + (planned) embedded tutorial video references
Security | Row-level access patterns, audit logging enablement, least-privilege data connectors
Accessibility | Screen reader labels, keyboard navigation, high contrast, structured focus order
Performance | Pagination, lazy load, selective concurrent data fetches, caching primitives

---
## 4. Screen Inventory
Screen | Purpose | Key Elements | Notes
-------|---------|--------------|------
Home | Landing & overview | Stats (totals, pending), recent feed, navigation tiles | Entry hub; minimize first-load calls
Submit Recognition | New nomination form | Employee selector, award level/type, description, justification, attachments | Draft + validation; rich text planned → plain text sanitized
My Nominations | User submissions gallery | Filters (status/date/name), edit drafts, withdraw pending | Delegation-aware filtering
Approvals | Pending approvals (role-based) | Detail pane, Approve/Reject/Request Info, comments | Future bulk approval toggle (feature flag)
Reports Dashboard | Analytics & metrics | Charts (dept/type/month/top employees), export | Offloaded heavy queries to flows (planned)
Admin | Administrative console | Approver assignments, award delivery status, role management, system checks | Restricted via role claims

---
## 5. Data Connections & Model
Primary Data Sources:
- SharePoint: Recognition master list (+ optional approval/delivery tracking lists)
- Office 365 Users: User profile lookups
- Office 365 Outlook (optional): Notification fallback when not using flows
- Power Automate: Approval, escalation, milestone tracking, reporting jobs

Future (config toggled): Teams integration, Power BI dataset push, finance system endpoint.

---
## 6. Configuration Linkage
Config File | Scope | Sample Keys | Operational Impact
-----------|-------|-------------|-------------------
`app-config.json` | UI, UX, validation, branding, feature flags | `features.enablePublicRecognitionBoard`, `validation.maxAttachments` | Controls client behaviors & toggles
`flow-config.json` | Workflow, escalation, notifications | `approvalConfiguration.level1ApprovalTimeoutDays` | Drives timing & threshold SLAs

Placeholders: `TENANT_PLACEHOLDER` tokens are substituted during packaging/release automation (see `prepare-release.ps1`). Avoid hardcoding tenant URLs in formulas; centralize in config variables loaded on App.OnStart.

---
## 7. State: Variables & Collections
Type | Identifier | Purpose
-----|-----------|---------
Global Variable | `gblCurrentUser` | Cached current user profile object
Global Variable | `gblUserRole` | Role string (Submitter/Approver/Admin)
Global Variable | `gblIsAdmin` / `gblIsApprover` | Boolean flags for conditional UI
Collection | `colDepartments` | Department lookup values
Collection | `colRecognitionTypes` | Recognition categories from config / list
Collection | `colAwardLevels` | Mapped award levels (min/max/approval flags)
Collection | `colMyNominations` | User-filtered nominations for gallery
Collection | `colPendingApprovals` | Items requiring current approver’s action

OnStart Pattern (conceptual):
```
// Simplified pseudo-Power Fx
Set(gblCurrentUser, User());
// Load config (future externalization) then hydrate lookup collections
Concurrent(
  ClearCollect(colDepartments,    Filter(DepartmentsSource, Active = true)),
  ClearCollect(colRecognitionTypes, RecognitionTypesSource),
  ClearCollect(colAwardLevels,    AwardLevelsSource)
);
// Determine roles
Set(gblIsApprover, LookUp(Approvers, User().Email = Email, true));
Set(gblIsAdmin,    LookUp(Admins,    User().Email = Email, true));
Set(gblUserRole, If(gblIsAdmin, "Admin", If(gblIsApprover, "Approver", "Submitter")));
```

---
## 8. Core Logic & Validation Patterns
Concern | Pattern
--------|--------
Required Fields | `If(IsBlank(DataCardValue_X.Text), Notify("Description required", NotificationType.Error))`
Length & Bounds | Clamp description/justification lengths using config max
Award Amount | Validate against `awardLevels` min/max; enforce additional approval when threshold exceeded
Conditional Visibility | `Visible: gblIsAdmin` or role-based composite conditions
Dynamic Icons | Switch over recognition type → media asset name
Error Handling | Wrap `SubmitForm(FormRecognition)` in `If(IsError(...), Notify(...))`

---
## 9. Accessibility & UX Standards
- All actionable controls have `AccessibleLabel`
- Focus order is verified per screen; critical paths test with keyboard only
- Color contrast meets WCAG AA using palette from `assets/README.md`
- Alt text for logos/icons; purely decorative visuals flagged appropriately
- High contrast mode: avoid color-only encoding of award status (use icon + text)

---
## 10. Performance & Delegation
Strategy | Implementation
---------|---------------
Delegation | Restrict complex filters to delegable predicates (Created date range, status, user email)
Pagination | Config-driven items per page (`defaults.itemsPerPage`)
Lazy Loading | Load heavy collections only when entering dependent screen
Concurrent Loads | Use `Concurrent()` on startup for independent lookups
Caching | Time-bound (planned) with `app-config.json` `cacheExpiration`

---
## 11. Security & Compliance
Aspect | Practice
-------|---------
Row-Level Access | Filtered galleries; sensitive admin screens locked behind role checks
Audit Logging | Flows capture approval & status changes with timestamps
Least Privilege | Use service accounts only where automation necessary; human contexts resolved at runtime
Data Retention | Aligned to config retention periods (reporting & archiving flows)
PII Handling | Avoid storing unnecessary personal attributes; rely on dynamic user profile lookups

---
## 12. Installation & Deployment
### Option A – Import Packaged App (Primary)
1. Download `EmployeeRecognitionApp_v1.0.6.msapp` from `releases/v1.0.x/`.
2. Navigate to https://make.powerapps.com (select correct environment).
3. Apps → Import Canvas App → Upload → Import.
4. Rebind data connections (SharePoint lists, flows, user profiles).
5. Configure environment-specific variables (OnStart or environment variables) & test.
6. Publish & share with appropriate security groups.

### Option B – Source Modification
1. Unpack newer `.msapp` (if starting from binary) using: `pac canvas unpack --msapp <file> --sources <dir>`.
2. Make changes under source directory; commit to versioned path.
3. Re-pack with: `pac canvas pack --sources <dir> --msapp <release-target>`.
4. Re-import and regression test before promoting.

---
## 13. Environment Initialization & Flags
Representative initialization snippet (pseudo):
```
Set(gblEnvironment, "Production"); // or DEV/UAT
Set(gblFeature_PublicBoard,    true);
Set(gblFeature_BulkApproval,   false);
Set(gblFeature_MilestoneNotif, true);
```
Align these with `features` subtree in `app-config.json` to avoid divergence. Future enhancement: auto-generate a Power Fx module from JSON during build.

---
## 14. Customization Matrix
Area | How to Modify | Notes
-----|---------------|------
Branding | Update colors in `app-config.json` + asset updates | Keep contrast ratios
Award Levels | Adjust `awardLevels` object & flows’ threshold logic | Coordinate with approval flows
Form Fields | Add data cards; update validation & collections | Document changes in CHANGELOG
Notifications | Modify flow templates & email configs | Keep consistent signature block
Reporting | Extend dashboard: create new charts using existing galleries or connect to Power BI dataset | Confirm delegation

---
## 15. Testing & Validation Checklist
Category | Key Tests
---------|----------
Form Submission | All required fields enforced; attachments accepted/rejected per type & size
Approval Workflow | Level1/Level2 path; escalation timers (simulated)
Role Views | Submitter cannot access Admin or non-owned approvals
Performance | Load time under target threshold for primary screens
Accessibility | Keyboard navigation, screen reader verbalization, high contrast rendering
Security | Unauthorized user blocked from admin actions; audit entries produced
Reporting | Charts reflect underlying data after new submissions
Error Handling | Graceful errors on failed submit / connection interruptions
Mobile Responsiveness | Layout integrity on tablet & phone form factors

---
## 16. Operational Monitoring & Support
Monitoring Vector | Approach
------------------|---------
Flow Failures | Power Automate run history alerts (email distribution lists)
Performance | Manual sampling + (planned) telemetry instrumentation
Adoption Metrics | SharePoint list counts + weekly reporting flow
Configuration Drift | Hash comparison of config JSON (future script)
Asset Integrity | (Planned) asset manifest diff pre-commit

---
## 17. Version History
Version | Highlights
--------|-----------
v1.0.6 (Current) | Toolbar submission flow refinements; triage form/gallery binding; preliminary version metadata groundwork
v1.0.1 | Version/tag alignment, documentation consolidation, structural cleanup
v1.0.0 | Initial public release: full award set, security & compliance baseline

Historical release notes for the broader platform maintained in root `CHANGELOG.md`.

---
## 18. Future Roadmap (Indicative)
- Bulk approval screen enablement (feature flag toggle)
- Auto-generation of Power Fx config module from JSON
- Teams notification integration (flow + deep link to item)
- Milestone certificate templating & PDF generation
- Config schema validation pipeline + PR diff summary
- Asset manifest + image size lint pre-commit hook

---
## 19. Support & Contacts
Need | Contact / Resource
-----|-------------------
General Issues | GitHub Issues in repository
Development Queries | dev-team@va.gov
Configuration Governance | config-governance@va.gov
Flow Operations | flow-operations@va.gov
Security / Compliance | security-review@va.gov
Branding / Assets | graphics@va.gov

---
_This document is the single authoritative source for Canvas App design & operations. Update it with any functional, structural, or governance changes._
