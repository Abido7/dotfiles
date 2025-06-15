# 🧠 تحميل oh-my-posh
Import-Module oh-my-posh

# 🎨 تطبيق ثيم jandedobbeleer (من ضمن الثيمات الجاهزة)
oh-my-posh init pwsh --config "$(Get-PoshThemesPath)\jandedobbeleer.omp.json" | Invoke-Expression

# 🔍 تحسين تجربة الكتابة في PowerShell
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -Colors @{
    "Prediction" = [ConsoleColor]::DarkGray
}

# 📁 إظهار اسم الجهاز والمجلد الحالي بشكل واضح
function prompt {
    "$PWD > "
}
