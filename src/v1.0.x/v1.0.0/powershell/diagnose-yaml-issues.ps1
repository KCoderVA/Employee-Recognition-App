# Diagnose remaining YAML issues after accessibility fix
# Focus on finding PA3003 indentation problems

param([switch]$Detailed = $false)

Write-Host "🔍 Diagnosing YAML issues in test\.unpacked..." -ForegroundColor Cyan

$files = Get-ChildItem 'test\.unpacked\Src' -Filter '*.fx.yaml'
$totalIssues = 0

foreach ($file in $files) {
    Write-Host "`n📄 Checking: $($file.Name)" -ForegroundColor Yellow
    $content = Get-Content $file.FullName
    $fileIssues = 0

    # Check for tab characters (should be spaces)
    $tabLines = $content | Where-Object { $_ -match '^[\t]+' }
    if ($tabLines.Count -gt 0) {
        Write-Host "  ❌ Found $($tabLines.Count) lines with tab indentation" -ForegroundColor Red
        $fileIssues++
    }

    # Check for mixed indentation within property blocks
    for ($i = 0; $i -lt $content.Count - 1; $i++) {
        $line = $content[$i]
        $nextLine = $content[$i + 1]

        # Look for property pairs that should have same indentation
        if ($line -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):' -and
            $nextLine -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):') {

            $indent1 = $matches[1].Length
            $prop1 = $matches[2]

            if ($nextLine -match '^(\s+)(AccessibleLabel|Tooltip|Text|Default|Items|X|Y|Width|Height):') {
                $indent2 = $matches[1].Length
                $prop2 = $matches[2]

                if ($indent1 -ne $indent2) {
                    Write-Host "  ❌ Line $($i+2): $prop2 (indent: $indent2) should match $prop1 (indent: $indent1)" -ForegroundColor Red
                    $fileIssues++

                    if ($Detailed) {
                        Write-Host "    Line $($i+1): $line" -ForegroundColor Gray
                        Write-Host "    Line $($i+2): $nextLine" -ForegroundColor Gray
                    }
                }
            }
        }
    }

    # Check for orphaned properties (properties not under a control)
    $inControl = $false
    for ($i = 0; $i -lt $content.Count; $i++) {
        $line = $content[$i]

        # Control definitions start with no indentation or minimal indentation
        if ($line -match '^[A-Za-z][A-Za-z0-9_]* As [A-Za-z]') {
            $inControl = $true
        } elseif ($line -match '^$') {
            $inControl = $false
        } elseif ($line -match '^(\s+)(AccessibleLabel|Tooltip):' -and -not $inControl) {
            Write-Host "  ❌ Line $($i+1): Orphaned property $($matches[2]) (not under a control)" -ForegroundColor Red
            $fileIssues++
        }
    }

    if ($fileIssues -eq 0) {
        Write-Host "  ✅ No indentation issues found" -ForegroundColor Green
    }

    $totalIssues += $fileIssues
}

Write-Host "`n📊 Summary: $totalIssues total issues found across $($files.Count) files" -ForegroundColor $(if ($totalIssues -gt 0) { 'Red' } else { 'Green' })

if ($totalIssues -gt 0) {
    Write-Host "`n💡 Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Fix indentation inconsistencies manually" -ForegroundColor White
    Write-Host "  2. Ensure all properties use spaces (not tabs)" -ForegroundColor White
    Write-Host "  3. Verify properties are properly nested under controls" -ForegroundColor White
    Write-Host "  4. Test with 'pac canvas pack' again" -ForegroundColor White
} else {
    Write-Host "`n✅ All basic YAML structure looks correct" -ForegroundColor Green
    Write-Host "  The PA3003 error may be in a specific file location" -ForegroundColor Yellow
}
