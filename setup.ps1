$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ZedConfig = Join-Path $env:APPDATA "Zed"

New-Item -ItemType Directory -Force -Path $ZedConfig | Out-Null

$Files = @(
    "settings.json",
    "keymap.json",
    "tasks.json",
    "debug.json"
)

$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

foreach ($File in $Files) {
    $Source = Join-Path $RepoRoot "zed\$File"
    $Target = Join-Path $ZedConfig $File

    if (-not (Test-Path $Source)) {
        Write-Host "Skipping missing source: $Source"
        continue
    }

    if (Test-Path $Target) {
        $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File)
        $Extension = [System.IO.Path]::GetExtension($File)
        $BackupName = "${BaseName}.bkp_${Timestamp}${Extension}"
        $Backup = Join-Path $ZedConfig $BackupName

        Write-Host "Backing up: $Target -> $Backup"
        Copy-Item -Path $Target -Destination $Backup -Force

        Write-Host "Removing existing file: $Target"
        Remove-Item -Path $Target -Force
    }

    Write-Host "Hardlinking: $File"
    New-Item -ItemType HardLink -Path $Target -Target $Source | Out-Null
}

Write-Host ""
Write-Host "Zed configuration installed."
