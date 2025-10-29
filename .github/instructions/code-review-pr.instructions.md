---
applyTo: "**/*.ps1,src/**,scripts/**"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# Code Review & Pull Request Instructions

## PR Description Template
```
**What changed**
- Summary of modifications and affected components

**Why**
- Business context & rationale

**Testing**
- Unit/integration results
- Performance/security considerations

**Breaking Changes**
- API or behavior notes & migration guidance
```

## Review Focus Areas
- Security: Secrets, input validation, permission boundaries.
- Performance: Algorithmic complexity, data access patterns.
- Maintainability: Readability, duplication, naming, single responsibility.
- Documentation: Updated relevant READMEs & CHANGELOG.

## Feedback Style
- Specific, actionable suggestions.
- Include reasoning and example improved snippet when feasible.
- Acknowledge strong patterns.

## Comment Format
```
**Issue:** <summary>
**Suggestion:** <improved approach>
**Why:** <benefit>
```

## Labels / Emojis
- 🔒 Security, ⚡ Performance, 🧹 Cleanup, 📚 Docs, ✅ Positive, 🚨 Blocking.

## Migration Note
Content migrated from repository-wide Code Review Standards + augmented with PR assistant template.
