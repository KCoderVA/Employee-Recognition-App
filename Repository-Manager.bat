@echo off
REM Quick Launcher for Repository Manager
REM Copyright 2025 Kyle J. Coder - Apache License 2.0

echo.
echo 🚀 Launching Repository Manager...
echo.

REM Check if repository_manager folder exists
if not exist "repository_manager\GitHub-Repository-Manager.bat" (
    echo ❌ ERROR: Repository Manager not found!
    echo    Expected: repository_manager\GitHub-Repository-Manager.bat
    echo    Current directory: %CD%
    pause
    exit /b 1
)

REM Launch the main repository manager
call "repository_manager\GitHub-Repository-Manager.bat"
