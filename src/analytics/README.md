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

# Employee Recognition App – Analytics & Reporting Component

**Version:** 0.1.0 (Early Development)
**Status:** Initial Development Phase
**Last Updated:** November 19, 2025

---

## 📊 Overview

The Analytics & Reporting component provides comprehensive performance metrics, KPI dashboards, and operational insights for the Employee Recognition application. This module enables data-driven decision-making through interactive visualizations and real-time monitoring capabilities.

### **Vision Statement**

Enable leadership, administrators, and stakeholders to monitor recognition program effectiveness, identify trends, track processing performance, and celebrate organizational success through intuitive data visualizations.

---

## 🎯 Key Objectives

1. **Performance Monitoring**: Track submission volumes, processing times, and approval workflows
2. **Trend Analysis**: Identify patterns by department, award type, time period, and recognition frequency
3. **Quality Metrics**: Monitor triage efficiency, approval timeliness, and bottleneck identification
4. **Success Tracking**: Measure program adoption, completion rates, and employee engagement
5. **Executive Insights**: Provide facility-wide visibility and strategic decision support

---

## 📁 Component Architecture

```
src/analytics/
├── README.md                          # This file - component overview
├── DEVELOPMENT_PLAN.md                # Strategic planning and roadmap
├── powerbi/                           # Power BI reports and dashboards
│   ├── README.md                      # Power BI implementation guide
│   ├── development/                   # Active development files
│   │   └── 578_Starfish_v0.1.0.pbix  # Early prototype dashboard
│   ├── templates/                     # Reusable report templates (future)
│   └── published/                     # Production-ready reports (future)
├── data-extracts/                     # SharePoint data exports for analysis
│   ├── extractedListDetails.xlsx      # Initial SharePoint list data
│   ├── extractedListDetails_v2.xlsx   # Enhanced data extract
│   └── updatedCharts_v2.xlsx          # Chart development data
├── canvas-integration/                # Power Apps embedded analytics (future)
│   └── README.md                      # Executive screen development guide
└── automation/                        # Automated reporting workflows (future)
    └── README.md                      # Flow-based report generation
```

---

## 🔍 Current Development Status

### **Phase 1: Foundation (Current - v0.1.0)**
**Status:** 🔨 In Progress
**Completion:** 15%

- ✅ Directory structure established
- ✅ Initial Power BI prototype created (`578_Starfish_v0.1.0.pbix`)
- ✅ SharePoint data extraction performed (3 Excel files)
- ✅ Basic chart development and visualization testing
- 🔄 Data model design and relationships
- ⏳ KPI metric definitions
- ⏳ Dashboard layout and user experience design

### **Phase 2: Core Metrics (Planned - v0.2.0)**
**Status:** ⏳ Not Started
**Target:** Q1 2026

- Define standard KPIs and success metrics
- Establish SharePoint data connection strategies
- Build core visualizations (submission volumes, processing times)
- Implement departmental and award type breakdowns
- Create time-series trend analysis

### **Phase 3: Advanced Analytics (Planned - v0.3.0)**
**Status:** ⏳ Not Started
**Target:** Q2 2026

- Processing bottleneck identification
- Approval team performance metrics
- Outlier detection and alerting thresholds
- Predictive analytics for workload planning
- Historical comparison and benchmarking

### **Phase 4: Integration & Automation (Planned - v0.4.0)**
**Status:** ⏳ Not Started
**Target:** Q3 2026

- Embed analytics screen in Power Apps canvas app
- Automated report generation via Power Automate
- Scheduled data refresh and distribution
- Email notifications for key metrics and alerts
- Executive dashboard for real-time facility monitoring

---

## 📊 Planned Metrics & KPIs

### **Submission Volume Metrics**
- Total submissions by time period (daily, weekly, monthly, quarterly)
- Submissions by award type (HeRO, Great Catch, Starfish, I CARE)
- Submissions by department/service line
- Top nominating departments
- Submission trends and seasonality patterns

### **Processing Performance Metrics**
- Average time from submission to triage completion
- Average time from triage to approval decision
- Average total cycle time (submission to completion)
- Triage team response time metrics
- Approval team response time metrics
- SLA compliance rates

