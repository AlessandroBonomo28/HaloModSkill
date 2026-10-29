# Reproducible workspace layout

Keep the retail game, official tools, editable source, and distributable package separate.

## Recommended layers

```text
project-repository/
  README.md
  source/
    scripts/          # canonical authored HSC
  metadata/           # package manifests and build records
  media/              # original preview/loading images
  scripts/            # project automation
  docs/
  backups/            # private and normally ignored
```

Outside the public repository:

```text
official-hrek/        # Steam-managed installation
project-hrek-copy/    # optional disposable working copy
installed-mod/        # package consumed by MCC
```

Do not put stock `data`, `tags`, maps, tools, or executables in the public repository. If a private project requires modified binary tags, store them in a controlled artifact archive and document their hashes.

## Source-of-truth rules

- Choose one canonical location for every authored HSC file.
- Treat the copy under the HREK `data` tree as a synchronized build input, not an independent source.
- Before overwriting either copy, compare SHA-256 hashes, modification times, and known probe identifiers.
- Record the exact scenario-relative path and expected output map name in a small project manifest or README.
- Give each tested package a version and map hash.

## Backups

Before editing tags or scenarios, back up the exact files that can change, including generated scenario resource tags. Name backups with a timestamp or build identifier and keep a hash manifest. Avoid copying an entire HREK tree for every change; it obscures which file is authoritative.

Keep a pristine official installation or be prepared to verify/reinstall it through Steam. Use a project copy for experiments that may rewrite large tag/resource trees.

## Git hygiene

Commit text, metadata, original media, and scripts. Ignore generated maps, binaries, logs, local roots, and proprietary content. Review `git status` before every commit for usernames, drive paths, Steam identifiers, access tokens, and accidentally copied game assets.

