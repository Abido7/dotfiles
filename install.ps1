Write-Host "🔧 بدء إعداد dotfiles..."
$ErrorActionPreference = "Continue"

# 1️⃣ التحقق من PowerShell 7، تحميله وتثبيته لو مش موجود
try {
    if ($PSVersionTable.PSVersion.Major -lt 7) {
        Write-Host "⚠️ PowerShell 7 غير مثبت. جاري تحميله وتثبيته..."
        $url = "https://github.com/PowerShell/PowerShell/releases/latest/download/PowerShell-7.4.2-win-x64.msi"
        $installerPath = "$env:TEMP\PowerShell-7.msi"
        Invoke-WebRequest -Uri $url -OutFile $installerPath -UseBasicParsing

        Start-Process "msiexec.exe" -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait
        Write-Host "`n✅ تم تثبيت PowerShell 7. يرجى إعادة فتحه يدويًا لتكملة الإعداد"
        Start-Sleep -Seconds 5
        exit
    } else {
        Write-Host "✅ PowerShell 7 موجود (v$($PSVersionTable.PSVersion))"
    }
} catch {
    Write-Host "❌ فشل في تنزيل أو تثبيت PowerShell 7: $_"
    exit 1
}

# 2️⃣ إعداد PowerShell profile
try {
    $profileDest = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    Copy-Item -Path ".\profile.ps1" -Destination $profileDest -Force
    Write-Host "✅ تم نسخ PowerShell profile إلى: $profileDest"
} catch {
    Write-Host "⚠️ فشل في نسخ PowerShell profile: $_"
}

# 3️⃣ إعداد VS Code (لو موجود)
try {
    $vsCodePath = "$env:APPDATA\Code\User"
    if (Test-Path $vsCodePath) {
        $vsCodeSettings = Join-Path $vsCodePath "settings.json"
        Copy-Item -Path ".\vscode-settings.json" -Destination $vsCodeSettings -Force
        Write-Host "✅ تم نسخ إعدادات VS Code"
    } else {
        Write-Host "⚠️ VS Code غير موجود، تم تخطي الإعدادات الخاصة به"
    }
} catch {
    Write-Host "⚠️ حصل خطأ أثناء إعداد VS Code: $_"
}

# 4️⃣ التحقق من Windows Terminal (اختياري)
try {
    $wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    if (Test-Path $wtSettingsPath) {
        Write-Host "✅ Windows Terminal موجود"
    } else {
        Write-Host "⚠️ Windows Terminal غير مثبت أو في نسخة مختلفة"
    }
} catch {
    Write-Host "⚠️ خطأ أثناء التحقق من Windows Terminal"
}

# 5️⃣ تثبيت oh-my-posh
try {
    if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
        Write-Host "⬇️ جاري تثبيت oh-my-posh..."
        Install-Module oh-my-posh -Scope CurrentUser -Force -AllowClobber
        Write-Host "✅ تم تثبيت oh-my-posh"
    } else {
        Write-Host "✅ oh-my-posh مثبت بالفعل"
    }
} catch {
    Write-Host "⚠️ فشل في تثبيت oh-my-posh: $_"
}

Write-Host "`n🎉 تمت عملية الإعداد بالكامل بنجاح!"
Write-Host "✅ افتح PowerShell 7 أو VS Code لتجربة الشكل الجديد!"
