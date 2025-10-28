# Triage and Approval Flow (v1.0.1)

<!--
   Copyright 2025 Kyle J. Coder

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   # Recognition Workflow Flows – Consolidated Architecture (v1.0.6)

   <!--
      Copyright 2025 Kyle J. Coder

      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
   -->

   Unified, authoritative documentation for all Power Automate flows supporting the Employee Recognition Platform (data collection, triage, multi‑level approvals, notification orchestration, escalation, delivery tracking, follow‑ups, and reporting). This merges prior alternate READMEs (`README_alternative*.md`, notification / follow‑up / architecture templates) into one maintained source. Remove alternates after review; update only this file going forward.

   ---
   ## 1. Scope & Objectives
   The workflow suite automates the full lifecycle:
   1. Submission intake & validation
   2. Tracking ID assignment & approver resolution
   3. Multi-level approval routing with SLA timers
   4. Escalation & reminder handling
   5. Notifications (submitter, approvers, employee, leadership, finance, HR)
   6. Award delivery orchestration (monetary & non‑monetary)
   7. Follow-up & completion verification
   8. Monthly analytics & metrics generation
   9. Audit logging & compliance traceability

   Release alignment: **v1.0.6** (adds refinements to escalation clarity, structured notification templates, and roadmap for config-driven thresholds).

   ---
   ## 2. Source File Inventory
   File | Purpose
   -----|--------
   `TriageAndApproval_definition.json` | Canonical main approval + triage flow definition
   `TriageAndApproval_connections.json` | Connection references (SharePoint, Outlook, Approvals, Teams)
   `TriageAndApproval_apis.json` | API connector mapping / dependencies
   `TriageAndApproval_manifest.json` | Metadata (flow identity, environment IDs, properties)

   Child / Supporting flows (logical grouping; some may be separate exported packages):
   Category | Flow Name (Logical) | Description
   ---------|---------------------|------------
   Data Collection | New Recognition Submission Flow | Intake, validation, approver resolution, initial notifications
   Data Collection | Recognition Update Handler | Reacts to modifications, routes status & comment changes
   Approval | Level 1 Approval Flow | First-level SLA enforcement & conditional escalation
   Approval | Level 2 Approval Flow | Executive / HR approvals for higher tiers
   Approval | Approval Escalation Flow | Daily overdue scan & escalation
   Notifications | Submission Confirmation Flow | Nominator confirmation w/ tracking ID
   Notifications | Approver Notification Flow | Action-required approval email + optional calendar entry
   Notifications | Employee Recognition Notification | Congratulatory message upon final approval
   Notifications | Status Update Notification | Generic status change dispatcher
   Follow-up | Award Delivery Tracking Flow | Branching for monetary vs non‑monetary fulfillment
   Follow-up | Follow-up Reminder System | Daily review of pending delivery / actions
   Reporting | Monthly Recognition Summary Flow | Analytics, stats, leadership report
   Completion | Recognition Completion Cleanup | Archival, final metrics, milestone detection

   ---
   ## 3. High-Level Architecture
   ```
   Submission (SharePoint Item Created)
     → Intake Flow (validation + approver assignment + confirmation)
        → Approver Notification Flow (L1)
           → Level 1 Approval Flow
               (Approve) ──> (If L2 needed) Level 2 Approval Flow
                                    │
                                    └─> (Approved) → Award Delivery Tracking Flow
                                                        → Follow-up Reminder System (scheduled)
                                                        → Completion Cleanup Flow (on delivery complete)

   Scheduled Support:
     • Approval Escalation Flow (daily)
     • Monthly Recognition Summary Flow (monthly)
   ```

   ---
   ## 4. Award Categories & Routing Matrix
   Award Type | Typical Levels | Sample Level Roles | Routing Notes
   -----------|----------------|--------------------|--------------
   HeRO | 2–3 | Supervisor → Service Chief → Exec Leadership (if high-value) | Additional public affairs notification
   Great Catch | 2–3 | Safety Officer → Dept Head → Quality Committee | Emphasis on risk / safety data capture
   Starfish | 1–2 | Supervisor → Dept Head (monetary) | Peer recognition; may skip head for non‑monetary
   I CARE | 2–3 | Values Committee → Service Line Director → Chief of Staff | Values-based; strong messaging templates

   Escalation triggers adjust by award type & amount (see config roadmap §17).

   ---
   ## 5. Key Variables (Common Patterns)
   Variable | Purpose | Typical Origin
   ---------|---------|---------------
   `varTrackingID` | Unique external-facing reference (e.g., REC-YYYYMMDD-####) | Constructed on submission
   `varAwardLevel` | Award monetary bracket / classification | SharePoint item field
   `varApproverEmail` | Current approval actor | Lookup (user profile / dept head list / config)
   `varDaysPending` | SLA / escalation calculations | Date math in escalation flow
   `varEscalationLevel` | Warning vs Critical classification | Derived from thresholds (e.g., ≥5, ≥10 days)
   `varDeadline` | Approval due date | Added days from now (5 or 3 business days)

   ---
   ## 6. Submission Intake (New Recognition Submission Flow)
   Steps | Summary
   ------|--------
   Initialize | Set tracking ID, cache key fields (award level, dept, nominator)
   Validate | Required field presence (employee, type, description). Fail → mark Incomplete + notify nominator
   Determine Approvers | Switch award level → L1 + optional L2 mapping (supervisor, dept head, HR Director, etc.)
   Persist | Update SharePoint item with tracking ID, approval status = Pending Review, approver assignments
   Notify | Confirmation email to nominator (HTML template) + trigger Approver Notification Flow
   Audit | Log “New Submission” with tracking ID & timestamp
   Error Handling | Try/Catch: mark status Error, email admins, record audit entry

   Validation expands easily with additional field constraints (e.g., justification length). Keep expressions modular for maintainability.

   ---
   ## 7. Update Handling (Recognition Update Handler)
   Change Detection Branches:
   - Status update → cascade notifications / potential delivery trigger
   - New comment → notify counterpart party (approver ↔ nominator)
   - Delivery status change → metrics + possible finalization
   - Critical field change (employee, award level, recognition type) after approval → reset to Pending Review & reinitiate approval sequence (with audit note).

   ---
   ## 8. Approval Workflows
   ### 8.1 Level 1
   Action | Detail
   -------|-------
   Approval Request | First-to-respond or single approver; 5 business day target (calendar logic may be future enhancement)
   Outcomes | Approve → either advance to L2 or finalize; Reject → status Rejected + notify parties; Timeout → escalate
   Timeout Handling | Supervisor escalation + item note + optional new approval request to escalated approver
   Audit | Approved / Rejected / Escalated events appended with responder and comments

   ### 8.2 Level 2
   Action | Detail
   -------|-------
   Trigger | Prior level approved & threshold (amount or category) requires L2
   Approval Type | Everyone must approve (if multi-role) OR standard single approver depending on award level
   Custom Responses | Approve / Reject / Request More Information
   Request More Info | Status → More Information Needed; follow-up date set; nominators notified with required details
   Finalize | If approved: set final status = Approved; trigger delivery orchestration

   ### 8.3 Escalation (Scheduled)
   Logic | Description
   ------|------------
   Query | Pending or in-flight approvals beyond thresholds (e.g., 5 day warning, 10 day critical)
   Warning Actions | Reminder to approver, manager CC, add item note
   Critical Actions | Department head escalation, status note “Escalated,” log incident item
   Daily Report | Summary email (counts by escalation level, critical items list)

   ---
   ## 9. Notification Flows (Templates)
   Flow | Trigger | Content Highlights
   -----|--------|-------------------
   Submission Confirmation | After intake success | Tracking ID, next steps, expected SLA range
   Approver Notification | Pending Review status set | Rich HTML, description & justification blocks, action link, deadline
   Employee Recognition | Final approval | Congratulatory message, summary, acknowledgment of nominator
   Status Update | Status changes (L1 Approved, Approved, Rejected, More Info) | Dynamic recipient calculation; comments; next steps

   Best Practices: HTML accessibility (semantic headings), plain text alternatives (future), consistent palette (#003F72 / #CD2026 / #FDB81E), avoid inline base64 images where possible.

   ---
   ## 10. Award Delivery Tracking
   Branch | Steps
   ------|------
   Monetary | Create finance request → notify finance → update notes → create follow-up task → schedule status check
   Non‑Monetary | Certificate generation (API / manual), HR notification, status updates, queue follow-up
   Scheduled Check | Delay + re-query item; remind or escalate if still pending; end if completed
   Audit | Log “Award Delivery Initiated” with type & amount

   ---
   ## 11. Follow-up Reminder System
   Function | Description
   --------|------------
   Daily Scan | Items requiring follow-up where `FollowUpDate <= Today`
   Urgency Classification | Days overdue → Normal / Warning / Critical (e.g., >2 or >5 days)
   Emails | Tailored messaging with overdue context and next action
   Summary | Aggregated HTML table to HR administration distribution
   Rescheduling | Optionally push FollowUpDate if reattempt needed (future enhancement)

   ---
   ## 12. Monthly Summary & Analytics
   Metric | Description
   -------|-----------
   Total Recognitions | Count in previous month
   By Department / Type | Aggregated distribution objects (pie / bar data sources)
   Total Award Amount | Sum of monetary awards
   Average Approval Time | Duration from submission to final approval date
   Top Recognized Employees | Ranked list (frequency)
   Top Nominators | Ranked list (frequency)
   Trend Data | 12-month month-over-month volumes

   Outputs: HTML email + Excel export stored in Report library + archive entry.

   ---
   ## 13. Completion & Cleanup
   Trigger: Delivery status → Completed.
   Tasks: Verify required fields, finalize status, send final confirmations (nominator / employee / HR), archive attachments, update metrics, milestone detection (e.g., 5,10,25 recognitions), certificate registry entry, audit log record “Full lifecycle completed.”

   ---
   ## 14. Error Handling & Resilience
   Layer | Strategy
   ------|---------
   Critical Actions | Encapsulated in Try/Catch scopes with failure routing
   Retries | Built-in automatic retry for transient operations (SharePoint/HTTP) where safe
   Notifications | Admin distribution list emailed on persistent failures or unexpected outcomes
   Graceful Degradation | Non-critical notifications skipped rather than failing entire flow
   Logging | Central audit + error log (flow run ID, timestamp, category, error text)

   ---
   ## 15. Security & Compliance
   Aspect | Implementation
   -------|---------------
   Least Privilege | Service account scoping restricted to required lists & connectors
   Audit Trail | All state transitions logged (submission, approvals, rejections, escalations, completion)
   Data Protection | No secrets hard-coded (use environment variables / connections) – planned schema validation
   PII Minimization | Only essential employee identifiers stored; extended info resolved at runtime
   Access Review | Quarterly review of connector permissions & service principal
   Retention | Reporting & audit lists aligned with retention policy (24 months typical; archive thereafter)

   ---
   ## 16. Performance & Optimization
   Technique | Benefit
   ---------|--------
   Parallel Branches | Lower latency for independent notifications
   Conditional Short-Circuiting | Avoid unnecessary connector calls
   Batch Operations (future) | Reduce round trips for mass updates
   Delegated Filtering | SharePoint OData filters vs client-side loops
   Caching (planned) | Store config mappings in environment variables / dataverse table for rapid lookup

   Monitoring Signals: Run duration trends, throttle events, failure rate (<5% target), average approval time variance.

   ---
   ## 17. Configuration & Externalization Roadmap
   Area | Current | Planned Enhancement
   -----|--------|--------------------
   SLA Thresholds | Hard-coded (5/10 days) | Move to `flow-config.json` with environment overrides
   Escalation Recipients | Derived via manager / static lists | Configurable escalation matrix (JSON)
   Email Templates | Inline HTML in Compose | Central template store + token replacement
   Award Level Logic | Switch statements | Data-driven mapping table (SharePoint / Dataverse)
   Milestone Thresholds | Hard-coded array | External thresholds + message variants

   ---
   ## 18. Testing & Validation Matrix
   Category | Tests
   --------|------
   Submission Intake | Required field enforcement, invalid data rejection, tracking ID format
   Approval Paths | L1 only, L1→L2, Rejection, More Info, Timeout escalation
   Notifications | Each template renders & recipients correct (HTML + alt text)
   Escalation | Synthetic overdue items escalate at thresholds; daily summary accuracy
   Delivery | Monetary vs non‑monetary branching; follow-up reminder generation
   Completion | All final notifications + metrics + milestone detection
   Error Handling | Forced connector failures produce admin alerts & preserved state
   Reporting | Monthly figures match manual spot checks
   Security | Unauthorized account cannot trigger restricted flows

   ---
   ## 19. Operational Monitoring
   Channel | Metric / Action
   -------|-----------------
   Flow Analytics | Failure %, average duration, run counts
   Escalation Report | Daily review for chronic bottlenecks
   Monthly Summary | Leadership consumption & variance analysis
   Audit Log | Random sample verify integrity
   Exception Log | Categorize root causes & address recurrent patterns

   ---
   ## 20. Troubleshooting Guide
   Issue | Likely Cause | Resolution Steps
   -----|-------------|-----------------
   Approval delays | Approver OOF / unassigned L2 | Check manager chain, validate escalation flow run
   Missing notifications | Broken connection reference | Re-authenticate Outlook/Teams connectors in environment
   Incorrect routing | Award level mapping drift | Review switch logic; compare with `app-config.json` awardLevels
   Timeout not escalating | Recurrence flow paused | Confirm schedule still active; check environment run history
   Duplicate emails | Parallel branch duplication | Consolidate email actions under single condition or use idempotency flag

   ---
   ## 21. Governance & Change Control
   All structural modifications require:
   1. Issue / change request reference
   2. Update to this README section if logic class changes (e.g., new escalation tier)
   3. CHANGELOG entry (Added / Changed / Deprecated)
   4. Export of updated flow definition committed under versioned path
   5. Peer review (App + Flow Owner + Security for compliance-impacting changes)

   ---
   ## 22. Future Backlog
   - Business-day aware SLA calculation (skip weekends/holidays)
   - Central tokenized HTML template service
   - Telemetry integration for proactive SLA breach prediction
   - Config-driven dynamic approver groups (Dataverse table)
   - Power BI streaming dataset for real-time dashboarding
   - Automated config diff report in PR descriptions

   ---
   ## 23. Support & Contacts
   Need | Contact
   ----|--------
   Flow Operations | flow-operations@va.gov
   Configuration Governance | config-governance@va.gov
   Security / Compliance | security-review@va.gov
   Development / Enhancements | dev-team@va.gov
   Branding / Templates | graphics@va.gov

   ---
   _Single authoritative flow documentation. Update promptly with any logic, SLA, or structural changes to prevent drift._
- User satisfaction with approval experience

## Troubleshooting

### Common Issues
- **Approval Delays** – Check approver availability and delegation settings
- **Notification Failures** – Verify email addresses and Teams permissions
- **Permission Errors** – Ensure service account has proper SharePoint access
- **Timeout Issues** – Review approval timeout configurations
- **Data Inconsistencies** – Check SharePoint list field mappings

### Monitoring and Diagnostics
- Flow run history with detailed execution logs
- SharePoint list audit trails
- Email delivery confirmations
- Teams message status
- Approval service logs and analytics

### Support Escalation
- Level 1: Flow administrator review and basic troubleshooting
- Level 2: Power Platform administrator involvement
- Level 3: Microsoft support for platform-level issues

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For comprehensive documentation and support, visit the main project repository.*

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-->

This folder contains the unpacked source files for the **Triage and Approval Flow**, which automates the routing, review, and approval process for employee recognition nominations across multiple award types (HeRO, Great Catch, Starfish, I CARE).

## Folder Contents

| File                                 | Description                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------------ |
| `TriageAndApproval_definition.json`  | **Core flow logic** - Complete workflow definition with multi-level approval routing |
| `TriageAndApproval_connections.json` | **Connection mappings** - Maps flow connections to SharePoint, Teams, and Outlook    |
| `TriageAndApproval_apis.json`        | **API mappings** - References to external APIs and services                          |
| `TriageAndApproval_manifest.json`    | **Flow metadata** - Flow properties, dependencies, and configuration settings        |

## Flow Functionality

### Primary Purpose
- **Automated Triage**: Intelligently routes award nominations based on type and criteria
- **Multi-Level Approvals**: Implements cascading approval workflows for different award types
- **Notification Management**: Sends notifications via Teams, Outlook, and SharePoint
- **Status Tracking**: Updates submission status throughout the approval process

### Key Features
- **Smart Routing**: Routes nominations to appropriate reviewers based on award type
- **Parallel Processing**: Handles multiple nominations simultaneously
- **Approval Workflows**: Implements Microsoft Approvals for executive-level decisions
- **Audit Trails**: Maintains complete history of approval decisions and actions

## Award Types Supported

### HeRO Awards
- Executive-level approval required
- Multi-step review process
- Special notification requirements

### Great Catch Awards
- Department-level approval
- Safety-focused evaluation criteria
- Integration with patient safety systems

### Starfish Awards
- Peer recognition workflow
- Simplified approval process
- Team-based notifications

### I CARE Awards
- Values-based recognition
- Department manager approval
- Organizational culture focus

## Using These Source Files

### For Analysis & Customization
1. **Review Flow Logic**: Open `TriageAndApproval_definition.json` to understand the complete workflow
2. **Understand Routing**: Check the conditional logic for award type routing
3. **Approval Mappings**: Review approval assignments and escalation paths
4. **Notification Settings**: Examine Teams and Outlook integration points

### For Import Into Your Environment

#### Option 1: Manual Recreation
1. Create a new Power Automate flow
2. Use the `definition.json` as a reference to recreate the approval logic
3. Configure approval assignments for your organization
4. Update connection references and test thoroughly

#### Option 2: Package-Based Import
To import this flow into your Power Platform environment:

1. **Repackage the Flow**:
   ```powershell
   # Use Power Platform CLI to package the source files
   pac solution add-reference --path "src/Microsoft.Flow/flows/[flow-id]"
   pac solution export --path "./exports/TriageAndApproval.zip"
   ```

2. **Environment Preparation**:
   - Update connection references in `connections.json`
   - Modify SharePoint site URLs and list IDs
   - Configure approval assignments for your organization
   - Update Teams channels and notification recipients

3. **Import Process**:
   - Go to Power Automate > My Flows > Import
   - Upload the packaged .zip file
   - Reconnect all connections during import
   - Configure approvers and notification settings

#### Required Environment Setup
Before importing, ensure your environment has:
- **SharePoint Online**: Lists for employee recognition data and approval tracking
- **Microsoft Approvals**: Service for handling approval workflows
- **Microsoft Teams**: Integration for notifications and collaboration
- **Outlook**: Email notification capabilities
- **Power Automate Premium**: Required for complex workflows and approvals

### Customization Guidelines

#### Approval Configuration
- **Approver Assignments**: Update approver mappings in the definition.json
- **Escalation Rules**: Modify timeout and escalation logic as needed
- **Award Criteria**: Adjust routing conditions based on your organization's criteria
- **Notification Templates**: Customize email and Teams message templates

#### Business Logic Modifications
- **Routing Rules**: Update conditional logic for award type routing
- **Approval Thresholds**: Modify approval requirements and criteria
- **Timeout Settings**: Adjust wait times and escalation triggers
- **Status Updates**: Customize SharePoint field updates and tracking

#### Integration Points
- **SharePoint Lists**: Update list references and field mappings
- **Teams Channels**: Configure appropriate notification channels
- **Outlook Integration**: Set up email templates and distribution lists
- **External Systems**: Add integrations to HR or other organizational systems

## Development Notes

### Flow Architecture
- **Trigger-Based**: Activated by SharePoint list item creation or modification
- **Conditional Routing**: Uses complex branching based on award types and criteria
- **Parallel Processing**: Implements parallel branches for efficiency
- **Error Handling**: Comprehensive error management with retry logic

### Technical Dependencies
- **SharePoint Lists**: Award nomination data storage and tracking
- **Microsoft Approvals**: Core approval workflow engine
- **Microsoft Teams**: Real-time notifications and collaboration
- **Outlook**: Email notifications and communication
- **Power Platform**: Core automation and workflow infrastructure

### Performance Considerations
- **Parallel Branches**: Used to optimize processing time
- **Delegation**: Ensures efficient data operations with large datasets
- **Caching**: Implements compose actions for complex expressions
- **Retry Logic**: Built-in resilience for external service calls

## Troubleshooting

### Common Issues
- **Connection Failures**: Verify all connections are properly authenticated
- **Approval Delays**: Check approver assignments and availability
- **Notification Problems**: Validate Teams and Outlook integration settings
- **Data Sync Issues**: Ensure SharePoint list permissions are correct

### Monitoring & Maintenance
- **Flow History**: Monitor run history for errors and performance
- **Connection Health**: Regularly check connection status
- **Approver Updates**: Maintain current approver assignments
- **Performance Metrics**: Track approval times and bottlenecks

---

*This flow is part of the Employee Recognition App v1.0.1 Production Pilot. For support or questions, visit the [GitHub repository](https://github.com/KCoderVA/Employee-Recognition-App) or contact the development team.*
