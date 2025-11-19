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

# Power BI Reports & Dashboards

**Version:** 0.1.0 (Early Development)
**Last Updated:** November 19, 2025

---

## 📊 Overview

This directory contains Power BI reports and dashboards for the Employee Recognition application analytics. These reports provide interactive visualizations of key performance metrics, submission trends, and operational insights.

---

## 🗂️ Directory Structure

```
powerbi/
├── README.md                           # This file
├── development/                        # Active development files
│   ├── 578_Starfish_v0.1.0.pbix       # Early prototype (CONTAINS PHI - not in Git)
│   └── dashboard_v0.1.0.pbit          # Sanitized template (PUBLIC - in Git)
├── templates/                          # Reusable report templates (future)
└── published/                          # Production-ready reports (future)
```

---

## 🔐 Security & File Handling

### **CRITICAL: PHI/Sensitive Data Protection**

⚠️ **All `.pbix` files contain real PHI and sensitive VA employee data and MUST NOT be committed to GitHub!**

| File Type | Contains PHI? | Git Status | Purpose |
|-----------|---------------|------------|---------|
| `.pbix` | ✅ YES | ❌ Excluded | Development with real data |
| `.pbit` | ❌ NO | ✅ Included | Sanitized public template |
| Data extracts (`.xlsx`, `.csv`) | ✅ YES | ❌ Excluded | Source data files |

### **Git Protection**

The `.gitignore` file is configured to automatically exclude:
- All `*.pbix` files
- All files in `src/analytics/data-extracts/`
- All files in `src/analytics/powerbi/development/*.pbix`

Only `.pbit` template files are allowed in the public repository.

### **Creating Safe Templates**

To create a sanitized `.pbit` template from a `.pbix` file:

1. Open the `.pbix` file in Power BI Desktop
2. Remove all data connections or sanitize data
3. File → Export → Power BI template (.pbit)
4. Save as `dashboard_v0.1.0.pbit` (or appropriate version)
5. Verify no PHI is embedded before committing to Git

---

## 📂 Current Files

### **Development Files (Local Only)**

#### `578_Starfish_v0.1.0.pbix`
- **Status**: Early prototype (15% complete)
- **Contains**: Real PHI and sensitive employee data
- **Git**: Excluded via `.gitignore`
- **Purpose**: Active development with live SharePoint data
- **Location**: Local development machine only

**Features**:
- Initial dashboard layout exploration
- Basic visualizations testing
- Data model experimentation
- Chart type evaluation

### **Public Template Files (GitHub)**

#### `dashboard_v0.1.0.pbit`
- **Status**: Sanitized template (no PHI)
- **Contains**: Report structure and layout only
- **Git**: Included in public repository
- **Purpose**: Shareable template for external collaboration
- **Location**: `src/analytics/powerbi/development/`

**Features**:
- Clean report structure
- Placeholder data or no data
- Reusable for similar implementations
- Safe for public distribution

---

## 🔗 Published Dataset

### **VA Power BI Gov Dataset**

