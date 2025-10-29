---
applyTo: "releases/**,scripts/prepare-release.ps1"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Release Management Instructions

## Versioning
- Semantic: MAJOR changes to architecture or security posture; MINOR features; PATCH fixes.
- Tag pattern: `v0.9.x` branch releases; update badge in `README.md` post-tag.

## Pipeline
1. Ensure `[Unreleased]` fully categorized.
2. Run `prepare-release.ps1` (interactive) to generate artifacts.
3. Create Git tag & push; mirror workflow syncs to personal repo.
4. Archive superseded artifacts to `archive/` if necessary.

## Rollback Strategy
- Retain previous `.msapp` and solution package artifacts.
- Document rollback triggers and steps in release notes.

## Compliance
- Validate license headers before tagging.
- Ensure environment auth steps documented for consumers.

## Migration Note
Content migrated from repository-wide Release Pipeline & Package Management sections.
