---
name: halo-reach-modding
description: "Build, edit, diagnose, verify, and package Halo: Reach MCC custom content with the official HREK. Use for HSC or scenario changes, Sapien script compilation, tag and split-resource edits, tool_fast cache builds, stale-bytecode diagnosis, localization, insertion and spawn changes, Excession packaging, or campaign and co-op test handoff. Use halo-reach-setup first when tools or roots are not ready."
---

# Halo Reach Modding

Work on Halo: Reach MCC custom content without modifying the retail executable.

## Safety and collaboration

- Use official HREK tools and MCC's anti-cheat-disabled mode for custom content.
- Preserve user changes and make backups before tag or scenario edits.
- Let the user perform gameplay, Sapien navigation, and other interactive tests unless they explicitly ask for desktop control.
- Do not claim co-op compatibility from a successful solo test. Test 1–4 player synchronization on real MCC clients.
- Never publish stock tags, maps, binaries, or extracted assets in a public source repository.

## Resolve the build contract first

Before editing, identify all of the following. Do not guess paths:

- HREK root;
- exact scenario path relative to `tags`, without the `.scenario` suffix when passed to `tool_fast`;
- canonical editable source and the HREK `data` copy;
- scenario tag and any generated scenario resource tags;
- expected output `.map`;
- installed or packaged mod directory;
- current version/build identity.

When two HSC copies exist, compare hashes, modification times, and known probe names before deciding which is authoritative. If they diverge, preserve both and ask or infer from build evidence; never overwrite one blindly.

## Choose the correct pipeline

Use **Pipeline A** when HSC changed, a scenario was cloned, compiled script state is uncertain, or stale bytecode is suspected. It requires Sapien **Compile Scripts** followed by **Save** before `tool_fast`.

Use **Pipeline B** only for confirmed tag-only edits. It deliberately does not compile HSC and must retain the previous successful script probe.

Follow [build-pipelines.md](references/build-pipelines.md) exactly. Use `scripts/verify-reach-build.ps1` to check hashes, timestamps, probes, and build logs before installing a package.

## Route the task

- Script compilation, cache builds, versioning, and verification: [build-pipelines.md](references/build-pipelines.md)
- Black screens, stale scripts, wrong spawns, missing AI, or old maps: [diagnostics.md](references/diagnostics.md)
- Main scenario versus generated resource tags and runtime-authoritative data: [scenario-resources.md](references/scenario-resources.md)
- English/Italian or other multilingual strings and `string_id` behavior: [localization.md](references/localization.md)
- Excession, campaign metadata, previews, installation, and Workshop release: [packaging.md](references/packaging.md)

## Verification standard

A build is not complete merely because a `.map` exists. Require evidence appropriate to the change:

1. canonical and HREK source hashes match when both exist;
2. Sapien saved the intended scenario after script compilation for Pipeline A;
3. `tool_fast` exited successfully and its log contains the cache-build success line;
4. a unique compiled-script probe is present in both the scenario tag and map for Pipeline A;
5. the new map hash differs from the previous installed build when a runtime change was expected;
6. MCC launches a fresh mission rather than an old checkpoint;
7. every affected language and co-op path is tested explicitly.

Record the scenario path, map hash, package version, and test result so a later machine can reproduce the build.
