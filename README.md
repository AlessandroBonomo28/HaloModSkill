# HaloModSkill

Reusable Codex skills for setting up and working with the official **Halo: Reach MCC Editing Kit**.

This repository contains instructions and read-only verification scripts. It does **not** contain Halo assets, stock tags, maps, game binaries, or tools.

## Skills

| Skill | Use it for |
| --- | --- |
| `halo-reach-setup` | Installing, locating, verifying, and reproducing an HREK workspace on a new PC. |
| `halo-reach-modding` | Editing HSC/tags/scenarios, compiling scripts, building maps, diagnosing runtime problems, localization, and Excession packaging. |

The split is intentional: machine setup is stable and reusable, while mission development needs a stricter edit–compile–build–test loop. Each skill is self-contained and can be installed independently.

## Requirements

- Halo: The Master Chief Collection with Halo: Reach content
- The official Halo: Reach MCC Editing Kit / Mod Tools
- Excession for MCC mod packages and Steam Workshop uploads
- Windows PowerShell 5.1 or newer for the included checks

Custom content must be launched through MCC's supported **anti-cheat-disabled** option. These skills do not patch MCC, bypass anti-cheat, or modify the retail executable.

## Agent installation guides

The skill bundles use the portable `SKILL.md` layout. Install the same `skills/halo-reach-setup` and `skills/halo-reach-modding` folders using the guide for your harness:

| Agent or runtime | Guide |
| --- | --- |
| OpenAI Codex | [docs/codex.md](docs/codex.md) |
| Claude Code | [docs/claudecode.md](docs/claudecode.md) |
| DeepSeek Harness | [docs/deepseekharness.md](docs/deepseekharness.md) |
| Hermes Agent | [docs/hermes.md](docs/hermes.md) |
| Unsloth local models | [docs/unsloth.md](docs/unsloth.md) |

For a repository shared between several compatible agents, `.agents/skills/` is the preferred common project location. Harness-specific directories can be used when precedence or isolation matters.

## Quick start

Prepare a machine:

```text
Use $halo-reach-setup to verify my official Halo Reach editing-kit installation and propose a clean workspace layout.
```

Work on a mod:

```text
Use $halo-reach-modding to inspect this scenario, choose the correct build pipeline, build it, and give me the exact runtime tests to perform.
```

## Publishing an MCC mod

The Steam application is named **Halo MCC Mod Uploader**. The tool and executable used by the official documentation are called **Excession**. They are the same publishing workflow: Excession creates MCC package metadata, lets MCC discover the package locally, and uploads the completed folder to Steam Workshop.

An **MCC mod package** is a self-contained folder, not merely a `.map` file. Its exact contents depend on whether it provides Campaign, Multiplayer, or Firefight content, but a campaign package commonly resembles:

```text
My Reach Mod/
  ModInfo.json
  CampaignInfo.json
  campaign/
    mission-name.json
  maps/
    mission-name.map
  images/
    thumbnail.png
    large.png
    loading.png
```

Excession creates and maintains the JSON metadata. You supply the finished cache maps and original images. Keep the mod folder directly under one of Excession's configured root folders; deeper nesting may prevent discovery.

### Build and package

1. Finish the HREK build first. For an HSC change, compile scripts and save the exact scenario in Sapien before running `tool_fast build-cache-file`.
2. Verify the resulting map hash and test a fresh mission with anti-cheat disabled.
3. Open **Halo MCC Mod Uploader / Excession**, configure a mod root, and select **CREATE**.
4. Choose the final mod folder carefully. Excession makes this field read-only after creation.
5. Enter title, description, semantic version, target game (**Halo: Reach**), and the appropriate Campaign, Multiplayer, or Firefight section.
6. Put every `.map` in the package's `maps/` folder.
7. For each map, set **Scenario File Name** to the source scenario path relative to the HREK `tags/` folder, without `.scenario`. Do not enter the `.map` filename. Example: `levels/my_mod/my_mission`.
8. Add campaign missions, insertion points, player limits, previews, and loading screens. Click outside a field before saving so the UI commits its current value, then use **File → Save All**.
9. Press **REFRESH** on the Home Screen and review the Trace List. Excession does not reliably validate that every map exists or that every Scenario File Name is correct, so check those manually.
10. Install or expose the package locally through MCC's mod configuration, restart MCC, and test **New Mission** rather than Resume/Continue.

Map thumbnail and large images belong inside the package and should be PNG; roughly 900 KB is recommended. Loading images should be high resolution, commonly 1920×1080 PNG. The separate Steam Workshop preview may be PNG or JPG, can live outside the package, and must be no larger than 1 MB.

### Upload to Steam Workshop

1. Start Steam and sign in. If Steam is closed or offline, Excession's **UPLOAD** button remains disabled.
2. Select the saved package on Excession's Home Screen and choose **UPLOAD**.
3. Review title and description, choose the Workshop preview, accept the Steam Workshop Contribution Agreement, and upload.
4. Open the item under your Steam profile's Workshop Items for Halo: MCC. Keep the first release private or unlisted.
5. Subscribe from a clean profile or second PC, launch MCC with anti-cheat disabled, and repeat solo, language, insertion-point, and real host/client co-op tests.
6. Make the item public only after the Workshop download reproduces the local package. All co-op players must use the same published version.

When updating an existing item, preserve its Workshop ID, increment the package version, replace the map deliberately, and verify the installed/Workshop map hash. Do not upload HREK executables, stock tags, credentials, local paths, or content you do not have permission to redistribute.

Official references: [Excession overview](https://learn.microsoft.com/en-us/halo-master-chief-collection/excession/excessionoverview), [folder structure](https://learn.microsoft.com/en-us/halo-master-chief-collection/excession/setup/folderstructure), [creating packages](https://learn.microsoft.com/en-us/halo-master-chief-collection/excession/creatingmodpackage/creatinghome), and [uploading a package](https://learn.microsoft.com/en-us/halo-master-chief-collection/excession/uploading/uploadinghome).

## Repository policy

Safe to commit:

- original `.hsc` files you authored;
- documentation, build manifests, hashes, and small metadata files;
- original Workshop images and package metadata;
- automation and verification scripts.

Do not commit:

- stock or modified Halo `tags/` and `data/` trees unless you have explicit redistribution rights;
- `.map` cache files, MCC/HREK executables, DLLs, or extracted proprietary content;
- local Steam paths, usernames, machine-specific configuration, or credentials.

Before publishing a mod, test it with anti-cheat disabled, start a new mission instead of resuming an autosave, verify every supported language, and perform real co-op tests if co-op is advertised.

## Scope

The current material focuses on Halo: Reach campaign-style custom content, but the setup and verification patterns also help with Firefight and multiplayer projects. Engine-specific assumptions must still be validated in the target game mode.
