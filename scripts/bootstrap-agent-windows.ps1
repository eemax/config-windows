[CmdletBinding()]
param(
    [switch]$SkipScoopInstall
)

$ErrorActionPreference = "Stop"

function Add-UserPath {
    param([Parameter(Mandatory)][string[]]$Paths)

    $current = [Environment]::GetEnvironmentVariable("Path", "User")
    $parts = @()
    if ($current) {
        $parts = $current -split ";" | Where-Object { $_ }
    }

    foreach ($path in $Paths) {
        $expanded = [Environment]::ExpandEnvironmentVariables($path)
        if ($parts -notcontains $expanded) {
            $parts += $expanded
        }
    }

    [Environment]::SetEnvironmentVariable("Path", ($parts -join ";"), "User")
}

if (-not $SkipScoopInstall -and -not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

$env:Path = "$env:USERPROFILE\scoop\shims;$env:USERPROFILE\scoop\apps\git\current\cmd;$env:Path"

scoop install git 7zip aria2
scoop config aria2-enabled true

$packages = @(
    "python", "uv",
    "nodejs-lts", "pnpm", "yarn", "deno", "bun",
    "rustup", "go",
    "cmake", "ninja", "make", "mingw", "llvm", "pkg-config", "openssl-lts-light",
    "ripgrep", "fd", "jq", "yq", "fzf", "gh", "bat", "delta", "sd", "sqlite", "less",
    "pwsh"
)

foreach ($package in $packages) {
    scoop install $package
}

$pathEntries = @(
    "%USERPROFILE%\scoop\shims",
    "%USERPROFILE%\scoop\apps\git\current\cmd",
    "%USERPROFILE%\scoop\apps\python\current",
    "%USERPROFILE%\scoop\apps\python\current\Scripts",
    "%USERPROFILE%\scoop\persist\uv\python\shims",
    "%USERPROFILE%\scoop\persist\uv\tools\shims",
    "%USERPROFILE%\scoop\apps\nodejs-lts\current",
    "%USERPROFILE%\scoop\apps\nodejs-lts\current\bin",
    "%USERPROFILE%\scoop\apps\pnpm\current\bin",
    "%USERPROFILE%\scoop\apps\yarn\current\bin",
    "%USERPROFILE%\scoop\apps\yarn\current\global\node_modules\.bin",
    "%USERPROFILE%\scoop\persist\bun\bin",
    "%USERPROFILE%\scoop\persist\rustup\.cargo\bin",
    "%USERPROFILE%\scoop\apps\mingw\current\bin",
    "%USERPROFILE%\scoop\apps\llvm\current\bin",
    "%USERPROFILE%\go\bin",
    "%USERPROFILE%\.local\bin"
)

Add-UserPath -Paths $pathEntries

$env:Path = (($pathEntries | ForEach-Object { [Environment]::ExpandEnvironmentVariables($_) }) + ($env:Path -split ";") | Select-Object -Unique) -join ";"

[Environment]::SetEnvironmentVariable("CARGO_HOME", "$env:USERPROFILE\scoop\persist\rustup\.cargo", "User")
[Environment]::SetEnvironmentVariable("RUSTUP_HOME", "$env:USERPROFILE\.rustup", "User")

uv python install 3.12 3.13
uv tool install ruff
uv tool install black
uv tool install pre-commit

npm.cmd install -g npm@latest
npm.cmd install -g typescript tsx eslint prettier pyright npm-check-updates

rustup.exe toolchain install stable-x86_64-pc-windows-gnu
rustup.exe default stable-x86_64-pc-windows-gnu

git config --global init.defaultBranch main
git config --global core.longpaths true
git config --global core.filemode false
git config --global pull.ff only

Write-Host "Bootstrap complete. Open a fresh terminal, then run scripts\verify-toolchain.ps1."

