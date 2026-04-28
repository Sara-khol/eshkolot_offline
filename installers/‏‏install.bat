@echo off


chcp 65001 > nul
cls

REM --- Check if Eshkolot is running ---
tasklist /FI "IMAGENAME eq eshkolot_offline.exe" | find /I "eshkolot_offline.exe" >nul
if errorlevel 1 goto CONTINUE

:RUNNING
powershell -NoProfile -Command ^
"Add-Type -AssemblyName PresentationFramework; ^
 $msg = 'התוכנה Eshkolot Offline פתוחה כרגע.' + [Environment]::NewLine + ^
        'אנא סגור אותה לפני המשך ההתקנה.'; ^
 [System.Windows.MessageBox]::Show($msg, 'התוכנה פתוחה', 'OK', 'Warning')"
exit /b

:CONTINUE

echo ==========================================
echo Detecting installer location and starting setup...
echo ==========================================
echo.

setlocal EnableExtensions EnableDelayedExpansion

REM === Get current drive & folder ===
set "batDrive=%~d0"
set "batFolder=%~dp0"
echo Script is running from: [%batFolder%]

@REM REM === Ask install location (GUI) ===
@REM powershell -NoProfile -Command ^
@REM "Add-Type -AssemblyName PresentationFramework; ^
@REM  $msg = '?איפה תרצה להתקין את התוכנה' + [Environment]::NewLine + [Environment]::NewLine + ^
@REM         'כן  - התקנה על המחשב ' + [Environment]::NewLine + ^
@REM         '(USB) לא  - התקנה על כונן חיצוני'; ^
@REM  $res = [System.Windows.MessageBox]::Show($msg, 'בחירת מיקום התקנה', 'YesNo', 'Question'); ^
@REM  if($res -eq 'Yes'){ exit 1 } else { exit 2 }"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Add-Type -AssemblyName System.Windows.Forms; ^
Add-Type -AssemblyName System.Drawing; ^
$form = New-Object System.Windows.Forms.Form; ^
$form.Text = 'בחירת מיקום התקנה'; ^
$form.StartPosition = 'CenterScreen'; ^
$form.ClientSize = New-Object System.Drawing.Size(390,180); ^
$form.FormBorderStyle = 'FixedDialog'; ^
$form.MaximizeBox = $false; ^
$form.MinimizeBox = $false; ^
$form.RightToLeft = [System.Windows.Forms.RightToLeft]::Yes; ^
$form.RightToLeftLayout = $true; ^
$form.TopMost = $true; ^
$form.BackColor = [System.Drawing.Color]::White; ^
$form.Font = New-Object System.Drawing.Font('Segoe UI',9); ^

$iconBox = New-Object System.Windows.Forms.PictureBox; ^
$iconBox.Size = New-Object System.Drawing.Size(32,32); ^
$iconBox.Location = New-Object System.Drawing.Point(30,20); ^
$iconBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::StretchImage; ^
$iconBox.Image = [System.Drawing.SystemIcons]::Question.ToBitmap(); ^
$form.Controls.Add($iconBox); ^

$label = New-Object System.Windows.Forms.Label; ^
$label.AutoSize = $false; ^
$label.Size = New-Object System.Drawing.Size(280,32); ^
$label.Location = New-Object System.Drawing.Point(70,20); ^
$label.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter; ^
$label.Font = New-Object System.Drawing.Font('Segoe UI',10,[System.Drawing.FontStyle]::Bold); ^
$label.Text = 'איפה תרצה להתקין את התוכנה?'; ^
$form.Controls.Add($label); ^

$btnComputer = New-Object System.Windows.Forms.Button; ^
$btnComputer.Size = New-Object System.Drawing.Size(145,36); ^
$btnComputer.Location = New-Object System.Drawing.Point(205,75); ^
$btnComputer.Text = 'התקנה על המחשב'; ^
$btnComputer.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; ^
$btnComputer.BackColor = [System.Drawing.Color]::FromArgb(245,245,245); ^
$btnComputer.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180,180,180); ^
$btnComputer.FlatAppearance.BorderSize = 1; ^
$btnComputer.Cursor = [System.Windows.Forms.Cursors]::Hand; ^
$btnComputer.Add_MouseEnter({ ^
    $this.BackColor = [System.Drawing.Color]::FromArgb(230,240,255); ^
    $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(120,160,220); ^
}); ^
$btnComputer.Add_MouseLeave({ ^
    $this.BackColor = [System.Drawing.Color]::FromArgb(245,245,245); ^
    $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180,180,180); ^
}); ^
$btnComputer.Add_Click({ $form.Tag = 'PC'; $form.Close() }); ^
$form.Controls.Add($btnComputer); ^

