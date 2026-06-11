[CmdletBinding()]
param()

$ErrorActionPreference = "Continue"

$commands = @(
    @{ Name = "git"; Command = "git --version" },
    @{ Name = "pwsh"; Command = "pwsh -NoLogo -NoProfile -Command `$PSVersionTable.PSVersion.ToString()" },
    @{ Name = "python"; Command = "python --version" },
    @{ Name = "python3.12"; Command = "python3.12 --version" },
    @{ Name = "python3.13"; Command = "python3.13 --version" },
    @{ Name = "uv"; Command = "uv --version" },
    @{ Name = "ruff"; Command = "ruff --version" },
    @{ Name = "black"; Command = "black --version" },
    @{ Name = "node"; Command = "node --version" },
    @{ Name = "npm"; Command = "npm.cmd --version" },
    @{ Name = "pnpm"; Command = "pnpm --version" },
    @{ Name = "yarn"; Command = "yarn --version" },
    @{ Name = "bun"; Command = "bun --version" },
    @{ Name = "deno"; Command = "deno --version" },
    @{ Name = "tsc"; Command = "tsc --version" },
    @{ Name = "tsx"; Command = "tsx --version" },
    @{ Name = "eslint"; Command = "eslint --version" },
    @{ Name = "prettier"; Command = "prettier --version" },
    @{ Name = "pyright"; Command = "pyright --version" },
    @{ Name = "rustc"; Command = "rustc --version" },
    @{ Name = "cargo"; Command = "cargo --version" },
    @{ Name = "go"; Command = "go version" },
    @{ Name = "gcc"; Command = "gcc --version" },
    @{ Name = "cmake"; Command = "cmake --version" },
    @{ Name = "ninja"; Command = "ninja --version" },
    @{ Name = "make"; Command = "make --version" },
    @{ Name = "rg"; Command = "rg --version" },
    @{ Name = "fd"; Command = "fd --version" },
    @{ Name = "jq"; Command = "jq --version" },
    @{ Name = "yq"; Command = "yq --version" },
    @{ Name = "fzf"; Command = "fzf --version" },
    @{ Name = "gh"; Command = "gh --version" },
    @{ Name = "sqlite"; Command = "sqlite3 --version" },
    @{ Name = "openssl"; Command = "openssl version" }
)

foreach ($item in $commands) {
    Write-Host "== $($item.Name) =="
    powershell -NoProfile -ExecutionPolicy Bypass -Command $item.Command 2>&1 | Select-Object -First 3
}

Write-Host "== rust smoke test =="
$rustDir = Join-Path $PSScriptRoot "..\work\verify-rust"
if (Test-Path $rustDir) {
    Remove-Item -LiteralPath $rustDir -Recurse -Force
}
cargo new $rustDir --bin | Out-Host
Push-Location $rustDir
cargo run --quiet | Out-Host
Pop-Location

Write-Host "== go smoke test =="
$goDir = Join-Path $PSScriptRoot "..\work\verify-go"
New-Item -ItemType Directory -Force -Path $goDir | Out-Null
$goFile = Join-Path $goDir "main.go"
@'
package main
import "fmt"
func main() { fmt.Println("go-ok") }
'@ | Set-Content -Path $goFile -Encoding ASCII
go run $goFile | Out-Host

