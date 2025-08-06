
# ============================================================================
#  Script: diagnose-yaml-issues.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script diagnoses YAML formatting issues in Power Apps source files,
#    focusing on indentation and orphaned property errors (e.g., PA3003 errors).
#    It is intended to help developers quickly identify and resolve common
#    YAML structure problems that prevent successful app packaging.
#
#  USAGE:
#    1. Run this script from the project root directory.
#    2. Optionally use -Detailed for more verbose output.
#    3. Review the summary and next steps for manual fixes.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell file parsing, regex, and reporting for ALM.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================


# =====================
# PARAMETER DEFINITION
# =====================
# -Detailed: Optional switch for verbose output.
param([switch]$Detailed = $false)


# =====================
# MAIN SCRIPT LOGIC
# =====================
Write-Host "🔍 Diagnosing YAML issues in test\.unpacked..." -ForegroundColor Cyan


# SECTION: Gather YAML files to check
$files = Get-ChildItem 'test\.unpacked\Src' -Filter '*.fx.yaml'
$totalIssues = 0


# SECTION: Iterate through each YAML file and check for issues
foreach ($file in $files) {
    Write-Host "`n📄 Checking: $($file.Name)" -ForegroundColor Yellow
    $content = Get-Content $file.FullName
    $fileIssues = 0

    # SUBSECTION: Check for tab characters (should be spaces)
    $tabLines = $content | Where-Object { $_ -match '^[\t]+' }
    if ($tabLines.Count -gt 0) {
        Write-Host "  ❌ Found $($tabLines.Count) lines with tab indentation" -ForegroundColor Red
        $fileIssues++
    }

    # SUBSECTION: Check for mixed indentation within property blocks
    for ($i = 0; $i -lt $content.Count - 1; $i++) {
        $line = $content[$i]
        $nextLine = $content[$i + 1]

        # Look for property pairs that should have same indentation
        if ($line -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):' -and
            $nextLine -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):') {

            $indent1 = $matches[1].Length
            $prop1 = $matches[2]

            if ($nextLine -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):') {
                $indent2 = $matches[1].Length
                $prop2 = $matches[2]

                if ($indent1 -ne $indent2) {
                    Write-Host "  ❌ Line $($i+2): $prop2 (indent: $indent2) should match $prop1 (indent: $indent1)" -ForegroundColor Red
                    $fileIssues++

                    if ($Detailed) {
                        Write-Host "    Line $($i+1): $line" -ForegroundColor Gray
                        Write-Host "    Line $($i+2): $nextLine" -ForegroundColor Gray
                    }
                }
            }
        }
    }

    # SUBSECTION: Check for orphaned properties (properties not under a control)
    $inControl = $false
    for ($i = 0; $i -lt $content.Count; $i++) {
        $line = $content[$i]

        # Control definitions start with no indentation or minimal indentation
        if ($line -match '^[A-Za-z][A-Za-z0-9_]* As [A-Za-z]') {
            $inControl = $true
        }
        elseif ($line -match '^$') {
            $inControl = $false
        }
        elseif ($line -match '^(\s+)(AccessibleLabel|Tooltip):' -and -not $inControl) {
            Write-Host "  ❌ Line $($i+1): Orphaned property $($matches[2]) (not under a control)" -ForegroundColor Red
            $fileIssues++
        }
    }

    # SUBSECTION: Report results for this file
    if ($fileIssues -eq 0) {
        Write-Host "  ✅ No indentation issues found" -ForegroundColor Green
    }

    $totalIssues += $fileIssues
}


# SECTION: Output summary and next steps
Write-Host "`n📊 Summary: $totalIssues total issues found across $($files.Count) files" -ForegroundColor $(if ($totalIssues -gt 0) { 'Red' } else { 'Green' })


if ($totalIssues -gt 0) {
    Write-Host "`n💡 Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Fix indentation inconsistencies manually" -ForegroundColor White
    Write-Host "  2. Ensure all properties use spaces (not tabs)" -ForegroundColor White
    Write-Host "  3. Verify properties are properly nested under controls" -ForegroundColor White
    Write-Host "  4. Test with 'pac canvas pack' again" -ForegroundColor White
}
else {
    Write-Host "`n✅ All basic YAML structure looks correct" -ForegroundColor Green
    Write-Host "  The PA3003 error may be in a specific file location" -ForegroundColor Yellow
}

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see Power Apps YAML schema documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
