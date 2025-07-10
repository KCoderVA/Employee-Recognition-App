# Repository Health Check Script

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

param(
    [switch]$Detailed = $false,
    [switch]$ExportReport = $false
)

Write-Host "🏥 Repository Health Check - Employee Recognition App" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Green
Write-Host ""

$healthReport = @()
$totalChecks = 0
$passedChecks = 0

# Function to perform a health check
function Test-RepositoryHealth {
    param(
        [string]$CheckName,
        [scriptblock]$TestScript,
        [string]$Recommendation = "",
        [string]$Category = "General"
    )

    $script:totalChecks++

    try {
        $result = & $TestScript
        if ($result) {
            Write-Host "✅ $CheckName" -ForegroundColor Green
            $script:passedChecks++
            $status = "PASS"
        } else {
            Write-Host "❌ $CheckName" -ForegroundColor Red
            if ($Recommendation) {
                Write-Host "   💡 $Recommendation" -ForegroundColor Yellow
            }
            $status = "FAIL"
        }
    } catch {
        Write-Host "⚠️  $CheckName - Error: $($_.Exception.Message)" -ForegroundColor Yellow
        $status = "ERROR"
    }

    $script:healthReport += [PSCustomObject]@{
        Category = $Category
        Check = $CheckName
        Status = $status
        Recommendation = $Recommendation
    }
}

Write-Host "📁 File Structure Checks" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

Test-RepositoryHealth -CheckName "README.md exists and is comprehensive" -Category "Documentation" `
    -TestScript { (Test-Path "README.md") -and ((Get-Content "README.md" -Raw).Length -gt 5000) } `
    -Recommendation "Ensure README.md is present and contains comprehensive project information"

Test-RepositoryHealth -CheckName "LICENSE file present" -Category "Legal" `
    -TestScript { Test-Path "LICENSE" } `
    -Recommendation "Add LICENSE file for legal compliance"

Test-RepositoryHealth -CheckName "NOTICE file present (Apache 2.0 requirement)" -Category "Legal" `
    -TestScript { Test-Path "NOTICE" } `
    -Recommendation "Create NOTICE file as required by Apache 2.0 License"

Test-RepositoryHealth -CheckName "CHANGELOG.md exists and is detailed" -Category "Documentation" `
    -TestScript { (Test-Path "CHANGELOG.md") -and ((Get-Content "CHANGELOG.md" -Raw).Length -gt 3000) } `
    -Recommendation "Maintain detailed CHANGELOG.md for version history"

Test-RepositoryHealth -CheckName "CONTRIBUTING.md exists" -Category "Community" `
    -TestScript { Test-Path "CONTRIBUTING.md" } `
    -Recommendation "Create CONTRIBUTING.md to guide community contributions"

Test-RepositoryHealth -CheckName "SECURITY.md exists" -Category "Security" `
    -TestScript { Test-Path "SECURITY.md" } `
    -Recommendation "Add SECURITY.md for security policy and vulnerability reporting"

Write-Host "`n🏗️ Project Structure Checks" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

Test-RepositoryHealth -CheckName "src/ directory structure organized" -Category "Organization" `
    -TestScript { (Test-Path "src") -and (Test-Path "src\power-apps") -and (Test-Path "src\power-automate") } `
    -Recommendation "Organize source code in logical folder structure"

Test-RepositoryHealth -CheckName "docs/ directory exists with documentation" -Category "Documentation" `
    -TestScript { (Test-Path "docs") -and ((Get-ChildItem "docs" -Recurse).Count -gt 5) } `
    -Recommendation "Maintain comprehensive documentation in docs/ folder"

Test-RepositoryHealth -CheckName "testing/ directory exists" -Category "Quality" `
    -TestScript { Test-Path "testing" } `
    -Recommendation "Include testing documentation and strategies"

Test-RepositoryHealth -CheckName "scripts/ directory with automation" -Category "Automation" `
    -TestScript { (Test-Path "scripts") -and ((Get-ChildItem "scripts\*.ps1").Count -gt 2) } `
    -Recommendation "Provide automation scripts for common tasks"

Write-Host "`n🔧 GitHub Integration Checks" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

Test-RepositoryHealth -CheckName ".github/ directory configured" -Category "GitHub" `
    -TestScript { Test-Path ".github" } `
    -Recommendation "Configure .github directory for GitHub features"

Test-RepositoryHealth -CheckName "Issue templates present" -Category "GitHub" `
    -TestScript { (Test-Path ".github\ISSUE_TEMPLATE") -and ((Get-ChildItem ".github\ISSUE_TEMPLATE\*.md").Count -gt 2) } `
    -Recommendation "Create issue templates for bug reports, feature requests, etc."

Test-RepositoryHealth -CheckName "Pull request template exists" -Category "GitHub" `
    -TestScript { Test-Path ".github\pull_request_template.md" } `
    -Recommendation "Add pull request template for consistent PR submissions"

Test-RepositoryHealth -CheckName ".gitignore configured for Power Platform" -Category "Git" `
    -TestScript { (Test-Path ".gitignore") -and ((Get-Content ".gitignore" -Raw) -match "msapp|Connections") } `
    -Recommendation "Configure .gitignore for Power Platform specific files"

Write-Host "`n🛡️ Security & Compliance Checks" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

