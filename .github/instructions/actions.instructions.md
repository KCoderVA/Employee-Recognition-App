---
applyTo: ".github/workflows/**/*.yml,.github/workflows/**/*.yaml"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# GitHub Actions Workflow Instructions

## Security
- Pin third-party actions by full commit SHA (not moving tags) for supply chain integrity.
- Define `permissions:` minimally (never default `write-all`).
- Use `secrets` for sensitive values; never echo raw secrets.

## Reliability & Performance
- Add `timeout-minutes` per job to avoid hanging runners.
- Use matrix only where result differences matter; avoid unnecessary combinatorial explosion.
- Cache dependencies where deterministic (Node, PowerShell modules if version pinned).

## Structure
- Descriptive workflow `name:` matching purpose.
- Group logically: build, test, package, compliance.
- Use separate jobs for orthogonal validations (e.g., changelog vs health check) to allow parallelization.

## Validation Enhancements
- Include step to run `repo-health-check.ps1 -Detailed` on main PRs.
- On failure, output actionable suggestions referencing scripts.

## Example Skeleton
```yaml
name: CI
on:
  pull_request:
    paths-ignore:
      - 'docs/**'
  push:
    branches: ['main']
jobs:
  changelog:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - name: Validate Changelog
        run: pwsh -File scripts/validate-changelog.ps1 -Detailed
```

## Migration Note
Content migrated from repository-wide CI/CD and workflow guidance sections.
