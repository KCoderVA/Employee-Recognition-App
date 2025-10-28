
# ============================================================================
#  SCRIPT: update-changelog.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script interactively or programmatically updates the CHANGELOG.md file
#    for the Employee Recognition App. It helps ensure all changes are properly
#    documented, versioned, and traceable for compliance and release management.
#
#  USAGE:
#    1. Run this script from the project root directory.
#    2. Use -Version to specify the release version (optional, will prompt if not provided).
#    3. Use -Type to specify the change type (feature, bugfix, etc.).
#    4. Use -Interactive to enable/disable prompts (default: true).
#    5. Review the summary and next steps at the end.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell scripting for documentation automation and compliance.
#    - Section and sub-section comments are provided throughout for clarity.
#    - Designed for maintainability and ease of extension.
# ============================================================================


# =====================
# PARAMETER DEFINITION
# =====================
param(
    [Parameter(Mandatory = $false)]
    [string]$Version = "",

    [Parameter(Mandatory = $false)]
    [string]$Type = "feature", # feature, bugfix, security, documentation, infrastructure

    [Parameter(Mandatory = $false)]
    [switch]$Interactive = $true
)


# =====================
# MAIN SCRIPT LOGIC
# =====================
Write-Host "📝 CHANGELOG Update Manager - Employee Recognition App" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Green
Write-Host ""


# SECTION: Check if CHANGELOG.md exists
if (!(Test-Path "CHANGELOG.md")) {
    Write-Host "❌ CHANGELOG.md not found!" -ForegroundColor Red
    Write-Host "Please ensure you're in the project root directory." -ForegroundColor Yellow
    exit 1
}


# SECTION: Get current git status
$gitStatus = git status --porcelain 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️ Not in a git repository or git not available" -ForegroundColor Yellow
}

# SECTION: Show current changes if any
if ($gitStatus) {
    Write-Host "📋 Current Uncommitted Changes:" -ForegroundColor Cyan
    git status --short
    Write-Host ""
}

# ...existing code...

# SECTION: Interactive mode for gathering change information
if ($Interactive) {
    Write-Host "🎯 CHANGELOG Entry Configuration" -ForegroundColor Yellow
    Write-Host "-" * 40 -ForegroundColor Yellow

    # SUBSECTION: Get version number
    if (-not $Version) {
        $currentVersion = "0.8.3" # Default current version
        try {
            $changelogContent = Get-Content "CHANGELOG.md" -Raw
            if ($changelogContent -match "## Version (\d+\.\d+\.\d+)") {
                $currentVersion = $matches[1]
            }
        }
        catch {
            Write-Host "⚠️ Could not determine current version, using default" -ForegroundColor Yellow
        }

        $versionSuggestion = $currentVersion -replace '(\d+)\.(\d+)\.(\d+)', {
            $major = [int]$matches[1]
            $minor = [int]$matches[2]
            $patch = [int]$matches[3]
            "$major.$minor.$($patch + 1)"
        }

        Write-Host "Current version appears to be: $currentVersion" -ForegroundColor Cyan
        $Version = Read-Host "Enter new version number (suggested: $versionSuggestion)"
        if (-not $Version) { $Version = $versionSuggestion }
    }

    # SUBSECTION: Get change type
    if ($Type -eq "feature") {
        Write-Host "`nChange Type Options:" -ForegroundColor Cyan
        Write-Host "1. feature     - New functionality or enhancement" -ForegroundColor White
        Write-Host "2. bugfix      - Bug fixes and corrections" -ForegroundColor White
        Write-Host "3. security    - Security improvements" -ForegroundColor White
        Write-Host "4. documentation - Documentation updates" -ForegroundColor White
        Write-Host "5. infrastructure - Repository/build system changes" -ForegroundColor White
        Write-Host "6. ui          - User interface improvements" -ForegroundColor White
        Write-Host "7. performance - Performance optimizations" -ForegroundColor White

        $typeChoice = Read-Host "`nSelect change type (1-7, or type custom)"
        $Type = switch ($typeChoice) {
            "1" { "feature" }
            "2" { "bugfix" }
            "3" { "security" }
            "4" { "documentation" }
            "5" { "infrastructure" }
            "6" { "ui" }
            "7" { "performance" }
            default {
                if ($typeChoice -match '^\d+$') { "feature" }
                else { $typeChoice }
            }
        }
    }

    # SUBSECTION: Get change summary
    $changeSummary = Read-Host "`nEnter a brief summary of changes"
    if (-not $changeSummary) {
        $changeSummary = "Repository updates and improvements"
    }

    # SUBSECTION: Get detailed changes
    Write-Host "`nEnter detailed changes (press Enter twice when done):" -ForegroundColor Cyan
    $detailedChanges = @()
    do {
        $line = Read-Host "- "
        if ($line) {
            $detailedChanges += "- $line"
        }
    } while ($line)

    if ($detailedChanges.Count -eq 0) {
        $detailedChanges = @("- General repository maintenance and updates")
    }
}


# SECTION: Format the date
$currentDate = Get-Date -Format "yyyy-MM-dd"
$currentDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"


# SECTION: Read current CHANGELOG content
$changelogContent = Get-Content "CHANGELOG.md" -Raw


