# Security Policy

## Supported Versions

We provide security updates for the following versions of the Employee Recognition Application:

| Version | Supported          |
| ------- | ------------------ |
| 0.8.x   | ✅ Current Release |
| 0.7.x   | ⚠️ Limited Support |
| < 0.7   | ❌ No Support      |

## Reporting a Vulnerability

The Employee Recognition Application handles sensitive employee information and must maintain the highest security standards in compliance with VA IT security policies.

### How to Report

**🚨 For Critical Security Issues:**
- **DO NOT** create a public GitHub issue
- Contact the project team directly through secure VA channels
- Email: [Insert secure VA contact method]
- Follow VA incident reporting procedures

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

## Security Standards

### Data Protection
- All employee data is handled in accordance with VA privacy policies
- No PII is stored in unsecured locations
- Access controls follow principle of least privilege
- Data retention follows VA records management requirements

### Authentication & Authorization
- Integration with VA Active Directory
- Role-based access control (RBAC)
- Regular access reviews and cleanup
- Strong authentication requirements

### Code Security
- Regular security reviews of Power Apps formulas
- Secure Power Automate flow configurations
- SharePoint permission audits
- Input validation and sanitization

### Compliance
- VA IT security standards
- FISMA compliance requirements
- Privacy Act considerations
- HIPAA requirements where applicable

## Response Timeline

| Severity Level | Initial Response | Resolution Target |
|---------------|------------------|-------------------|
| Critical      | 24 hours         | 72 hours          |
| High          | 48 hours         | 1 week            |
| Medium        | 1 week           | 2 weeks           |
| Low           | 2 weeks          | 1 month           |

## Security Updates

Security updates will be:
- Released as patch versions (e.g., 0.8.4)
- Documented in the CHANGELOG.md
- Communicated to all stakeholders
- Deployed following emergency change procedures when critical

## Security Testing

Regular security assessments include:
- Power Platform security reviews
- SharePoint permission audits
- Flow execution monitoring
- Data access logging and review

## Contact Information

For security-related questions or concerns:
- **Project Lead**: Kyle J. Coder
- **VA IT Security**: [Follow VA procedures]
- **Emergency Contact**: [VA IT Security Team]

## Acknowledgments

We appreciate responsible disclosure of security vulnerabilities and recognize contributors who help improve the security of the Employee Recognition Application.

---

*This security policy is maintained in accordance with VA IT security requirements and is subject to regular review and updates.*
