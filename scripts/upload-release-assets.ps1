#Requires -Version 5.1
param(
    [int] $ReleaseId = 333515548,
    [string] $Owner = "RTCartist",
    [string] $Repo = "wechat-science-writer"
)

$ErrorActionPreference = "Stop"
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

$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases/$ReleaseId" -Headers $headers
$files = @(
    "wechat-science-writer.skill",
    "wechat-science-writer-1.0.0.skill"
)

foreach ($name in $files) {
    $path = Join-Path $repoRoot "dist\$name"
    if (-not (Test-Path $path)) {
        & (Join-Path $repoRoot "scripts\package-skill.ps1") -Version "1.0.0"
        Copy-Item (Join-Path $repoRoot "dist\wechat-science-writer-1.0.0.skill") (Join-Path $repoRoot "dist\wechat-science-writer.skill") -Force
    }
    $uploadUrl = "https://uploads.github.com/repos/$Owner/$Repo/releases/$ReleaseId/assets?name=$name"
    curl.exe -sS -X POST `
        -H "Authorization: Bearer $token" `
        -H "Content-Type: application/octet-stream" `
        --data-binary "@$path" `
        $uploadUrl | Out-Null
    Write-Host "Uploaded: $name"
}

Write-Host "Release: $($release.html_url)"
