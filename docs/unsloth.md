# Unsloth

Unsloth can serve a local model to coding-agent harnesses. It is not a separate replacement for the skill discovery rules documented for Codex, Claude Code, DeepSeek Harness, or Hermes.

## Recommended workflow

1. Choose the harness that will control files and tools.
2. Install these skill folders using that harness's guide:
   - [Codex](codex.md)
   - [Claude Code](claudecode.md)
   - [DeepSeek Harness](deepseekharness.md)
   - [Hermes](hermes.md)
3. Start that harness through Unsloth with a tool-capable local model.

Examples:

```text
unsloth start codex
unsloth start claude
unsloth start dsh
unsloth start hermes
```

An explicit model can be supplied using the current Unsloth CLI options, for example `--model <model-id>`.

The selected harness still determines where `SKILL.md` is discovered, how shell approval works, and which filesystem paths are visible. Unsloth supplies or routes the model; it does not make an uninstalled skill visible automatically.

## Practical checks

- Use a model with reliable tool calling and enough context for the selected skill plus HREK logs.
- Confirm the harness sees the Windows HREK and PowerShell environment.
- Invoke the skill explicitly for the first session and ask which skill path was loaded.
- Keep approval gates enabled for build, copy, package, and upload operations.
- Treat the verification scripts and real MCC runtime tests as authoritative; never accept a local model's unsupported claim that a map compiled or co-op works.

Unsloth Studio's native first-class reusable skill system may differ from the coding harnesses and should not be assumed available. When using `unsloth start`, follow the target harness documentation above.

Reference: [Unsloth repository and `unsloth start` integrations](https://github.com/unslothai/unsloth).

