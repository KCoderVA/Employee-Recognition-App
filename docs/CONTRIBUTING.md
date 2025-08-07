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


# Contributing to Employee Recognition App (v1.0.2)

Thank you for your interest in contributing to the Employee Recognition App! This guide provides everything you need to get started, contribute effectively, and follow best practices for this Power Platform solution.

## 📋 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Process](#development-process)
- [Submission Guidelines](#submission-guidelines)
- [Power Platform Best Practices](#power-platform-best-practices)
- [Repository Structure & File Policy](#repository-structure--file-policy)
- [Testing & Review](#testing--review)
- [Questions or Issues?](#questions-or-issues)
- [Recognition](#recognition)

## Code of Conduct

This project follows VA and open source standards for professional conduct. All contributors are expected to:
- Be respectful and inclusive
- Focus on constructive collaboration
- Maintain confidentiality of sensitive information
- Follow VA IT security and privacy guidelines
- Ensure all public contributions are professional and appropriate for a wide audience

## Getting Started

### Prerequisites
- Access to a VA Power Platform environment (or test tenant)
- Power Platform CLI (`pac`) installed
- Visual Studio Code with Power Platform extensions
- Git for version control
- PowerShell 7+ for automation scripts

### Setup Steps
1. Fork and clone the repository
2. Configure your Power Platform environment connection
3. Review project documentation in `/docs/`
4. Run initial health check: `pwsh -ExecutionPolicy Bypass -File ./scripts/repo-health-check.ps1`

## Development Process

### Branch Strategy
- `main`: Production-ready code
- `develop`: Integration branch for new features
- `feature/*`: Individual feature development
- `hotfix/*`: Critical production fixes

### Change Request Process
1. All changes must be linked to a documented Change Request (CR)
2. Reference the CR number in commit messages
3. Update the CHANGELOG.md with your changes
4. Follow the established version numbering scheme (see below)

### Version Numbering
Semantic versioning is used:
- Major.Minor.Patch (e.g., 1.0.1)
- Each Change Request gets a unique version increment
- See [CHANGELOG.md](../CHANGELOG.md) for full version history

## Submission Guidelines

### How to Propose a Change
1. Fork the repository and create a feature branch
2. Make your changes, following the guidelines below
3. Open a pull request with a clear title and description
4. Reference any related issues or change requests
5. Use the template below for your PR description:

```
### Summary
Briefly describe the change and its purpose.

### Related Issue(s)
Link to any related issues or change requests.

### Testing
Describe how you tested your change.
```

### Pull Request Process
1. **Create a feature branch** from `develop` or `main`
2. **Make your changes** following Power Platform best practices
3. **Update documentation** as needed (CHANGELOG, README, docs/)
4. **Test thoroughly** in your environment
5. **Submit a pull request** with a clear title, description, and references
6. **Request review** from project maintainers

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

## Repository Structure & File Policy

### 📁 Public Repository (GitHub)
The GitHub repository contains only user-relevant files:
- Source code and documentation needed to run or contribute to the project
- Essential README files, contribution guidelines, and security policies
- GitHub workflows and issue templates

### 🏠 Local Development Environment
Your local repository may contain additional development resources:
- VS Code settings and personal workspace configurations
- Scripts and automation for developer use
- Testing data, validation files, and debugging information
- Archive materials, historical exports, and reference documents
- Binary files (Excel, PowerPoint, Visio, etc.)
- Environment-specific settings and credentials

### 🔄 Contribution Workflow
When contributing:
1. **Edit only public files** – Focus on source code and documentation in `src/` and `docs/`
2. **Test locally** – Use your complete local environment for development and testing
3. **Commit selectively** – Only commit changes to files tracked in the public repository
4. **Reference local materials** – You may reference local documentation in commit messages

This separation ensures the GitHub repository remains clean and professional while preserving your complete development environment locally.

## Testing & Review

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

### Review Process
1. **Technical Review**: Code quality, architecture, best practices
2. **Functional Review**: Feature completeness, user experience
3. **Security Review**: Compliance with VA security standards
4. **Stakeholder Review**: Business requirements and approval

## Questions or Issues?

- Review existing documentation in `/docs/`
- Check the [CHANGELOG.md](CHANGELOG.md) for recent changes
- Create an issue using the appropriate template
- For urgent matters, contact the project team via the GitHub repository

## Recognition

Contributors to this project help improve the employee recognition process for all VA staff. Your contributions make a meaningful impact on recognizing the excellent work happening across our healthcare system.

---

*This project is developed in support of the VA's healthcare and operational missions, and follows all applicable VA IT policies and procedures. Last updated: August 4, 2025 for v1.0.0 public release.*
