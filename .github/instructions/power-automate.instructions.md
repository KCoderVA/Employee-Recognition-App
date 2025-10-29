---
applyTo: "src/power-automate/**"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Power Automate Flow Development Instructions

## Scope
Applied to YAML/JSON definitions, solution exports, and documentation under `src/power-automate/`.

## Design Principles
- Descriptive action names: Business context > generic (e.g., `Route_Recognition_To_Approver` not `Condition2`).
- Idempotent triggers: Ensure flows handle duplicate events gracefully.
- Observability: Include tracking (compose) steps for critical routing values.

## Error Handling Pattern
- Use parallel branch with `Configure Run After` for failure paths.
- Log failure context (inputs, correlation id) to audit list.
- Notify stakeholders with actionable message (include link to flow run).

## Performance & Concurrency
- Minimize sequential dependency; run independent operations in parallel branches.
- Batch SharePoint operations with `Create item` inside `Apply to each` only when necessary—consider bulk actions or selective updates.
- Avoid unnecessary `Get items` without filters; always narrow query.

## Naming Conventions
- Trigger: `TRG_<Entity>_<Event>`
- Variables: `varRecognitionId`, `varAwardType`
- Environment-specific connectors documented in solution metadata.

## Security
- Principle of least privilege: Use scoped connection references.
- Do not hardcode emails; reference environment variables / configuration list.
- Redact sensitive values in notifications.

## Testing Guidance
- Create sample recognition payload for unit runs.
- Validate approvals escalate correctly for each award category.

## Review Prompts
When improving a flow, Copilot should:
- Suggest variable initialization consolidation.
- Identify actions that can run in parallel.
- Check error branch completeness.

## Migration Note
Content migrated from repository-wide "Power Automate Best Practices" section.
