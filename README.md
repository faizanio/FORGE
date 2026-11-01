# Forge (`/forge`) — Engineering Reliability Skill for Antigravity

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Antigravity](https://img.shields.io/badge/Antigravity-Agent%20Skill-blueviolet.svg)](https://antigravity.google)
[![TypeScript](https://img.shields.io/badge/TypeScript-Strict%20Mode-3178C6.svg?logo=typescript&logoColor=white)](references/typescript-guide.md)
[![Python](https://img.shields.io/badge/Python-Mypy%20%7C%20Ruff%20%7C%20Pytest-3776AB.svg?logo=python&logoColor=white)](references/python-guide.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**Forge** is an autonomous engineering reliability runtime designed for Google Antigravity. It enforces grounded code inspection before modification, strictly bounded write scopes, calibrated planning against blast radius, and deterministic proof validation before any task can be marked complete.

---

## Quick Start: Using `/forge`

Once installed, simply type `/forge` in your Antigravity chat or prepend it to your prompt:

```text
/forge Implement user session timeout with unit tests and verify the result.
```

Antigravity automatically discovers the skill and activates Forge's cognitive protocol.

---

## Installation

Forge provides multiple installation methods tailored to your workflow:

### 1. Core (Recommended)

Portable behavioral policy delivered directly as an Agent Skill via `skills.sh`. No dependencies beyond the skill files:

```bash
# Workspace install (creates .agents/skills/forge/)
npx skills add faizanio/Forge --skill forge --agent antigravity --yes

# Global install (available across all projects in Antigravity)
npx skills add faizanio/Forge --skill forge --agent antigravity --global --yes

# For Antigravity CLI (agy)
npx skills add faizanio/Forge --skill forge --agent antigravity-cli --yes
```

### 2. Native (Antigravity Runtime Hooks)

Core plus an Antigravity plugin (`forge-native`) with `PreToolUse`, `PostToolUse`, `PostInvocation`, and `Stop` hooks. For teams that want tool calls checked and completion gated mechanically by the Antigravity runtime:

```bash
git clone --depth 1 https://github.com/faizanio/Forge.git
cd Forge
bash scripts/build-native-bundle.sh
agy plugin install "$PWD/dist/forge-antigravity"
agy plugin validate "$PWD/dist/forge-antigravity"
```

### 3. Local Installer Script (`install.sh`)

If you downloaded or cloned this repository directly and prefer a fast, dependency-free installer:

```bash
# Current workspace (.agents/skills/forge)
./install.sh --workspace

# Global machine-wide installation (~/.gemini/config/skills/forge)
./install.sh --global

# Interactive menu
./install.sh
```

For complete details, update procedures, and troubleshooting, see [docs/install.md](docs/install.md).

---

## Supported Stacks

Forge includes native, specialized deep guides and verification chains for:

- **TypeScript / Node.js**:
  - `tsconfig.json` strictness checks (`strict`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`)
  - Type checking with `tsc --noEmit`
  - Linting with ESLint (`@typescript-eslint`)
  - Testing with Vitest / Jest (verbose test counts and failure traces)
  - Anti-patterns: `any` avoidance, discriminated unions, type guards

- **Python**:
  - `pyproject.toml` tool discovery (`[tool.mypy]`, `[tool.ruff]`, `[tool.pytest]`)
  - Strict type checking with `mypy` / `pyright`
  - Ultra-fast linting and format checking with `ruff`
  - Testing with `pytest` (fixtures, parameterized test cases, assertions)
  - Anti-patterns: bare `except` avoidance, builtin shadowing, structured types with dataclasses/Pydantic

---

## The 6 Invariants of Forge

1. **Ground before mutating**: Read the target file, its tests, and its callers before editing. Never assume file state or guess signatures.
2. **Stay in declared scope**: Only edit files within `allowed_write_scope`. If unexpected modifications are needed, amend scope openly.
3. **Completion needs evidence**: A task is done only when an automated check passes *after* the last file modification. Stale test runs and self-review do not count.
4. **Never exact-retry a failure**: If an approach fails, change the diagnosis, context, or strategy before retrying. Exact retries are blocked.
5. **Satisfy the contract**: Acceptance criteria and declared validators gate completion. Generic "tests passed" does not cover unrelated criteria.
6. **Say what you cannot verify**: Clearly label uncertain or unverified assumptions. Never fabricate certainty.

---

## Directory Structure

```text
skills/forge/ (and .agents/skills/forge/)
├── SKILL.md                  # Main skill entrypoint (invoked via /forge)
├── PROMPT-TEMPLATE.md        # 3-layer prompt structure (System, Task, Context)
├── SESSION_FAILURES.md       # Session failure memory to avoid retry loops
├── references/               # Progressive deep references
│   ├── typescript-guide.md   # TypeScript strict patterns & failure modes
│   ├── python-guide.md       # Python mypy, ruff, pytest patterns
│   ├── task-contract.md      # Formal task contract specification
│   ├── reasoning.md          # Calibrated reasoning & planning depth
│   ├── reconnaissance.md     # Codebase mapping and deep dive
│   ├── verification.md       # Evidence hierarchy & VERDICT format
│   ├── delegation.md         # Subagent delegation rules
│   ├── recovery.md           # Session resumption after context compaction
│   └── model-routing.md      # Cost & effort profile management
├── resources/                # Defensive resources
│   ├── anti-rationalization.md # Defenses against 20 common model rationalizations
│   ├── adversarial-critique.md # Plan attacking checklist
│   ├── gemini-native.md      # Gemini agent orchestration strengths
│   ├── persona-protocol.md   # Rigorous engineering tone
│   └── subagent-patterns.md  # Multi-agent role templates
├── agents/                   # Agent prompts
│   ├── explore.md            # Read-only exploration agent
│   ├── plan.md               # Adversarial planning agent
│   ├── general.md            # Implementation agent
│   └── verify.md             # Verification agent
└── scripts/                  # Standalone verification utilities
    ├── verify.sh             # Multi-language verification runner
    ├── run-checks.sh         # Fast automated checks
    ├── forge_verify.py       # Standalone project validator discovery
    ├── verify.py             # Python verification runner
    ├── detect_project.py     # Project language & test scanner
    └── doctor.py             # Forge installation diagnostic tool
```

---

## Verification Tools

You can run the verification scripts directly at any time:

```bash
# Auto-detect project language and run full verification chain
bash skills/forge/scripts/verify.sh

# Run quick automated checks
bash skills/forge/scripts/run-checks.sh

# Run project detector
python3 skills/forge/scripts/detect_project.py .

# Check Forge skill installation health
python3 skills/forge/scripts/doctor.py
```

---

## Community & Security

- **Contributing**: Read our [Contributing Guide](CONTRIBUTING.md) to report issues or propose additions.
- **Code of Conduct**: We follow the [Contributor Covenant](CODE_OF_CONDUCT.md).
- **Security**: Please review our [Security Policy](SECURITY.md) to report vulnerabilities responsibly.
- **License**: Released under the [MIT License](LICENSE).

