---
applyTo: "src/power-apps/**"
---
<!--
  Copyright 2025 Kyle J. Coder
  Apache License 2.0
  Migrated from repository-wide instructions on 2025-10-29.
-->
# Power Apps Canvas App Development & YAML Source Control Instructions

## Purpose
Guide Copilot when generating, refactoring, or reviewing Canvas App YAML (`*.fx.yaml`, control templates, data sources) to ensure enterprise ALM, performance, accessibility, and VA Healthcare security compliance.

## Core Principles
- Source-first: Always modify unpacked source under `src/power-apps/EmployeeRecognitionApp_v*/Source/`, never edit packaged `.msapp` directly.
- Deterministic builds: Packaging uses `pac canvas pack`; do not introduce tooling requiring elevation.
- Least surprise: Maintain consistent control naming and formula style to reduce merge conflicts.
- Performance & Delegation: Favor delegable operations; surface delegation warnings explicitly.

## Naming Conventions
- Controls: `btn`, `lbl`, `gal`, `ico`, `scr`, `cmp` prefixes + PascalCase descriptive noun (e.g., `btnSubmitRecognition`).
- Collections: camelCase with plural noun (e.g., `recognitionsRecent`).
- Variables: `var` prefix for global (`Set(varCurrentUser, User())`). Context variables keep camelCase.
- Components: PascalCase singular domain concept.

## Packaging Workflow (ALM)
1. Edit formulas & controls in YAML source.
2. Validate structure: No orphaned properties; run `diagnose-yaml-issues.ps1` if anomalies suspected.
3. Performance pass: Search for non-delegable patterns (`Search`, `Lookup` with large lists) and replace with delegable `Filter`, `StartsWith` when possible.
4. Accessibility pass: Ensure label `TabIndex`, `AccessibleLabel`, and color contrast guidelines (WCAG AA) via script `fix-form-accessibility-properties.ps1` if required.
5. Pack app: `pac canvas pack --sources ./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source --msapp ./releases/v0.9.x/EmployeeRecognitionApp_v0.9.0.msapp`.
6. Manual portal import (web), smoke test, export updated `.msapp` if changes were web-based.
7. Unpack exported app (if changed externally): `pac canvas unpack --msapp <file> --sources ./src/power-apps/EmployeeRecognitionApp_v0.9.0/Source`.

## Formula Standards
- Prefer `With()` to reduce repeated calculations.
- Guard network calls: Wrap in `IfError()`; provide user-friendly `Notify()` messages.
- Avoid chained `If` ladder; use `Switch()` for discrete state evaluation.
- Use `Concurrent()` for independent data loads at app start.
- Cache frequently used static reference data in collections during `OnStart`.

## Delegation Checklist
- Verify SharePoint queries: Use indexed columns for `Filter()` predicates (`Created`, `CreatedBy`).
- Replace non-delegable functions with delegable equivalents (e.g., `StartsWith` instead of `Left` substring match).
- Limit collection size for local, non-delegable operations (< 500 rows) and document rationale.

## Error Handling Pattern
```
If(
    IsError(SubmitForm(formRecognition)),
    Notify("Error submitting recognition: " & ErrorMessage, NotificationType.Error),
    Navigate(screenSuccess, ScreenTransition.Fade)
)
```
Keep messages user-centric; avoid exposing internal stack traces.

## Accessibility Guidelines
- Labels: Provide `AccessibleLabel` for icon-only buttons.
- Contrast: Minimum 4.5:1; prefer theme variables instead of hard-coded hex values.
- Focus: Ensure logical tab order and visible focus styles.

## Performance Optimization
- Minimize control count per screen; reuse components.
- Avoid overuse of `Set()` for transient context—prefer `UpdateContext()`.
- Do not store large remote datasets locally unless required; load on demand.

## Security & Compliance
- Never embed credentials or secrets; authentication handled by platform connectors.
- Document any data privacy considerations for new collections referencing PII.

## Review Prompts (for Copilot)
When asked to optimize or review Canvas formulas:
- Check delegation warnings.
- Suggest component extraction for reusable UI patterns.
- Recommend `With()` or `Concurrent()` where repeated logic or parallel loads occur.

## Migration Note
Content migrated from repository-wide section "Canvas App Development Workflow" & "Power Fx Formula Standards".
