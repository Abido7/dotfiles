# ❗️غير اسم المستخدم هنا لاسم GitHub بتاعك
$githubUser = "abido7"
$repo = "dotfiles"
$branch = "main"  # لو اسم الفرع main اكتب "main"

# مسارات مؤقتة
$zipUrl = "https://github.com/$githubUser/$repo/archive/refs/heads/$branch.zip"
$zipPath = "$env:TEMP\$repo.zip"
$extractPath = "$env:TEMP\$repo"

# تحميل ملف ZIP
Write-Host "⬇️  بيتم تحميل dotfiles من GitHub..."
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing

# فك الضغط
Write-Host "📦 بيتم فك الضغط..."
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# تشغيل سكربت التثبيت
$installScript = "$extractPath\$repo-$branch\install.ps1"
Write-Host "🚀 تشغيل سكربت التثبيت..."
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
& $installScript
