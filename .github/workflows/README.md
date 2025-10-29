<!--
  README for GitHub Actions Workflows
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

# GitHub Actions Workflows Overview

This folder contains automation workflows that support quality, transparency, and operational continuity for the Employee Recognition App. The summaries below explain their purpose in plain language first, then provide deep technical detail for maintainers. A final section proposes additional workflows to strengthen CI/CD, security, and release management.

---
## 1. Plain-English Summaries

| Workflow | What It Does | Why It Matters | When It Runs |
|----------|--------------|----------------|--------------|
| **Enforce CHANGELOG Updates** (`changelog-enforcement.yml`) | Checks that the project changelog exists, has the required sections, and is updated when meaningful changes are made. Leaves a status comment on pull requests. | Keeps a reliable historical record so anyone can understand what changed and why. Prevents silent or undocumented edits. | On pull requests to `main`/`develop` and pushes to `main`.
| **Repository Health Check** (`repository-health.yml`) | Performs a broad scan of repository structure, required files, documentation quality, link integrity, basic security indicators, and generates a health report artifact. | Continuously surfaces structural or documentation drift before it becomes technical debt. | On pushes, PRs, a weekly cron schedule, and manual dispatch.
| **Mirror to Personal Repository** (`mirror-personal.yml`) | Mirrors selected branches (or all refs in full mode) from the enterprise repository to a public personal repo to maintain transparency and community visibility. | Ensures publicly visible source is aligned with internal improvements without manual copying. Supports external contributions and audit transparency. | On pushes to key branches or manually via “Run workflow”.

### Quick Usage Notes
- Pull Request authors should glance at the CHANGELOG comment—if it says validation failed, add an entry under `[Unreleased]` or justify the exclusion.
- Health reports appear as build artifacts; download periodically for auditing.
- Mirror workflow requires a valid SSH deploy key secret (`MIRROR_SSH_KEY`). It will not push if the secret is misconfigured.

### Potential Non-Technical Improvements
- Add notification (email/Teams) when mirror fails repeatedly.
- Auto-generate a short “Release Digest” from the CHANGELOG on tag creation.
- Provide a one-click manual health “Re-run” button in docs for onboarding.

---
## 2. Technical Deep Dive

### 2.1 Enforce CHANGELOG Updates (`changelog-enforcement.yml`)
**Jobs:**
- `changelog-check`: Bash-based validation of structure and PR diff significance.
- `changelog-validation`: Extended PowerShell validation using the local script `scripts/validate-changelog.ps1` if present.
- `pr-comment`: Posts a context-aware comment using `actions/github-script`.

**Key Mechanics:**
- Validates presence of top-level header (`# CHANGELOG` case-insensitive) and `## [Unreleased]`.
- Diff logic extracts `BASE_SHA` and `HEAD_SHA` to inspect changed files; treats source/doc/script changes as significant.
- Exclusion pattern intentionally ignores workflow-only changes (as of latest adjustment) to avoid cluttering the changelog with internal automation tweaks.
- PowerShell stage optionally runs deeper semantic checks (status codes: 0=pass,1=warnings,>1=fail).
- PR comment uses an array join to avoid literal `\n` formatting artifacts.

**Internal References:**
- Relies on local `scripts/validate-changelog.ps1` if present—non-existent script is safely skipped.
- CHANGELOG policy aligns with narrative style; only `[Unreleased]` is mandated, not the full Keep a Changelog section taxonomy.

**Hypothetical Enhancement Examples:**
- Add semantic version pattern check for new entries: Regex verify `Version X.Y.Z (YYYY-MM-DD)` consistency.
- Collect categorized metrics (e.g., counts of Added/Changed/Fixed) and embed in PR comment summary.
- Add concurrency control to avoid duplicate comments (use `concurrency: changelog-${{ github.ref }}`).

**Advanced Improvement Ideas:**
- Use a composite action for changelog enforcement to share across related repos.
- Enforce tag-to-changelog alignment (fail if a tag is pushed without matching version header in CHANGELOG).

