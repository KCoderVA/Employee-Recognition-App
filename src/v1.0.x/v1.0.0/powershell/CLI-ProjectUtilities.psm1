
# ============================================================================
#  MODULE: CLI-ProjectUtilities.psm1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This PowerShell module provides a suite of utility functions for Power Platform
#    development, workspace management, and compliance automation. It is designed
#    for use in enterprise environments (including VA Healthcare) and can be
#    adapted for any Power Platform ALM workflow.
#
#  USAGE:
#    1. Import this module in your PowerShell session or scripts:
#         Import-Module ./CLI-ProjectUtilities.psm1
#    2. Use the provided functions to:
#         - Check Power Platform CLI, authentication, and source status
#         - Create timestamped workspace backups
#         - Validate required Power Platform source structure
#    3. All functions are extensible and can be customized for your organization's
#       standards and folder structure.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell module structure, error handling, and ALM automation.
#    - Section and sub-section comments are provided throughout for clarity.
#    - Designed for maintainability and ease of extension.
# ============================================================================


# =====================
# POWER PLATFORM DEVELOPMENT UTILITIES
# =====================
# Collection of helper functions for Power Platform development


# =====================
# FUNCTION: Get-PowerPlatformStatus
# =====================
# Checks the status of Power Platform CLI, authentication, source files, and git.
# Provides a quick overview for developers and admins.
function Get-PowerPlatformStatus {
    Write-Host "Power Platform Development Status" -ForegroundColor Green
    Write-Host "=================================" -ForegroundColor Green

    # SUBSECTION: Check PAC CLI
    try {
        $pacOutput = & pac --version 2>$null | Out-String
        if ($pacOutput) {
            # Extract just the version line (first line usually contains the version)
            $versionLine = ($pacOutput -split "`n" | Where-Object { $_ -match "Microsoft PowerPlatform CLI Version" })[0]
            if ($versionLine) {
                # Extract just the version number portion
                if ($versionLine -match "Version:\s*([\d\.\+\w]+)") {
                    $cleanVersion = $matches[1]
                    Write-Host "✅ PAC CLI: Version $cleanVersion" -ForegroundColor Green
                }
                else {
                    Write-Host "✅ PAC CLI: Installed and available" -ForegroundColor Green
                }
            }
            else {
                Write-Host "✅ PAC CLI: Installed (version info unavailable)" -ForegroundColor Green
            }
        }
        else {
            Write-Host "❌ PAC CLI: Not responding" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "❌ PAC CLI: Not installed or not in PATH" -ForegroundColor Red
    }

    # SUBSECTION: Check authentication
    try {
        $authOutput = & pac auth list 2>$null | Out-String
        if ($authOutput -match "No profiles found" -or [string]::IsNullOrWhiteSpace($authOutput)) {
            Write-Host "❌ Authentication: No profiles" -ForegroundColor Red
        }
        else {
            Write-Host "✅ Authentication: Profiles found" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "❌ Authentication: Error checking" -ForegroundColor Red
    }

    # SUBSECTION: Check source files
    $appPath = "./src/v1.0.x/v1.0.0"
    if (Test-Path $appPath) {
        Write-Host "✅ Power App Source: Found" -ForegroundColor Green
    }
    else {
        Write-Host "❌ Power App Source: Missing" -ForegroundColor Red
    }

    # SUBSECTION: Check git status
    try {
        $gitStatus = & git status --porcelain 2>$null
        if ($gitStatus) {
            $changeCount = ($gitStatus | Measure-Object).Count
            Write-Host "⚠️  Git: $changeCount uncommitted changes" -ForegroundColor Yellow
        }
        else {
            Write-Host "✅ Git: Clean working directory" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "❌ Git: Not initialized or not in PATH" -ForegroundColor Red
    }
}


# =====================
# FUNCTION: New-PowerPlatformBackup
# =====================
# Creates a timestamped backup of the src, docs, and assets folders.
# Useful for archiving workspace state before major changes or releases.
function New-PowerPlatformBackup {
    param(
        [string]$BackupName = "manual_$(Get-Date -Format 'yyyy-MM-dd_HHmm')"
    )

    Write-Host "Creating Power Platform backup: $BackupName" -ForegroundColor Yellow

    $backupPath = "./archive/$BackupName"
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    # SUBSECTION: Copy source files
    if (Test-Path "./src") {
        Copy-Item -Path "./src" -Destination "$backupPath/src" -Recurse
        Write-Host "✅ Source files backed up" -ForegroundColor Green
    }

    # SUBSECTION: Copy documentation
    if (Test-Path "./docs") {
        Copy-Item -Path "./docs" -Destination "$backupPath/docs" -Recurse
        Write-Host "✅ Documentation backed up" -ForegroundColor Green
    }

    # SUBSECTION: Copy assets
    if (Test-Path "./assets") {
        Copy-Item -Path "./assets" -Destination "$backupPath/assets" -Recurse
        Write-Host "✅ Assets backed up" -ForegroundColor Green
    }

    # SUBSECTION: Create backup manifest
    $manifest = @{
        BackupName = $BackupName
        Timestamp  = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Contents   = @("src", "docs", "assets")
        CreatedBy  = $env:USERNAME
    } | ConvertTo-Json

    Set-Content -Path "$backupPath/backup_manifest.json" -Value $manifest

    Write-Host "✅ Backup completed: $backupPath" -ForegroundColor Green
}


# =====================
# FUNCTION: Test-PowerPlatformSources
# =====================
# Validates that all required Power Platform source folders exist and that the
# app is unpacked. Returns $true if all checks pass, $false otherwise.
function Test-PowerPlatformSources {
    Write-Host "Testing Power Platform sources..." -ForegroundColor Yellow

    $issues = @()

    # SUBSECTION: Check for required source structure
    $requiredPaths = @(
        "./src/v1.0.x/v1.0.0/power-apps",
        "./src/v1.0.x/v1.0.0/power-automate",
        "./src/v1.0.x/v1.0.0/sharepoint",
        "./src/v1.0.x/v1.0.0/powershell"
    )

    foreach ($path in $requiredPaths) {
        if (!(Test-Path $path)) {
            $issues += "Missing directory: $path"
        }
    }

    # SUBSECTION: Check for unpacked app
    $appPath = "./src/v1.0.x/v1.0.0/power-apps/.unpacked"
    if (!(Test-Path $appPath)) {
        $issues += "Power App not unpacked at: $appPath"
    }

    # SUBSECTION: Report results
    if ($issues.Count -eq 0) {
        Write-Host "✅ All source checks passed" -ForegroundColor Green
    }
    else {
        Write-Host "❌ Issues found:" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "  - $issue" -ForegroundColor Red
        }
    }

    return $issues.Count -eq 0
}


# =====================
# MODULE EXPORTS
# =====================
# Export the main utility functions for use in other scripts or sessions.
Export-ModuleMember -Function Get-PowerPlatformStatus, New-PowerPlatformBackup, Test-PowerPlatformSources

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This module is part of the Employee Recognition App Power Platform ALM toolkit.
#    - Functions are designed for extensibility; add new utilities as needed for your workflow.
#    - For advanced customization, see PowerShell module and ALM automation documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