$btnUsb = New-Object System.Windows.Forms.Button; ^
$btnUsb.Size = New-Object System.Drawing.Size(145,36); ^
$btnUsb.Location = New-Object System.Drawing.Point(40,75); ^
$btnUsb.Text = 'התקנה על כונן (USB)'; ^
$btnUsb.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat; ^
$btnUsb.BackColor = [System.Drawing.Color]::FromArgb(245,245,245); ^
$btnUsb.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180,180,180); ^
$btnUsb.FlatAppearance.BorderSize = 1; ^
$btnUsb.Cursor = [System.Windows.Forms.Cursors]::Hand; ^
$btnUsb.Add_MouseEnter({ ^
    $this.BackColor = [System.Drawing.Color]::FromArgb(230,240,255); ^
    $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(120,160,220); ^
}); ^
$btnUsb.Add_MouseLeave({ ^
    $this.BackColor = [System.Drawing.Color]::FromArgb(245,245,245); ^
    $this.FlatAppearance.BorderColor = [System.Drawing.Color]::FromArgb(180,180,180); ^
}); ^
$btnUsb.Add_Click({ $form.Tag = 'USB'; $form.Close() }); ^
$form.Controls.Add($btnUsb); ^

$bottomLabel = New-Object System.Windows.Forms.Label; ^
$bottomLabel.AutoSize = $false; ^
$bottomLabel.Size = New-Object System.Drawing.Size(340,30); ^
$bottomLabel.Location = New-Object System.Drawing.Point(25,128); ^
$bottomLabel.TextAlign = [System.Drawing.ContentAlignment]::MiddleCenter; ^
$bottomLabel.Font = New-Object System.Drawing.Font('Segoe UI',8); ^
$bottomLabel.ForeColor = [System.Drawing.Color]::Gray; ^
$bottomLabel.Text = 'במידה והתוכנה לא נפתחת בצורה תקינה יש להפעיל מחדש'; ^
$form.Controls.Add($bottomLabel); ^

[void]$form.ShowDialog(); ^
if ($form.Tag -eq 'PC') { exit 1 } elseif ($form.Tag -eq 'USB') { exit 2 } else { exit 0 }"

set installChoice=%ERRORLEVEL%


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


REM === Find ZIP file ===
for /f "delims=" %%f in ('powershell -nologo -noprofile -command ^
    "Get-ChildItem -Path '%batFolder%' -Filter '*.eshkolot' | Sort-Object LastWriteTime -Descending | Select-Object -First 1 | ForEach-Object { $_.FullName }"') do (
    set "zipFile=%%f"
)

if "%zipFile%"=="" goto ZIP_MISSING
goto AFTER_ZIP_CHECK

:ZIP_MISSING
powershell -NoProfile -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('קובץ ההתקנה (.eshkolot) לא נמצא בתיקייה זו.','קובץ חסר','OK','Error')"
exit /b

:AFTER_ZIP_CHECK


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


REM --- Compare using PowerShell and return OK/NO (no ERRORLEVEL logic) ---
for /f "usebackq delims=" %%R in (`
  powershell -NoProfile -Command ^
    "$free=[int64]%freeSpaceClean%; $req=[int64]%requiredSpace%; if($free -lt $req){'NO'} else {'OK'}"
`) do set "spaceCheck=%%R"

echo spaceCheck=%spaceCheck%

if /i "%spaceCheck%"=="NO" goto NO_SPACE

REM אם הגיע לכאן - יש מקום
goto SPACE_OK


:NO_SPACE
powershell -NoProfile -Command ^
"Add-Type -AssemblyName PresentationFramework; ^
 $free = [int64]%freeSpaceClean%; ^
 $req  = [int64]%requiredSpace%; ^
 $freeFmt = '{0:N0}' -f $free; ^
 $reqFmt  = '{0:N0}' -f $req; ^
 $msg = 'אין מספיק מקום פנוי בדיסק כדי להמשיך בהתקנה.' + [Environment]::NewLine + [Environment]::NewLine + ^
        'מקום פנוי: ' + $freeFmt + [Environment]::NewLine + ^
        'נדרש: ' + $reqFmt; ^
 [System.Windows.MessageBox]::Show($msg, 'שגיאת מקום בדיסק', 'OK', 'Error')"

exit /b

:SPACE_OK
echo Disk space OK


REM === Reset destination folder ===
echo Cleaning destination folder...
if exist "%destinationFolder%" (
    rmdir /s /q "%destinationFolder%"
)

mkdir "%destinationFolder%"


REM === Hide folder only if it's on USB ===
if "%installChoice%"=="2" (
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
if not exist "%destinationFolder%\eshkolot_setup.exe" goto SETUP_NOT_FOUND

echo Launching application...
start "" "%destinationFolder%\eshkolot_setup.exe"
goto END

:SETUP_NOT_FOUND
powershell -NoProfile -Command ^
"Add-Type -AssemblyName PresentationFramework; ^
 [System.Windows.MessageBox]::Show('קובץ ההפעלה eshkolot_setup.exe לא נמצא לאחר החילוץ.','קובץ חסר','OK','Error')"
exit /b

:END



endlocal


