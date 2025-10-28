
# ============================================================================
#  Script: PowerApp_Recursive_Variable_Extraction.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    Recursively scans a user-specified folder for PowerApps/Power Fx variables,
#    collections, connections, data sources, and component variables. Outputs a
#    detailed, organized markdown report to the workspace root with a timestamped filename.
#
#  USAGE:
#    1. Run this script in PowerShell. You will be prompted for a root folder to scan.
#    2. The script will search all supported text files and generate a markdown report.
#    3. Review the output file in the workspace root for results and summary.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates recursive file search, Power Fx pattern extraction, and report generation.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================


# =====================
# PARAMETER DEFINITION
# =====================
param()


# =====================
# MAIN SCRIPT LOGIC
# =====================

function Prompt-ForRootFolder {
    $root = Read-Host 'Enter the root folder path to scan (e.g. C:\MyApp\src\power-apps\AppName)'
    if (-not (Test-Path $root)) {
        Write-Host "[ERROR] Path does not exist. Please try again." -ForegroundColor Red
        exit 1
    }
    return $root
}


function Get-Timestamp {
    return (Get-Date -Format 'yyyyMMddHHmmss')
}


function Get-TextFilesRecursive {
    param($Root)
    $patterns = '*.fx.yaml','*.yml','*.json','*.xml','*.sarif','*.txt','*.csv','*.md','*.log','*.ini','*.conf','*.config','*.yaml'
    $files = @()
    foreach ($pattern in $patterns) {
        $files += Get-ChildItem -Path $Root -Recurse -File -Filter $pattern -ErrorAction SilentlyContinue
    }
    return $files | Sort-Object -Unique
}

function Extract-VariablesFromLine {
    param($line, $commented)
    $results = @{}
    # Power Fx patterns
    $fxPatterns = @{
        'Set' = 'Set\s*\(\s*([a-zA-Z0-9_]+)';
        'UpdateContext' = 'UpdateContext\s*\(\s*\{\s*([a-zA-Z0-9_]+)';
        'ClearCollect' = 'ClearCollect\s*\(\s*([a-zA-Z0-9_]+)';
        'Collect' = 'Collect\s*\(\s*([a-zA-Z0-9_]+)';
        'Clear' = 'Clear\s*\(\s*([a-zA-Z0-9_]+)';
    }
    foreach ($type in $fxPatterns.Keys) {
        $matches = [regex]::Matches($line, $fxPatterns[$type])
        foreach ($m in $matches) {
            $results[$m.Groups[1].Value] = $type + $(if ($commented) { ' (commented)' } else { '' })
        }
    }
    return $results
}

function Extract-VariablesFromJson {
    param($content)
    $results = @()
    $json = $null
    try { $json = $content | ConvertFrom-Json -ErrorAction Stop } catch { return $results }
    function Recurse($obj) {
        if ($obj -is [System.Collections.IDictionary]) {
            foreach ($k in $obj.Keys) {
                $results += $k
                Recurse $obj[$k]
            }
        } elseif ($obj -is [System.Collections.IEnumerable] -and -not ($obj -is [string])) {
            foreach ($item in $obj) { Recurse $item }
        }
    }
    Recurse $json
    return $results | Sort-Object -Unique
}

function Extract-VariablesFromXml {
    param($content)
    $results = @()
    try {
        $xml = [xml]$content
        $results += $xml.DocumentElement.ChildNodes | ForEach-Object { $_.Name }
    } catch { }
    return $results | Sort-Object -Unique
}


# =====================
# MAIN EXECUTION
# =====================
$root = Prompt-ForRootFolder
$timestamp = Get-Timestamp
$workspaceRoot = (Get-Location).Path
$outputFile = Join-Path $workspaceRoot "TEMP_OUTPUT_Recursive_Variable_Search_${timestamp}.md"
$files = Get-TextFilesRecursive -Root $root

$fxVars = @{}
$fxVarsCommented = @{}
$jsonVars = @{}
$xmlVars = @{}
$otherVars = @{}

$totalLines = 0
$totalFiles = $files.Count

foreach ($file in $files) {
    $ext = $file.Extension.ToLower()
    $lines = Get-Content $file.FullName -Raw | Select-String '.*' | ForEach-Object { $_.Line }
    $totalLines += $lines.Count
    foreach ($line in $lines) {
        $trimmed = $line.Trim()
        $isComment = $trimmed -match '^(//|#|--|;|/\*|\*)'
        $fxFound = Extract-VariablesFromLine -line $trimmed -commented:$isComment
        foreach ($k in $fxFound.Keys) {
            if ($isComment) {
                $fxVarsCommented[$k] = $fxFound[$k]
            } else {
                $fxVars[$k] = $fxFound[$k]
            }
        }
    }
    if ($ext -eq '.json') {
        $jsonVars[$file.Name] = Extract-VariablesFromJson -content:(Get-Content $file.FullName -Raw)
    } elseif ($ext -eq '.xml') {
        $xmlVars[$file.Name] = Extract-VariablesFromXml -content:(Get-Content $file.FullName -Raw)
    } else {
        # For other text files, try to extract variable-like words (alphanumeric + underscores, >2 chars)
        $otherVars[$file.Name] = @()
        foreach ($line in $lines) {
            $matches = [regex]::Matches($line, '\b[a-zA-Z_][a-zA-Z0-9_]{2,}\b')
            foreach ($m in $matches) {
                $otherVars[$file.Name] += $m.Value
            }
        }
        $otherVars[$file.Name] = $otherVars[$file.Name] | Sort-Object -Unique
    }
}

