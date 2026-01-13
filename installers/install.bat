@echo off
chcp 65001 > nul
cls

REM --- Check if Eshkolot is running ---
tasklist /FI "IMAGENAME eq eshkolot_offline.exe" | find /I "eshkolot_offline.exe" >nul
if %ERRORLEVEL%==0 (
    echo The application is currently running.
    echo Please close "Eshkolot Offline" before continuing.
    pause
    exit /b
)

echo ==========================================
echo Detecting installer location and starting setup...
echo ==========================================
echo.

setlocal EnableExtensions EnableDelayedExpansion

REM === Get current drive & folder ===
set "batDrive=%~d0"
set "batFolder=%~dp0"
echo Script is running from: [%batFolder%]

echo ==========================================
echo Choose installation location:
echo 1 - Install on this computer (AppData)
echo 2 - Install on USB / external drive
echo ==========================================
set /p installChoice=Enter your choice (1 or 2):

if "%installChoice%"=="1" (
    echo Installing to AppData...
    set "destinationFolder=%APPDATA%\GoApp\eshkolot_offline"
) else if "%installChoice%"=="2" (
    echo Installing to USB / external drive...
    set "destinationFolder=%batDrive%\.eshkolot_system"
) else (
    echo Invalid choice.
    pause
    exit /b
)

echo.
echo Installation will be done here:
echo %destinationFolder%
echo.
pause

REM === Find ZIP file ===
for /f "delims=" %%f in ('powershell -nologo -noprofile -command ^
    "Get-ChildItem -Path '%batFolder%' -Filter '*.eshkolot' | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { $_.FullName }"') do (
    set "zipFile=%%f"
)

if "%zipFile%"=="" (
    echo ERROR: installation.eshkolot file not found in this folder.
    pause
    exit /b
)

echo zipFile = [%zipFile%]
echo destinationFolder = [%destinationFolder%]
echo.


echo ============================
echo Checking disk space...
echo ============================

REM --- Detect free disk space ---
for /f "tokens=3" %%A in ('dir "%batDrive%\" ^| find "bytes free"') do set "freeSpace=%%A"

if "%freeSpace%"=="" (
    echo ERROR: Could not detect free disk space.
    pause
    exit /b
)

echo freeSpace=%freeSpace%

REM --- Get ZIP size ---
for /f "usebackq" %%A in (`
    powershell -NoProfile -Command "(Get-Item '%zipFile%').Length"
`) do set "zipSize=%%A"

if "%zipSize%"=="" (
    echo ERROR: Could not read ZIP size!
    pause
    exit /b
)

echo zipSize=%zipSize%

REM --- Required space = ZIP × 1.2 ---
for /f "usebackq" %%A in (`
    powershell -NoProfile -Command "[int64](%zipSize% * 1.2)"
`) do set "requiredSpace=%%A"

echo requiredSpace=%requiredSpace%

REM --- Remove commas from freeSpace ---
set "freeSpaceClean=%freeSpace:,=%"

REM --- Compare using PowerShell ---
powershell -NoProfile -Command "if ([int64]%freeSpaceClean% -lt [int64]%requiredSpace%) { exit 1 } else { exit 0 }"

if errorlevel 1 (
    echo ERROR: Not enough disk space!
    echo Free: %freeSpace%
    echo Required: %requiredSpace%
    pause
    exit /b
)

echo Disk space OK

REM === Always reset destination folder ===
echo Cleaning destination folder...
if exist "%destinationFolder%" (
    rmdir /s /q "%destinationFolder%"
)


REM === Create destination folder ===
if exist "%destinationFolder%" (
    rmdir /s /q "%destinationFolder%"
)

mkdir "%destinationFolder%"

REM === Hide folder only if it's on USB ===
if "%installChoice%"=="2" (
    echo Hiding .eshkolot_system on USB...
    attrib +h +s "%destinationFolder%"
)


REM === Extract files ===
echo Extracting files...
powershell.exe -NoLogo -NoProfile -Command ^
    "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
    "[System.IO.Compression.ZipFile]::ExtractToDirectory('%zipFile%', '%destinationFolder%')"

if %errorlevel% NEQ 0 (
    echo ERROR: Extraction failed.
    pause
    exit /b
)

REM === Launch the app ===
if exist "%destinationFolder%\eshkolot_setup.exe" (
    echo Launching application...
    start "" "%destinationFolder%\eshkolot_setup.exe"
) else (
    echo ERROR: eshkolot_setup.exe not found after extraction.
    pause
    exit /b
)


endlocal
