# Current Machine State

Snapshot for Maxim's Windows workstation as configured on 2026-06-11.

## Repo Home

Durable development repos live under:

```text
C:\Users\maxim\dev
```

Current repos:

- `C:\Users\maxim\dev\texet-dpp`
- `C:\Users\maxim\dev\centric-api`
- `C:\Users\maxim\dev\runtime`
- `C:\Users\maxim\dev\config-windows`

The Codex chat workspace under `Documents\Codex\...` is scratch space and
should not be used as the durable clone location.

## Core Toolchain

Installed with Scoop under `C:\Users\maxim\scoop`:

- `7zip` 26.01
- `aria2` 1.37.0-1
- `bat` 0.26.1
- `bun` 1.3.14
- `cacert` 2026-05-14
- `cmake` 4.3.3
- `delta` 0.19.2
- `deno` 2.8.2
- `fd` 10.4.2
- `fzf` 0.73.1
- `gh` 2.93.0
- `git` 2.54.0
- `go` 1.26.4
- `jq` 1.8.1
- `less` 704
- `llvm` 22.1.7
- `make` 4.4.1
- `mingw` 16.1.0
- `ninja` 1.13.2
- `nodejs-lts` 24.16.0
- `openssl-lts-light` 3.0.21
- `pkg-config` 0.26-1
- `pnpm` 11.5.3
- `pwsh` 7.6.2
- `python` 3.14.6
- `ripgrep` 15.1.0
- `rustup` 1.29.0
- `sd` 1.1.0
- `sqlite` 3.53.2
- `uv` 0.11.19
- `yarn` 1.22.22
- `yq` 4.53.3

Also configured:

- uv-managed Python 3.12 and 3.13
- npm globals: `typescript`, `tsx`, `eslint`, `prettier`, `pyright`, `npm-check-updates`
- uv tools: `ruff`, `black`, `pre-commit`
- GitHub CLI authenticated as `eemax`
- Rust default toolchain: `stable-x86_64-pc-windows-gnu`

## PATH And Rust

User environment:

```text
CARGO_HOME=C:\Users\maxim\scoop\persist\rustup\.cargo
RUSTUP_HOME=C:\Users\maxim\.rustup
```

Important user PATH entries include:

```text
C:\Users\maxim\scoop\apps\llvm\current\bin
C:\Users\maxim\scoop\apps\mingw\current\bin
C:\Users\maxim\go\bin
C:\Users\maxim\scoop\persist\bun\bin
C:\Users\maxim\scoop\apps\yarn\current\global\node_modules\.bin
C:\Users\maxim\scoop\apps\yarn\current\bin
C:\Users\maxim\scoop\apps\pnpm\current\bin
C:\Users\maxim\scoop\apps\nodejs-lts\current\bin
C:\Users\maxim\scoop\apps\nodejs-lts\current
C:\Users\maxim\scoop\persist\uv\tools\shims
C:\Users\maxim\scoop\persist\uv\python\shims
C:\Users\maxim\scoop\apps\python\current\Scripts
C:\Users\maxim\scoop\apps\python\current
C:\Users\maxim\scoop\apps\git\current\cmd
C:\Users\maxim\scoop\shims
C:\Users\maxim\.local\bin
C:\Users\maxim\scoop\persist\rustup\.cargo\bin
```

## Microsoft Apps

Installed:

- Microsoft Teams work/school: `Microsoft.Teams` 26134.1702.4747.7366
- Microsoft OneDrive sync client: `Microsoft.OneDrive` 26.088.0510.0004
- Word
- Excel
- PowerPoint
- Windows-shipped Outlook app
- Outlook classic is currently installed because the first Office ODT run
  included it before the config was tightened.

Future Office installs from this repo exclude Outlook classic. The intended
repeatable Office set is Word, Excel, and PowerPoint only.
