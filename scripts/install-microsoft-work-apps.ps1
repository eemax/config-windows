[CmdletBinding()]
param(
    [switch]$InstallOfficeCore,
    [switch]$SkipTeams,
    [switch]$SkipOneDrive,
    [ValidateSet("O365BusinessRetail", "O365ProPlusRetail")]
    [string]$OfficeProductId = "O365BusinessRetail"
)

$ErrorActionPreference = "Stop"

function Invoke-WingetInstall {
    param(
        [Parameter(Mandatory)][string]$Id,
        [string[]]$ExtraArgs = @()
    )

    $args = @(
        "install",
        "--id", $Id,
        "--exact",
        "--accept-package-agreements",
        "--accept-source-agreements"
    ) + $ExtraArgs

    Write-Host "winget $($args -join ' ')"
    winget @args
}

if (-not $SkipTeams) {
    Invoke-WingetInstall -Id "Microsoft.Teams"
}

if (-not $SkipOneDrive) {
    Invoke-WingetInstall -Id "Microsoft.OneDrive"
}

if ($InstallOfficeCore) {
    $templatePath = Resolve-Path (Join-Path $PSScriptRoot "..\office\microsoft-365-core-only.xml")
    $workDir = Join-Path $env:TEMP "office-deployment-tool"
    New-Item -ItemType Directory -Force -Path $workDir | Out-Null

    $configPath = Join-Path $workDir "microsoft-365-core-only.generated.xml"
    $configXml = Get-Content -Raw -LiteralPath $templatePath
    $configXml = $configXml -replace 'Product ID="[^"]+"', "Product ID=`"$OfficeProductId`""
    Set-Content -LiteralPath $configPath -Value $configXml -Encoding UTF8

    Invoke-WingetInstall -Id "Microsoft.OfficeDeploymentTool" -ExtraArgs @("--location", $workDir)

    $setup = Get-ChildItem -Path $workDir -Filter "setup.exe" -Recurse -File |
        Select-Object -First 1

    if (-not $setup) {
        throw "Office Deployment Tool setup.exe was not found under $workDir"
    }

    $principal = [Security.Principal.WindowsPrincipal]::new([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    Write-Host "Installing Microsoft 365 core apps with $configPath"
    Write-Host "Office product ID: $OfficeProductId"

    if ($isAdmin) {
        & $setup.FullName /configure $configPath
    }
    else {
        Write-Host "Launching elevated Office Deployment Tool. Approve the UAC prompt to continue."
        Start-Process -FilePath $setup.FullName -ArgumentList @("/configure", $configPath) -Verb RunAs -Wait
    }
}
else {
    Write-Host "Skipping Microsoft 365 Apps install. Pass -InstallOfficeCore to install Word, Excel, and PowerPoint only."
}
