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

# Employee Recognition App – Configuration Index (v1.0.6)

This directory (`src/v1.0.x/v1.0.0/`) houses **versioned configuration** for the Employee Recognition App. Each subdirectory under `v1.0.x/` represents a semver minor/patch lineage snapshot. Runtime (environment-specific) adjustments should occur through **parameterization & environment variables** wherever possible—not by editing production-tagged JSON directly in-flight.

> IMPORTANT: Treat configuration artifacts as code. All changes require PR review + CHANGELOG entry where material (security, feature flags, performance thresholds).

## 1. File Inventory

File / Folder | Purpose | Promotion Strategy
--------------|---------|------------------
`power-apps/app-config.json` | Canvas App feature flags, branding tokens, validation limits, award definitions | Promote via pack/unpack cycle; avoid ad‑hoc edits in managed environments
`power-automate/flow-config.json` | Central flow orchestration + notification / approval behavior | Reference from Flow environment variables; re-import on structural change
`email-templates/` | (Planned) HTML templates for outbound notifications | Store sanitized, tokenized templates; inject dynamic values at runtime
`permissions-config.json` (future) | Role/group mapping + RBAC matrix | Generate from authoritative identity source (AAD/Entra) export script

## 2. Environment Model

Supported logical environments (baseline): `DEV`, `UAT`, `Production`.

Design Principles:
1. No secrets in repository (service principals, API keys) – use secure vault (Key Vault / Azure AD application secret) and reference by name.
2. Environment-specific values grouped under `environments.{ENV}` node.
3. Feature experimentation toggled via `features` subtree (DEV first, then UAT → Production).
4. Approval and escalation rules centralized (flow config) to prevent logic drift across multiple Flows.

## 3. Configuration Responsibilities

Role | Responsibilities | Typical Change Examples
-----|------------------|------------------------
Developer | Introduce new feature flag; adjust validation bounds | `features.enableTeamsIntegration`, `validation.maxAttachments`
Flow Owner | Tune approval SLAs, escalation thresholds | `approvalConfiguration.level1ApprovalTimeoutDays`
Administrator | Update distribution list emails | `emailConfiguration.hrTeamEmail`
Security Officer | Enforce session / audit requirements | `security.sessionTimeoutMinutes`, `compliance.enableAuditTrail`

## 4. Change Workflow
1. Propose update (issue / change request ID).
2. Local edit + validate JSON schema (planned: add JSON Schema under `docs/reference/config-schema/`).
3. Run repository health + pre-commit hooks (ensures license header & formatting where required).
4. Update `CHANGELOG.md` (Added / Changed / Deprecated sections).
5. Open PR; reviewers: App Maintainer + Flow Owner (if flow impact) + Security (if compliance node touched).
6. Merge → Tag (if version significance) → Package Canvas App → Deploy flows with updated environment variables.

## 5. Parameterization & Tokens (Planned Enhancements)
- Replace `[tenant]` placeholders during deployment using a simple substitution script (`scripts/prepare-release.ps1`).
- Introduce `${ENV}` tokens in email templates for dynamic phrasing.
- Externalize long HTML fragments to reduce JSON file size where feasible.

## 6. Validation & Tooling
Planned script additions:
- `scripts/validate-config.ps1` – Lints JSON, enforces key presence, flags secrets.
- `scripts/diff-config.ps1` – Compares two version directories (e.g., `v1.0.0` vs `v1.0.6`).
- Pre-commit hook enhancement to reject accidental secret patterns (email + credential combos, GUID + known key prefixes).

## 7. Security & Compliance Guardrails
- No service account passwords / client secrets committed.
- Email addresses should be distribution lists when possible (avoid direct PII of individuals unless required).
- Retention values align with published retention policy (24 months standard, 2-year audit retention). Adjust only with documented approval.
- Ensure any new compliance framework additions map to internal control IDs (store mapping in `docs/security/`).

## 8. Versioning Strategy
- Patch updates (v1.0.x) that only adjust timeouts, thresholds, or non-breaking flags typically DO NOT require schema version bump inside JSON; update outer app release tag instead.
- Breaking structural change (rename key, remove node) → increment minor (e.g., `v1.1.0`).
- Document deprecations with a `deprecated` array or `// DEPRECATED:` comments (avoid immediate removal without sunset timeline).

## 9. Frequently Updated Keys – Watchlist
Category | Keys | Rationale
---------|------|----------
Performance | `dataLoadLimit`, `cacheExpiration`, `maxConcurrentFlowRuns` | Capacity tuning & throttling
Approval SLA | `approvalDeadlineDays`, `level1ApprovalTimeoutDays`, `reminderIntervalDays` | Directly impacts user expectations & escalations
Notifications | `enableMilestoneNotification`, `reminderFrequencyDays` | Communication volume & compliance
Security | `sessionTimeoutMinutes`, `enableRowLevelSecurity` | Data protection posture

## 10. Future Improvements Backlog
- Add JSON Schema + VS Code `settings.json` association for IntelliSense.
- Generate Markdown diff on config change automatically in PR body.
- Introduce environment variable injection script for pipeline-driven deployments.
- Integrate configuration snapshot hash into app telemetry for support reproducibility.

## 11. Support & Escalation
Layer | Contact | Purpose
------|---------|--------
Configuration Governance | config-governance@va.gov | Policy & schema questions
Flow Operations | flow-operations@va.gov | Approval / notification behavior
App Development | dev-team@va.gov | Feature flags & validation logic
Security Review | security-review@va.gov | Compliance & audit trail changes

---
_Maintain parity between this document and actual JSON structures. Submit a PR immediately if drift is discovered._
