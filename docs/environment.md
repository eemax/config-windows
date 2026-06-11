# Environment Variables

Use persistent user environment variables for machine-level agent settings that
should survive reboot and be visible to new shells.

## Commands

Set a variable for the current user:

```powershell
[Environment]::SetEnvironmentVariable("NAME", "value", "User")
```

Read a user variable:

```powershell
[Environment]::GetEnvironmentVariable("NAME", "User")
```

Delete a user variable:

```powershell
[Environment]::SetEnvironmentVariable("NAME", $null, "User")
```

Set a variable for the current shell only:

```powershell
$env:NAME = "value"
```

Machine-wide variables use the `Machine` target and require an elevated shell:

```powershell
[Environment]::SetEnvironmentVariable("NAME", "value", "Machine")
```

Open a new terminal after setting persistent variables. Existing shells keep
their current process environment until updated manually.

## Agent Variables

Current persistent user variables:

```text
CENTRIC_API_HOME=C:\Users\maxim\dev\runtime\centric-api
CARGO_HOME=C:\Users\maxim\scoop\persist\rustup\.cargo
RUSTUP_HOME=C:\Users\maxim\.rustup
```

`CENTRIC_API_HOME` intentionally points to the `centric-api` directory inside
the `runtime` repo. The standalone clone also exists at
`C:\Users\maxim\dev\centric-api`, but it is not the current value.

## Script

Apply the standard persistent user variables:

```powershell
.\scripts\set-agent-env.ps1
```

Apply them to the current shell too:

```powershell
.\scripts\set-agent-env.ps1 -UpdateCurrentProcess
```

Add or update one variable interactively:

```powershell
.\scripts\add-user-env.ps1 -UpdateCurrentProcess
```

Add or update one variable non-interactively:

```powershell
.\scripts\add-user-env.ps1 -Name CENTRIC_API_HOME -Value "C:\Users\maxim\dev\runtime\centric-api" -UpdateCurrentProcess
```

Delete one variable:

```powershell
.\scripts\add-user-env.ps1 -Name OLD_VAR -Delete -UpdateCurrentProcess
```

Do not use this helper for secrets unless you are comfortable with the value
being visible in shell history and process logs. For secrets, prefer a password
manager or a dedicated credential store.

