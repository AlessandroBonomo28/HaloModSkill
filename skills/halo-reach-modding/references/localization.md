# Localization and multilingual strings

HaloScript normally references a `string_id`; it does not embed the displayed sentence directly. Compilation and runtime display can consult different multilingual string lists.

## Safe workflow

1. Identify the exact `string_id` used by the HSC or scenario field.
2. Determine which list the compiler uses to validate that ID.
3. Determine which level-local or shared list supplies the runtime text.
4. Back up and hash every list that will change.
5. Register the ID in the compiler-visible list when required.
6. Add the desired text to each supported language in the runtime list.
7. Preserve the format expected by the multilingual tag: language offsets, terminators, encoding, and `-1` for genuinely unused entries.
8. Save through Foundation or supported automation, rebuild, and test the exact MCC language.

For English as the neutral/default language and Italian support, every custom objective/title should have both entries. Do not leave Italian text in the English slot as a temporary shortcut before release.

## Common traps

- Foundation's language selector changes the displayed column; identical English and Italian rows can mean both language offsets point to the same text or the wrong entries were imported.
- A compiler error about an unknown `string_id` can come from a shared/global validation list even when runtime text belongs in a level-local list.
- Replacing same-length bytes in an unrelated shared tag can silently change other missions and is not a safe localization method.
- Absence of readable text in a `.map` search does not prove localization failed; packed strings may not remain plain ASCII/UTF-8.
- Reusing an existing ID for a different objective can display the wrong title in only one mission or language.

## Verification matrix

Record, for each custom ID:

| String ID | English expected | Italian expected | Compile succeeds | EN runtime | IT runtime |
| --- | --- | --- | --- | --- | --- |
| `example_objective` | Objective text | Testo obiettivo | yes/no | pass/fail | pass/fail |

Test mission start, objective updates, checkpoints, and outro transitions in both languages. Localization can expose a script branch that was not reached in the other test.

