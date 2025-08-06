
# ============================================================================
#  Script: fix-form-accessibility-properties.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script corrects PowerApps YAML form control accessibility patterns that
#    cause PA3003 parsing errors. It only processes files in the test.unpacked
#    directory to avoid modifying working files.
#
#  USAGE:
#    1. Run this script from the project root directory.
#    2. Use -DryRun to preview changes without modifying files.
#    3. Use -Verbose for detailed output.
#    4. Review the summary and safety confirmation at the end.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell file parsing, regex, and safe batch editing.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================


# =====================
# PARAMETER DEFINITION
# =====================
# -DryRun: Preview changes only
# -Verbose: Show detailed output
param(
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)


# =====================
# INITIALIZATION
# =====================
# Define the target directory - ONLY test.unpacked
$TargetDirectory = "test\.unpacked\Src"
$ScriptLocation = Get-Location


# =====================
# MAIN SCRIPT LOGIC
# =====================
Write-Host "🔧 PowerApps Form Control Accessibility Fix Script" -ForegroundColor Cyan
Write-Host "📁 Target Directory: $TargetDirectory" -ForegroundColor Yellow
Write-Host "📍 Working Directory: $ScriptLocation" -ForegroundColor Yellow


if ($DryRun) {
    Write-Host "🔍 DRY RUN MODE - No files will be modified" -ForegroundColor Green
}


# SECTION: Verify target directory exists and is correct
$FullTargetPath = Join-Path $ScriptLocation $TargetDirectory
if (-not (Test-Path $FullTargetPath)) {
    Write-Host "❌ ERROR: Target directory not found: $FullTargetPath" -ForegroundColor Red
    Write-Host "   Make sure you're running this script from the Employee Recognition App root directory" -ForegroundColor Red
    exit 1
}


Write-Host "✅ Target directory confirmed: $FullTargetPath" -ForegroundColor Green


# SECTION: Get all YAML files in the target directory
$YamlFiles = Get-ChildItem -Path $FullTargetPath -Filter "*.fx.yaml" -File
Write-Host "🔍 Searching for files in: $FullTargetPath" -ForegroundColor Cyan


if ($YamlFiles.Count -eq 0) {
    Write-Host "❌ No .fx.yaml files found in target directory" -ForegroundColor Red
    Write-Host "   Directory contents:" -ForegroundColor Yellow
    Get-ChildItem -Path $FullTargetPath | ForEach-Object { Write-Host "      $($_.Name)" -ForegroundColor Gray }
    exit 1
}


Write-Host "📋 Found $($YamlFiles.Count) YAML files to process:" -ForegroundColor Cyan
foreach ($file in $YamlFiles) {
    Write-Host "   - $($file.Name)" -ForegroundColor White
}


# SECTION: Define problematic patterns that need to be fixed
$ProblematicPatterns = @(
    # Form controls that should use Parent.DisplayName pattern
    @{
        Name        = "DataCardValue Text Input Controls"
        Pattern     = '(\s+)AccessibleLabel: ="([^"]*text input[^"]*)"'
        Replacement = '$1AccessibleLabel: =Parent.DisplayName'
        Description = "Form text input controls should inherit accessibility from parent"
    },
    @{
        Name        = "DataCardValue Date Picker Controls"
        Pattern     = '(\s+)AccessibleLabel: ="([^"]*date picker[^"]*)"'
        Replacement = '$1AccessibleLabel: =Parent.DisplayName'
        Description = "Form date picker controls should inherit accessibility from parent"
    },
    @{
        Name        = "DataCardValue Dropdown Controls"
        Pattern     = '(\s+)AccessibleLabel: ="([^"]*dropdown[^"]*)"'
        Replacement = '$1AccessibleLabel: =Parent.DisplayName'
        Description = "Form dropdown controls should inherit accessibility from parent"
    },
    @{
        Name        = "DataCardValue Description Fields"
        Pattern     = '(\s+)AccessibleLabel: ="([^"]*description[^"]*)"'
        Replacement = '$1AccessibleLabel: =Parent.DisplayName'
        Description = "Form description fields should inherit accessibility from parent"
    },
    @{
        Name        = "DataCardValue Comment Fields"
        Pattern     = '(\s+)AccessibleLabel: ="([^"]*comment[^"]*)"'
        Replacement = '$1AccessibleLabel: =Parent.DisplayName'
        Description = "Form comment fields should inherit accessibility from parent"
    }
)


