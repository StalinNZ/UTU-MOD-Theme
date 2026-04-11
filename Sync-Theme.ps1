# 󰒓 UTU-MOD Theme Sync Utility
# Purpose: Synchronize the theme.json with Gemini CLI settings.json

$ThemePath = Join-Path $PSScriptRoot "theme.json"
$SettingsPath = "$HOME\.gemini\settings.json"

if (!(Test-Path $ThemePath)) {
    Write-Error "󰒃 theme.json not found in current directory."
    exit 1
}

if (!(Test-Path $SettingsPath)) {
    Write-Error "󰒃 Gemini settings.json not found at $SettingsPath"
    exit 1
}

Write-Host "󰚌 Loading UTU-MOD Tactical Palette..." -ForegroundColor Green
$Theme = Get-Content $ThemePath -Raw | ConvertFrom-Json
$Settings = Get-Content $SettingsPath -Raw | ConvertFrom-Json

# Update or Create the custom theme entry
if ($null -eq $Settings.ui.customThemes) {
    $Settings.ui | Add-Member -MemberType NoteProperty -Name "customThemes" -Value @{}
}

$Settings.ui.customThemes | Add-Member -MemberType NoteProperty -Name "UTU-MOD" -Value $Theme -Force
$Settings.ui.theme = "UTU-MOD"

# Save back to settings
$Settings | ConvertTo-Json -Depth 10 | Set-Content $SettingsPath

Write-Host "󱥸 Tikaka restored. UTU-MOD Theme is now active and synchronized." -ForegroundColor Cyan