### 2.2 Repository Health Check (`repository-health.yml`)
**Scope:** Structural validation, file presence, documentation size heuristics, license header coverage, sensitive token pattern scanning, link integrity (if `npm` available), basic Git history metrics, large file detection, and artifact creation.

**Key Mechanics:**
- File presence arrays: `required_files` vs `optional_docs` for flexible location (root or `docs/`).
- Directory probing includes case-insensitive fallback searches for resilience.
- License coverage heuristic counts Markdown files containing the Apache header phrase; threshold currently set to 80%.
- Sensitive pattern scanning intentionally filters out placeholder contexts to reduce false positives.
- Generates `health-report.md` with timestamp, commit, and summary, then uploads as artifact.

**Potential Enhancements:**
- Integrate secret scanning (e.g., `trufflesecurity/trufflehog` or `gitleaks`) in a dedicated step.
- Add actionlint to validate workflow syntax.
- Provide SARIF upload for security tools (enables code scanning alerts tab integration).
- Cache dependencies for link checker to speed up repeated runs.

**Hypothetical Use Case:** A contributor adds a new large media file—this workflow flags it for review before repository bloat occurs.

### 2.3 Mirror to Personal Repository (`mirror-personal.yml`)
**Mechanics:**
- SSH key provisioning using secret `MIRROR_SSH_KEY` (ed25519 recommended).
- Conditional full mirror vs branch/tag-only sync based on `workflow_dispatch` input `force_mirror`.
- Cleanup step removes temporary private key after use.
- Failure notification job opens an issue with reproduction and manual recovery steps.

**Potential Enhancements:**
- Add timing metrics and a diff summary (list of tags newly added).
- Add a push protection step verifying the target repo’s default branch is up to date before overwriting.
- Switch from raw shell to composite/custom action for reuse and reduced YAML duplication.

**Security Considerations:**
- Key must be limited in scope (deploy key with write to target only).
- Consider adding `permissions:` block per job for principle of least privilege (explicitly `contents: write` for mirror job, `contents: none` for failure notify except issues creation).

### Workflow Interaction Notes
- CHANGELOG enforcement and health check may both evaluate docs; ensure they do not duplicate heavy link scanning unnecessarily.
- Mirror workflow should ideally run **after** health checks succeed (add `needs: health-check` if coordination desired).

---
## 3. Recommended New Workflows & Automations

Below are curated suggestions. Each includes a summary, external references, pros/cons/risks, and implementation guidance.

