#Requires -Version 5.1
<#
.SYNOPSIS
  Package Cursor-importable .skill archive for GitHub Releases.

.DESCRIPTION
  Creates dist/wechat-science-writer.skill (ZIP) with SKILL.md at archive root.
  Includes references/ and templates/ only — not README, LICENSE, or this script.

.EXAMPLE
  .\scripts\package-skill.ps1
  .\scripts\package-skill.ps1 -Version "1.0.0"
#>
[CmdletBinding()]
param(
    [string] $Version = ""
)

$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$skillName = "wechat-science-writer"
$distDir = Join-Path $repoRoot "dist"
$skillMd = Join-Path $repoRoot "SKILL.md"

if (-not (Test-Path $skillMd)) {
    throw "SKILL.md not found. Run from repo root: .\scripts\package-skill.ps1"
}

$outBase = if ($Version) { "$skillName-$Version" } else { $skillName }
$skillPath = Join-Path $distDir "$outBase.skill"

if (Test-Path $distDir) {
    Remove-Item $distDir -Recurse -Force
}
New-Item -ItemType Directory -Path $distDir -Force | Out-Null

function Add-FileToZip {
    param(
        [System.IO.Compression.ZipArchive] $Archive,
        [string] $SourcePath,
        [string] $EntryName
    )
    $entry = $Archive.CreateEntry($EntryName.Replace("\", "/"), [System.IO.Compression.CompressionLevel]::Optimal)
    $stream = $entry.Open()
    try {
        $bytes = [System.IO.File]::ReadAllBytes($SourcePath)
        $stream.Write($bytes, 0, $bytes.Length)
    }
    finally {
        $stream.Dispose()
    }
}

function Add-DirectoryToZip {
    param(
        [System.IO.Compression.ZipArchive] $Archive,
        [string] $SourceDir,
        [string] $Prefix
    )
    Get-ChildItem -Path $SourceDir -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($SourceDir.Length).TrimStart("\", "/")
        $entryName = if ($Prefix) { "$Prefix/$relative" } else { $relative }
        Add-FileToZip -Archive $Archive -SourcePath $_.FullName -EntryName $entryName
    }
}

$zip = [System.IO.Compression.ZipFile]::Open($skillPath, [System.IO.Compression.ZipArchiveMode]::Create)

try {
    Add-FileToZip -Archive $zip -SourcePath $skillMd -EntryName "SKILL.md"

    foreach ($dir in @("references", "templates")) {
        $fullDir = Join-Path $repoRoot $dir
        if (Test-Path $fullDir) {
            Add-DirectoryToZip -Archive $zip -SourceDir $fullDir -Prefix $dir
        }
    }

    $entryCount = $zip.Entries.Count
    $bytes = (Get-Item $skillPath).Length
    Write-Host "Packaged: $skillPath"
    Write-Host "  $entryCount entries, $bytes bytes"
    Write-Host "Upload to: https://github.com/RTCartist/wechat-science-writer/releases"
}
finally {
    $zip.Dispose()
}
