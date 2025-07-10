# Employee Recognition App - Deployment Script
# This script handles the deployment of the Power Platform solution

param(
    [Parameter(Mandatory=$false)]
    [string]$Environment = "dev",

    [Parameter(Mandatory=$false)]
    [switch]$Validate = $false
)

Write-Host "Employee Recognition App - Deployment Script" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""

# Check if PAC CLI is installed
try {
    $pacVersion = pac --version
    Write-Host "✅ Power Platform CLI Version: $pacVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Power Platform CLI not found. Please install PAC CLI first." -ForegroundColor Red
    exit 1
}

# Check authentication
try {
    $authList = pac auth list 2>$null
    if ($authList -match "No profiles found") {
        Write-Host "❌ No authenticated profiles found. Please run 'pac auth create' first." -ForegroundColor Red
        exit 1
    }
    Write-Host "✅ Authentication profiles found" -ForegroundColor Green
} catch {
    Write-Host "❌ Unable to check authentication status" -ForegroundColor Red
    exit 1
}

# Create timestamp for deployment
$timestamp = Get-Date -Format "yyyy-MM-dd_HHmm"
$deploymentPath = "./releases/deployment_$timestamp"

Write-Host ""
Write-Host "🚀 Starting deployment process..." -ForegroundColor Yellow
Write-Host "Target Environment: $Environment" -ForegroundColor Cyan
Write-Host "Timestamp: $timestamp" -ForegroundColor Cyan

# Create deployment directory
New-Item -ItemType Directory -Path $deploymentPath -Force | Out-Null

# Package the Power App
Write-Host ""
Write-Host "📦 Packaging Power App..." -ForegroundColor Yellow
try {
    pac canvas pack --sources "./src/power-apps/EmployeeRecognitionApp_Unpacked" --msapp "$deploymentPath/EmployeeRecognitionApp.msapp"
    Write-Host "✅ Power App packaged successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to package Power App" -ForegroundColor Red
    exit 1
}

if ($Validate) {
    Write-Host ""
    Write-Host "🔍 Validation mode - deployment simulation complete" -ForegroundColor Yellow
    Write-Host "Deployment package created at: $deploymentPath" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "✅ Deployment preparation complete!" -ForegroundColor Green
    Write-Host "Next steps:" -ForegroundColor Yellow
    Write-Host "1. Review the package in: $deploymentPath" -ForegroundColor White
    Write-Host "2. Import manually through Power Platform admin center" -ForegroundColor White
    Write-Host "3. Configure environment-specific settings" -ForegroundColor White
}

Write-Host ""
Write-Host "📊 Deployment Summary:" -ForegroundColor Green
Write-Host "- Power App: EmployeeRecognitionApp.msapp" -ForegroundColor White
Write-Host "- Deployment Path: $deploymentPath" -ForegroundColor White
Write-Host "- Environment: $Environment" -ForegroundColor White
Write-Host "- Timestamp: $timestamp" -ForegroundColor White
