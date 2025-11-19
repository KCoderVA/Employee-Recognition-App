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

# Analytics Component - Quick Start Guide

**Version:** 0.1.0
**Status:** Early Development Phase
**Created:** November 19, 2025

---

## 🎯 What This Component Does

The Analytics & Reporting component provides **interactive dashboards and performance metrics** for the Employee Recognition application, enabling:

- 📊 **Submission volume tracking** by department, award type, and time period
- ⏱️ **Processing time analysis** for triage and approval workflows
- 📈 **Trend identification** and pattern recognition
- 🎯 **KPI monitoring** for program effectiveness
- 🚨 **Bottleneck detection** and alert notifications

---

## 📁 Current File Organization

```
src/analytics/
├── README.md                               # Full documentation (comprehensive)
├── QUICK_START.md                          # This file (quick reference)
├── powerbi/
│   └── development/
│       ├── 578_Starfish_v0.1.0.pbix       # Development file (EXCLUDED from GitHub)
│       └── dashboard_v0.1.0.pbit          # Sanitized template (INCLUDED in GitHub)
└── data-extracts/
    ├── extractedListDetails.xlsx           # Sample data (EXCLUDED from GitHub)
    ├── extractedListDetails_v2.xlsx        # Sample data (EXCLUDED from GitHub)
    └── updatedCharts_v2.xlsx               # Sample data (EXCLUDED from GitHub)
```

---

## 🔒 Security Configuration

### **What's Protected (.gitignore)**
✅ **All `.pbix` files** - Contain real PHI and sensitive data
✅ **All files in `data-extracts/`** - Contain real submission data
✅ **Development workbooks** - Contain identifiable information

### **What's Public (GitHub)**
✅ **`.pbit` template files** - Sanitized, no PHI, safe to share
✅ **README documentation** - Planning and architecture
✅ **Code and scripts** - No sensitive data embedded

---

## 🚀 Current Development Status

**Phase 1: Foundation (15% Complete)**
- ✅ Directory structure created
- ✅ Initial Power BI prototype built
- ✅ Sample data extracted from SharePoint
- 🔄 Data model design in progress
- ⏳ Core visualizations being developed

**Next Milestone:** Data model finalization (December 2025)

---

## 📊 Power BI Dataset

**Published Dataset URL:**
https://app.powerbigov.us/groups/f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9/datasets/bf54f67b-c0a9-41bf-958a-f0c5c9b88335/details

- **Status:** Dataset published ✅
- **Report:** Not yet published ⏳
- **Workspace ID:** f9a21156-7cbd-49e0-8cec-3b7b6e47b9e9
- **Dataset ID:** bf54f67b-c0a9-41bf-958a-f0c5c9b88335

---

## ⚡ Key Metrics Being Developed

### **Volume Metrics**
- Submissions by award type (HeRO, Great Catch, Starfish, I CARE)
- Submissions by department
- Submissions over time (daily, weekly, monthly)

### **Performance Metrics**
- Average time from submission to triage
- Average time from triage to approval
- Total cycle time (submission to delivery)
- SLA compliance rates

### **Outcome Metrics**
- Approval rates by award type
- Most recognized employees
- Most active departments
- Processing backlog age

---

## 🎯 Critical Next Steps

### **Before Investing More Time:**

1. **Data Model Architecture**
   - Finalize fact and dimension table relationships
   - Create date dimension for time intelligence
   - Define standard calculated measures
   - Document data model design decisions

2. **Stakeholder Alignment**
   - Review planned metrics with leadership
   - Confirm report layout and priorities
   - Establish success criteria
   - Get approval on KPI definitions

3. **Technical Decisions**
   - Confirm Power BI vs Canvas App native visuals strategy
   - Choose data refresh approach (scheduled vs real-time)
   - Plan notification/alerting mechanism
   - Verify licensing and access requirements

### **Strategic Considerations:**

⚠️ **Integration Approach**
- **Option A:** Standalone Power BI reports (full featured, requires licenses)
- **Option B:** Embedded Power BI visual in Canvas App (hybrid approach)
- **Option C:** Canvas App native charts (fully integrated, limited visuals)
- **Recommendation:** Hybrid (published Power BI + embedded view in app)

⚠️ **Notification Strategy**
- **Option A:** Power Automate triggered by Power BI alerts
- **Option B:** Scheduled flow queries SharePoint directly
- **Option C:** Canvas App-based push notifications
- **Recommendation:** Power Automate with SharePoint threshold queries

⚠️ **Data Refresh Strategy**
- **Option A:** Scheduled refresh (daily/hourly) for historical data
- **Option B:** DirectQuery for real-time access (performance impact)
- **Option C:** Hybrid (scheduled for trends, live for current metrics)
- **Recommendation:** Hybrid approach for balance

---

## 📋 Planning Checklist

Before continuing development, ensure these are addressed:

- [ ] **Data Model Design:** Finalize table relationships and measures
- [ ] **Stakeholder Review:** Get feedback on planned metrics and layout
- [ ] **Access Strategy:** Confirm who needs access and what permissions
- [ ] **Refresh Strategy:** Decide on data refresh approach
- [ ] **Integration Plan:** Confirm Canvas App integration approach
- [ ] **Notification Rules:** Define alert thresholds and recipients
- [ ] **Security Review:** Verify PHI handling and access controls
- [ ] **License Verification:** Confirm Power BI license availability
- [ ] **Performance Testing:** Test with realistic data volumes
- [ ] **Documentation Plan:** Outline user guide and training materials

---

## 🔗 Additional Resources

- **Full Documentation:** See `README.md` in this folder
- **Power BI Development:** See `powerbi/README.md` (to be created)
- **Canvas Integration Plan:** See full README.md, section "Phase 4"
- **VA Power BI Governance:** https://department-of-veterans-affairs.github.io/

---

## 📞 Questions or Issues?

Contact: Kyle.Coder@va.gov

---

**Last Updated:** November 19, 2025
**Next Review:** December 2025
