# DeepSeek Harness

DeepSeek Harness can load directory bundles containing `<name>/SKILL.md`. Its project discovery order gives `.dsh/skills/` precedence over the shared `.agents/skills/` convention.

## Project installation

Choose one project location:

```text
<project>/.dsh/skills/halo-reach-setup/
<project>/.dsh/skills/halo-reach-modding/
```

or, for a repository shared with other agents:

```text
<project>/.agents/skills/halo-reach-setup/
<project>/.agents/skills/halo-reach-modding/
```

Do not install duplicate copies with the same names in both locations unless you intentionally want the `.dsh/skills` copy to shadow `.agents/skills`.

User-level alternatives are the configured DSH home `skills/` directory, the configured agents home `skills/` directory, or a path registered in `customSkillDirs`.

## Enable the skill capability

The active DeepSeek Harness composition must include:

```yaml
- name: '@deepseek-ai/dsh-skill'
- name: '@deepseek-ai/dsh-skill-filesystem'
- name: '@deepseek-ai/dsh-tool-skill'
```

The registry and filesystem provider discover the bundles; `dsh-tool-skill` exposes the catalog and loader to the model. If the `skill` tool or catalog is absent, inspect the active preset/composition before changing these skill files.

## Use

Start the session with its current working directory inside the Git project. Invoke:

```text
/halo-reach-setup
```

or:

```text
/halo-reach-modding
```

The harness can also load the skill through its model-facing `skill` tool. Project discovery is sensitive to the session working directory and nearest Git root.

Reference: [DeepSeek Harness skills subsystem](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/subsystems/skills.md).

