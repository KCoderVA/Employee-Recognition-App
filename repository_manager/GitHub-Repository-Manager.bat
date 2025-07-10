@echo off
REM Employee Recognition App - One-Click Repository Manager
REM Copyright 2025 Kyle J. Coder - Apache License 2.0
REM Double-click this file to prepare workspace for GitHub commit

REM Set UTF-8 encoding to handle Unicode characters
chcp 65001 >nul

setlocal enabledelayedexpansion

REM Set console title and colors
title Employee Recognition App - Repository Manager
color 0A

REM Change to project root directory (parent of script directory)
cd /d "%~dp0\.."

echo.
echo ================================================================
echo   🚀 Employee Recognition App - Repository Manager
echo ================================================================
echo   Copyright 2025 Kyle J. Coder - Apache License 2.0
echo   Preparing workspace for GitHub commit...
echo ================================================================
echo.

REM Check if we're in the right directory (look for key files)
if not exist "CHANGELOG.md" (
    echo ❌ ERROR: CHANGELOG.md not found!
    echo    This script must be run from the project root directory.
    echo    Current directory: %CD%
    pause
    exit /b 1
)

if not exist "scripts\workspace-cleanup.ps1" (
    echo ❌ ERROR: Workspace cleanup script not found!
    echo    Expected: scripts\workspace-cleanup.ps1
    echo    Current directory: %CD%
    pause
    exit /b 1
)

REM Step 1: Workspace Cleanup
echo 🧹 Step 1: Cleaning workspace...
echo ----------------------------------------
pwsh -ExecutionPolicy Bypass -File "scripts\workspace-cleanup.ps1"
if !errorlevel! neq 0 (
    echo ❌ Workspace cleanup failed!
    echo    Check the error messages above.
    pause
    exit /b 1
)
echo ✅ Workspace cleanup completed!
echo.

REM Step 2: Git Status Check
echo 📋 Step 2: Checking repository status...
echo ----------------------------------------
git status --porcelain > nul 2>&1
if !errorlevel! neq 0 (
    echo ❌ ERROR: Not in a git repository or git not available!
    echo    Make sure git is installed and this is a git repository.
    pause
    exit /b 1
)

REM Show current git status
echo Current repository status:
git status --short
echo.

REM Step 3: CHANGELOG and Safe Commit
echo 📝 Step 3: Preparing for commit with CHANGELOG validation...
echo ----------------------------------------
echo.
echo Choose your preferred commit method:
echo   1. Interactive safe commit (recommended)
echo   2. Quick commit with auto-generated message
echo   3. Preview only (dry run)
echo   4. Cancel and exit
echo.
set /p choice="Enter your choice (1-4): "

if "!choice!"=="1" goto interactive_commit
if "!choice!"=="2" goto quick_commit
if "!choice!"=="3" goto preview_mode
if "!choice!"=="4" goto cancel
echo Invalid choice. Using interactive mode...

:interactive_commit
echo.
echo 🛡️ Running interactive safe commit...
pwsh -ExecutionPolicy Bypass -File "scripts\safe-commit.ps1" -Interactive
goto commit_complete

:quick_commit
echo.
echo 🚀 Running quick commit with auto-generated message...
for /f "tokens=2 delims==" %%i in ('wmic OS Get localdatetime /value') do set datetime=%%i
set timestamp=!datetime:~0,4!-!datetime:~4,2!-!datetime:~6,2!_!datetime:~8,2!!datetime:~10,2!
pwsh -ExecutionPolicy Bypass -File "scripts\safe-commit.ps1" -Message "Repository update - !timestamp!"
goto commit_complete

:preview_mode
echo.
echo 🔍 Running preview mode (dry run)...
pwsh -ExecutionPolicy Bypass -File "scripts\safe-commit.ps1" -DryRun
echo.
echo 💡 This was a preview. No actual commit was made.
echo    Run this script again and choose option 1 or 2 to commit.
goto finish

:cancel
echo.
echo ⏹️ Operation cancelled by user.
goto finish

:commit_complete
if !errorlevel! equ 0 (
    echo.
    echo ✅ Repository preparation completed successfully!
    echo.
    echo 📊 Final repository status:
    git status --short
    echo.
    echo 🎯 Your repository is now ready for GitHub!
) else (
    echo.
    echo ❌ Commit process encountered issues.
    echo    Check the messages above for details.
)

:finish
echo.
echo ================================================================
echo   Process completed. You can now close this window.
echo ================================================================
echo.
pause
exit /b 0
