
# ============================================================================
#  SCRIPT: validate-changelog.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    Checks and fixes CHANGELOG format for the Employee Recognition App.
#    Validates CHANGELOG.md for required sections and formatting, and can auto-fix issues.
#    Ensures compliance with project documentation standards and release management.
#
#  USAGE:
#    1. Run this script from the project root directory.
#    2. Use -Detailed to show detailed validation output.
#    3. Use -ShowStatus to display git status for CHANGELOG.md.
#    4. Use -Fix to attempt auto-fix of detected issues.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell scripting for documentation validation and compliance.
#    - Section and sub-section comments are provided throughout for clarity.
#    - Designed for maintainability and ease of extension.
# ============================================================================


# =====================
# PARAMETER DEFINITION
# =====================
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [switch]$Detailed = $false,

    [Parameter(Mandatory = $false)]
    [switch]$Fix = $false,

    [Parameter(Mandatory = $false)]
    [switch]$ShowStatus = $false
)


# =====================
# HELPER FUNCTIONS
# =====================
function Write-Header {
    param([string]$Title, [string]$Color = "Green")
    Write-Host ""
    Write-Host "📋 $Title" -ForegroundColor $Color
    Write-Host ("=" * ($Title.Length + 4)) -ForegroundColor $Color
}

function Write-Status {
    param([string]$Message, [string]$Icon = "ℹ️", [string]$Color = "Cyan")
    Write-Host "$Icon $Message" -ForegroundColor $Color
}

function Write-Error {
    param([string]$Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}


function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️ $Message" -ForegroundColor Yellow
}


# =====================
# FUNCTION: Test-ChangelogFormat
# =====================
# Validates the structure and content of the CHANGELOG.md file.
function Test-ChangelogFormat {
    param([string]$Content)

    $issues = @()
    $warnings = @()

    # SUBSECTION: Check for basic structure
    if (!($Content -match "# Changelog")) {
        $issues += "Missing main '# Changelog' header"
    }

    if (!($Content -match "## \[Unreleased\]")) {
        $issues += "Missing '## [Unreleased]' section"
    }

    # SUBSECTION: Check for Keep a Changelog format compliance
    if (!($Content -match "All notable changes.*will be documented")) {
        $warnings += "Missing standard Keep a Changelog introduction"
    }

    if (!($Content -match "The format is based on.*Keep a Changelog")) {
        $warnings += "Missing Keep a Changelog format reference"
    }

    # SUBSECTION: Check for semantic versioning reference
    if (!($Content -match "Semantic Versioning")) {
        $warnings += "Missing Semantic Versioning reference"
    }

    # SUBSECTION: Check for consistent date format
    $dateMatches = [regex]::Matches($Content, '\d{4}-\d{2}-\d{2}')
    foreach ($match in $dateMatches) {
        try {
            [DateTime]::ParseExact($match.Value, "yyyy-MM-dd", $null)
        }
        catch {
            $issues += "Invalid date format: $($match.Value)"
        }
    }

    # SUBSECTION: Check for proper section headers
    $validSections = @("Added", "Changed", "Deprecated", "Removed", "Fixed", "Security")
    $sectionMatches = [regex]::Matches($Content, '### (.+)')
    foreach ($match in $sectionMatches) {
        $section = $match.Groups[1].Value.Trim()
        if ($validSections -notcontains $section) {
            $warnings += "Non-standard section: '$section' (should be one of: $($validSections -join ', '))"
        }
    }

    return @{
        Issues   = $issues
        Warnings = $warnings
        Valid    = $issues.Count -eq 0
    }
}


