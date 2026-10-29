# Hermes Agent

Hermes follows the portable Agent Skills format and can discover skills globally, from a project, or from configured external directories.

## Installation options

Global installation:

```text
~/.hermes/skills/halo-reach-setup/
~/.hermes/skills/halo-reach-modding/
```

Project installation:

```text
<project>/.hermes/skills/halo-reach-setup/
<project>/.hermes/skills/halo-reach-modding/
```

Hermes also supports the cross-agent project location:

```text
<project>/.agents/skills/halo-reach-setup/
<project>/.agents/skills/halo-reach-modding/
```

Alternatively, add this repository's `skills/` directory under `skills.external_dirs` in `~/.hermes/config.yaml`. Remember that writable external directories are not protected from agent-managed skill updates.

## Trust and verify

Hermes does not automatically load skills from an arbitrary cloned repository. From the project root run:

```text
hermes skills trust
hermes skills list
```

Then invoke `/halo-reach-setup` or `/halo-reach-modding`. Project skills have the highest precedence, followed by local Hermes skills and configured external directories. Avoid duplicate skill names unless shadowing is deliberate.

For a public GitHub repository, Hermes can also inspect and install a repository/path through `hermes skills install`; review the scan results before accepting third-party scripts.

Reference: [Hermes skills system](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/skills.md).

