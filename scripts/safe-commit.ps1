# Enhanced Safe Commit Script with Comprehensive CHANGELOG Enforcement

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
    [Parameter(Mandatory=$false, Position=0)]
    [string]$CommitMessage = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$Force = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$SkipChangelogCheck = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$Interactive = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false,
    
    [Parameter(Mandatory=$false)]
    [string]$ChangelogEntry = "",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Added", "Changed", "Deprecated", "Removed", "Fixed", "Security")]
    [string]$ChangeType = "Changed"
)

# Helper Functions
function Write-Header {
    param([string]$Title, [string]$Color = "Green")
    Write-Host ""
    Write-Host "🛡️ $Title" -ForegroundColor $Color
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

# Main execution
Write-Header "Safe Commit Manager - Employee Recognition App"
Write-Status "Ensuring CHANGELOG.md compliance before commit" "🔍"

if ($DryRun) {
    Write-Warning "DRY RUN MODE - No actual commits will be made"
}

# Check if we're in a git repository
try {
    $null = git rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Not in a git repository"
    }
} catch {
    Write-Error "Not in a git repository!"
    exit 1
}

# Get current git status
$gitStatus = git status --porcelain 2>$null
if (!$gitStatus) {
    Write-Status "No changes to commit - working directory is clean" "✨" "Green"
    exit 0
}

Write-Status "Current Changes Detected:" "📋"
$stagedFiles = @()
$unstagedFiles = @()

foreach ($line in $gitStatus) {
    $status = $line.Substring(0, 2)
    $file = $line.Substring(3)
    
    if ($status[0] -ne ' ') {
        $stagedFiles += $file
        Write-Host "  📄 [STAGED] $file" -ForegroundColor Green
    }
    if ($status[1] -ne ' ') {
        $unstagedFiles += $file
        Write-Host "  📝 [MODIFIED] $file" -ForegroundColor Yellow
    }
}
# Stage all modified files if none are staged
if ($stagedFiles.Count -eq 0 -and $unstagedFiles.Count -gt 0) {
    if ($Interactive) {
        Write-Status "No files staged. Stage all modified files? (y/N)" "🤔" "Yellow"
        $response = Read-Host
        if ($response -eq "y" -or $response -eq "Y") {
            git add .
            Write-Success "All modified files staged"
            $stagedFiles = $unstagedFiles
        }
    } else {
        Write-Status "Auto-staging all modified files..." "📦"
        git add .
        Write-Success "All modified files staged"
        $stagedFiles = $unstagedFiles
    }
}

if ($stagedFiles.Count -eq 0) {
    Write-Warning "No files staged for commit"
    exit 0
}

# Analyze if changes require CHANGELOG update
function Test-RequiresChangelog {
    param([string[]]$Files)
    
    $significantExtensions = @('.md', '.js', '.ts', '.py', '.ps1', '.json', '.yml', '.yaml', '.xml', '.html', '.css')
    $significantPaths = @('src/', 'docs/', 'scripts/', '.github/', 'assets/')
    $significantFiles = @('LICENSE', 'NOTICE', 'SECURITY.md', 'CONTRIBUTING.md', 'README.md')
    
    foreach ($file in $Files) {
        # Skip CHANGELOG.md itself
        if ($file -eq "CHANGELOG.md") { continue }
        
        # Check file extensions
        foreach ($ext in $significantExtensions) {
            if ($file.EndsWith($ext)) { return $true }
        }
        
        # Check paths
        foreach ($path in $significantPaths) {
            if ($file.StartsWith($path)) { return $true }
        }
        
        # Check specific files
        if ($significantFiles -contains $file) { return $true }
    }
    
    return $false
}

# CHANGELOG enforcement (unless explicitly skipped)
$requiresChangelog = Test-RequiresChangelog $stagedFiles

