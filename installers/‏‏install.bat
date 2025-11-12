@echo off
chcp 65001 > nul
cls

echo ==========================================
echo Detecting installer location and starting setup...
echo ==========================================
echo.

setlocal EnableExtensions EnableDelayedExpansion

REM ===========================
REM Soft lock: only clean stale lock, do not block
REM ===========================
set "lockFile=%TEMP%\eshkolot_install.lock"
if exist "%lockFile%" (
    echo ℹ️ Lock file found from a previous run – cleaning up...
    del /f /q "%lockFile%" 2>nul
)
echo Installing... > "%lockFile%"

REM Ensure we always remove the lock on any exit
REM Use a common cleanup label
set "EXIT_CODE=0"

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
REM set "fileName=installation.eshkolot"
REM set "zipFile=%batFolder%%fileName%"

for /f "delims=" %%f in ('powershell -nologo -noprofile -command ^
    "Get-ChildItem -Path '%batFolder%' -Filter '*.eshkolot' | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { $_.FullName }"') do (
    set "zipFile=%%f"
)

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