Test-RepositoryHealth -CheckName "Apache 2.0 license headers in source files" -Category "Legal" `
    -TestScript {
        $mdFiles = Get-ChildItem -Recurse -Filter "*.md" | Where-Object { $_.Name -notlike "*archive*" }
        $filesWithHeaders = ($mdFiles | Where-Object {
            $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
            $content -and $content.Contains("Apache License, Version 2.0")
        }).Count
        $filesWithHeaders -gt ($mdFiles.Count * 0.8) # At least 80% should have headers
    } `
    -Recommendation "Add Apache 2.0 license headers to all source files"

Test-RepositoryHealth -CheckName "No sensitive data in repository" -Category "Security" `
    -TestScript {
        $sensitivePatterns = @("password", "apikey", "secret", "token", "connectionstring")
        $found = $false
        Get-ChildItem -Recurse -Include "*.md", "*.json", "*.txt" | ForEach-Object {
            $content = Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue
            if ($content) {
                foreach ($pattern in $sensitivePatterns) {
                    if ($content -match $pattern -and $content -notmatch "# Example" -and $content -notmatch "placeholder") {
                        $found = $true
                        break
                    }
                }
            }
        }
        -not $found
    } `
    -Recommendation "Remove any hardcoded secrets, passwords, or sensitive information"

Write-Host "`n📊 Quality Metrics" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

Test-RepositoryHealth -CheckName "Documentation coverage is comprehensive" -Category "Quality" `
    -TestScript {
        $docFiles = Get-ChildItem -Recurse -Filter "*.md"
        $totalSize = ($docFiles | ForEach-Object { (Get-Content $_.FullName -Raw -ErrorAction SilentlyContinue).Length } | Measure-Object -Sum).Sum
        $totalSize -gt 50000 # At least 50KB of documentation
    } `
    -Recommendation "Expand documentation to cover all aspects of the project"

Test-RepositoryHealth -CheckName "Project has version management" -Category "Quality" `
    -TestScript { (Test-Path "releases") -and (Test-Path "CHANGELOG.md") } `
    -Recommendation "Implement proper version management with releases and changelog"

# Git repository checks
Write-Host "`n📝 Git Repository Status" -ForegroundColor Cyan
Write-Host "-" * 30 -ForegroundColor Cyan

if (Get-Command git -ErrorAction SilentlyContinue) {
    Test-RepositoryHealth -CheckName "Git repository is clean" -Category "Git" `
        -TestScript { (git status --porcelain).Count -eq 0 } `
        -Recommendation "Commit any pending changes"

    Test-RepositoryHealth -CheckName "Remote repository configured" -Category "Git" `
        -TestScript { (git remote -v | Select-String "origin").Count -gt 0 } `
        -Recommendation "Configure remote repository (GitHub)"

    Test-RepositoryHealth -CheckName "Recent commits exist" -Category "Git" `
        -TestScript { (git log --oneline -10).Count -gt 5 } `
        -Recommendation "Maintain regular commit history"
}

# Summary
Write-Host "`n📊 HEALTH CHECK SUMMARY" -ForegroundColor Green
Write-Host "=" * 40 -ForegroundColor Green
Write-Host "Total Checks: $totalChecks" -ForegroundColor White
Write-Host "Passed: $passedChecks" -ForegroundColor Green
Write-Host "Failed: $($totalChecks - $passedChecks)" -ForegroundColor Red

$healthPercentage = [math]::Round(($passedChecks / $totalChecks) * 100, 1)
Write-Host "Health Score: $healthPercentage%" -ForegroundColor $(if ($healthPercentage -gt 80) { "Green" } elseif ($healthPercentage -gt 60) { "Yellow" } else { "Red" })

if ($healthPercentage -gt 90) {
    Write-Host "`n🎉 Excellent! Your repository is in great shape!" -ForegroundColor Green
} elseif ($healthPercentage -gt 75) {
    Write-Host "`n👍 Good repository health. Address remaining issues for optimal setup." -ForegroundColor Yellow
} else {
    Write-Host "`n⚠️  Repository needs attention. Focus on failed checks to improve health." -ForegroundColor Red
}

# Detailed report
if ($Detailed) {
    Write-Host "`n📋 DETAILED REPORT" -ForegroundColor Cyan
    Write-Host "=" * 40 -ForegroundColor Cyan

    $healthReport | Group-Object Category | ForEach-Object {
        Write-Host "`n$($_.Name):" -ForegroundColor Yellow
        $_.Group | ForEach-Object {
            $color = switch ($_.Status) {
                "PASS" { "Green" }
                "FAIL" { "Red" }
                "ERROR" { "Yellow" }
            }
            Write-Host "  [$($_.Status)] $($_.Check)" -ForegroundColor $color
            if ($_.Status -ne "PASS" -and $_.Recommendation) {
                Write-Host "    → $($_.Recommendation)" -ForegroundColor Gray
            }
        }
    }
}

# Export report
if ($ExportReport) {
    $reportPath = "repository-health-report-$(Get-Date -Format 'yyyy-MM-dd-HHmm').csv"
    $healthReport | Export-Csv -Path $reportPath -NoTypeInformation
    Write-Host "`n📄 Report exported to: $reportPath" -ForegroundColor Green
}

Write-Host "`n🚀 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Address any failed checks above" -ForegroundColor White
Write-Host "2. Run this script regularly to maintain repository health" -ForegroundColor White
Write-Host "3. Use -Detailed flag for comprehensive analysis" -ForegroundColor White
Write-Host "4. Use -ExportReport flag to save results" -ForegroundColor White
Write-Host ""
