# profile.ps1

# تحميل oh-my-posh (لو مش متثبت)
if (-not (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
    Install-Module oh-my-posh -Scope CurrentUser -Force
}

# تحميل theme
$theme = "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json"
if (-not (Test-Path $theme)) {
    oh-my-posh get themes --destination "$env:POSH_THEMES_PATH"
}

# تشغيل oh-my-posh
oh-my-posh init pwsh --config $theme | Invoke-Expression
