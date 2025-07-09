@echo off
chcp 65001 > nul
cls

echo ==========================================
echo Detecting installer location and starting setup...
echo ==========================================
echo.

setlocal enabledelayedexpansion

REM === Lock file to prevent multiple instances ===
set "lockFile=%TEMP%\eshkolot_install.lock"
if exist "%lockFile%" (
    tasklist | find /i "eshkolot_setup.exe" >nul
    if %errorlevel%==0 (
        echo ⚠️ Installer is already running!
        echo If this is a mistake, delete: %lockFile%
        pause
        exit /b
    ) else (
        echo ℹ️ Lock file found, but no app is running – cleaning up...
        del "%lockFile%"
    )
)
echo Installing... > "%lockFile%"

REM === Get current drive & folder ===
set "batDrive=%~d0"
set "batFolder=%~dp0"
echo Script is running from: [%batFolder%]

REM === Check if running from USB ===
fsutil fsinfo drivetype %batDrive% > "%TEMP%\driveinfo.txt" 2>nul

set "driveType="
for /f "tokens=*" %%a in (%TEMP%\driveinfo.txt) do (
    echo %%a | findstr /i "Removable" >nul && set "driveType=Removable"
)
del "%TEMP%\driveinfo.txt"

REM === Set paths ===
set "fileName=installation.eshkolot"
set "zipFile=%batFolder%%fileName%"

if "%driveType%"=="Removable" (
    echo ✅ Detected USB
    set "destinationFolder=%batFolder%.eshkolot_system"

    REM === Create and immediately hide the folder
    if not exist "%destinationFolder%" (
        echo Creating .eshkolot_system...
        mkdir "%destinationFolder%"
    )
) else (
    echo ℹ️ Not a USB – using AppData
    set "destinationFolder=%APPDATA%\GoApp\eshkolot_offline"
)

echo zipFile = [%zipFile%]
echo destinationFolder = [%destinationFolder%]
echo.

REM === Always reset destination folder ===
echo 🧹 Cleaning destination folder...
if exist "%destinationFolder%" (
    rmdir /s /q "%destinationFolder%"
)

echo Creating destination folder...
mkdir "%destinationFolder%"

REM === Hide folder if on USB ===
if "%driveType%"=="Removable" (
    echo Hiding .eshkolot_system...
    pushd "%batFolder%"
    attrib +h +s ".eshkolot_system"
    popd
)

REM === Extract files ===
echo 📦 Extracting files...
powershell.exe -NoLogo -NoProfile -Command ^
    "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
    "[System.IO.Compression.ZipFile]::ExtractToDirectory('%zipFile%', '%destinationFolder%')"

if %errorlevel% NEQ 0 (
    echo ❌ ERROR: Extraction failed.
    del "%lockFile%"
    pause
    exit /b
)

REM === Launch the app ===
if exist "%destinationFolder%\eshkolot_setup.exe" (
    echo 🚀 Launching application...
    start "" "%destinationFolder%\eshkolot_setup.exe"
) else (
    echo ❌ ERROR: eshkolot_setup.exe not found after extraction.
    del "%lockFile%"
    pause
    exit /b
)

REM === Remove the lock ===
del "%lockFile%"
endlocal
