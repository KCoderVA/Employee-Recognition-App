
# ============================================================================
#  Script: CLI-FilterCanvasApps.ps1
#  Author: Kyle J. Coder
#  License: Apache License, Version 2.0 (see https://www.apache.org/licenses/LICENSE-2.0)
#  Copyright 2025 Kyle J. Coder
#
#  DESCRIPTION (For End Users):
#    This script provides a PowerShell function to filter the output of the
#    Power Platform CLI (PAC) 'canvas list' command, making it easier to search
#    for apps by name, creator, or modification date.
#
#  USAGE:
#    1. Import or dot-source this script in your PowerShell session:
#         . ./CLI-FilterCanvasApps.ps1
#    2. Call Get-FilteredCanvasApps with the desired search column and string.
#         Example:
#           Get-FilteredCanvasApps -SearchColumn "CreatedBy" -SearchString "kyle"
#           Get-FilteredCanvasApps -SearchColumn "Name" -SearchString "578_TemplateApp"
#           Get-FilteredCanvasApps -SearchColumn "ModifiedOn" -SearchString "12/7/2023"
#    3. Designed for Power Platform ALM automation and reporting.
#    4. Can be adapted for other PAC CLI list commands.
#
#  EDUCATIONAL NOTES:
#    - Demonstrates PowerShell parsing, filtering, and integration with external CLI tools for enterprise automation.
#    - Section and sub-section comments are provided throughout for clarity.
# ============================================================================


# =====================
# FUNCTION DEFINITION
# =====================
# Get-FilteredCanvasApps
#   - Main function to filter Power Platform Canvas Apps list output.
#   - Parameters:
#       * SearchString: The value to search for (partial or full match).
#       * SearchColumn: The column to search in (Name, CreatedBy, ModifiedOn).
function Get-FilteredCanvasApps {
    param (
        [string]$SearchString,
        [ValidateSet('Name', 'CreatedBy', 'ModifiedOn')]
        [string]$SearchColumn
    )

    try {
        # SECTION: Run PAC CLI and capture output
        # This executes the Power Platform CLI command and stores the result as a string.
        $canvasAppsRaw = pac canvas list | Out-String

        # SECTION: Output raw data for debugging (optional for advanced users)
        Write-Output "Raw output from pac canvas list:"
        Write-Output $canvasAppsRaw

        # SECTION: Parse CLI output into lines
        $canvasAppsLines = $canvasAppsRaw -split "`n"

        # Remove the first two lines (header and a blank line) to get to the data rows
        $canvasAppsLines = $canvasAppsLines[2..($canvasAppsLines.Length - 1)]

        # SECTION: Initialize array for parsed results
        $canvasAppsArray = @()

        # SECTION: Parse each line into a PowerShell object for easier filtering
        foreach ($line in $canvasAppsLines) {
            if ($line.Trim()) {
                # Split by at least 2 spaces to separate columns
                $columns = $line -split '\s{2,}'
                $app = [PSCustomObject]@{
                    Name       = $columns[0]
                    CreatedBy  = $columns[1]
                    ModifiedOn = $columns[2]
                }
                $canvasAppsArray += $app
            }
        }

        # SECTION: Filter the array based on user input
        $filteredApps = $canvasAppsArray | Where-Object { $_.$SearchColumn -like "*$SearchString*" }

        # SECTION: Output the filtered list to the user
        return $filteredApps
    }
    catch {
        # SECTION: Error handling for unexpected issues
        Write-Error "An error occurred: $_"
    }
}

# ============================================================================
#  FOOTER (For maintainers and advanced users):
#    - Script file name: CLI-FilterCanvasApps.ps1
#    - Script directory path: \root\scripts\CLI-FilterCanvasApps.ps1
#    - This script is part of the Employee Recognition App Power Platform ALM toolkit.
#    - For advanced customization, see the Power Platform CLI documentation and
#      consider extending this script for additional PAC CLI commands.
#    - For license and contribution details, see the project root LICENSE file.
# ============================================================================
