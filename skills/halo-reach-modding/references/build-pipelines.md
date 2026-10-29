# Build pipelines

Compilation and cache building are separate operations. `tool_fast` packages the scenario state already saved in the tags; it does not replace Sapien's HSC compilation step.

## Pipeline A: HSC, clone, or stale-bytecode change

Use this pipeline when scripts changed, a level/scenario was cloned, compiled state is uncertain, or runtime behavior does not match source.

1. Close MCC, Tag Test, Sapien, and any process that could hold the scenario or map open.
2. Back up the exact scenario and relevant generated scenario resource tags.
3. Edit the canonical HSC source.
4. Add or change a unique ASCII probe such as `zz_probe_20261029_01`. The name must be harmless, unique to this build, and expected to survive compilation.
5. Synchronize the canonical HSC into the exact HREK `data` path. Verify SHA-256 equality.
6. Open the exact `.scenario` in Sapien.
7. Clear or note the Script Output window because old messages remain visible.
8. Run **Compile Scripts**. Require a clean result for the current attempt.
9. Save the scenario in Sapien. Compilation without Save does not reliably update the tag consumed by the cache build.
10. Verify that the scenario tag is newer than the synchronized HSC and contains the new probe.
11. Build from the HREK root:

```powershell
& .\tool_fast.exe build-cache-file '<scenario path relative to tags, without .scenario>' pc
```

12. Require exit code zero, the cache-build success line, and no current script compile errors or unexpected stripping of changed scripts.
13. Verify that the output map contains the same new probe and record its SHA-256 hash.
14. Increment the package version, install the new map, and verify the installed hash.
15. In MCC, start a **new mission**. Do not use Continue/Resume or an old checkpoint for the first verification.

Cloned scenarios require this pipeline even when their visible HSC text is byte-identical to the original. A clone can inherit compiled script blocks and startup state from its source scenario.

## Pipeline B: confirmed tag-only change

Use only when no HSC input or compiled script behavior changed.

1. Close processes that can hold the target files open.
2. Back up the exact main/resource tags to be edited.
3. Confirm the runtime-authoritative tag layer and save the change with Sapien, Foundation, or supported ManagedBlam automation.
4. Do not add a new HSC probe and do not compile scripts merely to make the build look newer.
5. Build the cache with `tool_fast`.
6. Confirm build success and verify the map still contains the previous known-good script probe.
7. Record old/new tag and map hashes, bump the package version, install, and test a fresh mission.

If the prior probe disappears or behavior suggests compiled state changed, stop and return to Pipeline A.

## Temporary tag replacement

Some tool operations require a temporary reference or tag swap. Use a guarded sequence:

1. calculate the original file hash;
2. make a uniquely named backup;
3. perform the temporary operation;
4. restore in a `finally` path even when the build fails;
5. verify the restored file hash equals the original.

Never leave a shared/global tag modified merely because the final map built successfully.

## Build verification

Use the included verifier after Pipeline A:

```powershell
& .\scripts\verify-reach-build.ps1 `
  -CanonicalHsc '<canonical .hsc>' `
  -HrekHsc '<HREK data .hsc>' `
  -ScenarioTag '<compiled .scenario>' `
  -MapFile '<output .map>' `
  -BuildLog '<tool_fast log>' `
  -Probe 'zz_probe_...'
```

For Pipeline B, pass the last known-good probe and omit HSC paths if the source did not change. Add `-ForbiddenLogPattern` values for changed script names that must not be stripped.

