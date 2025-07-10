# CHANGELOG Enforcement System

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

## Overview

This project implements a comprehensive CHANGELOG enforcement system to ensure that all significant changes are properly documented before any commit to the repository. This system is essential for maintaining clear project history and enabling proper release management.

## 🛡️ Enforcement Layers

### 1. Git Pre-commit Hook

**Location**: `.git/hooks/pre-commit`

**Functionality**:
- Automatically runs before every `git commit`
- Analyzes staged files to determine if CHANGELOG update is required
- Blocks commits for significant changes without CHANGELOG updates
- Provides helpful error messages and resolution steps
- Allows bypassing with `git commit --no-verify` (not recommended)

**File Types Requiring CHANGELOG**:
- Source code: `*.js`, `*.ts`, `*.py`, `*.ps1`
- Documentation: `*.md` (except minor README updates)
- Configuration: `*.json`, `*.yml`, `*.yaml`, `*.xml`
- Scripts and automation: `scripts/*`, `.github/*`
- Project files: `LICENSE`, `NOTICE`, `SECURITY.md`, etc.

### 2. PowerShell Safe Commit Script

**Location**: `scripts/safe-commit.ps1`

**Usage**:
```powershell
# Interactive mode with guided CHANGELOG update
.\scripts\safe-commit.ps1 -Interactive

# Provide commit message and changelog entry together
.\scripts\safe-commit.ps1 -CommitMessage "Fix bug X" -ChangelogEntry "Fixed issue with feature Y"

# Dry run to test validation
.\scripts\safe-commit.ps1 -DryRun -CommitMessage "Test commit"
```

**Features**:
- Interactive CHANGELOG updating
- Comprehensive pre-commit validation
- License header checking
- Automatic staging of modified files
- Optional GitHub push integration

### 3. CHANGELOG Validation Script

**Location**: `scripts/validate-changelog.ps1`

**Usage**:
```powershell
# Basic validation
.\scripts\validate-changelog.ps1

# Detailed validation with status info
.\scripts\validate-changelog.ps1 -Detailed -ShowStatus

# Attempt automatic fixes
.\scripts\validate-changelog.ps1 -Fix
```

**Validation Checks**:
- ✅ File exists and is readable
- ✅ Contains required headers (`# Changelog`, `## [Unreleased]`)
- ✅ Follows Keep a Changelog format
- ✅ Has proper date formats (YYYY-MM-DD)
- ✅ Uses standard section categories
- ✅ Contains recent changes in Unreleased section

### 4. GitHub Actions Enforcement

**Location**: `.github/workflows/changelog-enforcement.yml`

**Triggers**:
- Pull requests to `main` or `develop` branches
- Direct pushes to `main` branch

**Checks**:
- CHANGELOG.md existence and format validation
- Requirement verification for PR changes
- Content quality assessment
- Breaking change detection
- Automated PR comments with status

### 5. VS Code Task Integration

**Tasks Available**:
- 📋 **Validate CHANGELOG (Comprehensive)**: Full validation with detailed output
- 📝 **Update CHANGELOG (Required Before Commit)**: Interactive CHANGELOG editing
- 🛡️ **Safe Commit with CHANGELOG Check**: Guided commit with validation
- 🔧 **Fix CHANGELOG Format**: Automatic format correction

**Access**: `Ctrl+Shift+P` → "Tasks: Run Task" → Select desired task

### 6. Git Commit Template

**Location**: `.gitmessage`

**Purpose**: Reminds developers to update CHANGELOG.md with every commit

**Configuration**: Automatically set via `git config commit.template .gitmessage`

## 📋 CHANGELOG Format Requirements

### Required Structure

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- New features go here

### Changed
- Changes to existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Now removed features

### Fixed
- Bug fixes

### Security
- Vulnerability fixes

## [1.0.0] - 2025-01-15

