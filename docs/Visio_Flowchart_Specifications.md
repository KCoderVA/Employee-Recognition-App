# Employee Recognition App - Visio Flowchart Specifications

## Chart 1: Overall Application Flow

### Main Flow Structure:
```
[START: User Opens App] 
    ↓
[Office 365 Authentication]
    ↓
[Main Dashboard Loads]
    ↓
[Award Type Selection]
    ├── [HRO Award] → [HRO Form] → [HRO Workflow]
    ├── [Hines Hero] → [Hero Form] → [Hero Workflow]  
    ├── [Starfish] → [Starfish Form] → [Starfish Workflow]
    └── [ICARE] → [ICARE Form] → [ICARE Workflow]
    ↓
[Form Completion & Validation]
    ↓
[Submission to SharePoint]
    ↓
[Power Automate Trigger]
    ↓
[Automated Processing]
    ↓
[END: Confirmation & Notifications]
```

### Visual Elements to Include:
- **Start/End**: Green ovals
- **Process Steps**: Blue rectangles
- **Decision Points**: Yellow diamonds
- **Data Storage**: Cylinder shapes for SharePoint
- **External Systems**: Gray rectangles (Office 365, Teams, Email)

---

## Chart 2: Detailed User Journey for Starfish Award

### Step-by-Step Process:
```
[User Launches App]
    ↓
[Authentication Check] → [Valid?] 
    ├── NO → [Login Screen] → [Office 365 Auth]
    └── YES → [Continue]
    ↓
[Load User Profile from AD]
    ↓
[Display Main Dashboard]
    ↓
[User Clicks "Starfish Award"]
    ↓
[Pop-up Form Opens]
    ↓
[Form Sections:]
    ├── [Nominee Information]
    │   ├── Name (required)
    │   ├── Department
    │   └── Service Line
    ├── [Event Details]
    │   ├── Date/Time
    │   ├── Location
    │   └── Safety Flag?
    ├── [I-CARE Comments]
    │   ├── Integrity
    │   ├── Commitment
    │   ├── Advocacy
    │   ├── Respect
    │   └── Excellence
    └── [Additional Information]
    ↓
[Validation Check] → [Complete?]
    ├── NO → [Highlight Missing Fields] → [Return to Form]
    └── YES → [Continue]
    ↓
[Submit Button Clicked]
    ↓
[Save to SharePoint List]
    ↓ [Parallel Processes]
    ├── [Send Confirmation Email to Submitter]
    ├── [Notify Nominee's Supervisor]
    ├── [Update Recognition Database]
    └── [Log Activity for Reporting]
    ↓
[Display Success Message]
    ↓
[Return to Dashboard]
```

---

## Chart 3: HRO Award Approval Workflow

### Complex Approval Process:
```
[HRO Nomination Submitted]
    ↓
[Auto-assign to Triage Team]
    ↓
[Create Approval Action in Power Automate]
    ↓
[Send Teams Notification to Triage Team]
    ↓
[Triage Team Reviews Packet]
    ↓
[Decision Point] 
    ├── [Approve & Route]
    │   ├── [Determine Sub-committee]
    │   ├── [HRO Principles Committee]
    │   ├── [Safety Committee]
    │   └── [Clinical Excellence Committee]
    ├── [Return for More Info]
    │   ├── [Add Comments]
    │   ├── [Send Back to Submitter]
    │   └── [Request Clarification]
    └── [Reject]
        ├── [Document Reasons]
        └── [Close Nomination]
    ↓
[Sub-committee Review] (if routed)
    ↓
[Final Decision]
    ├── [Approve] → [Process Award]
    ├── [Modify] → [Request Changes]
    └── [Decline] → [Document & Close]
    ↓
[Update Status in SharePoint]
    ↓
[Notify All Stakeholders]
    ↓
[Generate Reports]
```

---

## Chart 4: System Architecture Overview

