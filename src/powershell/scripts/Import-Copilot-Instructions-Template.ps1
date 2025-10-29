# ============================================================================
#  Script: Import-Copilot-Instructions-Template.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script imports and merges the public Copilot instructions template
#    into an existing workspace. It searches for the template file
#    "copilot-instructions(public).md" and either creates a new
#    "copilot-instructions.md" file or appends the template content to an
#    existing one. The template file is then archived for reference.
#
#  USAGE:
#    1. Run this script from the root directory of your workspace:
#         pwsh -ExecutionPolicy Bypass -File ./src/v1.0.x/v1.0.0/powershell/Import-Copilot-Instructions-Template.ps1
#    2. For testing without making changes, use the -DryRun parameter:
#         pwsh -ExecutionPolicy Bypass -File ./src/v1.0.x/v1.0.0/powershell/Import-Copilot-Instructions-Template.ps1 -DryRun
#    3. The script will automatically:
#         - Search for the template file recursively
#         - Check for existing copilot-instructions.md file
#         - Merge or create the instructions file
#         - Archive the template file for future reference
#    4. Designed for seamless integration of Power Platform Copilot templates
#    5. Preserves existing user customizations while adding template content
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell file system operations, content manipulation, and workspace organization
#    - Implements safe file merging practices to preserve existing user content
#    - Uses robust error handling for enterprise-grade automation
#    - Follows Microsoft Power Platform ALM best practices for template distribution
# ============================================================================


# =====================
# SCRIPT PARAMETERS
# =====================
param(
    [switch]$DryRun = $false
)

# =====================
# MAIN SCRIPT EXECUTION
# =====================

if ($DryRun) {
    Write-Host "🧪 DRY RUN MODE ENABLED - No files will be modified" -ForegroundColor Magenta
    Write-Host "🚀 Starting Copilot Instructions Template Import Process (DRY RUN)..." -ForegroundColor Cyan
}
else {
    Write-Host "🚀 Starting Copilot Instructions Template Import Process..." -ForegroundColor Cyan
}
Write-Host ""