# =====================
# FUNCTION: Get-ChangelogStatus
# =====================
# Checks for the presence of an [Unreleased] section and recent changes.
function Get-ChangelogStatus {
    param([string]$Content)

    # SUBSECTION: Check for recent updates in Unreleased section
    $unreleasedMatch = [regex]::Match($Content, '## \[Unreleased\](.*?)(?=## \[|$)', [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($unreleasedMatch.Success) {
        $unreleasedContent = $unreleasedMatch.Groups[1].Value
        $hasRecentChanges = $unreleasedContent -match '### (Added|Changed|Deprecated|Removed|Fixed|Security)[\s\S]*?- .+'

        return @{
            HasUnreleasedSection = $true
            HasRecentChanges     = $hasRecentChanges
            UnreleasedContent    = $unreleasedContent.Trim()
        }
    }

    return @{
        HasUnreleasedSection = $false
        HasRecentChanges     = $false
        UnreleasedContent    = ""
    }
}


# =====================
# MAIN SCRIPT LOGIC
# =====================
Write-Header "CHANGELOG Validation - Employee Recognition App"

# SECTION: Check if CHANGELOG.md exists
if (!(Test-Path "CHANGELOG.md")) {
    Write-Error "CHANGELOG.md not found!"
    Write-Host "Run 'scripts/update-changelog.ps1 --init' to create one." -ForegroundColor Yellow
    exit 1
}

# SECTION: Read CHANGELOG content
try {
    $changelogContent = Get-Content "CHANGELOG.md" -Raw -Encoding UTF8
}
catch {
    Write-Error "Failed to read CHANGELOG.md: $_"
    exit 1
}

# SECTION: Get file info
$changelogFile = Get-Item "CHANGELOG.md"
$lastModified = $changelogFile.LastWriteTime
$fileSize = $changelogFile.Length
$lineCount = (Get-Content "CHANGELOG.md").Count

Write-Status "File Information:" "📄"
Write-Host "  Size: $([math]::Round($fileSize / 1KB, 2)) KB" -ForegroundColor Gray
Write-Host "  Lines: $lineCount" -ForegroundColor Gray
Write-Host "  Last Modified: $($lastModified.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Gray
Write-Host "  Time Since Modified: $([math]::Round(((Get-Date) - $lastModified).TotalMinutes, 1)) minutes" -ForegroundColor Gray

# SECTION: Validate format
Write-Status "Validating CHANGELOG format..." "🔍"
$validation = Test-ChangelogFormat $changelogContent

if ($validation.Valid) {
    Write-Success "CHANGELOG format is valid"
}
else {
    Write-Error "CHANGELOG format issues found:"
    foreach ($issue in $validation.Issues) {
        Write-Host "    • $issue" -ForegroundColor Red
    }
}

if ($validation.Warnings.Count -gt 0) {
    Write-Warning "Format warnings:"
    foreach ($warning in $validation.Warnings) {
        Write-Host "    • $warning" -ForegroundColor Yellow
    }
}


# SECTION: Check status
Write-Status "Checking CHANGELOG status..." "📊"
$status = Get-ChangelogStatus $changelogContent

if ($status.HasUnreleasedSection) {
    Write-Success "Has [Unreleased] section"

    if ($status.HasRecentChanges) {
        Write-Success "Contains recent changes"

        if ($Detailed) {
            Write-Status "Recent changes preview:" "📝"
            $preview = $status.UnreleasedContent -split "`n" | Select-Object -First 10
            foreach ($line in $preview) {
                if ($line.Trim()) {
                    Write-Host "    $line" -ForegroundColor Gray
                }
            }
        }
    }
    else {
        Write-Warning "No recent changes in [Unreleased] section"
    }
}
else {
    Write-Error "Missing [Unreleased] section"
}


# SECTION: Git integration check
if ($ShowStatus -and (git rev-parse --git-dir 2>$null)) {
    Write-Status "Git status for CHANGELOG.md:" "🔀"

    $gitStatus = git status --porcelain CHANGELOG.md 2>$null
    if ($gitStatus) {
        if ($gitStatus.StartsWith('M ')) {
            Write-Success "CHANGELOG.md has staged changes"
        }
        elseif ($gitStatus.StartsWith(' M')) {
            Write-Warning "CHANGELOG.md has unstaged changes"
        }
        elseif ($gitStatus.StartsWith('??')) {
            Write-Warning "CHANGELOG.md is untracked"
        }
    }
    else {
        Write-Status "CHANGELOG.md is up to date with git" "🔄" "Green"
    }

    # Check last commit
    $lastCommit = git log -1 --format="%h %s" CHANGELOG.md 2>$null
    if ($lastCommit) {
        Write-Host "  Last commit: $lastCommit" -ForegroundColor Gray
    }
}


# SECTION: Summary
Write-Header "Validation Summary"

$overallStatus = "PASS"
if ($validation.Issues.Count -gt 0) {
    $overallStatus = "FAIL"
    Write-Error "Validation FAILED - $($validation.Issues.Count) critical issues"
}
elseif ($validation.Warnings.Count -gt 0) {
    $overallStatus = "WARN"
    Write-Warning "Validation passed with $($validation.Warnings.Count) warnings"
}
else {
    Write-Success "Validation PASSED - No issues found"
}

if (!$status.HasRecentChanges -and $overallStatus -ne "FAIL") {
    $overallStatus = "WARN"
    Write-Warning "CHANGELOG may need updates for recent changes"
}

# SECTION: Fix option
if ($Fix -and ($validation.Issues.Count -gt 0 -or !$status.HasRecentChanges)) {
    Write-Status "Attempting to fix CHANGELOG issues..." "🔧"
    try {
        & ".\scripts\update-changelog.ps1" -Fix
        Write-Success "CHANGELOG fix attempt completed"
    }
    catch {
        Write-Error "Fix attempt failed: $_"
        exit 1
    }
}

# SECTION: Exit with appropriate code
switch ($overallStatus) {
    "PASS" { exit 0 }
    "WARN" { exit 1 }
    "FAIL" { exit 2 }
}

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see PowerShell documentation automation and compliance docs.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
