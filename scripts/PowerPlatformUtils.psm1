# Power Platform Development Utilities
# Collection of helper functions for Power Platform development

function Get-PowerPlatformStatus {
    Write-Host "Power Platform Development Status" -ForegroundColor Green
    Write-Host "=================================" -ForegroundColor Green

    # Check PAC CLI
    try {
        $pacVersion = pac --version
        Write-Host "✅ PAC CLI: $pacVersion" -ForegroundColor Green
    } catch {
        Write-Host "❌ PAC CLI: Not installed" -ForegroundColor Red
    }

    # Check authentication
    try {
        $authList = pac auth list 2>$null
        if ($authList -match "No profiles found") {
            Write-Host "❌ Authentication: No profiles" -ForegroundColor Red
        } else {
            Write-Host "✅ Authentication: Profiles found" -ForegroundColor Green
        }
    } catch {
        Write-Host "❌ Authentication: Error checking" -ForegroundColor Red
    }

    # Check source files
    $appPath = "./src/power-apps/EmployeeRecognitionApp_Unpacked"
    if (Test-Path $appPath) {
        Write-Host "✅ Power App Source: Found" -ForegroundColor Green
    } else {
        Write-Host "❌ Power App Source: Missing" -ForegroundColor Red
    }

    # Check git status
    try {
        $gitStatus = git status --porcelain 2>$null
        if ($gitStatus) {
            Write-Host "⚠️  Git: Uncommitted changes" -ForegroundColor Yellow
        } else {
            Write-Host "✅ Git: Clean working directory" -ForegroundColor Green
        }
    } catch {
        Write-Host "❌ Git: Not initialized" -ForegroundColor Red
    }
}

function New-PowerPlatformBackup {
    param(
        [string]$BackupName = "manual_$(Get-Date -Format 'yyyy-MM-dd_HHmm')"
    )

    Write-Host "Creating Power Platform backup: $BackupName" -ForegroundColor Yellow

    $backupPath = "./archive/$BackupName"
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null

    # Copy source files
    if (Test-Path "./src") {
        Copy-Item -Path "./src" -Destination "$backupPath/src" -Recurse
        Write-Host "✅ Source files backed up" -ForegroundColor Green
    }

    # Copy documentation
    if (Test-Path "./docs") {
        Copy-Item -Path "./docs" -Destination "$backupPath/docs" -Recurse
        Write-Host "✅ Documentation backed up" -ForegroundColor Green
    }

    # Copy assets
    if (Test-Path "./assets") {
        Copy-Item -Path "./assets" -Destination "$backupPath/assets" -Recurse
        Write-Host "✅ Assets backed up" -ForegroundColor Green
    }

    # Create backup manifest
    $manifest = @{
        BackupName = $BackupName
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Contents = @("src", "docs", "assets")
        CreatedBy = $env:USERNAME
    } | ConvertTo-Json

    Set-Content -Path "$backupPath/backup_manifest.json" -Value $manifest

    Write-Host "✅ Backup completed: $backupPath" -ForegroundColor Green
}

function Test-PowerPlatformSources {
    Write-Host "Testing Power Platform sources..." -ForegroundColor Yellow

    $issues = @()

    # Check for required source structure
    $requiredPaths = @(
        "./src/power-apps",
        "./src/power-automate",
        "./src/sharepoint"
    )

    foreach ($path in $requiredPaths) {
        if (!(Test-Path $path)) {
            $issues += "Missing directory: $path"
        }
    }

    # Check for unpacked app
    $appPath = "./src/power-apps/EmployeeRecognitionApp_Unpacked"
    if (!(Test-Path $appPath)) {
        $issues += "Power App not unpacked at: $appPath"
    }

    # Report results
    if ($issues.Count -eq 0) {
        Write-Host "✅ All source checks passed" -ForegroundColor Green
    } else {
        Write-Host "❌ Issues found:" -ForegroundColor Red
        foreach ($issue in $issues) {
            Write-Host "  - $issue" -ForegroundColor Red
        }
    }

    return $issues.Count -eq 0
}

# Export functions
Export-ModuleMember -Function Get-PowerPlatformStatus, New-PowerPlatformBackup, Test-PowerPlatformSources
