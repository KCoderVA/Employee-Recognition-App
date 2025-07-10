# GitHub Repository Post-Setup Commands
# Run these commands AFTER creating the repository on GitHub.com

param(
    [string]$GitHubUsername = "KCoderVA",
    [string]$RepositoryName = "Employee-Recognition-App"
)

Write-Host "🔗 Connecting Local Repository to GitHub" -ForegroundColor Green
Write-Host "=======================================" -ForegroundColor Green

$repoUrl = "https://github.com/$GitHubUsername/$RepositoryName.git"

Write-Host "📡 Repository URL: $repoUrl" -ForegroundColor Cyan
Write-Host ""

try {
    # Check if remote already exists
    $existingRemote = git remote get-url origin 2>$null
    if ($existingRemote) {
        Write-Host "⚠️ Remote 'origin' already exists: $existingRemote" -ForegroundColor Yellow
        Write-Host "Updating remote URL..." -ForegroundColor Yellow
        git remote set-url origin $repoUrl
    } else {
        Write-Host "➕ Adding remote origin..." -ForegroundColor Cyan
        git remote add origin $repoUrl
    }

    Write-Host "🌿 Setting main branch..." -ForegroundColor Cyan
    git branch -M main

    Write-Host "📊 Current repository status:" -ForegroundColor Magenta
    git status --short

    Write-Host ""
    Write-Host "🚀 Ready to push to GitHub!" -ForegroundColor Green
    Write-Host "Run this command to upload everything:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "git push -u origin main" -ForegroundColor Cyan
    Write-Host ""
    
    # Ask if user wants to push now
    $push = Read-Host "Would you like to push to GitHub now? (y/N)"
    if ($push -eq "y" -or $push -eq "Y") {
        Write-Host "📤 Pushing to GitHub..." -ForegroundColor Green
        git push -u origin main
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
            Write-Host "🎯 Repository is now available at:" -ForegroundColor Cyan
            Write-Host "   $repoUrl" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "🎉 Your professional Power Platform repository is live!" -ForegroundColor Green
        } else {
            Write-Host ""
            Write-Host "❌ Push failed. Please check your GitHub credentials and repository access." -ForegroundColor Red
            Write-Host "💡 You may need to authenticate with GitHub first." -ForegroundColor Yellow
        }
    } else {
        Write-Host ""
        Write-Host "📝 To push later, run: git push -u origin main" -ForegroundColor Yellow
    }

} catch {
    Write-Host "❌ Error: $_" -ForegroundColor Red
    Write-Host "💡 Make sure the GitHub repository exists and you have access." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📋 Post-Setup Checklist:" -ForegroundColor Magenta
Write-Host "  1. ✅ Configure branch protection rules" -ForegroundColor White
Write-Host "  2. ✅ Add repository topics/tags" -ForegroundColor White  
Write-Host "  3. ✅ Enable security features" -ForegroundColor White
Write-Host "  4. ✅ Set up project board (optional)" -ForegroundColor White
Write-Host "  5. ✅ Invite collaborators (if needed)" -ForegroundColor White
