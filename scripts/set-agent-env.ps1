[CmdletBinding()]
param(
    [switch]$UpdateCurrentProcess
)

$ErrorActionPreference = "Stop"

$variables = [ordered]@{
    CENTRIC_API_HOME = "$env:USERPROFILE\dev\runtime\centric-api"
    CARGO_HOME = "$env:USERPROFILE\scoop\persist\rustup\.cargo"
    RUSTUP_HOME = "$env:USERPROFILE\.rustup"
}

foreach ($name in $variables.Keys) {
    $value = $variables[$name]
    [Environment]::SetEnvironmentVariable($name, $value, "User")

    if ($UpdateCurrentProcess) {
        Set-Item -Path "Env:$name" -Value $value
    }

    Write-Host "$name=$value"
}

Write-Host "Persistent user environment variables updated. Open a new terminal to inherit them."

