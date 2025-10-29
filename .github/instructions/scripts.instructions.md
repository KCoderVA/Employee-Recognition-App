---
applyTo: "scripts/**/*.ps1"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# PowerShell Scripts & Automation Instructions

## Purpose
Ensure safe, consistent execution of automation scripts under `scripts/` without violating VA enterprise restrictions.

## Execution Rules
- Always run with `pwsh -ExecutionPolicy Bypass -File` for user-scope scripts.
- Never request elevation; abort if admin rights required.
- Provide colored output: Green=Success, Yellow=Warning, Red=Error.

## Logging & Error Handling
- Use `Try { } Catch { Write-Error $_ }` patterns; include contextual data (script, step name).
- Return non-zero exit code for CI-critical failures (enable actionable pipeline feedback).

## Git Operations
- Prefer script wrappers (e.g., `safe-commit.ps1`) for commit validation.
- Use `get_changed_files` tool integration over raw parsing when in Copilot automation context.

## Commit Workflow Guidance
Steps (automated): cleanup → health check → analyze → message build → commit → changelog update → verify.
Copilot should not pause for cancellation artifacts; continue unless a genuine structural failure is detected.

## Quick Command Triggers & Zero-Prompt Automation
The following short user inputs MUST initiate full, uninterrupted automation (reference legacy file for historical wording):

Trigger Groups:
- Workspace Cleanup: "Clean workspace", "Organize files", "Workspace cleanup", "Fix workspace".
- Repository Health: "Health check", "Check repo", "Repo status", "Validate repo".
- Local Commit: "Commit local", "Commit .git", "Back up local", "Local commit", "Save changes local".

Execution Guarantees:
1. Do not ask for confirmation; begin immediately.
2. Ignore false cancellation messages (see Cancellation Override Protocol below).
3. Maintain ordered chain: Cleanup → Health → Change Analysis → Commit Message → Commit → CHANGELOG Update → Confirmation.
4. Provide a concise final summary (outcomes + any warnings) after completion.
5. Abort only on structural failures (e.g., missing required script file) and report remediation steps.

## Cancellation Override & Execution Chain Protocol
If any tool or script output contains phrases like "user cancelled" or similar transient interruption indicators:
- Treat as non-fatal and continue to the next step in the chain.
- Log occurrence as: "[Warning] False cancellation artifact ignored at <step>." (yellow).
- Only halt if accompanied by an actual error code or missing prerequisite (script not found, permission denied).

Chain Integrity Checks:
- Before step start, verify required script path exists.
- After step completes, if exit code ≠ 0 and not a known benign code, attempt one auto-retry unless failure type is permission or syntax.
- On second failure: surface actionable remediation (e.g., "Run repo-health-check manually to view detailed log").

## Commit Message Construction (Condensed)
Retain conventional commit format:
```
type(scope?): brief summary

- Bullet details
- Rationale & impact

Refs: #issue, docs link
```
Supported types: feat, fix, docs, chore, refactor, perf, test, ci, build, security.

## Resilience Patterns
- Auto-Fix Modules: Attempt user-scope install once then cache failure reason.
- Path Normalization: Use `$PSScriptRoot` + relative joins.
- Rate Limit: Insert 500ms delay between heavy git operations when >25 files staged.


## Forbidden Operations (Enforced)
- System-wide installs (`winget install` with elevation, `Install-Module -Scope AllUsers`).
- Registry or LocalMachine certificate writes.

## Auto-Fix Patterns
- On missing module error: attempt `Install-Module <Name> -Scope CurrentUser`.
- On path errors: validate relative path against `$PSScriptRoot`.

## Migration Note
Content migrated from repository-wide Terminal Automation Guidelines & Commit workflow protocols.
