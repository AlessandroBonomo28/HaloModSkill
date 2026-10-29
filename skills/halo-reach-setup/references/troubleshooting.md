# Setup troubleshooting

## Steam does not show the editing kit or Excession

- Enable the **Tools** filter in the Steam Library.
- Confirm the account owns MCC and the Halo: Reach content.
- Search for the official tool by its full name, not only for “Halo”.
- Restart Steam after the game entitlement or DLC changes.
- Do not download tool binaries from an untrusted mirror to fill a missing installation.

## Sapien says “you tried to open a non scenario”

Select a real `.scenario` tag under the HREK `tags` tree. Do not select:

- a compiled `.map`;
- a source file under `data`;
- a generated `scenario_*_resource` tag;
- a similarly named BSP, lightmap, or object tag.

Sapien may display paths without obvious extensions. Verify the actual file path before retrying.

## A tool opens and immediately closes

- Start GUI tools from Steam once to install prerequisites.
- Verify the HREK root with `check-reach-environment.ps1`.
- Confirm `data`, `tags`, `maps`, and required DLLs come from one matching tool version.
- When using a command-line tool, run it in a terminal so its error output remains visible.
- Avoid copying a single executable into another HREK tree; dependencies and tag layouts must match.

## MCC reports a security or anti-cheat error

Close MCC and launch it through the supported anti-cheat-disabled option intended for mods. Do not patch the executable or attempt to bypass anti-cheat. Keep modded content out of protected matchmaking.

## Excession cannot upload

- Confirm Steam is running and signed in.
- Verify that Excession was launched through its official installation.
- Make sure the package has valid metadata, a version, and required images.
- If Upload is disabled, save the project and refresh Excession after Steam finishes connecting.

## Paths contain spaces

Use PowerShell `-LiteralPath` and quote complete command arguments. Never build a destructive command by concatenating unresolved paths or wildcards.

