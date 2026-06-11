[CmdletBinding()]
param(
    [string]$Name,
    [string]$Value,
    [switch]$UpdateCurrentProcess,
    [switch]$Delete
)

$ErrorActionPreference = "Stop"

if (-not $Name) {
    $Name = Read-Host "Variable name"
}

if (-not $Name -or $Name -notmatch '^[A-Za-z_][A-Za-z0-9_]*$') {
    throw "Environment variable names must start with a letter or underscore and contain only letters, numbers, and underscores."
}

if ($Delete) {
    [Environment]::SetEnvironmentVariable($Name, $null, "User")

    if ($UpdateCurrentProcess) {
        Remove-Item -Path "Env:$Name" -ErrorAction SilentlyContinue
    }

    Write-Host "Deleted user environment variable: $Name"
    exit 0
}

if (-not $PSBoundParameters.ContainsKey("Value")) {
    $Value = Read-Host "Value for $Name"
}

[Environment]::SetEnvironmentVariable($Name, $Value, "User")

if ($UpdateCurrentProcess) {
    Set-Item -Path "Env:$Name" -Value $Value
}

Write-Host "$Name=$Value"
Write-Host "Saved as a persistent user environment variable. Open a new terminal to inherit it."

