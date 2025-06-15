# install.ps1

Write-Host "🔧 إعداد dotfiles..."

# نسخ profile.ps1 إلى مكان profile الخاص بـ PowerShell 7
$profileDest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Copy-Item -Path ".\profile.ps1" -Destination $profileDest -Force
Write-Host "✅ PowerShell profile تم نسخه"

# نسخ إعدادات VS Code
$vsCodeSettingsPath = "$env:APPDATA\Code\User\settings.json"
Copy-Item -Path ".\vscode-settings.json" -Destination $vsCodeSettingsPath -Force
Write-Host "✅ VS Code settings تم ضبطها"

Write-Host "`n🎉 كل حاجة جهزت! افتح VS Code أو PowerShell 7 وجرب"
