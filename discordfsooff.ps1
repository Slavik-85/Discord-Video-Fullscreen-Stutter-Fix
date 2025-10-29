$user = $env:USERNAME
$discordFolder = "C:\Users\$user\AppData\Local\Discord"
$regPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"

function Patch-FSO {
    $latestApp = Get-ChildItem -Path $discordFolder -Directory -Filter "app-*" |
        Sort-Object Name -Descending | Select-Object -First 1
    if ($latestApp) {
        $exePath = Join-Path $latestApp.FullName "Discord.exe"
        New-Item -Path $regPath -Force | Out-Null
        Set-ItemProperty -Path $regPath -Name $exePath -Value "~ DISABLEDXMAXIMIZEDWINDOWEDMODE"
    }
}

Patch-FSO
$watcher = New-Object System.IO.FileSystemWatcher $discordFolder, "app-*"
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $true
Register-ObjectEvent $watcher Created -Action { Patch-FSO } | Out-Null
Register-ObjectEvent $watcher Renamed -Action { Patch-FSO } | Out-Null

Add-Type -Name Win -Namespace PS -MemberDefinition '[DllImport("user32.dll")]public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);'
$hwnd = (Get-Process -Id $pid).MainWindowHandle
[PS.Win]::ShowWindowAsync($hwnd, 0) | Out-Null

while ($true) { Start-Sleep -Seconds 3600 }
