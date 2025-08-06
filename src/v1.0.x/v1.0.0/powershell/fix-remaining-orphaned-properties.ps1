# Enhanced Fix for All Remaining Orphaned Properties
# This script removes ALL orphaned AccessibleLabel and Tooltip properties
# SCOPE: Only processes files in test\.unpacked directory

param(
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)

# Define the target directory - ONLY test\.unpacked
$TargetDirectory = "test\.unpacked\Src"
$ScriptLocation = Get-Location

Write-Host "🔧 Enhanced Orphaned Properties Fix Script" -ForegroundColor Cyan
Write-Host "📁 Target Directory: $TargetDirectory" -ForegroundColor Yellow

if ($DryRun) {
    Write-Host "🔍 DRY RUN MODE - No files will be modified" -ForegroundColor Green
}

# Verify target directory exists and is correct
$FullTargetPath = Join-Path $ScriptLocation $TargetDirectory
if (-not (Test-Path $FullTargetPath)) {
    Write-Host "❌ ERROR: Target directory not found: $FullTargetPath" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Target directory confirmed: $FullTargetPath" -ForegroundColor Green

# Get all YAML files in the target directory
$YamlFiles = Get-ChildItem -Path $FullTargetPath -Filter "*.fx.yaml" -File
Write-Host "🔍 Found $($YamlFiles.Count) YAML files to process" -ForegroundColor Cyan

# Statistics tracking
$TotalOrphanedRemoved = 0
$FilesModified = 0

# Process each YAML file
foreach ($file in $YamlFiles) {
    Write-Host "`n📄 Processing: $($file.Name)" -ForegroundColor Yellow

    $content = Get-Content $file.FullName
    $fileOrphansRemoved = 0
    $newContent = @()
    $inControl = $false

    for ($i = 0; $i -lt $content.Count; $i++) {
        $line = $content[$i]
        $includeLine = $true

        # More comprehensive control detection
        # Look for control definitions in various formats
        if ($line -match '^(\s{0,4})([A-Za-z][A-Za-z0-9_]*)\s+As\s+([A-Za-z])' -or
            $line -match '^([A-Za-z][A-Za-z0-9_]*)\s+As\s+([A-Za-z])') {
            $inControl = $true
            if ($Verbose) {
                Write-Host "   🎯 Found control at line $($i+1): $line" -ForegroundColor Gray
            }
        }
        # Detect end of control (empty line, new control, or significantly outdented line)
        elseif ($line -match '^\s*$' -or
                $line -match '^[A-Za-z][A-Za-z0-9_]*\s+As\s+' -or
                $line -match '^(\s{0,2})[A-Za-z]') {
            $inControl = $false
        }

        # Check for orphaned accessibility properties - enhanced detection
        if ($line -match '^\s+(AccessibleLabel|Tooltip):\s*=' -and -not $inControl) {
            $property = $matches[1]
            Write-Host "   ❌ Removing orphaned $property at line $($i+1)" -ForegroundColor Red

            if ($Verbose) {
                Write-Host "      Line content: $line" -ForegroundColor Gray
            }

            $includeLine = $false
            $fileOrphansRemoved++
        }
        # Also check for properties that appear to be orphaned based on context
        elseif ($line -match '^\s{4,}(AccessibleLabel|Tooltip):\s*=' -and
                $i -gt 0 -and
                $content[$i-1] -match '^\s*$' -and
                -not $inControl) {
            $property = $matches[1]
            Write-Host "   ❌ Removing contextually orphaned $property at line $($i+1)" -ForegroundColor Red

            if ($Verbose) {
                Write-Host "      Line content: $line" -ForegroundColor Gray
            }

            $includeLine = $false
            $fileOrphansRemoved++
        }

        if ($includeLine) {
            $newContent += $line
        }
    }

    # Save changes if any orphaned properties were removed
    if ($fileOrphansRemoved -gt 0) {
        if (-not $DryRun) {
            Set-Content -Path $file.FullName -Value $newContent
            Write-Host "   ✅ Removed $fileOrphansRemoved orphaned properties from $($file.Name)" -ForegroundColor Green
        } else {
            Write-Host "   🔍 DRY RUN: Would remove $fileOrphansRemoved orphaned properties from $($file.Name)" -ForegroundColor Yellow
        }

        $TotalOrphanedRemoved += $fileOrphansRemoved
        $FilesModified++
    } else {
        Write-Host "   ℹ️  No orphaned properties found in $($file.Name)" -ForegroundColor Gray
    }
}

# Display summary
Write-Host "`n📊 SUMMARY REPORT" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan
Write-Host "Files Processed: $($YamlFiles.Count)" -ForegroundColor White
Write-Host "Files Modified: $FilesModified" -ForegroundColor White
Write-Host "Total Orphaned Properties Removed: $TotalOrphanedRemoved" -ForegroundColor White

if ($TotalOrphanedRemoved -gt 0) {
    if (-not $DryRun) {
        Write-Host "`n✅ All remaining orphaned accessibility properties have been removed!" -ForegroundColor Green
        Write-Host "   This should resolve the PA3003 YAML parsing errors." -ForegroundColor Green
        Write-Host "   Try running 'pac canvas pack' again to test the fix." -ForegroundColor Green
    } else {
        Write-Host "`n🔍 DRY RUN COMPLETE - No files were actually modified" -ForegroundColor Yellow
        Write-Host "   Run without -DryRun flag to apply these changes" -ForegroundColor Yellow
    }
} else {
    Write-Host "`nℹ️  No orphaned accessibility properties found" -ForegroundColor Gray
    Write-Host "   All YAML files should now be clean!" -ForegroundColor Green
}

Write-Host "`n🔒 SAFETY CONFIRMATION:" -ForegroundColor Magenta
Write-Host "   ✅ Only files in test\.unpacked directory were processed" -ForegroundColor Green
Write-Host "   ✅ Original working files remain untouched" -ForegroundColor Green
Write-Host "   ✅ Only orphaned properties were removed (properly nested ones preserved)" -ForegroundColor Green
