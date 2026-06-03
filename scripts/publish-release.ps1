#Requires -Version 5.1
<#
.SYNOPSIS
  Create GitHub Release v1.0.0 and upload .skill assets via REST API.
#>
[CmdletBinding()]
param(
    [string] $Tag = "v1.0.0",
    [string] $Version = "1.0.0",
    [string] $Owner = "RTCartist",
    [string] $Repo = "wechat-science-writer"
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$gcm = "D:\Git\mingw64\bin\git-credential-manager.exe"
if (-not (Test-Path $gcm)) {
    throw "git-credential-manager not found at $gcm"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$env:GCM_INTERACTIVE = "false"

$job = Start-Job { param($g) "protocol=https`nhost=github.com`n`n" | & $g get 2>&1 } -ArgumentList $gcm
Wait-Job $job -Timeout 25 | Out-Null
if ($job.State -eq "Running") { Stop-Job $job; throw "GitHub credential timeout" }
$out = Receive-Job $job | Out-String
$token = (($out -split "`n" | Where-Object { $_ -match "^password=" }) -replace "^password=", "" | Select-Object -First 1).Trim()
if (-not $token) { throw "Could not read GitHub token from credential manager." }

& (Join-Path $repoRoot "scripts\package-skill.ps1") -Version $Version
Copy-Item (Join-Path $repoRoot "dist\wechat-science-writer-$Version.skill") (Join-Path $repoRoot "dist\wechat-science-writer.skill") -Force

Set-Location $repoRoot
if (-not (git rev-parse $Tag 2>$null)) {
    git tag -a $Tag -m "$Tag`: first public release"
}
git push origin $Tag 2>&1 | Out-Host

$headers = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

$releaseBody = @"
## 首个公开发布

- Cursor Agent Skill：微信公众号科研导读写作
- 安装：下载 **wechat-science-writer.skill** 并在 Cursor 中导入
- 或使用 ``npx skills add RTCartist/wechat-science-writer@wechat-science-writer -g -y``
"@

$existing = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases/tags/$Tag" -Headers $headers -Method Get -ErrorAction SilentlyContinue
if ($existing.id) {
    Write-Host "Release $Tag already exists (id=$($existing.id)). Uploading assets..."
    $release = $existing
}
else {
    $payload = @{
        tag_name   = $Tag
        name       = $Tag
        body       = $releaseBody
        draft      = $false
        prerelease = $false
    } | ConvertTo-Json
    $release = Invoke-RestMethod -Uri "https://api.github.com/repos/$Owner/$Repo/releases" -Headers $headers -Method Post -Body $payload -ContentType "application/json; charset=utf-8"
    Write-Host "Created release: $($release.html_url)"
}

$assets = @(
    (Join-Path $repoRoot "dist\wechat-science-writer.skill"),
    (Join-Path $repoRoot "dist\wechat-science-writer-$Version.skill")
)

foreach ($file in $assets) {
    $name = Split-Path $file -Leaf
    $uploadUrl = "https://uploads.github.com/repos/$Owner/$Repo/releases/$($release.id)/assets?name=$name"
    try {
        Invoke-WebRequest -Uri $uploadUrl -Method Post -Headers @{
            Authorization = "Bearer $token"
            "User-Agent"  = "RTCartist-release-uploader"
        } -ContentType "application/octet-stream" -InFile $file -UseBasicParsing | Out-Null
        Write-Host "Uploaded asset: $name"
    }
    catch {
        Write-Warning "Upload failed for $name ($($_.Exception.Message)). Upload manually on the Release page."
    }
}

Write-Host "Done: $($release.html_url)"