### 3.1 Dependency & Vulnerability Update Automation
**Summary:** Automate dependency version updates and basic vulnerability reporting.
**External References:**
- [Dependabot](https://docs.github.com/code-security/dependabot/dependabot-version-updates)
- [npm Audit](https://docs.npmjs.com/cli/v10/commands/npm-audit)
**Pros:** Reduced manual update overhead; early vulnerability patches. **Cons:** Noise from frequent PRs. **Risks:** Unvetted updates might introduce regressions.
**Implementation (Dependabot config example):** Add `.github/dependabot.yml`:
```yaml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```
**Advanced Additions:** Auto-label security updates; use GitHub Actions to auto-merge minor versions after tests pass.

### 3.2 Workflow Lint & Static Analysis
**Summary:** Ensure all workflows follow syntax and security best practices.
**Reference:** [actionlint](https://github.com/rhysd/actionlint)
**Pros:** Early detection of YAML typos and insecure patterns. **Cons:** Additional run time. **Risks:** False positives for deliberate patterns.
**Implementation:**
```yaml
name: Action Lint
on: [push, pull_request]
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: rhysd/actionlint@v1
```
**Advanced:** Add matrix strategy for multiple OS to ensure cross-runner compatibility.

### 3.3 Power Platform Packaging & Release Artifact Workflow
**Summary:** Create a workflow to run `pac canvas pack` on tag creation, upload `.msapp` artifact.
**Reference:** [Power Platform CLI](https://learn.microsoft.com/power-platform/developer/cli/introduction)
**Pros:** Guaranteed reproducible build artifacts; streamlines deployment. **Cons:** Requires configured auth profile (service account). **Risks:** Credential misuse if secrets not locked down.
**Implementation (simplified):**
```yaml
name: Package Power App
on:
  push:
    tags: ['v*']
jobs:
  pack:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install Power Platform CLI
        run: npm install -g @microsoft/powerplatform-cli
      - name: Auth (Service Principal)
        run: pac auth create --name ci --tenant ${{ secrets.PP_TENANT }} --client-secret ${{ secrets.PP_SECRET }} --client-id ${{ secrets.PP_CLIENT_ID }} --environment ${{ secrets.PP_ENV }}
      - name: Pack Canvas App
        run: pac canvas pack --sources ./src/power-apps/v1.0.6/.unpacked --msapp ./EmployeeRecognitionApp_v${{ github.ref_name }}.msapp
      - name: Upload Artifact
        uses: actions/upload-artifact@v4
        with:
          name: app-package
          path: EmployeeRecognitionApp_v${{ github.ref_name }}.msapp
```
**Advanced:** Add checksum verification; sign artifact; add release notes auto-generation.

### 3.4 License Header Enforcement
**Summary:** Fail PRs if new/changed files lack Apache 2.0 header.
**Reference:** [REUSE Tool](https://reuse.software/) or custom grep.
**Pros:** Consistent legal compliance. **Cons:** Might block trivial doc edits. **Risks:** Overhead maintaining whitelists.
**Implementation (basic grep):**
```yaml
name: License Header Check
on: pull_request
jobs:
  license:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Check headers
        run: |
          files=$(git diff --name-only ${{ github.event.pull_request.base.sha }}...${{ github.event.pull_request.head.sha }})
          missing=()
          for f in $files; do
            [[ $f == src/* ]] && continue  # Skip source exceptions
            if [[ -f $f && $f != *.md && $f != *.yml ]]; then
              if ! grep -q "Apache License, Version 2.0" "$f"; then
                missing+=("$f")
              fi
            fi
          done
          if [ ${#missing[@]} -gt 0 ]; then
            echo "Missing license headers: ${missing[*]}"; exit 1; fi
```

### 3.5 Dedicated Secret Scanning / Enhanced Security
**Summary:** Augment GitHub native secret scanning with additional tools (TruffleHog/Gitleaks).
**References:** [TruffleHog](https://github.com/trufflesecurity/trufflehog), [Gitleaks](https://github.com/gitleaks/gitleaks)
**Pros:** Reduces risk of leaked credentials. **Cons:** Slower runs. **Risks:** False positives require triage.
**Implementation (Gitleaks):**
```yaml
name: Gitleaks Scan
on: [push, pull_request]
jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: gitleaks/gitleaks-action@v2
```

### 3.6 Markdown & Documentation Quality Workflow
**Summary:** Separate docs validation (link check, spelling, heading style) from health check for clearer feedback.
**References:** [markdownlint](https://github.com/DavidAnson/markdownlint), [cspell](https://github.com/streetsidesoftware/cspell)
**Pros:** Cleaner segmentation; targeted feedback for doc contributors. **Cons:** Adds multiple jobs. **Risks:** Over-policing style.
**Implementation (markdownlint):**
```yaml
name: Docs Lint
on: pull_request
jobs:
  markdownlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: davidanson/markdownlint-cli2-action@v15
        with:
          globs: '**/*.md'
```

### 3.7 Performance / Flow Runtime Metrics (Synthetic Benchmarks)
**Summary:** Run synthetic PowerShell scripts measuring approximate packaging time, diff size, or artifact growth.
**Pros:** Detects gradual performance degradation. **Cons:** Not a real app runtime benchmark. **Risks:** Added complexity with environment auth.
**Implementation:** Build a PowerShell benchmarking script and invoke it in a workflow; store results as artifact and compare sizes.

### 3.8 Cache Optimization Workflow
**Summary:** Pre-warm caches (npm, Power Platform CLI) on schedule to reduce latency for first daily builds.
**Reference:** [Actions Cache](https://docs.github.com/actions/using-workflows/caching-dependencies-to-speed-up-workflows)
**Pros:** Faster interactive PR feedback. **Cons:** Cache storage usage. **Risks:** Stale cached tools if not invalidated correctly.
**Implementation Snippet:**
```yaml
- uses: actions/cache@v4
  with:
    path: ~/.npm
    key: npm-${{ runner.os }}-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      npm-${{ runner.os }}-
```

### 3.9 Release Notes Auto-Generation
**Summary:** Automatically assemble release markdown from CHANGELOG diff when tagging.
**Reference:** [GitHub Release Action](https://github.com/actions/create-release)
**Pros:** Saves manual effort; consistent formatting. **Cons:** Requires robust parsing logic. **Risks:** Incorrect extraction if format shifts.
**Implementation Outline:** Use a Node or PowerShell step to extract newest version block and pass to `actions/create-release`.

### Comparative Risk/Benefit Summary
| Recommendation | Benefit Impact | Complexity | Primary Risk |
|----------------|---------------|-----------|--------------|
| Dependency Updates | High | Low | Update noise / regressions |
| Workflow Lint | Medium | Low | False positives |
| Packaging Automation | High | Medium | Secret handling / CLI auth |
| License Header Check | Medium | Low | Over-enforcement |
| Secret Scanning | High | Low | False positives, run time |
| Docs Lint | Medium | Low | Style fatigue |
| Performance Benchmarks | Low/Medium | Medium | Low signal-to-noise |
| Cache Optimization | Medium | Low | Stale caches |
| Release Notes Auto-Gen | High | Medium | Parsing mismatch |

---
## 4. Educational Notes & Best Practices

### General GitHub Actions Best Practices
- **Pin Action Versions:** Use explicit version tags or SHAs (e.g., `actions/checkout@v4`). Avoid mutable `@latest` in production.
- **Permissions Hardening:** Minimize default `GITHUB_TOKEN` scopes with `permissions:` blocks per job (e.g., `contents: read`, `issues: write` only where needed).
- **Fail Fast vs. Aggregate:** For linters, failing early reduces wasted compute; for documentation quality, combining results may improve contributor experience.
- **Matrix Strategy:** Consider OS matrices only when OS differences matter (e.g., Power Platform CLI on Windows vs Linux path nuances).
- **Artifact Retention:** Set `retention-days` to project needs (30 days is reasonable; sensitive logs shorter). Avoid indefinite retention for compliance.
- **Reusable Workflow Extraction:** If multiple repos adopt similar enforcement, move logic into a reusable workflow under `.github/workflows/reusable-changelog.yml`.

### Local VS Code Integration
- Use tasks.json to mirror CI packaging steps locally (`pac canvas pack`) ensuring parity with release workflows.
- Run secret scanning locally (pre-commit hook) to reduce CI noise.

### Security Hardening Tips
- Rotate deploy keys used for mirroring at regular intervals.
- Add CodeQL or extend existing scanning with configuration for custom queries (if not already active).
- Use concurrency limits (e.g., `concurrency: mirror-${{ github.ref }}`) to prevent overlapping mirror runs.

### Power Platform Specific Notes
- For app packaging, prefer building from unpacked YAML sources to guarantee reproducibility.
- Include environment sanity checks (e.g., verifying expected tenant ID) before packaging actions.

### References
- GitHub Actions Docs: https://docs.github.com/actions
- Keep a Changelog: https://keepachangelog.com/
- Semantic Versioning: https://semver.org/
- Actionlint: https://github.com/rhysd/actionlint
- Dependabot: https://docs.github.com/code-security/dependabot
- Power Platform CLI: https://learn.microsoft.com/power-platform/developer/cli/introduction
- TruffleHog: https://github.com/trufflesecurity/trufflehog
- Gitleaks: https://github.com/gitleaks/gitleaks

---
## 5. Next Steps Checklist (Optional)
- [ ] Decide which new workflows to adopt first (suggest: Secret Scanning + License Headers)
- [ ] Add `.github/dependabot.yml`
- [ ] Implement packaging workflow on tag creation
- [ ] Add actionlint workflow for syntax validation
- [ ] Evaluate release notes auto-generation feasibility

*Feel free to adapt this README as workflows evolve.*