try {
    # SECTION 1: Determine workspace root directory
    # Find the root workspace directory by looking for common indicators
    $workspaceRoot = Get-Location
    $originalLocation = $workspaceRoot

    # Look for workspace indicators (git, VS Code, etc.)
    while ($workspaceRoot.Path -ne $workspaceRoot.Root.Path) {
        if ((Test-Path (Join-Path $workspaceRoot.Path ".git")) -or
            (Test-Path (Join-Path $workspaceRoot.Path ".vscode")) -or
            (Test-Path (Join-Path $workspaceRoot.Path "*.code-workspace"))) {
            break
        }
        $workspaceRoot = $workspaceRoot.Parent
    }

    Write-Host "📂 Workspace root directory: $($workspaceRoot.Path)" -ForegroundColor Green

    # SECTION 2: Search for the template file recursively
    Write-Host "🔍 Searching for copilot-instructions(public).md template file..." -ForegroundColor Yellow

    $templateFile = Get-ChildItem -Path $workspaceRoot.Path -Name "copilot-instructions(public).md" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1

    if (-not $templateFile) {
        Write-Host "❌ ERROR: Template file 'copilot-instructions(public).md' not found in workspace!" -ForegroundColor Red
        Write-Host "   Please ensure the template file exists in the workspace before running this script." -ForegroundColor Red
        exit 1
    }

    $templatePath = Join-Path $workspaceRoot.Path $templateFile
    Write-Host "✅ Found template file: $templatePath" -ForegroundColor Green

    # SECTION 3: Check for existing copilot-instructions.md file
    $targetPath = Join-Path $workspaceRoot.Path ".github\copilot-instructions.md"
    $githubDir = Join-Path $workspaceRoot.Path ".github"

    Write-Host "🔍 Checking for existing copilot-instructions.md file..." -ForegroundColor Yellow

    # Ensure .github directory exists
    if (-not (Test-Path $githubDir)) {
        if ($DryRun) {
            Write-Host "📁 [DRY RUN] Would create .github directory..." -ForegroundColor Yellow
        }
        else {
            Write-Host "📁 Creating .github directory..." -ForegroundColor Yellow
            New-Item -Path $githubDir -ItemType Directory -Force | Out-Null
        }
    }

    $existingContent = ""
    $existingLineCount = 0

    if (Test-Path $targetPath) {
        Write-Host "✅ Found existing copilot-instructions.md file" -ForegroundColor Green

        # SECTION 5: Read existing file content and count lines
        $existingContent = Get-Content -Path $targetPath -Raw -ErrorAction SilentlyContinue
        if ($existingContent) {
            $existingLineCount = ($existingContent -split "`n").Count
            Write-Host "📊 Existing file contains $existingLineCount lines" -ForegroundColor Cyan
        }
    }
    else {
        # SECTION 4: Create blank file if it doesn't exist
        if ($DryRun) {
            Write-Host "📄 [DRY RUN] Would create new copilot-instructions.md file..." -ForegroundColor Yellow
            Write-Host "✅ [DRY RUN] Would have created new blank copilot-instructions.md file" -ForegroundColor Green
        }
        else {
            Write-Host "📄 Creating new copilot-instructions.md file..." -ForegroundColor Yellow
            New-Item -Path $targetPath -ItemType File -Force | Out-Null
            Write-Host "✅ Created new blank copilot-instructions.md file" -ForegroundColor Green
        }
    }

    # SECTION 6: Read template content and append to target file
    Write-Host "📖 Reading template content..." -ForegroundColor Yellow

    $templateContent = Get-Content -Path $templatePath -Raw -ErrorAction Stop
    if (-not $templateContent) {
        Write-Host "❌ ERROR: Template file appears to be empty!" -ForegroundColor Red
        exit 1
    }

    $templateLineCount = ($templateContent -split "`n").Count
    Write-Host "📊 Template contains $templateLineCount lines" -ForegroundColor Cyan

    # Prepare content for merging
    if ($existingContent) {
        # Ensure existing content ends with newline before appending
        if (-not $existingContent.EndsWith("`n")) {
            $existingContent += "`n"
        }
        $mergedContent = $existingContent + "`n" + "# ============================================================================" + "`n"
        $mergedContent += "# IMPORTED TEMPLATE CONTENT - Added on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" + "`n"
        $mergedContent += "# Source: copilot-instructions(public).md template" + "`n"
        $mergedContent += "# ============================================================================" + "`n" + "`n"
        $mergedContent += $templateContent

        Write-Host "🔄 Appending template content to existing file..." -ForegroundColor Yellow
    }
    else {
        $mergedContent = $templateContent
        Write-Host "📝 Adding template content to new file..." -ForegroundColor Yellow
    }

    # Write merged content to target file
    if ($DryRun) {
        Write-Host "💾 [DRY RUN] Would write merged content to target file..." -ForegroundColor Yellow
        $finalLineCount = ($mergedContent -split "`n").Count
        Write-Host "✅ [DRY RUN] Would have merged content. Final file would contain $finalLineCount lines" -ForegroundColor Green
    }
    else {
        Set-Content -Path $targetPath -Value $mergedContent -Encoding UTF8 -ErrorAction Stop
        $finalLineCount = ($mergedContent -split "`n").Count
        Write-Host "✅ Successfully merged content. Final file contains $finalLineCount lines" -ForegroundColor Green
    }

    # SECTION 7: Move template file to archive directory
    Write-Host "📦 Archiving template file..." -ForegroundColor Yellow

    $archiveDir = Join-Path $workspaceRoot.Path "archive\.github"
    if (-not (Test-Path $archiveDir)) {
        if ($DryRun) {
            Write-Host "📁 [DRY RUN] Would create archive\.github directory..." -ForegroundColor Yellow
        }
        else {
            Write-Host "📁 Creating archive\.github directory..." -ForegroundColor Yellow
            New-Item -Path $archiveDir -ItemType Directory -Force | Out-Null
        }
    }

    $archivePath = Join-Path $archiveDir "copilot-instructions(public).md"
    if ($DryRun) {
        Write-Host "📄 [DRY RUN] Would copy template file to archive directory..." -ForegroundColor Yellow
        Write-Host "✅ [DRY RUN] Template file would be copied to archive directory" -ForegroundColor Green
    }
    else {
        Copy-Item -Path $templatePath -Destination $archivePath -Force -ErrorAction Stop
        Write-Host "✅ Template file copied to archive directory" -ForegroundColor Green
    }

    # SECTION 8: Delete original template file
    if ($DryRun) {
        Write-Host "🗑️ [DRY RUN] Would remove original template file..." -ForegroundColor Yellow
        Write-Host "✅ [DRY RUN] Original template file would be removed" -ForegroundColor Green
    }
    else {
        Write-Host "🗑️ Removing original template file..." -ForegroundColor Yellow
        Remove-Item -Path $templatePath -Force -ErrorAction Stop
        Write-Host "✅ Original template file removed" -ForegroundColor Green
    }

    # SECTION 9: Rename archived file
    Write-Host "📝 Renaming archived template file..." -ForegroundColor Yellow
    $renamedArchivePath = Join-Path $archiveDir "TEMPLATE_Copilot_Instructions.md"
    if ($DryRun) {
        Write-Host "📝 [DRY RUN] Would rename archived file to TEMPLATE_Copilot_Instructions.md..." -ForegroundColor Yellow
        Write-Host "✅ [DRY RUN] Archived file would be renamed to TEMPLATE_Copilot_Instructions.md" -ForegroundColor Green
    }
    else {
        Rename-Item -Path $archivePath -NewName "TEMPLATE_Copilot_Instructions.md" -Force -ErrorAction Stop
        Write-Host "✅ Archived file renamed to TEMPLATE_Copilot_Instructions.md" -ForegroundColor Green
    }

    # SECTION 10: Provide final summary report
    Write-Host ""
    if ($DryRun) {
        Write-Host "🧪 COPILOT INSTRUCTIONS TEMPLATE IMPORT - DRY RUN COMPLETED!" -ForegroundColor Magenta
        Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor Magenta
        Write-Host ""
        Write-Host "🔍 DRY RUN ANALYSIS REPORT:" -ForegroundColor Cyan
    }
    else {
        Write-Host "🎉 COPILOT INSTRUCTIONS TEMPLATE IMPORT COMPLETED SUCCESSFULLY!" -ForegroundColor Green
        Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor Green
        Write-Host ""
        Write-Host "📊 SUMMARY REPORT:" -ForegroundColor Cyan
    }
    Write-Host "  • Workspace Root: $($workspaceRoot.Path)" -ForegroundColor White
    Write-Host "  • Template Source: Found and processed $templateLineCount lines" -ForegroundColor White

    if ($existingLineCount -gt 0) {
        if ($DryRun) {
            Write-Host "  • Existing Content: Would preserve $existingLineCount lines from existing file" -ForegroundColor White
            Write-Host "  • Merge Strategy: Template content would be appended to existing instructions" -ForegroundColor White
        }
        else {
            Write-Host "  • Existing Content: Preserved $existingLineCount lines from existing file" -ForegroundColor White
            Write-Host "  • Merge Strategy: Template content appended to existing instructions" -ForegroundColor White
        }
    }
    else {
        if ($DryRun) {
            Write-Host "  • File Creation: New copilot-instructions.md file would be created" -ForegroundColor White
            Write-Host "  • Content Strategy: Template content would be added as primary content" -ForegroundColor White
        }
        else {
            Write-Host "  • File Creation: New copilot-instructions.md file created" -ForegroundColor White
            Write-Host "  • Content Strategy: Template content added as primary content" -ForegroundColor White
        }
    }

    if ($DryRun) {
        Write-Host "  • Final Result: $finalLineCount total lines would be in active instructions file" -ForegroundColor White
        Write-Host "  • Archive Location: $renamedArchivePath (would be created)" -ForegroundColor White
    }
    else {
        Write-Host "  • Final Result: $finalLineCount total lines in active instructions file" -ForegroundColor White
        Write-Host "  • Archive Location: $renamedArchivePath" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "📁 ACTIVE FILE LOCATION:" -ForegroundColor Cyan
    Write-Host "  $targetPath" -ForegroundColor Yellow
    Write-Host ""
    if ($DryRun) {
        Write-Host "🧪 DRY RUN COMPLETED - NO FILES WERE MODIFIED" -ForegroundColor Magenta
        Write-Host "🔧 TO EXECUTE FOR REAL:" -ForegroundColor Cyan
        Write-Host "  Run the script again without the -DryRun parameter" -ForegroundColor White
        Write-Host ""
        Write-Host "✨ DRY RUN: Your workspace would be configured with Power Platform Copilot instructions!" -ForegroundColor Magenta
    }
    else {
        Write-Host "🔧 NEXT STEPS:" -ForegroundColor Cyan
        Write-Host "  1. Review the merged copilot-instructions.md file" -ForegroundColor White
        Write-Host "  2. Customize the template content for your specific needs" -ForegroundColor White
        Write-Host "  3. Commit the new instructions to your repository" -ForegroundColor White
        Write-Host "  4. Test Copilot functionality with the new instructions" -ForegroundColor White
        Write-Host ""
        Write-Host "✨ Your workspace is now configured with Power Platform Copilot instructions!" -ForegroundColor Green
    }

}
catch {
    Write-Host ""
    if ($DryRun) {
        Write-Host "❌ ERROR OCCURRED DURING DRY RUN ANALYSIS:" -ForegroundColor Red
    }
    else {
        Write-Host "❌ ERROR OCCURRED DURING TEMPLATE IMPORT:" -ForegroundColor Red
    }
    Write-Host "   $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "🔧 TROUBLESHOOTING STEPS:" -ForegroundColor Yellow
    Write-Host "  1. Ensure you have read permissions to the workspace directory" -ForegroundColor White
    if (-not $DryRun) {
        Write-Host "  2. Ensure you have write permissions to the workspace directory" -ForegroundColor White
    }
    Write-Host "  3. Verify the template file 'copilot-instructions(public).md' exists" -ForegroundColor White
    Write-Host "  4. Check that PowerShell execution policy allows script execution" -ForegroundColor White
    Write-Host "  5. Run the script from the workspace root directory" -ForegroundColor White
    if (-not $DryRun) {
        Write-Host "  6. Try running with -DryRun parameter first to test the process" -ForegroundColor White
    }
    Write-Host ""
    Write-Host "📧 If issues persist, check the project documentation or submit an issue." -ForegroundColor White

    exit 1
}

# End of script
