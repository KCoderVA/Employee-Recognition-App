# Dual Repository Management Script

<#
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
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$false)]
    [string]$CommitMessage = "",

    [Parameter(Mandatory=$false)]
    [switch]$LocalOnly = $false,

    [Parameter(Mandatory=$false)]
    [switch]$GitHubOnly = $false,

    [Parameter(Mandatory=$false)]
    [switch]$Both = $false,

    [Parameter(Mandatory=$false)]
    [switch]$Status = $false,

    [Parameter(Mandatory=$false)]
    [switch]$SkipWorkspaceCleanup = $false
)

function Write-Header {
    param([string]$Title, [string]$Color = "Green")
    Write-Host ""
    Write-Host "🔄 $Title" -ForegroundColor $Color
    Write-Host ("=" * ($Title.Length + 4)) -ForegroundColor $Color
}

function Write-Status {
    param([string]$Message, [string]$Icon = "ℹ️", [string]$Color = "Cyan")
    Write-Host "$Icon $Message" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "⚠️ $Message" -ForegroundColor Yellow
}

Write-Header "Dual Repository Management - Employee Recognition App"

if ($Status) {
    Write-Status "Repository Status Information" "📊"

    # Local git status
    Write-Host ""
    Write-Host "📁 Local Repository Status:" -ForegroundColor Cyan
    git status --short

    # Remote status
    Write-Host ""
    Write-Host "🌐 Remote Repository Status:" -ForegroundColor Cyan
    git fetch --dry-run 2>&1 | Out-Host

    # Show what would be ignored for GitHub
    Write-Host ""
    Write-Host "🚫 Files Excluded from GitHub (via .gitignore):" -ForegroundColor Yellow
    if (Test-Path ".gitignore") {
        Get-Content ".gitignore" | Where-Object { $_ -notmatch "^#" -and $_ -ne "" } | ForEach-Object {
            if (Test-Path $_) {
                Write-Host "    • $_" -ForegroundColor Red
            }
        }
    }

    # Show included files for GitHub
    Write-Host ""
    Write-Host "✅ Files Included in GitHub Repository:" -ForegroundColor Green
    git ls-files | ForEach-Object {
        Write-Host "    • $_" -ForegroundColor Green
    }

    exit 0
}

# Validate parameters
if (!$LocalOnly -and !$GitHubOnly -and !$Both) {
    Write-Warning "Please specify repository target: -LocalOnly, -GitHubOnly, or -Both"
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Cyan
    Write-Host "  .\repository_manager\dual-repo-manager.ps1 -Status" -ForegroundColor White
    Write-Host "  .\repository_manager\dual-repo-manager.ps1 -Both -CommitMessage 'Update project files'" -ForegroundColor White
    Write-Host "  .\repository_manager\dual-repo-manager.ps1 -GitHubOnly -CommitMessage 'Public release'" -ForegroundColor White
    exit 1
}

if (!$CommitMessage -and !$Status) {
    $CommitMessage = Read-Host "Enter commit message"
    if (!$CommitMessage) {
        Write-Warning "Commit message is required"
        exit 1
    }
}

# Local Repository Management (maintains everything)
if ($LocalOnly -or $Both) {
    Write-Header "Local Repository Backup" "Blue"

    # Create comprehensive local backup
    $backupPath = ".\archive\local-backup-$(Get-Date -Format 'yyyy-MM-dd_HHmm')"
    Write-Status "Creating comprehensive local backup..." "💾"

    if (!(Test-Path ".\archive")) {
        New-Item -ItemType Directory -Path ".\archive" -Force | Out-Null
    }

    # Backup everything except .git folder
    $excludePatterns = @('.git', 'node_modules', 'temp')

    try {
        robocopy . $backupPath /E /XD .git node_modules temp /XF *.tmp /NFL /NDL /NP | Out-Null
        Write-Success "Local backup created: $backupPath"
    } catch {
        Write-Warning "Local backup failed: $_"
    }

    # Also maintain git history locally (including everything)
    Write-Status "Creating local git commit with all files..." "📝"

    # Temporarily rename .gitignore to include everything locally
    if (Test-Path ".gitignore") {
        Rename-Item ".gitignore" ".gitignore.github" -Force
    }

    # Create minimal .gitignore for local (only truly temporary files)
    @"
# Local Git - Minimal Exclusions Only
*.tmp
*.temp
.DS_Store
Thumbs.db
"@ | Set-Content ".gitignore.local" -Encoding UTF8

    Copy-Item ".gitignore.local" ".gitignore" -Force

    # Commit everything to local git
    git add -A
    git commit -m "LOCAL: $CommitMessage" 2>&1 | Out-Host

    # Restore GitHub .gitignore
    if (Test-Path ".gitignore.github") {
        Copy-Item ".gitignore.github" ".gitignore" -Force
        Remove-Item ".gitignore.github" -Force
    }
    Remove-Item ".gitignore.local" -Force

    Write-Success "Local repository updated with all files"
}

# GitHub Repository Management (excludes non-project files)
if ($GitHubOnly -or $Both) {
    Write-Header "GitHub Repository Sync" "Green"

    Write-Status "Ensuring GitHub .gitignore is active..." "🔧"

    # Make sure we're using the GitHub .gitignore
    if (Test-Path ".gitignore.github") {
        Copy-Item ".gitignore.github" ".gitignore" -Force
        Remove-Item ".gitignore.github" -Force
    }

    # Show what will be committed to GitHub
    Write-Status "Files to be committed to GitHub:" "📋"
    $gitStatus = git status --porcelain
    if ($gitStatus) {
        $gitStatus | ForEach-Object {
            Write-Host "    • $_" -ForegroundColor Yellow
        }
    } else {
        Write-Host "    No changes to commit" -ForegroundColor Gray
    }

    # Stage only non-ignored files
    git add .

    # Commit to GitHub
    if (git diff --cached --quiet) {
        Write-Status "No changes to commit to GitHub" "ℹ️" "Yellow"
    } else {
        Write-Status "Committing project files to GitHub..." "🚀"
        git commit -m "GITHUB: $CommitMessage"

        # Push to GitHub
        Write-Status "Pushing to GitHub..." "📤"
        git push origin main

        if ($LASTEXITCODE -eq 0) {
            Write-Success "Successfully pushed to GitHub!"

            # Get commit info
            $commitHash = git rev-parse --short HEAD
            Write-Status "Commit hash: $commitHash" "🔗" "Green"
        } else {
            Write-Warning "Push to GitHub failed"
        }
    }
}

Write-Header "Dual Repository Management Complete" "Green"
Write-Status "Local repository: Contains ALL workspace files and history" "💾"
Write-Status "GitHub repository: Contains only project-related files" "🌐"

if ($Both) {
    Write-Status "Both repositories have been updated successfully" "✨" "Green"
}