- **Dataset URL**: [View Dataset](https://app.powerbigov.us/groups/f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9/datasets/bf54f67b-c0a9-41bf-958a-f0c5c9b88335/details)
- **Workspace ID**: `f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9`
- **Dataset ID**: `bf54f67b-c0a9-41bf-958a-f0c5c9b88335`
- **Status**: Published (report not yet published)
- **Environment**: VA Power BI Government Cloud

**Next Steps**:
1. Finalize report development
2. Publish report to workspace
3. Configure scheduled data refresh
4. Set up row-level security (RLS)
5. Share with stakeholders

---

## 🚀 Development Workflow

### **Standard Development Process**

1. **Local Development**
   - Work with `.pbix` files containing real data
   - Test visualizations and calculations
   - Iterate on report design
   - Files remain on local machine (not committed)

2. **Version Control**
   - Export sanitized `.pbit` template when major milestones reached
   - Commit `.pbit` files to Git with version numbers
   - Document changes in commit messages

3. **Collaboration**
   - Share `.pbit` templates for structure review
   - External collaborators use template to understand layout
   - Feedback incorporated into `.pbix` development files

4. **Publication**
   - Publish finalized `.pbix` to Power BI Service
   - Move to `published/` directory for archival reference
   - Create `.pbit` template for long-term storage

### **Version Naming Convention**

- **Development**: `<feature>_v<major>.<minor>.<patch>.pbix`
  - Example: `578_Starfish_v0.1.0.pbix`
- **Templates**: `dashboard_v<major>.<minor>.<patch>.pbit`
  - Example: `dashboard_v0.1.0.pbit`
- **Published**: `EmployeeRecognition_Dashboard_v<major>.<minor>.<patch>.pbix`
  - Example: `EmployeeRecognition_Dashboard_v1.0.0.pbix`

---

## 📊 Report Structure & Layout (Planned)

### **Page 1: Executive Summary**
- Total submissions (current month, YTD)
- Average processing time
- Approval rate
- Top 5 departments by volume
- Trend sparklines

### **Page 2: Submission Analysis**
- Volume by award type
- Submissions over time (line chart)
- Department breakdown (bar chart)
- Heat map of submission patterns

### **Page 3: Processing Performance**
- Average cycle time by stage
- Bottleneck identification
- Team performance metrics
- SLA compliance tracking

### **Page 4: Outcome Metrics**
- Approval vs rejection rates
- Most recognized employees
- Most active nominators
- Recognition distribution

### **Page 5: Detailed Data**
- Filterable table view
- Export capabilities
- Drill-through details
- Supporting documentation

---

## 🔧 Technical Specifications

### **Data Connections**

- **Primary Source**: SharePoint Online lists
- **Connection Type**: Import (scheduled refresh)
- **Refresh Frequency**: Daily at 6:00 AM (planned)
- **Gateway**: VA Power BI Gateway (required)

### **Performance Optimization**

- Aggregated measures pre-calculated
- Appropriate indexing on date columns
- Query folding enabled where possible
- Incremental refresh for large datasets (future)

### **Required Power BI Version**

- **Minimum**: Power BI Desktop (March 2024 or later)
- **Recommended**: Latest version for best features
- **Environment**: Power BI Government Cloud (VA USGov)

---

## 📝 Data Model Documentation

### **Fact Tables**
- `FactRecognitions` - One row per submission with all measures

### **Dimension Tables**
- `DimDate` - Date dimension for time intelligence
- `DimAwardType` - Award category lookup
- `DimDepartment` - Organizational hierarchy
- `DimStatus` - Processing status values

### **Key Measures**
- Total Submissions
- Average Cycle Time
- Approval Rate
- Processing Speed (submissions per day)
- Backlog Count

### **Calculated Columns**
- Days in Triage
- Days in Approval
- Total Cycle Days
- Award Fiscal Year
- Quarter Number

---

## 🧪 Testing & Validation

### **Pre-Publication Checklist**

- [ ] All calculations validated against source data
- [ ] Date filters working correctly
- [ ] Drill-through navigation functional
- [ ] Mobile layout optimized
- [ ] Performance acceptable (<3 second load time)
- [ ] Row-level security tested
- [ ] Bookmarks and report navigation working
- [ ] Tooltips and help text included
- [ ] Accessibility compliance verified
- [ ] No PHI exposed inappropriately

---

## 👥 Stakeholder Access

### **Access Levels (Planned)**

| Role | Access Type | Scope |
|------|-------------|-------|
| Executive Leadership | Full View | All departments, all metrics |
| Department Managers | Filtered View | Department-specific data only |
| Program Administrators | Full Edit | Configuration and maintenance |
| General Users | Read-Only | Aggregated metrics only |

### **Implementation**

- Azure AD group-based assignment
- Row-level security by department
- Regular access reviews (quarterly)

---

## 📚 Resources & Documentation

### **Power BI Documentation**
- [Power BI Gov Cloud](https://docs.microsoft.com/en-us/power-bi/admin/service-govus-overview)
- [SharePoint Online connector](https://docs.microsoft.com/en-us/power-bi/connect-data/desktop-connect-to-sharepoint-list)
- [Row-Level Security](https://docs.microsoft.com/en-us/power-bi/admin/service-admin-rls)
- [Incremental Refresh](https://docs.microsoft.com/en-us/power-bi/connect-data/incremental-refresh-overview)

### **Internal Documentation**
- [VA Power BI Governance](https://department-of-veterans-affairs.github.io/)
- [HINClinicalAnalytics Support](mailto:HINClinicalAnalytics@va.gov)
- Analytics component overview: `../README.md`

---

## 🆘 Troubleshooting

### **Common Issues**

**Issue**: Cannot connect to SharePoint
- **Solution**: Ensure Power BI Gateway is running and configured with appropriate credentials

**Issue**: Data refresh fails
- **Solution**: Verify service account permissions on SharePoint lists

**Issue**: Slow report performance
- **Solution**: Check query folding, reduce visual complexity, implement aggregations

**Issue**: RLS not working
- **Solution**: Test RLS with "View As" feature, verify Azure AD group memberships

---

## 📞 Support

| Issue Type | Contact |
|------------|---------|
| Report Development | Kyle.Coder@va.gov |
| Power BI Service Issues | VA Power BI Support Team |
| Data Source Problems | HINClinicalAnalytics@va.gov |
| Security/Access | VA Information Security Office |

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 0.1.0 | 2025-11-19 | Initial development files, directory structure, documentation |

---

**Next Update**: December 2025 (Core dashboard completion and data model finalization)
