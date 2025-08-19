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


# Security Policy & Compliance Framework (v1.0.2)

## 🔒 Overview
The Employee Recognition App is a Power Platform solution for the VA healthcare system, designed to handle sensitive employee information with the highest standards of security and compliance. This policy ensures alignment with VA IT security standards, FISMA, Privacy Act, and HIPAA where applicable.

## 📋 Related Documentation
- **[README.md](../README.md)** – Project overview and security features
- **[CHANGELOG.md](../CHANGELOG.md)** – Version history and security updates
- **[CONTRIBUTING.md](../CONTRIBUTING.md)** – Secure development process
- **[Compliance Framework](../security/compliance-framework.md)** – Detailed compliance mapping

## 🛡️ Supported Versions & Security Updates

| Version | Support Status        | Security Updates                      | End of Life   |
| ------- | --------------------- | ------------------------------------- | ------------- |
| 1.0.x   | ✅ **Full Support**    | Active monitoring & immediate patches | Ongoing       |
| 0.9.x   | ⚠️ **Limited Support** | Critical vulnerabilities only         | December 2025 |
| < 0.9   | ❌ **Unsupported**     | No security updates                   | Immediate     |

**Current Production Version:** 1.0.6 (UX Flow & Triage Refinement)

## 🚨 Vulnerability Reporting Process

This app processes sensitive employee data and maintains enterprise-level security standards in compliance with VA IT security policies and federal regulations.

### How to Report
If you discover a security vulnerability:

**For Critical Security Issues:**
- **Do NOT** create a public GitHub issue.
- Contact the project team via secure VA channels or the GitHub Security tab.
- Provide a clear description, impact, and steps to reproduce.
- For urgent matters, follow VA incident reporting procedures.

**For Non-Critical Security Concerns:**
- Create a private security advisory on GitHub
- Use the "Security" tab in the repository
- Provide detailed information about the potential issue

### What to Include

When reporting a security vulnerability, please include:
1. **Description**: Clear description of the vulnerability
2. **Impact**: Potential impact and affected components
3. **Reproduction**: Steps to reproduce the issue
4. **Environment**: Where the issue was discovered
5. **Severity**: Your assessment of the severity level

### Components in Scope

This security policy covers:
- ✅ Power Apps Canvas Application
- ✅ Power Automate Flows
- ✅ SharePoint Lists and Permissions
- ✅ PowerShell Scripts/Modules
- ✅ Microsoft Approvals Integration
- ✅ Teams/Outlook Integration
- ✅ Data handling and storage
- ✅ Authentication and authorization

### Out of Scope

The following are outside the scope of this security policy:
- ❌ VA infrastructure and network security
- ❌ Microsoft 365 platform security
- ❌ Third-party dependencies outside our control
- ❌ Social engineering attacks
- ❌ Physical security

## Security Standards & Organizational Structure

### Data Protection
- All employee data is handled in accordance with VA privacy policies
- No PII is stored in unsecured locations
- Access controls follow the principle of least privilege
- Data retention follows VA records management requirements

### Authentication & Authorization
- Integration with VA Active Directory and Azure AD
- Role-based access control (RBAC) for all app components
- Regular access reviews and cleanup
- Strong authentication requirements for all users

### Code & Platform Security
- Regular security reviews of Power Apps formulas and Power Automate flows
- SharePoint permission audits and access reviews
- Input validation and sanitization throughout the solution
- Automated security validation scripts and compliance checks

### Compliance
- VA IT security standards
- FISMA compliance requirements
- Privacy Act and HIPAA requirements
- Documented audit trails for all critical actions

## Response Timeline

| Severity Level | Initial Response | Resolution Target |
| -------------- | ---------------- | ----------------- |
| Critical       | 24 hours         | 72 hours          |
| High           | 48 hours         | 1 week            |
| Medium         | 1 week           | 2 weeks           |
| Low            | 2 weeks          | 1 month           |

## Security Updates & Testing

- Security updates are released as patch versions (e.g., 1.0.1)
- All updates are documented in the CHANGELOG.md
- Stakeholders are notified of critical updates
- Emergency changes follow VA change management procedures
- Regular security assessments include:
  - Power Platform security reviews
  - SharePoint permission audits
  - Flow execution monitoring
  - Data access logging and review

## Contact Information

For security-related questions or concerns:
- **Project Lead**: Kyle J. Coder
- **VA IT Security**: [Follow VA internal procedures]
- **Emergency Contact**: [VA IT Security Team]

## Acknowledgments

We appreciate responsible disclosure of security vulnerabilities and recognize contributors who help improve the security of the Employee Recognition App.

---

*This security policy is maintained in accordance with VA IT security requirements and is subject to regular review and updates. Last updated: August 19, 2025 for v1.0.6 release.*
