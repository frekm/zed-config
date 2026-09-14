$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoZed = Join-Path $RepoRoot "zed"
$ZedConfig = Join-Path $env:APPDATA "Zed"

New-Item -ItemType Directory -Force -Path $RepoZed | Out-Null

$Files = @(
    "settings.json",
    "keymap.json",
    "tasks.json",
    "debug.json"
)

foreach ($File in $Files) {
    $Source = Join-Path $ZedConfig $File
    $Target = Join-Path $RepoZed $File

    if (Test-Path $Source) {
        if (Test-Path $Target) {
            Remove-Item -Path $Target -Force
        }
        Copy-Item -Path $Source -Destination $Target -Force
    }
}