if (!$SkipChangelogCheck -and $requiresChangelog) {
    Write-Status "CHANGELOG Verification Required..." "🔍" "Yellow"
    
    # Check if CHANGELOG.md exists
    if (!(Test-Path "CHANGELOG.md")) {
        Write-Error "CHANGELOG.md not found!"
        Write-Host "A CHANGELOG.md file is required for this project." -ForegroundColor Yellow
        Write-Host "Run: .\scripts\update-changelog.ps1 --init" -ForegroundColor Cyan
        exit 1
    }
    
    # Check if CHANGELOG.md is being committed
    $changelogStaged = $stagedFiles -contains "CHANGELOG.md"
    
    # Get the last modification date of CHANGELOG.md
    $changelogLastModified = (Get-Item "CHANGELOG.md").LastWriteTime
    $timeSinceModified = (Get-Date) - $changelogLastModified
    
    # Check if CHANGELOG.md has recent updates (within last 2 hours)
    $recentUpdate = $timeSinceModified.TotalHours -lt 2
    
    if (!$changelogStaged -and !$recentUpdate -and !$Force) {
        Write-Header "CHANGELOG UPDATE REQUIRED" "Red"
        Write-Host "The CHANGELOG.md file must be updated before committing significant changes." -ForegroundColor Yellow
        Write-Host "Last modified: $($changelogLastModified.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Gray
        Write-Host "Time since modification: $([math]::Round($timeSinceModified.TotalMinutes, 1)) minutes" -ForegroundColor Gray
        Write-Host ""
        
        Write-Status "Files requiring CHANGELOG documentation:" "📄"
        foreach ($file in $stagedFiles) {
            if ($file -ne "CHANGELOG.md" -and (Test-RequiresChangelog @($file))) {
                Write-Host "  • $file" -ForegroundColor Cyan
            }
        }
        Write-Host ""
        
        Write-Status "Resolution Options:" "🛠️"
        Write-Host "  1. Auto-update CHANGELOG: .\scripts\update-changelog.ps1" -ForegroundColor White
        Write-Host "  2. Manual edit: code CHANGELOG.md" -ForegroundColor White
        Write-Host "  3. Interactive entry: Add -ChangelogEntry 'Your change description'" -ForegroundColor White
        Write-Host "  4. Force bypass: Add -Force (NOT recommended)" -ForegroundColor White
        Write-Host ""
        
        # Offer to auto-update CHANGELOG if ChangelogEntry provided
        if ($ChangelogEntry) {
            Write-Status "Auto-updating CHANGELOG with provided entry..." "🔄"
            try {
                & ".\scripts\update-changelog.ps1" -Entry $ChangelogEntry -Type $ChangeType -AutoCommit:$false
                git add CHANGELOG.md
                Write-Success "CHANGELOG.md updated and staged"
                $changelogStaged = $true
            } catch {
                Write-Error "Failed to update CHANGELOG: $_"
                exit 1
            }
        } elseif ($Interactive) {
            Write-Status "Would you like to update CHANGELOG.md now? (y/N)" "🤔" "Yellow"
            $response = Read-Host
            if ($response -eq "y" -or $response -eq "Y") {
                Write-Host "Enter changelog entry (what changed?):" -ForegroundColor Cyan
                $entry = Read-Host
                if ($entry) {
                    try {
                        & ".\scripts\update-changelog.ps1" -Entry $entry -Type $ChangeType -AutoCommit:$false
                        git add CHANGELOG.md
                        Write-Success "CHANGELOG.md updated and staged"
                        $changelogStaged = $true
                    } catch {
                        Write-Error "Failed to update CHANGELOG: $_"
                        exit 1
                    }
                }
            }
        } else {
            Write-Error "Commit blocked - CHANGELOG.md update required"
            Write-Host "Rerun with -ChangelogEntry 'description' or -Interactive for guided update" -ForegroundColor Yellow
            exit 1
        }
    } elseif ($changelogStaged) {
        Write-Success "CHANGELOG.md is included in this commit"
    } elseif ($recentUpdate) {
        Write-Success "CHANGELOG.md was recently updated ($([math]::Round($timeSinceModified.TotalMinutes, 1)) minutes ago)"
    }
} elseif (!$requiresChangelog) {
    Write-Status "Changes don't require CHANGELOG update" "ℹ️" "Green"
}
# Get commit message
if (!$CommitMessage) {
    if ($Interactive) {
        Write-Status "Enter commit message:" "💬" "Yellow"
        $CommitMessage = Read-Host
        if (!$CommitMessage) {
            Write-Error "Commit message is required"
            exit 1
        }
    } else {
        Write-Error "Commit message is required. Use -CommitMessage parameter or -Interactive mode"
        exit 1
    }
}

