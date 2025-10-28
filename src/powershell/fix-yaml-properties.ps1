
# ============================================================================
#  Script: fix-yaml-properties.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script removes empty YAML property assignments that cause PowerApps
#    packaging to fail with PA3003 parse errors. It scans all .fx.yaml files in
#    the test.unpacked\Src directory and safely removes problematic lines.
#
#  USAGE:
#    1. Run this script from the project root directory.
#    2. It will process all .fx.yaml files in test.unpacked\Src.
#    3. No arguments are required; review the summary at the end.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell file parsing, filtering, and safe batch editing.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================

Write-Host "🔧 Fixing empty YAML properties in PowerApps source files..." -ForegroundColor Green
Write-Host ""

$sourceDir = "test\.unpacked\Src"
$yamlFiles = Get-ChildItem "$sourceDir\*.fx.yaml"

$totalFixed = 0

$totalFixed = 0

foreach ($file in $yamlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Cyan

    $content = Get-Content $file.FullName
    $originalLineCount = $content.Count
    $fixedLines = 0

    # Create new content array without empty properties
    $newContent = @()

    foreach ($line in $content) {
        # Skip lines with empty property assignments
        if ($line -match '^\s+[A-Za-z_][^:]*:\s*=$' -or
            $line -match '^\s+[A-Za-z_][^:]*:\s*=""$') {
            $fixedLines++
            Write-Host "  Removed: $line" -ForegroundColor Yellow
        }
        else {
            $newContent += $line
        }
    }

    if ($fixedLines -gt 0) {
        # Write the cleaned content back to the file
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "  ✅ Fixed $fixedLines empty properties in $($file.Name)" -ForegroundColor Green
        $totalFixed += $fixedLines
    }
    else {
        Write-Host "  ✅ No issues found in $($file.Name)" -ForegroundColor Green
    }

    Write-Host ""
}

Write-Host "🎉 Completed! Fixed $totalFixed empty properties across $($yamlFiles.Count) files." -ForegroundColor Green
Write-Host ""
Write-Host "You can now try packing the app again with:" -ForegroundColor Yellow
Write-Host "pac canvas pack --sources ""test\.unpacked"" --msapp ""test\EmployeeRecognitionApp_Fixed.msapp""" -ForegroundColor Cyan

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see Power Apps YAML schema documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
