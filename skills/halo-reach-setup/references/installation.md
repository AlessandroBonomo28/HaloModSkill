# Installation and migration

## Fresh installation

1. Install Halo: The Master Chief Collection and the Halo: Reach game content through Steam.
2. In the Steam Library, enable the **Tools** filter and install the official Halo: Reach MCC Editing Kit / Mod Tools associated with the owned game.
3. Install Excession when Workshop packaging or upload is required. It may appear as a separate Steam tool.
4. Launch each installed tool once through Steam so prerequisites and redistributables can finish installing.
5. Locate the three roots independently: MCC retail, HREK, and Excession.
6. Run the environment checker from this skill. Record the roots in local documentation that is excluded from Git.

The official tools can be installed on any drive. Never derive an HREK path merely from the MCC path.

## Expected HREK components

The exact distribution can evolve, but a usable Reach editing-kit root normally contains:

- `sapien.exe` for scenario editing and script compilation;
- `foundation.exe` for tags and multilingual string lists;
- `tool.exe` and/or `tool_fast.exe` for command-line processing and cache builds;
- `tag_test.exe` for development runtime tests;
- `bin\ManagedBlam.dll` for supported managed tag automation;
- `data`, `tags`, and `maps` directories.

Treat missing components as an installation problem before copying files from another machine. Mixed tool versions can create harder-to-diagnose failures.

## Moving to another PC

Reinstall MCC, HREK, and Excession from their official source. Move only the material you own and need:

- canonical authored HSC and documentation;
- original media and package metadata;
- hashes or build manifests;
- private backups of modified project tags/resources where redistribution is lawful.

Do not rely on absolute paths embedded in scripts. Make roots parameters or local configuration values. Re-run the environment checker, restore project files deliberately, and produce a clean build before trusting an old package.

## Supported runtime

Use the MCC launch choice that disables anti-cheat for modded content. This is a supported separation between ordinary matchmaking and custom mods; it is not an anti-cheat bypass. Never use modified content in anti-cheat-protected matchmaking.

## Further reading

- [Halo: The Master Chief Collection mod documentation](https://learn.microsoft.com/en-us/halo-master-chief-collection/)
- [Reclaimers Library: General mod tools](https://c20.reclaimers.net/general/mod-tools/)