# SECTION: Statistics tracking
$TotalChanges = 0
$FilesModified = 0
$ChangesByPattern = @{}


foreach ($pattern in $ProblematicPatterns) {
    $ChangesByPattern[$pattern.Name] = 0
}


# SECTION: Process each YAML file
foreach ($file in $YamlFiles) {
    Write-Host "`n🔍 Processing: $($file.Name)" -ForegroundColor Yellow

    $content = Get-Content $file.FullName -Raw
    $fileChanges = 0

    # Apply each pattern fix
    foreach ($pattern in $ProblematicPatterns) {
        $regexMatches = [regex]::Matches($content, $pattern.Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)

        if ($regexMatches.Count -gt 0) {
            Write-Host "   🎯 Found $($regexMatches.Count) instances of: $($pattern.Name)" -ForegroundColor Cyan

            if ($Verbose) {
                foreach ($match in $regexMatches) {
                    Write-Host "      - Line context: $($match.Groups[2].Value)" -ForegroundColor Gray
                }
            }

            $content = [regex]::Replace($content, $pattern.Pattern, $pattern.Replacement, [System.Text.RegularExpressions.RegexOptions]::Multiline)
            $fileChanges += $regexMatches.Count
            $ChangesByPattern[$pattern.Name] += $regexMatches.Count
        }
    }

    # Save changes if any were made
    if ($fileChanges -gt 0) {
        if (-not $DryRun) {
            Set-Content -Path $file.FullName -Value $content -NoNewline
            Write-Host "   ✅ Applied $fileChanges changes to $($file.Name)" -ForegroundColor Green
        }
        else {
            Write-Host "   🔍 DRY RUN: Would apply $fileChanges changes to $($file.Name)" -ForegroundColor Yellow
        }

        $TotalChanges += $fileChanges
        $FilesModified++
    }
    else {
        Write-Host "   ℹ️  No problematic patterns found in $($file.Name)" -ForegroundColor Gray
    }
}


# SECTION: Display summary and safety confirmation
Write-Host "`n📊 SUMMARY REPORT" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan
Write-Host "Files Processed: $($YamlFiles.Count)" -ForegroundColor White
Write-Host "Files Modified: $FilesModified" -ForegroundColor White
Write-Host "Total Changes: $TotalChanges" -ForegroundColor White

if ($TotalChanges -gt 0) {
    Write-Host "`n📋 Changes by Pattern:" -ForegroundColor Yellow
    foreach ($pattern in $ProblematicPatterns) {
        $count = $ChangesByPattern[$pattern.Name]
        if ($count -gt 0) {
            Write-Host "   - $($pattern.Name): $count changes" -ForegroundColor White
            Write-Host "     $($pattern.Description)" -ForegroundColor Gray
        }
    }

    if (-not $DryRun) {
        Write-Host "`n✅ Form control accessibility properties have been corrected!" -ForegroundColor Green
        Write-Host "   These changes should resolve the PA3003 YAML parsing errors." -ForegroundColor Green
        Write-Host "   Try running 'pac canvas pack' again to test the fix." -ForegroundColor Green
    }
    else {
        Write-Host "`n🔍 DRY RUN COMPLETE - No files were actually modified" -ForegroundColor Yellow
        Write-Host "   Run without -DryRun flag to apply these changes" -ForegroundColor Yellow
    }
}
else {
    Write-Host "`nℹ️  No problematic form control accessibility patterns found" -ForegroundColor Gray
    Write-Host "   The PA3003 errors may be caused by different issues" -ForegroundColor Gray
}

Write-Host "`n🔒 SAFETY CONFIRMATION:" -ForegroundColor Magenta
Write-Host "   ✅ Only files in test\.unpacked directory were processed" -ForegroundColor Green
Write-Host "   ✅ Original working files remain untouched" -ForegroundColor Green
Write-Host "   ✅ Changes follow PowerApps form control best practices" -ForegroundColor Green

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see Power Apps YAML schema documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
