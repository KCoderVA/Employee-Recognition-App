# Release Preparation Script

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
    [Parameter(Mandatory=$true)]
    [string]$Version,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ".\releases\$Version-assets",
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateZip = $true
)

Write-Host "📦 Release Preparation Script - Employee Recognition App" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Green
Write-Host "Version: $Version" -ForegroundColor Cyan
Write-Host "Output Path: $OutputPath" -ForegroundColor Cyan
Write-Host ""

# Create output directory
Write-Host "📁 Creating release directory..." -ForegroundColor Yellow
if (Test-Path $OutputPath) {
    Remove-Item $OutputPath -Recurse -Force
}
New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null

# Create subdirectories
$subDirs = @("power-apps", "power-automate", "sharepoint", "documentation", "scripts", "templates")
foreach ($dir in $subDirs) {
    New-Item -ItemType Directory -Path "$OutputPath\$dir" -Force | Out-Null
}

Write-Host "✅ Release directory structure created" -ForegroundColor Green

# Copy Power Apps assets
Write-Host "`n📱 Copying Power Apps assets..." -ForegroundColor Yellow
if (Test-Path "src\power-apps") {
    Get-ChildItem "src\power-apps" -Filter "*.msapp" | ForEach-Object {
        Copy-Item $_.FullName -Destination "$OutputPath\power-apps\" -Force
        Write-Host "  ✓ Copied $($_.Name)" -ForegroundColor Green
    }
    
    # Copy Power Apps documentation
    if (Test-Path "src\power-apps\README.md") {
        Copy-Item "src\power-apps\README.md" -Destination "$OutputPath\power-apps\" -Force
    }
}

# Copy Power Automate assets
Write-Host "`n🔄 Copying Power Automate assets..." -ForegroundColor Yellow
if (Test-Path "src\power-automate") {
    Get-ChildItem "src\power-automate" -Filter "*.zip" -Recurse | ForEach-Object {
        Copy-Item $_.FullName -Destination "$OutputPath\power-automate\" -Force
        Write-Host "  ✓ Copied $($_.Name)" -ForegroundColor Green
    }
    
    # Copy Flow documentation
    if (Test-Path "src\power-automate\README.md") {
        Copy-Item "src\power-automate\README.md" -Destination "$OutputPath\power-automate\" -Force
    }
}

# Copy SharePoint assets
Write-Host "`n📋 Copying SharePoint assets..." -ForegroundColor Yellow
if (Test-Path "src\sharepoint") {
    Copy-Item "src\sharepoint\*" -Destination "$OutputPath\sharepoint\" -Recurse -Force
    Write-Host "  ✓ Copied SharePoint configuration files" -ForegroundColor Green
}

# Copy key documentation
Write-Host "`n📚 Copying documentation..." -ForegroundColor Yellow
$keyDocs = @("README.md", "CHANGELOG.md", "LICENSE", "NOTICE", "SECURITY.md", "CONTRIBUTING.md")
foreach ($doc in $keyDocs) {
    if (Test-Path $doc) {
        Copy-Item $doc -Destination "$OutputPath\documentation\" -Force
        Write-Host "  ✓ Copied $doc" -ForegroundColor Green
    }
}

# Copy docs folder contents
if (Test-Path "docs") {
    Copy-Item "docs\*" -Destination "$OutputPath\documentation\guides\" -Recurse -Force
    Write-Host "  ✓ Copied detailed documentation guides" -ForegroundColor Green
}

# Copy deployment scripts
Write-Host "`n🔧 Copying deployment scripts..." -ForegroundColor Yellow
if (Test-Path "scripts") {
    Get-ChildItem "scripts" -Filter "*.ps1" | Where-Object { $_.Name -ne "repo-health-check.ps1" } | ForEach-Object {
        Copy-Item $_.FullName -Destination "$OutputPath\scripts\" -Force
        Write-Host "  ✓ Copied $($_.Name)" -ForegroundColor Green
    }
}

# Copy GitHub templates
Write-Host "`n🏷️ Copying GitHub templates..." -ForegroundColor Yellow
if (Test-Path ".github") {
    Copy-Item ".github\*" -Destination "$OutputPath\templates\github\" -Recurse -Force
    Write-Host "  ✓ Copied GitHub templates and workflows" -ForegroundColor Green
}

# Create release notes file
Write-Host "`n📝 Creating release notes..." -ForegroundColor Yellow
$releaseNotesPath = "$OutputPath\RELEASE_NOTES.md"

# Check if specific version release notes exist
$versionReleaseNotes = "releases\$Version\RELEASE_NOTES.md"
if (Test-Path $versionReleaseNotes) {
    Copy-Item $versionReleaseNotes -Destination $releaseNotesPath -Force
    Write-Host "  ✓ Used version-specific release notes" -ForegroundColor Green
} elseif (Test-Path "releases\v0.8.x\RELEASE_NOTES.md") {
    Copy-Item "releases\v0.8.x\RELEASE_NOTES.md" -Destination $releaseNotesPath -Force
    Write-Host "  ✓ Used latest release notes" -ForegroundColor Green
} else {
    # Create basic release notes
    $releaseNotes = @"
# Employee Recognition App - Release $Version

## 📋 Release Information
- **Version**: $Version
- **Release Date**: $(Get-Date -Format 'yyyy-MM-dd')
- **Release Type**: $(if ($Version -match 'alpha|beta|rc') { 'Pre-release' } else { 'Stable' })

## 📦 Package Contents
This release package contains:

### Power Platform Components
- Power Apps Canvas Application (.msapp)
- Power Automate Flows (.zip exports)
- SharePoint List configurations and schemas

### Documentation
- Complete setup and deployment guides
- User documentation and training materials
- Technical documentation for developers
- Security and compliance documentation

### Deployment Tools
- PowerShell automation scripts
- GitHub repository templates
- Configuration guides

## 🚀 Installation
1. Review the README.md in the documentation folder
2. Follow the setup guide in documentation/guides/
3. Use the deployment scripts in the scripts/ folder
4. Configure your Power Platform environment as documented

## 🔒 License
This software is licensed under the Apache License, Version 2.0.
See LICENSE file for complete terms.

## 📞 Support
For support and questions, please visit:
https://github.com/KCoderVA/Employee-Recognition-App

**Copyright 2025 Kyle J. Coder**
"@
    Set-Content -Path $releaseNotesPath -Value $releaseNotes -Encoding UTF8
    Write-Host "  ✓ Created basic release notes" -ForegroundColor Green
}

