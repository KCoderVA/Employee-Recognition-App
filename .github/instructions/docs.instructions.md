---
applyTo: "docs/**/*.md"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Documentation & CHANGELOG Instructions

## Purpose
Ensure consistent, concise, and traceable documentation across architecture, user guides, and release notes.

## Style
- Audience-aware tone: User guides plain; developer docs technical; security docs formal.
- Prefer headings < 60 characters; avoid deep nesting beyond H3.
- Cross-link related docs using relative paths.

## CHANGELOG Policy
- Every functional change: add entry under `[Unreleased]` with category (Added/Changed/Fixed/Security/Deprecated).
- Promote `[Unreleased]` to tagged version during release preparation script.
- No retroactive editing of historical versions except for clearly marked "Correction:" notes.

## Templates
Release entry minimal example:
```
### [X.Y.Z] - YYYY-MM-DD
Added: Brief feature summary.
Changed: Concise refactor note.
Fixed: Issue reference (#123).
Security: Hardening description.
```

## Migration Note
Content migrated from repository-wide CHANGELOG Management & documentation review sections.

## Public Code Filter Bypass Protocol (Migrated)
When a response is blocked for matching public code:
1. Switch to summary mode (bullets, high-level descriptions) – no verbatim large blocks.
2. Provide file references (paths, section titles) without copying full content.
3. Continue original task outcome (e.g., implement change, describe differences) using paraphrase.
4. Close with confirmation of completion and offer deeper dive with obfuscated excerpts if truly needed.

Standard Recovery Response:
"Encountered content filter. Proceeding with summarized, paraphrased guidance to fulfill the original request without blocked verbatim code."

Cross-Reference: Additional operational aspects and debugging escalation in `debugging.instructions.md`.
