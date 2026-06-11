# Agent Operating Notes

## Shell Choice

Prefer `pwsh` for interactive work and Windows PowerShell compatibility checks
only when needed. Use explicit `.cmd` launchers when PowerShell execution policy
or shim resolution gets noisy, for example:

```powershell
npm.cmd --version
```

## Search And Inspection

Default to:

```powershell
rg "pattern"
fd name
bat path\to\file
jq . file.json
yq . file.yaml
```

Avoid slow recursive PowerShell scans unless `rg` or `fd` are unavailable.

## Repo Defaults

Recommended Git defaults:

```powershell
git config --global init.defaultBranch main
git config --global core.longpaths true
git config --global core.filemode false
git config --global pull.ff only
gh auth setup-git
```

## PATH Recovery

After installs or reboot, a fresh terminal should have the user PATH. For a
single current session, prepend the important paths:

```powershell
$paths = @(
  "$env:USERPROFILE\scoop\shims",
  "$env:USERPROFILE\scoop\apps\git\current\cmd",
  "$env:USERPROFILE\scoop\apps\nodejs-lts\current",
  "$env:USERPROFILE\scoop\apps\nodejs-lts\current\bin",
  "$env:USERPROFILE\scoop\persist\rustup\.cargo\bin",
  "$env:USERPROFILE\scoop\persist\uv\python\shims",
  "$env:USERPROFILE\scoop\persist\uv\tools\shims",
  "$env:USERPROFILE\.local\bin"
)
$env:Path = (($paths + ($env:Path -split ';')) | Select-Object -Unique) -join ';'
```

