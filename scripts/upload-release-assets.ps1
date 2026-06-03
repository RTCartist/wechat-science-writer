#Requires -Version 5.1
param(
    [int] $ReleaseId = 333515548,
    [string] $Owner = "RTCartist",
    [string] $Repo = "wechat-science-writer"
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$env:GCM_INTERACTIVE = "false"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

$gcm = "D:\Git\mingw64\bin\git-credential-manager.exe"
$job = Start-Job { param($g) "protocol=https`nhost=github.com`n`n" | & $g get 2>&1 } -ArgumentList $gcm
Wait-Job $job -Timeout 25 | Out-Null
if ($job.State -eq "Running") { Stop-Job $job; throw "credential timeout" }
$out = Receive-Job $job | Out-String
$token = (($out -split "`n" | Where-Object { $_ -match "^password=" }) -replace "^password=", "" | Select-Object -First 1).Trim()

$headers = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github+json"
}

if (-not (Test-Path (Join-Path $repoRoot "dist\wechat-science-writer.skill"))) {
    & (Join-Path $repoRoot "scripts\package-skill.ps1") -Version "1.0.0"
    Copy-Item (Join-Path $repoRoot "dist\wechat-science-writer-1.0.0.skill") (Join-Path $repoRoot "dist\wechat-science-writer.skill") -Force
}

$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases/$ReleaseId" -Headers $headers
$name = "wechat-science-writer.skill"
$path = Join-Path $repoRoot "dist\$name"
$uploadUrl = "https://uploads.github.com/repos/$Owner/$Repo/releases/$ReleaseId/assets?name=$name"

try {
    $resp = Invoke-WebRequest -Uri $uploadUrl -Method Post -Headers @{
        Authorization = "Bearer $token"
        "User-Agent"  = "RTCartist-release-uploader"
    } -ContentType "application/octet-stream" -InFile $path -UseBasicParsing
    Write-Host "Uploaded: $name (HTTP $($resp.StatusCode))"
}
catch {
    Write-Host "Upload failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Manual fix: open $($release.html_url) -> Edit -> attach:" -ForegroundColor Yellow
    Write-Host "  $path"
    exit 1
}

$check = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases/tags/v1.0.0" -Headers $headers
if ($check.assets.Count -gt 0) {
    Write-Host "Verified assets on release:"
    $check.assets | ForEach-Object { Write-Host "  - $($_.name) ($([int]($_.size/1KB)) KB)" }
}
else {
    Write-Host "Warning: release still shows no assets. Use manual upload on GitHub." -ForegroundColor Yellow
    exit 1
}

Write-Host "Release: $($release.html_url)"
