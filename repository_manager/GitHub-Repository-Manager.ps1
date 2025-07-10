# Employee Recognition App - One-Click Repository Manager (PowerShell)
# Copyright 2025 Kyle J. Coder - Apache License 2.0
# Double-click this file to prepare workspace for GitHub commit

<#
.SYNOPSIS
    One-click repository manager for Employee Recognition App

.DESCRIPTION
    This script provides a complete one-click solution for:
    - Workspace cleanup (remove redundant/outdated files)
    - CHANGELOG validation and updates
    - Safe commit preparation for GitHub

.NOTES
    Author: Kyle J. Coder
    Copyright: 2025 Kyle J. Coder - Apache License 2.0
    Version: 1.0
#>

# Set execution policy for this session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Change to project root directory (parent of script directory)
Set-Location (Split-Path $PSScriptRoot -Parent)

# Console setup
$Host.UI.RawUI.WindowTitle = "Employee Recognition App - Repository Manager"
Clear-Host

# Color functions
function Write-Header {
    param([string]$Text, [string]$Color = "Green")
    Write-Host ""
    Write-Host "================================================================" -ForegroundColor $Color
    Write-Host "  $Text" -ForegroundColor $Color
    Write-Host "================================================================" -ForegroundColor $Color
    Write-Host ""
}

function Write-Step {
    param([string]$Text, [string]$Icon = "🔧")
    Write-Host "$Icon $Text" -ForegroundColor Cyan
    Write-Host ("─" * ($Text.Length + 3)) -ForegroundColor DarkCyan
}

function Write-Success {
    param([string]$Text)
    Write-Host "✅ $Text" -ForegroundColor Green
}

function Write-Error {
    param([string]$Text)
    Write-Host "❌ $Text" -ForegroundColor Red
}

function Write-Warning {
    param([string]$Text)
    Write-Host "⚠️  $Text" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Text)
    Write-Host "ℹ️  $Text" -ForegroundColor White
}

# Main execution
try {
    Write-Header "🚀 Employee Recognition App - Repository Manager"
    Write-Host "Copyright 2025 Kyle J. Coder - Apache License 2.0" -ForegroundColor Gray
    Write-Host "Preparing workspace for GitHub commit..." -ForegroundColor White
    Write-Host ""

    # Validation checks
    Write-Step "Validating environment..." "🔍"

    if (-not (Test-Path "CHANGELOG.md")) {
        Write-Error "CHANGELOG.md not found!"
        Write-Host "   This script must be run from the project root directory." -ForegroundColor Yellow
        Write-Host "   Current directory: $(Get-Location)" -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 1
    }

    if (-not (Test-Path "scripts\workspace-cleanup.ps1")) {
        Write-Error "Workspace cleanup script not found!"
        Write-Host "   Expected: scripts\workspace-cleanup.ps1" -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Check git repository
    try {
        $null = git rev-parse --git-dir 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "Not in a git repository"
        }
    } catch {
        Write-Error "Not in a git repository or git not available!"
        Write-Host "   Make sure git is installed and this is a git repository." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit 1
    }

    Write-Success "Environment validation passed!"
    Write-Host ""

    # Step 1: Workspace Cleanup
    Write-Step "Cleaning workspace..." "🧹"

    try {
        $cleanupResult = & "scripts\workspace-cleanup.ps1" 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Workspace cleanup completed!"

            # Show cleanup summary if available
            if ($cleanupResult -match "Files removed: (\d+)") {
                $filesRemoved = $Matches[1]
                if ([int]$filesRemoved -gt 0) {
                    Write-Info "$filesRemoved files were cleaned up"
                } else {
                    Write-Info "Workspace was already clean"
                }
            }
        } else {
            Write-Warning "Workspace cleanup encountered issues, but continuing..."
            Write-Host $cleanupResult -ForegroundColor Yellow
        }
    } catch {
        Write-Warning "Workspace cleanup failed: $($_.Exception.Message)"
        Write-Host "Continuing with commit process..." -ForegroundColor Yellow
    }
    Write-Host ""

    # Step 2: Git Status Check
    Write-Step "Checking repository status..." "📋"

    $gitStatus = git status --porcelain 2>$null
    if (-not $gitStatus) {
        Write-Info "Working directory is clean - no changes to commit"
        Write-Success "Repository is up to date!"
        Read-Host "Press Enter to exit"
        exit 0
    }

    Write-Host "Current repository status:" -ForegroundColor White
    git status --short
    Write-Host ""

    # Step 3: Commit Options
    Write-Step "Preparing for commit with CHANGELOG validation..." "📝"

    Write-Host "Choose your preferred commit method:" -ForegroundColor White
    Write-Host "  1. Interactive safe commit (recommended)" -ForegroundColor Green
    Write-Host "  2. Quick commit with auto-generated message" -ForegroundColor Cyan
    Write-Host "  3. Preview only (dry run)" -ForegroundColor Yellow
    Write-Host "  4. Cancel and exit" -ForegroundColor Red
    Write-Host ""

    do {
        $choice = Read-Host "Enter your choice (1-4)"
    } while ($choice -notin @("1", "2", "3", "4"))

    Write-Host ""

    switch ($choice) {
        "1" {
            Write-Info "Running interactive safe commit..."
            & "scripts\safe-commit.ps1" -Interactive
        }
        "2" {
            Write-Info "Running quick commit with auto-generated message..."
            $timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
            & "scripts\safe-commit.ps1" -Message "Repository update - $timestamp"
        }
        "3" {
            Write-Info "Running preview mode (dry run)..."
            & "scripts\safe-commit.ps1" -DryRun
            Write-Host ""
            Write-Warning "This was a preview. No actual commit was made."
            Write-Host "Run this script again and choose option 1 or 2 to commit." -ForegroundColor Yellow
            Read-Host "Press Enter to exit"
            exit 0
        }
        "4" {
            Write-Info "Operation cancelled by user."
            Read-Host "Press Enter to exit"
            exit 0
        }
    }

    # Check commit result
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Success "Repository preparation completed successfully!"
        Write-Host ""

        Write-Host "📊 Final repository status:" -ForegroundColor White
        git status --short
        Write-Host ""

        Write-Header "🎯 Your repository is now ready for GitHub!" "Green"
    } else {
        Write-Host ""
        Write-Error "Commit process encountered issues."
        Write-Host "Check the messages above for details." -ForegroundColor Yellow
    }

} catch {
    Write-Host ""
    Write-Error "An unexpected error occurred:"
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""
    Write-Host "Stack trace:" -ForegroundColor Yellow
    Write-Host $_.ScriptStackTrace -ForegroundColor Yellow
} finally {
    Write-Host ""
    Write-Header "Process completed. You can now close this window." "Gray"
    Read-Host "Press Enter to exit"
}
