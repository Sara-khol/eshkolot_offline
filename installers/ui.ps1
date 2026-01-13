Add-Type -AssemblyName PresentationFramework

$message = @"
?איפה תרצה להתקין את התוכנה

כן  – התקנה על המחשב הזה 
(USB) לא  – התקנה על כונן חיצוני 
 
"@

$result = [System.Windows.MessageBox]::Show(
    $message,
    "בחירת מיקום התקנה",
    [System.Windows.MessageBoxButton]::YesNo,
    [System.Windows.MessageBoxImage]::Question,
    [System.Windows.MessageBoxOptions]::RightToLeft -bor
   [System.Windows.MessageBoxOptions]::RightToLeftLayout
)

if ($result -eq [System.Windows.MessageBoxResult]::Yes) {
    exit 1
} else {
    exit 2
}