### **Outcome & Success Metrics**
- Approval rate by award type
- Rejection rate and common rejection reasons
- Withdrawal rate and analysis
- Most recognized employees
- Most active nominators
- Recognition distribution across organization

### **Workload & Capacity Metrics**
- Pending submissions by stage (triage, approval, delivery)
- Backlog age analysis
- Team workload distribution
- Peak submission periods
- Processing capacity utilization

### **Quality & Compliance Metrics**
- Data completeness scores
- Required field compliance
- Attachment submission rates
- Audit trail completeness
- Security compliance adherence

---

## 🔗 Data Source Strategy

### **Primary Data Sources**

1. **SharePoint Lists**
   - Recognition master list (all submissions)
   - Award categories configuration
   - User department mappings
   - Approval team assignments

2. **Power BI Published Dataset**
   - **Dataset URL**: [VA Power BI Gov Dataset](https://app.powerbigov.us/groups/f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9/datasets/bf54f67b-c0a9-41bf-958a-f0c5c9b88335/details)
   - **Status**: Published (report not yet published)
   - **Workspace**: f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9
   - **Dataset ID**: bf54f67b-c0a9-41bf-958a-f0c5c9b88335
   - **Purpose**: Centralized data model for analytics and reporting

3. **Date/Time Stamp Analysis**
   - `Created` - Initial submission timestamp
   - `TriageCompletedDate` - Triage stage completion
   - `Level1ApprovalDate` - First approval timestamp
   - `Level2ApprovalDate` - Executive approval timestamp
   - `DeliveryCompletedDate` - Final delivery timestamp
   - `Modified` - Last update timestamp

4. **Status Column Values**
   - `Submitted` → `In Triage` → `Pending Approval` → `Approved` → `Delivered`
   - Rejection and withdrawal tracking
   - Processing stage durations

5. **Categorical Dimensions**
   - Award Type (HeRO, Great Catch, Starfish, I CARE)
   - Department/Service Line
   - Approval level requirements
   - Monetary award amounts

### **Data Refresh Strategy**

- **Development Phase**: Manual data extracts from SharePoint
- **Production Phase**: Scheduled data refresh via Power BI Gateway or Power Automate
- **Real-Time Integration**: Direct Power Apps embedded analytics for live data

---

## 🚀 Implementation Roadmap

### **Immediate Next Steps (December 2025)**

1. **Data Model Finalization**
   - Define relationships between fact and dimension tables
   - Establish calculated columns and measures
   - Create date dimension table for time intelligence
   - Document data model architecture

2. **Core Dashboard Development**
   - Build executive summary page
   - Create submission volume visualizations
   - Implement processing time analysis
   - Design department breakdown views

3. **Testing & Validation**
   - Validate calculations against source data
   - Test with sample datasets
   - Gather feedback from key stakeholders
   - Refine visualizations based on user input

### **Short-Term Goals (Q1 2026)**

1. **Advanced Visualizations**
   - Trend analysis with forecasting
   - Heat maps for bottleneck identification
   - Comparative analysis (period over period)
   - Drill-through capabilities for detailed investigation

2. **Power BI Service Deployment**
   - Publish to Power BI Service (VA USGov environment)
   - Configure scheduled refresh
   - Set up row-level security (department-based)
   - Create distribution groups for report access

3. **User Training & Adoption**
   - Create user guide documentation
   - Conduct training sessions for leadership
   - Establish feedback collection mechanism
   - Iterate based on user experience

### **Medium-Term Goals (Q2-Q3 2026)**

1. **Canvas App Integration**
   - Design executive analytics screen in Power Apps
   - Embed Power BI report or implement native visuals
   - Add real-time metric cards and KPIs
   - Enable drill-down to detailed views

2. **Automated Notifications**
   - Power Automate flows for alert conditions
   - Email notifications for SLA breaches
   - Weekly summary reports to leadership
   - Escalation alerts for processing delays

3. **Advanced Analytics**
   - Predictive workload modeling
   - Anomaly detection for unusual patterns
   - Sentiment analysis (if text data available)
   - Benchmarking against organizational goals

### **Long-Term Vision (2026+)**

1. **Enterprise Reporting Platform**
   - Scalable across multiple VA facilities
   - Standardized metrics and definitions
   - Centralized data warehouse integration
   - Cross-facility comparative analytics

2. **AI/ML Integration**
   - Automated insights and recommendations
   - Natural language querying
   - Intelligent forecasting models
   - Proactive intervention suggestions

3. **Mobile & Accessibility**
   - Mobile-optimized report layouts
   - Power BI Mobile app integration
   - Accessibility compliance (508/WCAG)
   - Multi-device responsive design

---

## ⚠️ Critical Considerations & Planning Factors

### **Security & Compliance**

- **Data Privacy**: Ensure PII protection in reports (aggregated views, anonymization where needed)
- **Access Control**: Implement row-level security by department/role
- **Audit Compliance**: Maintain audit trail of who accessed what reports and when
- **VA Healthcare Security**: Follow VA data handling and security protocols
- **HIPAA Considerations**: If patient safety awards involve health data, ensure compliance

### **Performance & Scalability**

- **Data Volume Planning**: Design for growth (estimate 500-2000 submissions/year)
- **Refresh Performance**: Optimize queries for large datasets
- **Aggregation Strategy**: Pre-calculate common metrics to improve responsiveness
- **Incremental Refresh**: Implement incremental data refresh in Power BI for efficiency
- **Query Folding**: Ensure efficient data source queries to minimize load times

### **Data Quality & Governance**

- **Source Data Validation**: Implement checks for missing or invalid data
- **Standardization**: Ensure consistent date formats, department names, award types
- **Data Dictionary**: Maintain comprehensive documentation of all metrics and dimensions
- **Change Management**: Track changes to data sources and update reports accordingly
- **Version Control**: Manage Power BI file versions and track changes

### **Integration Considerations**

- **Power BI Gateway**: Required for on-premises SharePoint connectivity
- **Service Account**: Dedicated account for scheduled refresh (avoid personal credentials)
- **API Rate Limits**: Monitor SharePoint throttling if using direct connections
- **Canvas App Limits**: Understand Power Apps data connector limits for embedded analytics
- **Flow Execution**: Plan for flow run limits when automating notifications

### **User Experience & Adoption**

- **Executive Personas**: Design for non-technical leadership users
- **Mobile Access**: Ensure accessibility from tablets and mobile devices
- **Training Requirements**: Plan comprehensive training and support materials
- **Feedback Loop**: Establish mechanism for continuous improvement
- **Change Resistance**: Plan adoption strategy and stakeholder engagement

### **Technical Architecture Decisions**

**Decision Point 1: Power BI vs Canvas App Native Visuals**
- **Power BI Pro/Premium**: Rich visualizations, advanced analytics, scheduled refresh
  - ✅ Pros: Professional dashboards, extensive visual options, easy sharing
  - ❌ Cons: Requires Power BI licenses, separate platform from Power Apps
- **Canvas App Charts**: Native Power Apps chart controls
  - ✅ Pros: Integrated experience, no additional licenses, real-time data
  - ❌ Cons: Limited visualization types, performance with large datasets

**Recommendation**: Hybrid approach
- Published Power BI reports for comprehensive facility-wide analytics
- Embedded Power BI visual in Canvas App for executive quick view
- Native Canvas App charts for real-time individual metrics

**Decision Point 2: Data Refresh Strategy**
- **Scheduled Refresh**: Power BI scheduled refresh (daily/hourly)
- **Real-Time**: DirectQuery or Power Apps native connections
- **Hybrid**: Cached data for historical, live data for current metrics

**Recommendation**: Hybrid approach
- Scheduled refresh for historical trends and heavy analytics
- Live connection for current day pending items and real-time metrics

**Decision Point 3: Distribution & Access**
- **Power BI Service**: Publish to workspace, share via web
- **Embedded**: Embed in SharePoint page or Canvas App
- **Email**: Scheduled email delivery of reports

**Recommendation**: Multi-channel distribution
- Power BI Service as primary platform
- Embedded view in Canvas App for integrated experience
- Weekly email summary for proactive distribution

### **Notification & Alerting Strategy**

**Use Cases for Automated Notifications:**

1. **SLA Breach Alerts**
   - Trigger: Submission pending > X days in triage or approval
   - Action: Email to team lead with details and link
   - Frequency: Daily batch or immediate per threshold

2. **Backlog Alerts**
   - Trigger: Total pending items > threshold
   - Action: Notification to management team
   - Frequency: Weekly summary

3. **Processing Bottleneck Alerts**
   - Trigger: Average cycle time exceeds baseline by >20%
   - Action: Alert to operations manager
   - Frequency: Real-time or daily

4. **Quality Alerts**
   - Trigger: Spike in rejections or withdrawals
   - Action: Investigation notification to quality team
   - Frequency: Weekly trend analysis

**Implementation Approach:**
- Power Automate flow triggered by Power BI alert
- Or: Scheduled flow queries SharePoint directly for thresholds
- Or: Canvas App-based alert system with push notifications

---

## 📚 Documentation & Resources

### **Current Files**

| File | Description | Status | Public Repo |
|------|-------------|--------|-------------|
| `578_Starfish_v0.1.0.pbix` | Initial prototype dashboard (CONTAINS PHI) | Early development | ❌ Excluded (.gitignore) |
| `dashboard_v0.1.0.pbit` | Sanitized Power BI template (NO PHI) | Early development | ✅ Included (safe for GitHub) |
| `extractedListDetails.xlsx` | SharePoint data export v1 (CONTAINS PHI) | Sample data | ❌ Excluded (.gitignore) |
| `extractedListDetails_v2.xlsx` | Enhanced data extract (CONTAINS PHI) | Sample data | ❌ Excluded (.gitignore) |
| `updatedCharts_v2.xlsx` | Chart development workbook (CONTAINS PHI) | Sample data | ❌ Excluded (.gitignore) |

**Security Note**: All `.pbix` files and data extracts contain real PHI and sensitive information and are excluded from the public GitHub repository via `.gitignore`. Only the `.pbit` template file (sanitized) is safe for public distribution.

### **Planned Documentation**

- **Power BI Development Guide**: Best practices for report development
- **Data Model Reference**: Comprehensive data dictionary
- **User Guide**: End-user instructions for accessing and using reports
- **Admin Guide**: Configuration, refresh, and maintenance procedures
- **Metric Definitions**: Business definitions for all KPIs and measures

### **External Resources**

- [Power BI Documentation](https://docs.microsoft.com/en-us/power-bi/)
- [Power Apps Analytics](https://docs.microsoft.com/en-us/powerapps/maker/canvas-apps/add-data-connection)
- [SharePoint as Data Source](https://docs.microsoft.com/en-us/power-bi/connect-data/desktop-connect-to-sharepoint-list)
- [VA Power BI Governance](https://department-of-veterans-affairs.github.io/)

---

## 🤝 Stakeholder Engagement

### **Key Stakeholders**

- **Executive Leadership**: Strategic insights and program effectiveness
- **Program Administrators**: Operational metrics and process optimization
- **Triage Team**: Workload visibility and efficiency metrics
- **Approval Team**: Approval performance and backlog management
- **HR Department**: Recognition program success and employee engagement
- **IT/Analytics Team**: Technical implementation and support

### **Feedback & Iteration**

- Schedule bi-weekly review sessions during development phase
- Create dedicated Teams channel or SharePoint discussion board
- Implement formal feedback collection mechanism
- Prioritize feature requests based on impact and feasibility

---

## 🔐 Security & Access Control

### **Access Levels**

1. **Executive Access**: Full facility-wide visibility, all metrics
2. **Department Managers**: Department-specific filtered views
3. **Administrators**: Full access plus configuration capabilities
4. **Read-Only Users**: General metrics, anonymized data

### **Implementation**

- Power BI row-level security (RLS) by department
- Azure AD group-based access control
- Audit logging of report access and exports
- Regular access reviews and compliance checks

---

## 📞 Support & Contact

| Purpose | Contact |
|---------|---------|
| Analytics Development | Kyle.Coder@va.gov |
| Power BI Technical Support | VA Power BI Support Team |
| Data Source Issues | HINClinicalAnalytics@va.gov |
| Security & Compliance | VA Information Security Office |

---

## 📝 Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1.0 | 2025-11-19 | Kyle J. Coder | Initial component creation, directory structure, planning documentation |

---

**Next Update:** December 2025 (Data model finalization and core dashboard development)