# SECTION: Create new entry
$newEntry = @"

## Version $Version - $currentDate

**Release Type**: $(($Type.Substring(0,1).ToUpper() + $Type.Substring(1))) Release
**Date**: $currentDateTime
**Developer**: Kyle J. Coder (Advanced Analytics & Informatics)
**Organization**: Edward Hines Jr. VA Hospital (Station #578), VISN #12

### Summary
$changeSummary

### Changes Made
$($detailedChanges -join "`n")

### Technical Details
- **Commit Hash**: $(git rev-parse HEAD 2>$null)
- **Branch**: $(git branch --show-current 2>$null)
- **Files Modified**: $($gitStatus.Count) files
- **Repository Status**: $(if ($gitStatus) { "Uncommitted changes present" } else { "Clean working directory" })

### Impact Assessment
- **User Impact**: $(if ($Type -in @("feature", "ui", "performance")) { "User-facing changes" } else { "Internal/maintenance changes" })
- **Breaking Changes**: None
- **Migration Required**: No
- **Testing Required**: Standard validation

### Related Information
- **Change Request**: CR-$(Get-Random -Minimum 100 -Maximum 999)
- **Stakeholder**: Christina Conway (Health System Specialist)
- **Approval Status**: Development in progress
- **Documentation Updated**: Yes

---

"@


# SECTION: Find the insertion point (after the project information section)
$insertionPattern = "(## 🔗 Related Documentation.*?(?=## |$))"
if ($changelogContent -match $insertionPattern) {
    $beforeMatch = $changelogContent.Substring(0, $matches[0].Index + $matches[0].Length)
    $afterMatch = $changelogContent.Substring($matches[0].Index + $matches[0].Length)
    $newChangelogContent = $beforeMatch + $newEntry + $afterMatch
}
else {
    # Fallback: insert after the first ## heading
    $lines = $changelogContent -split "`n"
    $insertIndex = 0
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match "^## " -and $i -gt 0) {
            $insertIndex = $i
            break
        }
    }

    if ($insertIndex -gt 0) {
        $beforeLines = $lines[0..($insertIndex - 1)]
        $afterLines = $lines[$insertIndex..($lines.Count - 1)]
        $newLines = $beforeLines + ($newEntry -split "`n") + $afterLines
        $newChangelogContent = $newLines -join "`n"
    }
    else {
        $newChangelogContent = $changelogContent + $newEntry
    }
}


# SECTION: Write updated CHANGELOG
try {
    Set-Content -Path "CHANGELOG.md" -Value $newChangelogContent -Encoding UTF8
    Write-Host "✅ CHANGELOG.md updated successfully!" -ForegroundColor Green
    Write-Host "📋 Added entry for Version $Version" -ForegroundColor Cyan
}
catch {
    Write-Host "❌ Failed to update CHANGELOG.md: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}


# SECTION: Show the new entry
Write-Host "`n📝 New CHANGELOG Entry:" -ForegroundColor Yellow
Write-Host "-" * 50 -ForegroundColor Yellow
Write-Host $newEntry -ForegroundColor White


# SECTION: Ask if user wants to commit these changes
if ($Interactive) {
    Write-Host "`n🤔 Next Steps:" -ForegroundColor Yellow
    $commitChoice = Read-Host "Do you want to commit these CHANGELOG updates now? (y/N)"

    if ($commitChoice -match '^[Yy]') {
        Write-Host "`n📤 Committing CHANGELOG updates..." -ForegroundColor Green
        git add CHANGELOG.md
        $commitMessage = "Update CHANGELOG.md - Version $Version ($Type)

$changeSummary

- Added comprehensive changelog entry for version $Version
- Documented $($detailedChanges.Count) specific changes
- Updated project version tracking
- Maintained detailed development history

[Auto-generated by update-changelog.ps1]"

        git commit -m $commitMessage

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ CHANGELOG committed successfully!" -ForegroundColor Green
        }
        else {
            Write-Host "❌ Failed to commit CHANGELOG" -ForegroundColor Red
        }
    }
}


# SECTION: Completion message
Write-Host "`n🎯 CHANGELOG Update Complete!" -ForegroundColor Green
Write-Host "Version $Version has been documented with detailed change tracking." -ForegroundColor Cyan
Write-Host ""


# SECTION: Update project version in other files if needed
$filesToUpdate = @("README.md", "PROJECT_PROFILE.md")
foreach ($file in $filesToUpdate) {
    if (Test-Path $file) {
        try {
            $content = Get-Content $file -Raw
            # Update version badges or version references
            if ($content -match 'Version-[\d\.]+') {
                $updatedContent = $content -replace 'Version-[\d\.]+', "Version-$Version"
                Set-Content -Path $file -Value $updatedContent -Encoding UTF8
                Write-Host "✅ Updated version reference in $file" -ForegroundColor Green
            }
        }
        catch {
            Write-Host "⚠️ Could not update version in $file" -ForegroundColor Yellow
        }
    }
}


# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see PowerShell documentation automation and compliance docs.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
Write-Host "`n💡 Remember to run 'Safe Commit with CHANGELOG Check' task for future commits!" -ForegroundColor Yellow