# Create installation guide
Write-Host "`n📋 Creating installation guide..." -ForegroundColor Yellow
$installGuide = @"
# Employee Recognition App - Installation Guide

## Prerequisites
- Power Platform environment with appropriate licenses
- SharePoint Online site
- Power Automate premium license (for approval flows)
- Administrative permissions for environment setup

## Quick Start
1. **Extract Release Package**
   - Extract all files to a local directory
   - Review the RELEASE_NOTES.md file

2. **Environment Setup**
   - Import Power Apps application from power-apps/ folder
   - Import Power Automate flows from power-automate/ folder
   - Configure SharePoint lists using templates in sharepoint/ folder

3. **Configuration**
   - Update connection references
   - Configure environment variables
   - Set up security groups and permissions

4. **Testing**
   - Run basic functionality tests
   - Verify data flow and integrations
   - Test approval workflows

## Detailed Documentation
For detailed setup instructions, see the documentation/guides/ folder.

## Support
Visit: https://github.com/KCoderVA/Employee-Recognition-App/issues
"@

Set-Content -Path "$OutputPath\INSTALLATION_GUIDE.md" -Value $installGuide -Encoding UTF8
Write-Host "  ✓ Created installation guide" -ForegroundColor Green

# Create version info file
Write-Host "`n ℹ️ Creating version information..." -ForegroundColor Yellow
$versionInfo = @{
    Version = $Version
    BuildDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Components = @{
        PowerApps = (Get-ChildItem "$OutputPath\power-apps" -Filter "*.msapp" | Measure-Object).Count
        PowerAutomate = (Get-ChildItem "$OutputPath\power-automate" -Filter "*.zip" | Measure-Object).Count
        Documentation = (Get-ChildItem "$OutputPath\documentation" -Recurse -Filter "*.md" | Measure-Object).Count
        Scripts = (Get-ChildItem "$OutputPath\scripts" -Filter "*.ps1" | Measure-Object).Count
    }
    License = "Apache-2.0"
    Author = "Kyle J. Coder"
    Repository = "https://github.com/KCoderVA/Employee-Recognition-App"
}

$versionInfo | ConvertTo-Json -Depth 3 | Set-Content -Path "$OutputPath\version-info.json" -Encoding UTF8
Write-Host "  ✓ Created version information file" -ForegroundColor Green

# Calculate package size
$packageSize = (Get-ChildItem $OutputPath -Recurse | Measure-Object -Property Length -Sum).Sum
$packageSizeMB = [math]::Round($packageSize / 1MB, 2)

Write-Host "`n📊 Release Package Summary" -ForegroundColor Cyan
Write-Host "=" * 40 -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor White
Write-Host "Package Size: $packageSizeMB MB" -ForegroundColor White
Write-Host "Total Files: $((Get-ChildItem $OutputPath -Recurse | Measure-Object).Count)" -ForegroundColor White
Write-Host "Power Apps: $($versionInfo.Components.PowerApps) files" -ForegroundColor White
Write-Host "Power Automate: $($versionInfo.Components.PowerAutomate) files" -ForegroundColor White
Write-Host "Documentation: $($versionInfo.Components.Documentation) files" -ForegroundColor White
Write-Host "Scripts: $($versionInfo.Components.Scripts) files" -ForegroundColor White

# Create ZIP archive if requested
if ($CreateZip) {
    Write-Host "`n📦 Creating release archive..." -ForegroundColor Yellow
    $zipPath = ".\releases\Employee-Recognition-App-$Version.zip"
    
    # Ensure releases directory exists
    if (!(Test-Path ".\releases")) {
        New-Item -ItemType Directory -Path ".\releases" -Force | Out-Null
    }
    
    # Remove existing zip if it exists
    if (Test-Path $zipPath) {
        Remove-Item $zipPath -Force
    }
    
    # Create the archive
    try {
        Compress-Archive -Path "$OutputPath\*" -DestinationPath $zipPath -CompressionLevel Optimal
        $zipSize = [math]::Round((Get-Item $zipPath).Length / 1MB, 2)
        Write-Host "  ✅ Created release archive: $zipPath ($zipSize MB)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Failed to create archive: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n🎉 Release preparation complete!" -ForegroundColor Green
Write-Host "Release assets location: $OutputPath" -ForegroundColor Cyan
if ($CreateZip) {
    Write-Host "Release archive: .\releases\Employee-Recognition-App-$Version.zip" -ForegroundColor Cyan
}

Write-Host "`n🚀 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Review the generated release assets" -ForegroundColor White
Write-Host "2. Test the release package in a clean environment" -ForegroundColor White
Write-Host "3. Create GitHub release with these assets" -ForegroundColor White
Write-Host "4. Update repository documentation as needed" -ForegroundColor White
Write-Host ""
