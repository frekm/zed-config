# Zed Config

Version-controlled Zed configuration for Windows.

Configuration files are stored here and hard-linked into `%APPDATA%\Zed`.

## Structure

```text
zed-config/
├── .gitignore
├── README.md
├── setup.ps1
└── zed/
    ├── settings.json
    ├── keymap.json
    ├── tasks.json
    └── debug.json
```

## Setup

```powershell
git clone https://github.com/frekm/zed-config.git
cd zed-config
.\setup.ps1
```

`zed-config` and `%APPDATA%\Zed` must reside on the same drive/volume.

Close Zed before running the script.

The script creates `%APPDATA%\Zed`, backs up existing files with a timestamp,
removes them, and creates hard links to the repository files.

## Backups

Existing files are backed up before being replaced, e.g.,:

```text
settings.bkp_20260904_100812.json
```

Backups remain in `%APPDATA%\Zed` and are not version controlled.

## Adding files

Add the file to `zed/`, the filename to `$Files` in `setup.ps1`, and an
exception to `.gitignore`.

## Git

```powershell
git add .
git commit -m "Update Zed config"
git push
```

On another machine:

```powershell
git pull
```

Because the files are hard-linked, changes are shared between the repository and
Zed's configuration directory.
