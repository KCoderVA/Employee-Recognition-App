# PowerShell script to fix empty YAML properties causing PA3003 parse errors
# This script removes empty property assignments that cause PowerApps packaging to fail

Write-Host "🔧 Fixing empty YAML properties in PowerApps source files..." -ForegroundColor Green
Write-Host ""

$sourceDir = "test\.unpacked\Src"
$yamlFiles = Get-ChildItem "$sourceDir\*.fx.yaml"

$totalFixed = 0

foreach ($file in $yamlFiles) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Cyan

    $content = Get-Content $file.FullName
    $originalLineCount = $content.Count
    $fixedLines = 0

    # Create new content array without empty properties
    $newContent = @()

    foreach ($line in $content) {
        # Skip lines with empty property assignments
        if ($line -match '^\s+[A-Za-z_][^:]*:\s*=$' -or
            $line -match '^\s+[A-Za-z_][^:]*:\s*=""$') {
            $fixedLines++
            Write-Host "  Removed: $line" -ForegroundColor Yellow
        }
        else {
            $newContent += $line
        }
    }

    if ($fixedLines -gt 0) {
        # Write the cleaned content back to the file
        Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
        Write-Host "  ✅ Fixed $fixedLines empty properties in $($file.Name)" -ForegroundColor Green
        $totalFixed += $fixedLines
    }
    else {
        Write-Host "  ✅ No issues found in $($file.Name)" -ForegroundColor Green
    }

    Write-Host ""
}

Write-Host "🎉 Completed! Fixed $totalFixed empty properties across $($yamlFiles.Count) files." -ForegroundColor Green
Write-Host ""
Write-Host "You can now try packing the app again with:" -ForegroundColor Yellow
Write-Host "pac canvas pack --sources ""test\.unpacked"" --msapp ""test\EmployeeRecognitionApp_Fixed.msapp""" -ForegroundColor Cyan
