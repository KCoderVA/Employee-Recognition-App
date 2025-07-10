# Contributing to Employee Recognition App

Thank you for your interest in contributing to the Employee Recognition Application! This document provides guidelines for contributing to this Power Platform project.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Submission Guidelines](#submission-guidelines)
- [Power Platform Best Practices](#power-platform-best-practices)

## Code of Conduct

This project follows the VA's standards for professional conduct. All contributors are expected to:
- Be respectful and inclusive
- Focus on constructive collaboration
- Maintain confidentiality of sensitive information
- Follow VA IT security guidelines

## Getting Started

### Prerequisites
- Access to VA Power Platform environment
- Power Platform CLI (pac) installed
- VS Code with Power Platform extensions
- Git for version control

### Development Environment Setup
1. Clone the repository
2. Install required VS Code extensions (see `.vscode/extensions.json`)
3. Configure your Power Platform environment connection
4. Review the project documentation in `/docs/`

## Development Process

### Branch Strategy
- `main` - Production-ready code
- `develop` - Integration branch for new features
- `feature/*` - Individual feature development
- `hotfix/*` - Critical production fixes

### Change Request Process
1. All changes must be linked to a documented Change Request (CR)
2. Reference the CR number in commit messages
3. Update the CHANGELOG.md with your changes
4. Follow the established version numbering scheme

### Version Numbering
We use semantic versioning with three-part numbering:
- Major.Minor.Patch (e.g., 0.8.3)
- Each Change Request gets a unique version increment
- See CHANGELOG.md for the complete versioning history

## Submission Guidelines

### Pull Request Process
1. **Create a feature branch** from `develop`
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/CR-XXX-description
   ```

2. **Make your changes** following Power Platform best practices

3. **Update documentation**
   - Update CHANGELOG.md with your changes
   - Update relevant README.md files
   - Add/update technical documentation in `/docs/`

4. **Test thoroughly**
   - Test in development environment
   - Verify all Power Automate flows work correctly
   - Check SharePoint list integrations
   - Validate Power Apps functionality

5. **Submit Pull Request**
   - Use descriptive title with CR number
   - Include detailed description of changes
   - Reference any related issues
   - Request review from project maintainers

### Commit Message Guidelines
```
CR-XXX: Brief description of change

Detailed explanation of what was changed and why.
Include any breaking changes or special deployment notes.

- Component 1: Specific change made
- Component 2: Another specific change
```

## Power Platform Best Practices

### Power Apps
- Use descriptive control names (btnSubmit, lblTitle, galItems)
- Group related controls in containers
- Implement proper error handling with User() and IsError() functions
- Follow consistent naming conventions (PascalCase for apps, camelCase for variables)
- Document complex formulas with comments

### Power Automate
- Use descriptive action names
- Implement proper error handling with try-catch patterns
- Use parallel branches where possible for performance
- Document business logic with comments
- Use compose actions for complex expressions

### SharePoint
- Follow consistent list and column naming conventions
- Use content types for structured data
- Implement proper permissions and security
- Document list relationships and dependencies

### Documentation
- Update all relevant documentation with changes
- Include screenshots for UI changes
- Document any new configuration requirements
- Update training materials if user-facing changes

## File Organization

```
├── src/                     # Source code
│   ├── power-apps/         # Canvas app exports and source
│   ├── power-automate/     # Flow definitions and exports  
│   └── sharepoint/         # List templates and configurations
├── docs/                   # Project documentation
├── testing/                # Test scripts and data
├── releases/               # Release packages and notes
└── environments/           # Environment-specific configurations
```

## Testing Requirements

### Before Submitting
- [ ] Power Apps loads without errors
- [ ] All Power Automate flows execute successfully
- [ ] SharePoint integrations work correctly
- [ ] No broken links or references
- [ ] Error handling works as expected
- [ ] UI/UX follows established patterns

### Testing Environments
- **Development**: Initial testing and validation
- **Testing**: Stakeholder review and acceptance testing
- **Staging**: Pre-production validation
- **Production**: Live environment (deploy only after full approval)

## Review Process

1. **Technical Review**: Code quality, architecture, best practices
2. **Functional Review**: Feature completeness, user experience
3. **Security Review**: Compliance with VA security standards
4. **Stakeholder Review**: Business requirements and approval

## Questions or Issues?

- Review existing documentation in `/docs/`
- Check the [CHANGELOG.md](CHANGELOG.md) for recent changes
- Create an issue using the appropriate template
- Contact the project team for urgent matters

## Recognition

Contributors to this project help improve the employee recognition process for all VA staff. Your contributions make a meaningful impact on recognizing the excellent work happening across our healthcare system.

---

*This project is developed in support of the VA healthcare mission and follows all applicable VA IT policies and procedures.*
