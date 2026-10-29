# Scenario and generated resources

Reach scenarios can distribute runtime data across a main `.scenario` and generated `scenario_*_resource` tags. A value visible in the main tag is not automatically the authoritative runtime value.

## Practical rules

- Open the real main `.scenario` in Sapien.
- Expect Sapien to create, update, or move generated resource data as it saves the scenario.
- Back up the main scenario and every relevant generated scenario resource before an edit.
- Re-audit the saved tag/resource layer after Sapien or Foundation closes.
- Use Sapien for placements, spawns, encounters, and scenario-owned object state when possible.
- Reuse authored cutscene flags, object names, and locations that are valid in the currently loaded BSP/zone set.
- Verify the insertion point loads every BSP and designer zone needed by the new encounter.

## Why apparently valid edits disappear

An editor or script may change a field in the main scenario while cache building reads a generated resource copy. Conversely, Sapien can regenerate a resource and overwrite an external binary edit. Determine authority through save behavior, tag comparison, and runtime evidence rather than file naming alone.

ManagedBlam may not support saving every generated resource type. If a save fails, do not immediately raw-patch the binary. First try the official editor and inspect references/ownership. Binary patching is a last resort and requires:

1. an exact backup and hash;
2. known serialization and field width;
3. a minimal one-field proof;
4. reopen/audit in an official tool;
5. a cache build and runtime verification;
6. immediate rollback if any neighboring field changes.

## Spawns and encounters

For a new or moved spawn, validate more than coordinates:

- loaded BSP and zone set;
- insertion point and initial zone state;
- designer zone membership;
- character/template and equipment references;
- squad cell overrides;
- objective assignment and activation conditions;
- pathfinding and valid floor placement;
- host/client visibility in co-op.

Do not assume that a successful tag save means the engine will instantiate the actor or object.