### Technical Component Flow:
```
[Users] 
    ↓ (Access via)
[Canvas App Interface]
    ├── [Mobile Devices]
    ├── [Desktop Browsers] 
    └── [Tablet Devices]
    ↓ (Authenticates through)
[Office 365 / Azure AD]
    ↓ (Stores data in)
[SharePoint Lists]
    ├── [Nominations List]
    ├── [User Profiles List]
    ├── [Admin Settings List]
    └── [Audit Log List]
    ↓ (Triggers workflows in)
[Power Automate Flows]
    ├── [Submission Processing]
    ├── [Approval Routing]
    ├── [Notification Sending]
    └── [Report Generation]
    ↓ (Integrates with)
[External Systems]
    ├── [Microsoft Teams] → [Approval Notifications]
    ├── [Exchange Online] → [Email Notifications]
    ├── [Office 365 Users] → [Profile Information]
    └── [Power BI] → [Analytics & Reporting]
```

---

## Chart 5: Award Type Comparison Matrix

### Feature Comparison Table:
```
| Feature | HRO | Hines Hero | Starfish | ICARE |
|---------|-----|------------|----------|-------|
| Form Complexity | High | Medium | Low | Medium |
| Approval Required | Yes | Yes | No | Optional |
| Committee Review | Yes | Yes | No | No |
| Auto-notifications | Yes | Yes | Yes | Yes |
| Safety Flagging | Yes | Yes | Yes | No |
| Principles Focus | HRO | Service | I-CARE | I-CARE |
| Processing Time | 5-10 days | 3-7 days | Immediate | 1-3 days |
| Documentation Level | Detailed | Moderate | Basic | Moderate |
```

---

## Chart 6: User Role Access Matrix

### Permission Flowchart:
```
[User Logs In]
    ↓
[Check User Role] → [Admin List Lookup]
    ├── [Standard User]
    │   ├── Submit nominations ✓
    │   ├── View own submissions ✓
    │   ├── Edit pending submissions ✓
    │   └── Admin functions ✗
    ├── [Manager]
    │   ├── All Standard User functions ✓
    │   ├── View team submissions ✓
    │   ├── Approve basic awards ✓
    │   └── Advanced admin ✗
    ├── [Committee Member]
    │   ├── All Manager functions ✓
    │   ├── Access approval workflows ✓
    │   ├── Route nominations ✓
    │   └── System configuration ✗
    └── [Administrator]
        ├── All functions ✓
        ├── User management ✓
        ├── App configuration ✓
        └── System monitoring ✓
```

---

## Visual Design Guidelines for Visio/PowerPoint

### Color Scheme:
- **Primary Blue**: #003f7f (VA Blue)
- **Secondary Green**: #00a91c (Success/Approval)
- **Warning Orange**: #ff8c00 (Attention/Warnings)
- **Error Red**: #d83b2a (Errors/Rejections)
- **Neutral Gray**: #5a5a5a (Supporting text)

### Shape Standards:
- **Start/End**: Green rounded rectangles
- **Process**: Blue rectangles
- **Decision**: Yellow diamonds
- **Data Store**: Cylinder (SharePoint = Blue, External = Gray)
- **User Action**: Light blue rounded rectangles
- **System Action**: Dark blue rectangles
- **External System**: Gray rectangles with dashed borders

### Typography:
- **Headers**: Bold, 14pt, VA Blue
- **Body Text**: Regular, 11pt, Black
- **Labels**: Bold, 9pt, Dark Gray
- **Notes**: Italic, 9pt, Medium Gray

### Layout Principles:
- **Flow Direction**: Top to bottom, left to right
- **Spacing**: Consistent 0.5" between elements
- **Alignment**: Center-aligned text in shapes
- **Connectors**: Use 90-degree angles where possible
- **Grouping**: Related elements in rounded boxes

---

## Additional Visio Templates to Create:

### Template 1: "New User Onboarding Flow"
- Step-by-step guide for first-time users
- Include screenshots and callouts
- Show decision points for different scenarios

### Template 2: "Troubleshooting Decision Tree"
- Common issues and solutions
- If-then logic for problem resolution
- Contact information for escalation

### Template 3: "Admin Configuration Workflow"
- Steps for app administrators
- User management processes
- System maintenance procedures

### Template 4: "Future State Vision"
- Planned enhancements roadmap
- Integration possibilities
- Scalability considerations

---

*These specifications provide the framework for creating comprehensive visual documentation that will help new users understand and navigate the Employee Recognition App effectively.*
