# OpenAI Codex

Codex supports portable skills made from a `SKILL.md` file plus optional `references/`, `scripts/`, and assets.

## Recommended project installation

From the root of the project where Codex will work, copy both skill folders into the cross-agent project directory:

```text
<project>/.agents/skills/halo-reach-setup/
<project>/.agents/skills/halo-reach-modding/
```

Each destination must contain its own `SKILL.md`; do not copy only the Markdown entrypoint because the references and scripts are part of the skill.

For user-wide installation, use the skills location supported by the installed Codex version. Current installations commonly discover `%USERPROFILE%\.agents\skills\`; installations using `CODEX_HOME` may also support `%CODEX_HOME%\skills\`. Prefer the documented `.agents/skills` convention for new shared repositories.

## Use

Start a new Codex chat in the project after installation. Invoke explicitly while testing:

```text
Use $halo-reach-setup to verify my HREK installation.
```

```text
Use $halo-reach-modding to classify this change as Pipeline A or B and verify the build.
```

After discovery is confirmed, Codex can also select a skill from its description. Keep the HREK paths outside committed files and pass them as task inputs.

## Verify discovery

- Confirm both skill names appear in the session's available-skills list or `$` picker.
- Ask Codex which `SKILL.md` path it loaded.
- Run the setup skill's read-only environment checker.
- If a new skill is not visible, restart Codex or open a new chat before changing the skill files.

The `agents/openai.yaml` files provide Codex-facing display names and default prompts. Other compatible harnesses may ignore them safely.

Reference: [OpenAI skills overview](https://developers.openai.com/plugins/concepts/skills).

