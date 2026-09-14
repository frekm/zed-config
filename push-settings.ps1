$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoZed = Join-Path $RepoRoot "zed"
$ZedConfig = Join-Path $env:APPDATA "Zed"
$Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

New-Item -ItemType Directory -Force -Path $ZedConfig | Out-Null

$Files = @(
    "settings.json",
    "keymap.json",
    "tasks.json",
    "debug.json"
)

foreach ($File in $Files) {
    $Source = Join-Path $RepoZed $File
    $Target = Join-Path $ZedConfig $File

    if (-not (Test-Path $Source)) {
        continue
    }

    if (Test-Path $Target) {
        $BaseName = [System.IO.Path]::GetFileNameWithoutExtension($File)
        $Extension = [System.IO.Path]::GetExtension($File)
        $Backup = Join-Path $ZedConfig "${BaseName}.bkp_${Timestamp}${Extension}"
        Copy-Item -Path $Target -Destination $Backup -Force
        Remove-Item -Path $Target -Force
    }

    Copy-Item -Path $Source -Destination $Target -Force
}
