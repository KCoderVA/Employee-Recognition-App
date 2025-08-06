
# ============================================================================
#  Script: Test-VASecurityCompliance.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    Checks if system operations comply with VA Healthcare enterprise security restrictions.
#    Validates that requested operations do not require administrator privileges and suggests user-scope alternatives when available.
#
#  USAGE:
#    1. Run this script in PowerShell with the required parameters.
#    2. Use -Operation to specify the type (winget, powershell, system, extension).
#    3. Use -Command to specify the command to validate.
#    4. Review the output for compliance status and recommendations.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell compliance checking, JSON config loading, and enterprise security best practices.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================

<#
.SYNOPSIS
    Checks if system operations comply with VA Healthcare enterprise security restrictions.

.DESCRIPTION
    This script validates that requested operations do not require administrator privileges
    and suggests user-scope alternatives when available.

.PARAMETER Operation
    The operation type to check (winget, powershell, system)

.PARAMETER Command
    The specific command to validate

.EXAMPLE
    Test-VASecurityCompliance -Operation "winget" -Command "winget install Microsoft.Office"
    Returns: Blocked due to administrator privilege requirement

.EXAMPLE
    Test-VASecurityCompliance -Operation "powershell" -Command "Install-Module Az -Scope CurrentUser"
    Returns: Approved - user-scope operation
#>


# =====================
# PARAMETER DEFINITION
# =====================
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("winget", "powershell", "system", "extension")]
    [string]$Operation,

    [Parameter(Mandatory = $true)]
    [string]$Command
)


# =====================
# MAIN SCRIPT LOGIC
# =====================
# SECTION: Load restricted operations configuration
$RestrictionsPath = "$PSScriptRoot\..\.vscode\restricted-operations.json"
if (Test-Path $RestrictionsPath) {
    $Restrictions = Get-Content $RestrictionsPath | ConvertFrom-Json
}
else {
    Write-Warning "Restrictions file not found: $RestrictionsPath"
    return $false
}


# SECTION: Compliance check function
function Test-VASecurityCompliance {
    param($Operation, $Command)

    $Result = @{
        Allowed     = $false
        Reason      = ""
        Alternative = ""
    }

    switch ($Operation.ToLower()) {
        "winget" {
            # Check for blocked packages
            foreach ($blockedPackage in $Restrictions.restrictions.winget.blockedPackages) {
                if ($Command -match [regex]::Escape($blockedPackage)) {
                    $Result.Reason = $Restrictions.restrictions.errorMessages.administratorRequired
                    $Result.Alternative = "Use user-scope PowerShell modules: Install-Module -Scope CurrentUser"
                    return $Result
                }
            }

            # Check for blocked commands
            foreach ($blockedCmd in $Restrictions.restrictions.winget.blockedCommands) {
                if ($Command -match [regex]::Escape($blockedCmd)) {
                    $Result.Reason = "Command requires administrator privileges"
                    $Result.Alternative = "Use selective updates for user-scope applications only"
                    return $Result
                }
            }

            # Check if it's an allowed package
            foreach ($allowedPackage in $Restrictions.restrictions.winget.allowedPackages) {
                if ($Command -match [regex]::Escape($allowedPackage)) {
                    $Result.Allowed = $true
                    $Result.Reason = "Approved user-scope application"
                    return $Result
                }
            }

            $Result.Reason = "Package not in approved list - may require administrator privileges"
            $Result.Alternative = "Consider portable applications or user-scope alternatives"
        }

        "powershell" {
            # Check for blocked scopes
            if ($Command -match "-Scope\s+(AllUsers|LocalMachine)") {
                $Result.Reason = $Restrictions.restrictions.errorMessages.administratorRequired
                $Result.Alternative = "Use -Scope CurrentUser instead"
                return $Result
            }

            # Check for blocked modules
            foreach ($blockedModule in $Restrictions.restrictions.powershell.blockedModules) {
                if ($Command -match [regex]::Escape($blockedModule)) {
                    $Result.Reason = "Module requires domain administrator privileges"
                    $Result.Alternative = "Contact IT for enterprise module access if needed"
                    return $Result
                }
            }

            # If CurrentUser scope is specified, allow
            if ($Command -match "-Scope\s+CurrentUser") {
                $Result.Allowed = $true
                $Result.Reason = "Approved user-scope PowerShell module operation"
                return $Result
            }

            $Result.Reason = "PowerShell operation may require elevated privileges"
            $Result.Alternative = "Add -Scope CurrentUser to ensure user-scope installation"
        }

        "system" {
            # Check for blocked system commands
            foreach ($blockedCmd in $Restrictions.restrictions.systemOperations.blockedCommands) {
                if ($Command -match [regex]::Escape($blockedCmd)) {
                    $Result.Reason = $Restrictions.restrictions.errorMessages.administratorRequired
                    $Result.Alternative = "System configuration changes not permitted in enterprise environment"
                    return $Result
                }
            }

            # Check for blocked paths
            foreach ($blockedPath in $Restrictions.restrictions.systemOperations.blockedPaths) {
                if ($Command -match [regex]::Escape($blockedPath)) {
                    $Result.Reason = "Path requires administrator access"
                    $Result.Alternative = "Use user profile directories instead"
                    return $Result
                }
            }

            $Result.Allowed = $true
            $Result.Reason = "System operation appears to be user-scope"
        }

        default {
            $Result.Reason = "Unknown operation type"
            $Result.Alternative = "Verify operation complies with VA Healthcare security policies"
        }
    }

    return $Result
}


# SECTION: Execute the compliance check
$ComplianceResult = Test-VASecurityCompliance -Operation $Operation -Command $Command

# SECTION: Output results
Write-Host "VA Healthcare Security Compliance Check" -ForegroundColor Cyan
Write-Host "Operation: $Operation" -ForegroundColor White
Write-Host "Command: $Command" -ForegroundColor White
Write-Host ""

if ($ComplianceResult.Allowed) {
    Write-Host "✅ APPROVED" -ForegroundColor Green
    Write-Host "Reason: $($ComplianceResult.Reason)" -ForegroundColor Green
}
else {
    Write-Host "🚫 BLOCKED" -ForegroundColor Red
    Write-Host "Reason: $($ComplianceResult.Reason)" -ForegroundColor Red
    if ($ComplianceResult.Alternative) {
        Write-Host "Alternative: $($ComplianceResult.Alternative)" -ForegroundColor Yellow
    }
}

return $ComplianceResult

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see VA Healthcare security policy documentation.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
