# Microsoft PowerPlatform CLI Filtered Canvas Apps List
# Use the PowerPlatform CLI within PowerShell terminal to run a filtered "pac canvas list" command that allows user to search and filter output results.

# Script file name is "CLI-FilterCanvasApps.ps1"
# Script directory path is "\root\scripts\CLI-FilterCanvasApps.ps1"
# Example usage:
# Get-FilteredCanvasApps -SearchColumn "CreatedBy" -SearchString "kyle"
# Get-FilteredCanvasApps -SearchColumn "Name" -SearchString "578_TemplateApp"
# Get-FilteredCanvasApps -SearchColumn "ModifiedOn" -SearchString "12/7/2023"

function Get-FilteredCanvasApps {
    param (
        [string]$SearchString,
        [ValidateSet('Name', 'CreatedBy', 'ModifiedOn')]
        [string]$SearchColumn
    )

    try {
        # Run the pac canvas list command and capture the output
        $canvasAppsRaw = pac canvas list | Out-String

        # Debugging: Output the raw data to inspect manually
        Write-Output "Raw output from pac canvas list:"
        Write-Output $canvasAppsRaw

        # Split the raw output into lines
        $canvasAppsLines = $canvasAppsRaw -split "`n"

        # Remove the first two lines (header and a blank line)
        $canvasAppsLines = $canvasAppsLines[2..($canvasAppsLines.Length - 1)]

        # Initialize an empty array to hold the parsed results
        $canvasAppsArray = @()

        # Parse each line into an object
        foreach ($line in $canvasAppsLines) {
            if ($line.Trim()) {
                $columns = $line -split '\s{2,}'   # Split by at least 2 spaces
                $app = [PSCustomObject]@{
                    Name       = $columns[0]
                    CreatedBy  = $columns[1]
                    ModifiedOn = $columns[2]
                }
                $canvasAppsArray += $app
            }
        }

        # Filter the array based on the specified search string and column
        $filteredApps = $canvasAppsArray | Where-Object { $_.$SearchColumn -like "*$SearchString*" }

        # Output the filtered list
        return $filteredApps
    }
    catch {
        Write-Error "An error occurred: $_"
    }
}
