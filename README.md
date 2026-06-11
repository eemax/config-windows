# config-windows

Agent-optimized Windows setup notes, bootstrap scripts, and config templates.

This repo documents a native Windows developer environment tuned for coding
agents and fast human handoff: predictable tools, user-space installs, strong
CLI ergonomics, and minimal dependence on elevated installers.

## Goals

- Keep the core toolchain installable from a non-admin shell.
- Prefer modern, fast, open source CLIs.
- Make Python, TypeScript, Rust, Go, Git, and GitHub workflows ready by default.
- Keep PATH and shell state explicit so agents can recover quickly after reboot.
- Document elevated-only follow-ups separately instead of blocking the base setup.

## Baseline

The baseline package manager is [Scoop](https://scoop.sh), installed per-user.
Most tools live under:

```text
C:\Users\<you>\scoop
```

Durable repos should live under:

```text
C:\Users\<you>\dev
```

This keeps project clones out of transient Codex chat workspaces.

Primary tools:

- Shell: PowerShell 7 (`pwsh`)
- VCS: Git, GitHub CLI (`gh`)
- Python: `python`, `uv`, Python 3.12/3.13 compatibility interpreters
- JavaScript/TypeScript: Node LTS, npm, pnpm, yarn, bun, deno
- Rust: rustup with GNU toolchain by default on non-admin Windows
- Go: Go toolchain
- Native build: MinGW, LLVM, CMake, Ninja, Make, pkg-config, OpenSSL LTS light
- Search/edit/data: ripgrep, fd, jq, yq, fzf, bat, delta, sd, sqlite, less

Optional work apps:

- Microsoft Teams work/school through winget
- Microsoft OneDrive sync client through winget
- Microsoft 365 Apps through the Office Deployment Tool, configured as core
  apps only: Word, Excel, and PowerPoint

## Quick Start

Run from Windows PowerShell:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
.\scripts\bootstrap-agent-windows.ps1
```

Then open a fresh terminal and verify:

```powershell
.\scripts\verify-toolchain.ps1
```

Install repeatable Microsoft work apps:

```powershell
.\scripts\install-microsoft-work-apps.ps1
```

If Office is missing and should be installed as core apps only:

```powershell
.\scripts\install-microsoft-work-apps.ps1 -InstallOfficeCore
```

## Elevated Follow-Ups

These are useful, but intentionally outside the non-admin baseline:

- Visual Studio Build Tools with MSVC and Windows SDK
- Docker Desktop
- WSL

For agent work, the GNU Rust toolchain plus MinGW is enough for many native
builds without needing Visual Studio Build Tools.
