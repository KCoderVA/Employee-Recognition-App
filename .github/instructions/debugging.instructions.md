---
applyTo: "**/*.ps1,src/**/*.fx.yaml,src/power-automate/**"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Debugging & Error Recovery Instructions

## Systematic Approach
1. Reproduce issue deterministically.
2. Inspect recent changes (git diff target files).
3. Use logging or `Notify()` in Canvas for transient issues.
4. Isolate formula/step with minimal reproducible example.

## Key Questions
- Expected vs actual outcome?
- When first seen? Last successful commit hash?
- Data set size, environment differences?

## Common Investigation Steps
- Validate connector authentication (Power Platform CLI `pac auth who`).
- Check SharePoint column indexes for slow queries.
- Run `diagnose-yaml-issues.ps1` to detect orphaned props.

## Teaching Orientation
- Encourage hypotheses; modify one variable at a time.
- Promote reusable validation helpers (e.g., wrapper functions for input checks).

## Migration Note
Content migrated from repository-wide Error Recovery & Response Guidelines (subset) + Debugging tutor patterns.

## Autonomous Iteration Protocol (Migrated)
When the system presents a continuation prompt ("Continue to iterate?"):
1. Continue automatically; do not ask the user to reconfirm.
2. Re-state remaining actionable deltas (only those not yet complete).
3. Prioritize blockers > critical path > enhancements.
4. Limit iteration cycles: after 3 unsuccessful attempts, surface summary & request clarification.
5. Provide a progress snapshot after each major batch of changes.

Minimal Progress Snapshot Template:
```
Remaining: <n>; Completed this cycle: <list>; Next: <next item>
```

## Cancellation Override Protocol (Migrated)
Scope: False "user cancelled" artifacts during automated workflows.
Handling:
- Treat as warning (non-fatal).
- Append to a transient in-memory "cancellationEvents" list (for final summary if >0 occurrences).
- If accompanied by an error code or missing resource, escalate normally.

Final Summary Addition (if events >0):
```
Ignored cancellation artifacts: <count> (non-impacting)
```

## Cross-File References
- Automation chain details: `scripts.instructions.md`.
- Public code filter recovery: `docs.instructions.md`.