### Added
- Initial release
```

### Category Guidelines

| Category | Usage | Examples |
|----------|-------|----------|
| **Added** | New features, functionality, or capabilities | - New Power App screen<br>- Additional API endpoints<br>- New documentation sections |
| **Changed** | Modifications to existing functionality | - Updated UI design<br>- Modified workflow logic<br>- Changed configuration options |
| **Deprecated** | Features marked for future removal | - Legacy API endpoints<br>- Old configuration methods |
| **Removed** | Features/functionality that have been deleted | - Removed obsolete screens<br>- Deleted unused code |
| **Fixed** | Bug fixes and error corrections | - Fixed email notification bug<br>- Resolved performance issue |
| **Security** | Security-related changes and vulnerability fixes | - Fixed authentication bypass<br>- Updated dependencies |

## 🚀 Developer Workflows

### Standard Workflow

1. **Make changes** to your code/documentation
2. **Stage changes**: `git add .`
3. **Run safe commit**: `.\scripts\safe-commit.ps1 -Interactive`
4. **Follow prompts** to update CHANGELOG.md
5. **Commit and push** are handled automatically

### Quick Update Workflow

```powershell
# For simple changes with known changelog entry
.\scripts\safe-commit.ps1 -CommitMessage "Fix notification bug" -ChangelogEntry "Fixed issue where award notifications were not sent" -ChangeType "Fixed"
```

### Manual Workflow

1. **Edit CHANGELOG.md** manually under `[Unreleased]` section
2. **Stage changes**: `git add .`
3. **Validate**: `.\scripts\validate-changelog.ps1`
4. **Commit**: `git commit -m "Your message"`

### Emergency Bypass

```bash
# Only for urgent fixes - NOT RECOMMENDED
git commit --no-verify -m "Emergency fix"
```

## 🔧 Configuration Options

### Customizing File Requirements

Edit `.git/hooks/pre-commit` to modify which file types require CHANGELOG updates:

```bash
# Add new file extensions
src/*|*.js|*.ts|*.py|*.ps1|*.json|*.yml|*.yaml|*.your_extension)

# Add new paths
src/*|docs/*|scripts/*|your_path/*)
```

### Adjusting Time Thresholds

Modify the recent update window in the pre-commit hook:

```bash
# Change from 2 hours to your preferred duration
if [ $diff -lt 7200 ]; then  # 7200 = 2 hours in seconds
```

### VS Code Task Customization

Edit `.vscode/tasks.json` to add custom parameters to validation scripts:

```json
{
    "label": "Custom CHANGELOG Validation",
    "args": [
        "./scripts/validate-changelog.ps1",
        "-YourCustomParameter"
    ]
}
```

## 📊 Monitoring and Metrics

### Validation Status Codes

| Exit Code | Meaning | Action Required |
|-----------|---------|-----------------|
| 0 | Success | None - proceed with commit |
| 1 | Warnings | Review warnings, may proceed |
| 2 | Failure | Must fix issues before commit |

### GitHub Actions Status

- ✅ **Success**: CHANGELOG properly updated and formatted
- ⚠️ **Warning**: Minor issues or suggestions for improvement
- ❌ **Failure**: Missing or inadequate CHANGELOG updates

### VS Code Integration

Task results are displayed in the Terminal panel with:
- Color-coded status indicators
- Detailed validation results
- Actionable improvement suggestions

## 🆘 Troubleshooting

### Common Issues

**Problem**: "CHANGELOG.md not found"
```bash
# Solution: Initialize CHANGELOG
.\scripts\update-changelog.ps1 --init
```

**Problem**: "Pre-commit hook not executable"
```bash
# Solution: Fix permissions
chmod +x .git/hooks/pre-commit
```

**Problem**: "PowerShell execution policy error"
```powershell
# Solution: Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Problem**: "Git template not working"
```bash
# Solution: Reconfigure template
git config commit.template .gitmessage
```

### Getting Help

1. **Run validation**: `.\scripts\validate-changelog.ps1 -Detailed`
2. **Check git status**: `git status --porcelain`
3. **Review recent commits**: `git log --oneline -10`
4. **Test pre-commit**: `git commit --dry-run`

### Reset Enforcement

If you need to temporarily disable enforcement:

```bash
# Rename pre-commit hook
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled

# Re-enable later
mv .git/hooks/pre-commit.disabled .git/hooks/pre-commit
```

## 📚 Additional Resources

- [Keep a Changelog](https://keepachangelog.com/) - Format specification
- [Semantic Versioning](https://semver.org/) - Version numbering guidelines
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit message standards
- [Apache 2.0 License](https://www.apache.org/licenses/LICENSE-2.0) - Project license

## 🔄 Continuous Improvement

This enforcement system is continuously improved based on:
- Developer feedback and usage patterns
- GitHub Actions workflow results
- Project evolution and requirements
- Industry best practices and standards

All improvements are documented in this CHANGELOG.md file following the same standards this system enforces.
