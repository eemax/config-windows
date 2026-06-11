# Agent-friendly PowerShell profile.

$agentPaths = @(
    "$env:USERPROFILE\scoop\shims",
    "$env:USERPROFILE\scoop\apps\git\current\cmd",
    "$env:USERPROFILE\scoop\apps\nodejs-lts\current",
    "$env:USERPROFILE\scoop\apps\nodejs-lts\current\bin",
    "$env:USERPROFILE\scoop\persist\rustup\.cargo\bin",
    "$env:USERPROFILE\scoop\persist\uv\python\shims",
    "$env:USERPROFILE\scoop\persist\uv\tools\shims",
    "$env:USERPROFILE\.local\bin",
    "$env:USERPROFILE\go\bin"
)

$env:Path = (($agentPaths + ($env:Path -split ";")) | Where-Object { $_ } | Select-Object -Unique) -join ";"

Set-Alias ll Get-ChildItem
Set-Alias grep rg
Set-Alias find fd

$env:BAT_THEME = "TwoDark"
$env:RUSTUP_HOME = "$env:USERPROFILE\.rustup"
$env:CARGO_HOME = "$env:USERPROFILE\scoop\persist\rustup\.cargo"

function gs { git status --short --branch }
function ga { git add @args }
function gcmsg { git commit -m @args }
function gp { git push @args }
function gl { git log --oneline --decorate --graph -20 }