# Remove duplicates between commented and functional
$commentedOnly = $fxVarsCommented.Keys | Where-Object { -not $fxVars.ContainsKey($_) }

# Output
$header = @()
$header += "# PowerApps Recursive Variable/Collection/Connection Extraction Report"
$header += ""
$header += "**Generated:** $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$header += "**Script:** PowerApp_Recursive_Variable_Extraction.ps1"
$header += "**Root Searched:** $root"
$header += "**Files Scanned:** $totalFiles"


# Exclude 'First (Set)' and 'Last (Set)' from Power Fx results (safe hashtable removal)
if ($fxVars -and $fxVars.ContainsKey('First')) { $null = $fxVars.Remove('First') }
if ($fxVars -and $fxVars.ContainsKey('Last')) { $null = $fxVars.Remove('Last') }
if ($fxVarsCommented -and $fxVarsCommented.ContainsKey('First')) { $null = $fxVarsCommented.Remove('First') }
if ($fxVarsCommented -and $fxVarsCommented.ContainsKey('Last')) { $null = $fxVarsCommented.Remove('Last') }
$commentedOnly = @()
if ($fxVarsCommented) { $commentedOnly = $fxVarsCommented.Keys | Where-Object { -not $fxVars.ContainsKey($_) } }

$fxVarsCount = ($fxVars.Keys | Measure-Object).Count
$commentedOnlyCount = ($commentedOnly | Measure-Object).Count

$header += "**Unique Functional Power Fx Variables & Collections:** $fxVarsCount"
$header += "**Unique Non-Functional (Unused/Commented) Power Fx Variables & Collections:** $commentedOnlyCount"
$header += ""
$header += "---"
$header += ""
$header += "## What was searched and why"
$header += "This report lists all unique variables, collections, connections, data sources, and component variables found recursively in all supported text files under the specified root. Both functional and commented-out items are included. Items only found in comments are listed in a separate section."
$header += ""
$header += "---"


# Power Fx Section
$fxSection = @()
$fxSection += "## Power Fx Variables & Collections (Functional)"
if ($fxVars.Count -eq 0) { $fxSection += "_None found_" }
foreach ($k in ($fxVars.Keys | Sort-Object)) {
    $fxSection += "- $k ($($fxVars[$k]))"
}

# Commented-Only Section (moved up)
$commentSection = @()
$commentSection += "## Variables/Collections Only Found in Comments"
if ($commentedOnly.Count -eq 0) { $commentSection += "_None found_" }
foreach ($k in ($commentedOnly | Sort-Object)) {
    $commentSection += "- $k ($($fxVarsCommented[$k]))"
}

# Add two blank lines and a sub-section header before by-file results
$byFileHeader = @()
$byFileHeader += ""
$byFileHeader += ""
$byFileHeader += "---"
$byFileHeader += "### Detailed By-File Results"
$byFileHeader += ""

# Reorganize by-file results: Power Fx screens first, then .json, then .xml, then other
# Power Fx screens: .fx.yaml, .yml
$fxFiles = $files | Where-Object { $_.Extension -match 'fx.yaml|yml' }
$fxByFile = @()
if ($fxFiles.Count -gt 0) {
    $fxByFile += "## Power Fx Screen Files"
    foreach ($file in $fxFiles | Sort-Object Name) {
        $fxByFile += "### $($file.Name)"
        $lines = Get-Content $file.FullName -Raw | Select-String '.*' | ForEach-Object { $_.Line }
        $vars = @()
        foreach ($line in $lines) {
            $fxFound = Extract-VariablesFromLine -line $line -commented:($line.Trim() -match '^(//|#|--|;|/\*|\*)')
            $vars += $fxFound.Keys
        }
        $vars = $vars | Sort-Object -Unique | Where-Object { $_ -ne 'First' -and $_ -ne 'Last' }
        foreach ($v in $vars) { $fxByFile += "- $v" }
    }
}

# JSON files
$jsonByFile = @()
if ($jsonVars.Count -gt 0) {
    $jsonByFile += "## JSON Property Names (by file)"
    foreach ($fname in ($jsonVars.Keys | Sort-Object)) {
        $items = $jsonVars[$fname] | Sort-Object -Unique
        if ($items.Count -gt 0) {
            $jsonByFile += "### $fname"
            foreach ($item in $items) { $jsonByFile += "- $item" }
        }
    }
}

# XML files
$xmlByFile = @()
if ($xmlVars.Count -gt 0) {
    $xmlByFile += "## XML Tag/Property Names (by file)"
    foreach ($fname in ($xmlVars.Keys | Sort-Object)) {
        $items = $xmlVars[$fname] | Sort-Object -Unique
        if ($items.Count -gt 0) {
            $xmlByFile += "### $fname"
            foreach ($item in $items) { $xmlByFile += "- $item" }
        }
    }
}

# Other text files
$otherByFile = @()
if ($otherVars.Count -gt 0) {
    $otherByFile += "## Other Text File Variable-Like Names (by file)"
    foreach ($fname in ($otherVars.Keys | Sort-Object)) {
        $items = $otherVars[$fname] | Sort-Object -Unique
        if ($items.Count -gt 0) {
            $otherByFile += "### $fname"
            foreach ($item in $items) { $otherByFile += "- $item" }
        }
    }
}

# Write to file
@($header + $fxSection + $commentSection + $byFileHeader + $fxByFile + $jsonByFile + $xmlByFile + $otherByFile) | Set-Content -Path $outputFile -Encoding UTF8


Write-Host "Extraction complete. Output saved to $outputFile" -ForegroundColor Green

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see Power Fx and YAML schema documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
