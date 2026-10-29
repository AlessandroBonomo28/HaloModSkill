---
name: halo-reach-setup
description: "Set up, locate, verify, or reproduce an official Halo: Reach MCC Editing Kit workspace. Use for fresh-PC setup, HREK and Excession discovery, required-folder checks, portable project layout, or diagnosing missing tools. Do not use for mission logic, HSC compilation, cache builds, or runtime debugging; use halo-reach-modding for those tasks."
---

# Halo Reach Setup

Prepare a reproducible Halo: Reach MCC modding environment based on the official editing tools.

## Boundaries

- Use the official Halo: Reach MCC Editing Kit (HREK), MCC, and Excession.
- Never patch the retail executable, bypass anti-cheat, or present an anti-cheat workaround as part of the setup.
- Tell users to run custom content through MCC's supported anti-cheat-disabled launch option.
- Treat stock `data`, `tags`, maps, game binaries, and extracted assets as proprietary. Do not place them in a public repository.
- Do not install, download, copy large game content, or change Steam configuration unless the user asked for it.
- Never assume a drive letter or Steam library path. Resolve every root from user input or read-only discovery.

## Workflow

1. Inventory the machine with read-only checks. Locate MCC, the official Reach editing kit, and Excession independently; they may live in different Steam libraries.
2. Read [installation.md](references/installation.md) for a new installation or migration.
3. Resolve the HREK root and verify its executables, managed assemblies, and `data`, `tags`, and `maps` directories.
4. Run `scripts/check-reach-environment.ps1` and report the exact detected paths and missing components.
5. Keep the retail MCC installation, a pristine HREK installation, and project workspaces conceptually separate. Prefer a disposable project copy or a documented backup strategy for destructive experiments.
6. Read [workspace-layout.md](references/workspace-layout.md) before creating a Git repository or moving a project to another PC.
7. If a tool is absent, Sapien rejects a file, or Steam does not expose the tools, use [troubleshooting.md](references/troubleshooting.md).
8. End with a short environment report: verified roots, tools found, missing requirements, and the next safe command or UI action.

## Environment check

Run from PowerShell:

```powershell
& .\scripts\check-reach-environment.ps1 -HrekRoot '<HREK root>' -MccRoot '<MCC root>' -ExcessionRoot '<Excession root>'
```

Only `HrekRoot` is required. Omit optional roots instead of inventing them. The script is read-only and returns a nonzero exit code when required HREK components are missing.

## Handoff to content work

Once the environment is verified, switch to `$halo-reach-modding`. Pass it:

- the verified HREK root;
- the exact scenario tag path relative to `tags`;
- the canonical source location, if the project uses one;
- the intended output map and package directory.
