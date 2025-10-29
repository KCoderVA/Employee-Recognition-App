---
applyTo: "test/**,src/**/*.fx.yaml"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Quality Assurance & Testing Instructions

## Scope
Applies to test artifacts under `test/` and validation logic referencing source formulas.

## Testing Layers
- Unit: Formula/component logic isolation (mock data sources when feasible).
- Integration: End-to-end flow: submission → approval → SharePoint persistence.
- Performance: Measure response time for heavy list filters (< 1s target average under 5k items with indexed columns).

## Protocols
- Multi-device: Simulate desktop, tablet, mobile layouts—verify responsive control sizing.
- UAT: Validate each award category path and escalation.
- Regression: Scripts confirm no orphaned YAML properties post-refactor.

## Acceptance Criteria Template
```
Feature: Starfish Award Submission
Must: Save item, trigger approval flow, send Teams notification.
Should: Display success screen within 2s.
Security: No PII exposed in notifications.
```

## Migration Note
Content migrated from repository-wide Testing Protocols section.
