# Runtime and build diagnostics

Start with evidence: exact scenario, source hashes, last clean Sapien compile, map hash, package version, insertion point, language, and whether MCC started fresh or resumed an autosave.

| Symptom | Likely evidence to check | Recovery |
| --- | --- | --- |
| HSC edits are ignored | HREK source hash differs; scenario predates HSC; new probe absent | Run Pipeline A: sync, Compile Scripts, Save, build, verify probe. |
| Cloned mission starts like its source | Clone retained compiled script blocks or insertion state | Compile and save the clone in its own scenario, then rebuild and start fresh. |
| Screen is black but audio/gameplay continues | Startup script faded out for a skipped cinematic and never restored video | Trace cinematic skip/startup branches and add an intentional fade-in at the correct state. |
| Level stalls during a zone transition | Script polls or forces an invalid zone set/BSP transition | Prefer authored insertion/zone transitions; validate loaded BSP and zone-set state before manual switching. |
| Sapien reports a non-scenario | Wrong file type selected | Open the real main `.scenario`, not a map, BSP, or generated resource. |
| Old compile errors remain visible | Sapien Script Output appends across attempts | Clear the pane or timestamp the current compile; judge only the latest block. |
| MCC looks stock or one build old | Wrong installed folder/map, unchanged version, or Resume/Continue loaded old state | Compare hashes, bump version, reinstall, delete/avoid stale autosave, start a new mission. |
| AI is absent or stationary | Encounter is outside loaded BSP/zone, designer zone is wrong, template/override mismatch, or objective/gate never activates | Inspect loaded zone set, encounter placement, squad template, cell overrides, objectives, and activation scripts. |
| An object/tag edit seems ignored | Main scenario is not runtime-authoritative for that field | Inspect generated scenario resource tags and edit/save through the proper tool. |
| Text is correct in one language only | Wrong multilingual list, offsets, or runtime language entry | Audit both compiler-visible SID registration and level-local runtime text; test each language. |
| Co-op works inconsistently | Host-only script/object assumptions or unsynchronized state | Test host/client separately; favor engine-synchronized objects, encounter state, and global mission variables. |

## Probe interpretation

A probe proves that a particular compiled source reached a binary; it does not prove that the script executed or that the correct insertion point called it. Pair probe evidence with a visible, reversible runtime behavior and the exact mission-start path.

Map string searches are not proof that every localized value or tag edit was packed. Strings may be encoded, deduplicated, compressed, or resolved from another tag. Use hashes, tag audits, and runtime tests together.

## Process and file locks

Before replacing maps or tags, check for MCC, Sapien, Tag Test, Foundation, Excession, and build processes. If an expected executable is open, stop and ask the user to close it. Do not delete or replace a live executable or locked map.

## Test handoff

Give the tester exact steps:

- launch anti-cheat disabled;
- package/version to select;
- mission and insertion point;
- new mission versus checkpoint;
- language and difficulty;
- visible expected results and failure screenshots/logs;
- for co-op, who hosts and what each client should observe.

