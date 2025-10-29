---
applyTo: "src/sharepoint/**"
---
<!-- Copyright 2025 Kyle J. Coder | Migrated 2025-10-29 -->
# SharePoint Data Layer Instructions

## Purpose
Govern list schema changes, permissions, and audit requirements for award data.

## Schema Guidelines
- Separate content types per award (HeRO, Great Catch, Starfish, I CARE) enabling distinct metadata.
- Index frequently queried columns (Created, AwardType, Status) for delegation performance.
- Use choice fields for controlled vocabularies; avoid free-text when enumerations exist.

## Permission Strategy
- Apply least privilege: Submitters read own items; approvers broader read; admins full control.
- Sensitive fields (PII) flagged with internal-only column setting.

## Audit & Compliance
- Retain version history for all recognition lists.
- Log approvals and escalations in dedicated audit list with timestamp, actor, previous status, new status.

## Integration Notes
- Flows must reference content type IDs rather than display names where stability required.
- Canvas App should filter using indexed columns only.

## Data Privacy
- No storage of credentials, PHI, or secrets in list fields.
- Use separate secure storage for configuration secrets (not SharePoint lists).

## Migration Note
Content migrated from repository-wide "SharePoint Integration" section.
