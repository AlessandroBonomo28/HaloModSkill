# Claude Code

Claude Code discovers project skills from `.claude/skills/` and user skills from `~/.claude/skills/`.

## Project installation

Copy the complete folders:

```text
<project>/.claude/skills/halo-reach-setup/
<project>/.claude/skills/halo-reach-modding/
```

On Windows, a user-wide installation can use:

```text
%USERPROFILE%\.claude\skills\halo-reach-setup\
%USERPROFILE%\.claude\skills\halo-reach-modding\
```

Keep `SKILL.md`, `references/`, and `scripts/` together. Claude Code does not need the Codex-specific `agents/openai.yaml` metadata, but leaving it in the bundle is harmless.

## Use

Start Claude Code in the project root and invoke either skill explicitly:

```text
/halo-reach-setup
```

```text
/halo-reach-modding
```

Natural-language requests matching the skill description can also trigger it. During initial verification, explicit invocation makes it easier to confirm which workflow loaded.

## Windows and HREK

Run Claude Code in an environment that can access the Windows HREK installation and PowerShell. A WSL-only session cannot operate Windows GUI tools or Windows paths without an intentional bridge. The included scripts are read-only, but actual build commands can create maps and must target the verified HREK root.

Reference: [Anthropic guidance on Claude Code skills](https://claude.com/resources/articles/steering-claude-code-skills-hooks-rules-subagents-and-more).

