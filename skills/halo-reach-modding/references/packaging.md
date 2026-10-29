# Packaging and Steam Workshop release

Excession packages the finished cache maps and metadata for MCC. It does not compile HSC or repair scenario tags.

## Before Excession

- Complete the correct build pipeline and record the map SHA-256.
- Confirm the package contains the intended map, not a stock or older cache file.
- Start a fresh local mission with anti-cheat disabled.
- Test every advertised language and insertion point.
- Perform real host/client tests before claiming co-op support.

## Package metadata

Check the generated package and campaign metadata, including names, descriptions, identifiers, mission order, scenario/map filenames, insertion points, and supported player count. Give every installed or uploaded build a new version so MCC and testers can distinguish it from cached content.

Use original preview art that you own. A practical Workshop image is a 16:9 PNG or JPEG at 1920×1080 or 1280×720 and below 1 MB. Excession can also request separate thumbnail, large, and loading images; inspect the active project fields and keep each within its displayed size limit.

## Excession workflow

1. Run Steam and sign in.
2. Open Excession and configure the MCC mod staging root.
3. Create or open the project.
4. Add the campaign and mission records in the intended order.
5. Set each scenario/map filename exactly as built.
6. Add the preview/loading images and save.
7. Validate/install locally and compare the installed map hash.
8. Launch MCC with anti-cheat disabled and start a new mission.
9. Upload initially as private or unlisted.
10. Install from Workshop on a clean profile or another PC, then repeat solo, language, and co-op tests.
11. Publish publicly only after the Workshop download reproduces the local package.

## Release notes

Include:

- required MCC title/DLC and anti-cheat-disabled launch instruction;
- supported player count and whether co-op is experimental;
- supported languages;
- mission order and known limitations;
- version and change summary;
- a warning that all players need the same Workshop version.

Do not include HREK executables, DLLs, stock maps/tags, local file paths, usernames, Steam session data, or credentials in the upload.

