# Copilot Export Package - Quick Install Script
# Copyright 2025 Kyle J. Coder - Licensed under Apache License 2.0

param(
    [Parameter(Mandatory=$true)]
    [string]$TargetWorkspace,

    [switch]$CopilotOnly,
    [switch]$ScriptsOnly,
    [switch]$WorkflowsOnly,
    [switch]$DryRun
)

# Script metadata
$ScriptVersion = "1.0.0"
$ScriptName = "Copilot Export Package Installer"

Write-Host "🚀 $ScriptName v$ScriptVersion" -ForegroundColor Cyan
Write-Host "Copyright 2025 Kyle J. Coder - Licensed under Apache 2.0" -ForegroundColor Gray
Write-Host ""

# Validate target workspace
if (-not (Test-Path $TargetWorkspace)) {
    Write-Host "❌ Target workspace does not exist: $TargetWorkspace" -ForegroundColor Red
    exit 1
}

$SourcePath = $PSScriptRoot
$TargetPath = $TargetWorkspace

Write-Host "📂 Source: $SourcePath" -ForegroundColor Yellow
Write-Host "🎯 Target: $TargetPath" -ForegroundColor Yellow
Write-Host ""

if ($DryRun) {
    Write-Host "🔍 DRY RUN MODE - No files will be copied" -ForegroundColor Magenta
    Write-Host ""
}

# Function to safely copy files
function Copy-FileSafely {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Description
    )

    if (Test-Path $Source) {
        Write-Host "📄 $Description..." -ForegroundColor Green

        if (-not $DryRun) {
            $DestDir = Split-Path $Destination -Parent
            if (-not (Test-Path $DestDir)) {
                New-Item -ItemType Directory -Path $DestDir -Force | Out-Null
            }
            Copy-Item $Source $Destination -Force
        }
        Write-Host "   ✅ $Source → $Destination" -ForegroundColor Cyan
    } else {
        Write-Host "⚠️  Skipping $Description (not found): $Source" -ForegroundColor Yellow
    }
}

# Function to copy directory
function Copy-DirectorySafely {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Description
    )

    if (Test-Path $Source) {
        Write-Host "📁 $Description..." -ForegroundColor Green

        if (-not $DryRun) {
            if (-not (Test-Path $Destination)) {
                New-Item -ItemType Directory -Path $Destination -Force | Out-Null
            }
            Copy-Item "$Source\*" $Destination -Recurse -Force
        }
        Write-Host "   ✅ $Source → $Destination" -ForegroundColor Cyan
    } else {
        Write-Host "⚠️  Skipping $Description (not found): $Source" -ForegroundColor Yellow
    }
}

# Installation logic
if ($CopilotOnly) {
    Write-Host "🤖 Installing Copilot Instructions Only" -ForegroundColor Magenta
    Copy-FileSafely "$SourcePath\.github\copilot-instructions.md" "$TargetPath\.github\copilot-instructions.md" "Copilot Instructions"
}
elseif ($ScriptsOnly) {
    Write-Host "💻 Installing Scripts and VS Code Tasks Only" -ForegroundColor Magenta
    Copy-DirectorySafely "$SourcePath\scripts" "$TargetPath\scripts" "PowerShell Scripts"
    Copy-FileSafely "$SourcePath\.vscode\tasks.json" "$TargetPath\.vscode\tasks.json" "VS Code Tasks"
}
elseif ($WorkflowsOnly) {
    Write-Host "🔄 Installing GitHub Workflows Only" -ForegroundColor Magenta
    Copy-DirectorySafely "$SourcePath\.github\workflows" "$TargetPath\.github\workflows" "GitHub Workflows"
}
else {
    Write-Host "📦 Installing Complete Package" -ForegroundColor Magenta

    # Copy copilot instructions
    Copy-FileSafely "$SourcePath\.github\copilot-instructions.md" "$TargetPath\.github\copilot-instructions.md" "Copilot Instructions"

    # Copy scripts
    Copy-DirectorySafely "$SourcePath\scripts" "$TargetPath\scripts" "PowerShell Scripts"

    # Copy VS Code configuration
    Copy-FileSafely "$SourcePath\.vscode\tasks.json" "$TargetPath\.vscode\tasks.json" "VS Code Tasks"

    # Copy GitHub workflows
    Copy-DirectorySafely "$SourcePath\.github\workflows" "$TargetPath\.github\workflows" "GitHub Workflows"

    # Copy documentation
    Copy-FileSafely "$SourcePath\README.md" "$TargetPath\COPILOT_EXPORT_README.md" "Installation Documentation"
}

Write-Host ""
Write-Host "✅ Installation Complete!" -ForegroundColor Green
Write-Host ""

# Post-installation instructions
if (-not $DryRun) {
    Write-Host "📋 Next Steps:" -ForegroundColor Yellow
    Write-Host "1. Customize the copilot-instructions.md file for your project" -ForegroundColor White
    Write-Host "2. Update file paths in scripts and tasks to match your structure" -ForegroundColor White
    Write-Host "3. Test VS Code tasks: Ctrl+Shift+P → 'Tasks: Run Task'" -ForegroundColor White
    Write-Host "4. Verify PowerShell execution policy: Set-ExecutionPolicy RemoteSigned" -ForegroundColor White
    Write-Host ""
    Write-Host "🤖 Copilot Commands Available:" -ForegroundColor Cyan
    Write-Host "   • 'Clean workspace' - Execute workspace cleanup" -ForegroundColor White
    Write-Host "   • 'Health check' - Run repository health analysis" -ForegroundColor White
    Write-Host "   • 'Organize files' - Reorganize files to logical locations" -ForegroundColor White
} else {
    Write-Host "📋 This was a dry run. Use without -DryRun to perform actual installation." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📄 For detailed setup instructions, see the README.md file." -ForegroundColor Gray