# Pre-commit validation
Write-Header "Pre-commit Validation" "Yellow"

# Check for Apache 2.0 license headers in new/modified source files
Write-Status "Checking license headers..." "🔍"
$sourceFiles = $stagedFiles | Where-Object { $_ -match '\.(md|ps1|py|js|ts)$' -and $_ -ne "CHANGELOG.md" -and $_ -ne "README.md" }
$filesWithoutHeaders = @()

foreach ($file in $sourceFiles) {
    if (Test-Path $file) {
        $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
        if ($content -and $content.Length -gt 100 -and !($content -match "Apache License, Version 2\.0")) {
            $filesWithoutHeaders += $file
        }
    }
}

if ($filesWithoutHeaders.Count -gt 0 -and !$Force) {
    Write-Warning "Files missing Apache 2.0 license headers:"
    $filesWithoutHeaders | ForEach-Object { Write-Host "    • $_" -ForegroundColor Yellow }
    
    if ($Interactive) {
        Write-Status "Continue anyway? (y/N)" "🤔" "Yellow"
        $headerChoice = Read-Host
        if ($headerChoice -notmatch '^[Yy]') {
            Write-Error "Commit aborted. Please add license headers."
            exit 1
        }
    } else {
        Write-Warning "Use -Force to bypass license header check"
    }
} elseif ($filesWithoutHeaders.Count -eq 0) {
    Write-Success "All source files have proper license headers"
}

# Final commit summary
Write-Header "Commit Summary" "Cyan"
Write-Status "Files to commit: $($stagedFiles.Count)" "📦"
foreach ($file in $stagedFiles) {
    Write-Host "    • $file" -ForegroundColor Cyan
}
Write-Host ""
Write-Status "Commit message: $CommitMessage" "💬"
Write-Host ""

# Execute commit (unless dry run)
if ($DryRun) {
    Write-Warning "DRY RUN - Would execute: git commit -m '$CommitMessage'"
    Write-Status "All validation checks passed" "✅" "Green"
} else {
    Write-Status "Executing commit..." "🚀"
    try {
        git commit -m "$CommitMessage"
        if ($LASTEXITCODE -eq 0) {
            Write-Success "Commit successful!"
            
            # Get commit hash
            $commitHash = git rev-parse --short HEAD
            Write-Status "Commit hash: $commitHash" "🔗" "Green"
            
            # Ask about pushing to GitHub
            if ($Interactive) {
                Write-Status "Push to GitHub? (y/N)" "🌐" "Yellow"
                $pushChoice = Read-Host
                if ($pushChoice -match '^[Yy]') {
                    Write-Status "Pushing to origin..." "📤"
                    git push
                    if ($LASTEXITCODE -eq 0) {
                        Write-Success "Successfully pushed to GitHub!"
                    } else {
                        Write-Warning "Push failed. You may need to push manually."
                    }
                }
            } else {
                Write-Status "Remember to push changes: git push" "📤" "Cyan"
            }
        } else {
            Write-Error "Commit failed!"
            exit 1
        }
    } catch {
        Write-Error "Commit failed: $_"
        exit 1
    }
}

Write-Status "Safe commit process completed successfully!" "✨" "Green"
