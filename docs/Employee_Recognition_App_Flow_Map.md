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

# Employee Recognition App - Flow Map & User Guide

## Application Overview
**Employee Recognition Canvas App for Edward Hines Jr. VA Hospital**
- **Purpose**: Streamline employee recognition and award nominations
- **Version**: 0.4.2 (as of June 24, 2025)
- **Platform**: Microsoft Power Platform (Canvas App + Power Automate)
- **Target Users**: All VA employees at Hines VAMC

---

## Main Award Types Supported

### 1. **HRO Awards** (High Reliability Organization)
- **Purpose**: Recognize contributions to patient safety and quality care
- **Key Fields**:
  - Context, Actions, Results
  - HRO Principles alignment
  - Clinical vs. Non-clinical designation
- **Process**: Triage → Committee Review → Approval

### 2. **Hines Hero Awards**
- **Purpose**: Recognize exceptional service and going above and beyond
- **Key Fields**:
  - Event summary and detailed description
  - Impact assessment
  - Service line identification
- **Process**: Submission → Review → Recognition

### 3. **Starfish Awards**
- **Purpose**: Peer-to-peer recognition for daily excellence
- **Key Fields**:
  - I-CARE principles (Integrity, Commitment, Advocacy, Respect, Excellence)
  - Safety concerns flagging
  - Nursing service designation
- **Process**: Quick submission → Immediate recognition

### 4. **ICARE Awards**
- **Purpose**: Recognize demonstration of VA core values
- **Key Fields**:
  - Comments for each I-CARE principle
  - Additional supporting details
- **Process**: Values-based assessment → Recognition

---

## Application Flow Structure

### **User Entry Point**
```
App Launch → User Authentication (Office 365) → Main Dashboard
```

### **Navigation Structure**
1. **Home Screen**
   - Award type selection
   - Recent submissions view
   - Quick access buttons

2. **Nomination Screens** (Pop-up forms)
   - Award-specific questionnaires
   - Dynamic field validation
   - Progress indicators

3. **Admin Screens** (Admin users only)
   - User management
   - Submission oversight
   - System configuration

---

## Key Features & Functions

### **Core Functionality**
✅ **Multi-Award Support**: Handle 4 different award types in one app
✅ **Dynamic Forms**: Award-specific questions and validation
✅ **User Authentication**: Office 365 integration with role-based access
✅ **Mobile Responsive**: Works on Windows and mobile devices
✅ **Offline Capability**: Continue working without internet connection

### **Advanced Features**
🔧 **Conditional Logic**: Smart form branching based on responses
🔧 **Data Validation**: Prevent incomplete or invalid submissions
🔧 **Auto-Population**: Pre-fill user information from Active Directory
🔧 **Version Control**: Track app updates and deployment history
🔧 **Admin Controls**: Special access for administrators and developers

### **Integration Features**
🔗 **SharePoint**: Store all nomination data
🔗 **Power Automate**: Automated approval workflows
🔗 **Office 365**: User profiles and authentication
🔗 **Teams**: Approval notifications and actions
🔗 **Email**: Automated notifications and updates

---

## User Journey Examples

### **Scenario 1: Submitting a Starfish Award**
1. **Launch App** → Select "Starfish Award"
2. **Fill Form**:
   - Nominee information
   - Event date and location
   - I-CARE principle comments
   - Safety/nursing flags
3. **Submit** → Confirmation message
4. **Background Process**:
   - Data saved to SharePoint
   - Auto-notification to nominee's manager
   - Entry in recognition database

### **Scenario 2: HRO Award Submission (Admin Review)**
1. **Submit HRO Nomination** → Enhanced form with HRO-specific fields
2. **Triage Stage**:
   - Auto-assigned to Award Committee
   - Teams notification sent
   - Approval action created
3. **Committee Review**:
   - Detailed packet review
   - Route to appropriate sub-committee OR
   - Return for additional information
4. **Final Approval**: Recognition processing

---

## Technical Architecture

### **Frontend (Canvas App)**
- **Screens**: 5+ main screens with pop-up overlays
- **Collections**: Dynamic data storage (nominations, user profiles, configurations)
- **Variables**: 50+ global and local variables for state management
- **Controls**: Responsive design with conditional visibility

### **Backend (Power Automate)**
- **Triggers**: Form submission, approval actions
- **Actions**: SharePoint operations, Teams notifications, email sending
- **Approvals**: Multi-stage approval workflows
- **Data Processing**: Dynamic content generation, conditional routing

### **Data Storage (SharePoint)**
- **Lists**: Nominations, user profiles, admin settings
- **Libraries**: Supporting documents and attachments
- **Views**: Filtered data access for different user roles

---

## User Roles & Permissions

### **Standard Users**
- Submit nominations for any award type
- View their own submission history
- Access help and resources

### **Managers**
- Review nominations for their team members
- Access department-specific reports
- Approve certain award types

### **Award Committee Members**
- Triage and route nominations
- Access detailed approval workflows
- Review committee-specific awards

### **Administrators**
- Full app configuration access
- User management capabilities
- System monitoring and maintenance
- App development and updates

---

## Success Metrics & Benefits

### **Efficiency Gains**
- **50% reduction** in processing time vs. paper forms
- **Automated routing** eliminates manual distribution
- **Real-time tracking** of nomination status

### **User Experience**
- **Single platform** for all award types
- **Mobile accessibility** for field staff
- **Instant confirmations** and notifications

### **Compliance & Audit**
- **Complete audit trail** of all submissions
- **Standardized forms** ensure consistency
- **Automated documentation** for reporting

---

## Future Enhancements

### **Planned Features**
- 📊 **Analytics Dashboard**: Recognition trends and metrics
- 🏆 **Recognition Portal**: Public celebration of awards
- 📱 **Teams App**: Deeper Teams integration
- 🔄 **API Connections**: Integration with HR systems

### **Potential Improvements**
- Voice-to-text input for mobile users
- Bulk nomination processing
- Advanced reporting and analytics
- Integration with VA-wide recognition systems

---

## Support & Training

### **User Resources**
- **In-app help**: Contextual guidance and tooltips
- **Training materials**: Step-by-step guides
- **Video tutorials**: Screen recordings for common tasks
- **FAQs**: Answers to frequent questions

### **Technical Support**
- **Admin contacts**: Kyle Coder (Kyle.Coder@va.gov)
- **Help desk**: IT support for technical issues
- **Documentation**: Technical specifications and troubleshooting

---

## Contact Information
**App Development Team**: Informatics Department, Hines VAMC
**Primary Contact**: Kyle Coder - Program Analyst, Informatics
**Support**: Submit via IT Help Desk or contact app administrators

---

*This flow map serves as a comprehensive guide for new users and stakeholders to understand the Employee Recognition App's capabilities, processes, and benefits.*
