# Toolchain Notes

## Package Manager

Use Scoop for user-space installs:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git 7zip aria2
```

If a download source behaves badly with segmented downloads:

```powershell
scoop config aria2-enabled false
```

## Core Packages

```powershell
scoop install `
  python uv `
  nodejs-lts pnpm yarn deno bun `
  rustup go `
  cmake ninja make mingw llvm pkg-config openssl-lts-light `
  ripgrep fd jq yq fzf gh bat delta sd sqlite less `
  pwsh
```

## Python

The current system shim may point to the newest Python available in Scoop. Keep
compatibility versions around with uv:

```powershell
uv python install 3.12 3.13
uv tool install ruff
uv tool install black
uv tool install pre-commit
```

Important PATH entries:

```text
C:\Users\<you>\scoop\persist\uv\python\shims
C:\Users\<you>\scoop\persist\uv\tools\shims
C:\Users\<you>\.local\bin
```

## TypeScript And JavaScript

Global tools:

```powershell
npm install -g npm@latest
npm install -g typescript tsx eslint prettier pyright npm-check-updates
```

Use project-local tooling whenever a repo has lockfiles and scripts. The globals
are for quick inspection, scaffolding, and agent scratch work.

## Rust

On non-admin Windows, default Rust to GNU so it can link through MinGW:

```powershell
rustup toolchain install stable-x86_64-pc-windows-gnu
rustup default stable-x86_64-pc-windows-gnu
```

Recommended environment variables:

```text
CARGO_HOME=C:\Users\<you>\scoop\persist\rustup\.cargo
RUSTUP_HOME=C:\Users\<you>\.rustup
```

## GitHub CLI

Authenticate with the browser flow:

```powershell
gh auth login --hostname github.com --git-protocol https --web --clipboard
gh auth setup-git
gh auth status
```

## Microsoft Work Apps

Teams work/school and the modern OneDrive sync client are installed through
official winget packages:

```powershell
winget install --id Microsoft.Teams --exact --accept-package-agreements --accept-source-agreements
winget install --id Microsoft.OneDrive --exact --accept-package-agreements --accept-source-agreements
```

Microsoft 365 Apps are optional because many managed Windows machines already
ship with some Office apps. If Word, Excel, or PowerPoint are missing, use the
Office Deployment Tool config at:

```text
office\microsoft-365-core-only.xml
```

That config installs the Microsoft 365 Apps product while excluding the bundled
apps we do not want in the agent workstation baseline:

- Access
- Bing integration
- Groove / legacy OneDrive for Business client
- Skype for Business / Lync
- OneDrive
- OneNote
- Outlook classic
- Publisher
- Teams bundled via Office

Outlook is expected to be the Windows-shipped Outlook app unless there is a
specific reason to install classic Outlook. OneDrive is managed separately with
`Microsoft.OneDrive`, and Teams is managed separately with `Microsoft.Teams`.
This keeps the work/school sync and chat clients explicit and repeatable.

Run:

```powershell
.\scripts\install-microsoft-work-apps.ps1
```

Use the Office switch only when Office core apps are not already installed:

```powershell
.\scripts\install-microsoft-work-apps.ps1 -InstallOfficeCore
```

The default Office product ID is `O365BusinessRetail`, which matches Microsoft
365 Business Standard and Business Premium. For Enterprise E3/E5 licensing, use:

```powershell
.\scripts\install-microsoft-work-apps.ps1 -InstallOfficeCore -OfficeProductId O365ProPlusRetail
```

Office installation is machine-level. If the shell is not elevated, the script
launches the Office Deployment Tool through UAC for the configure step.
