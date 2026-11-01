# Install Forge

---

## ⚡ Zero-Effort: Install via Agent Prompt

You can install Forge globally across your entire system without touching the terminal. Just copy this prompt and paste it to your Antigravity agent:

```text
Install the Forge skill globally for my Antigravity agent by running:
npx --yes skills add faizanio/Forge --skill forge --agent antigravity --global --yes
```

*(Or for this project workspace only, change `--global` to `--yes`)*

Your agent will run the command non-interactively and install the skill in seconds. You are ready to use `/forge` right away.

---

## Manual Installation Methods

Forge has two manual installation modes:
- **Core** is the portable Agent Skill that works directly in Antigravity IDE and Antigravity CLI.
- **Native** is an Antigravity plugin that packages Core with runtime hook-based workflow checks (PreToolUse, PostToolUse, and Stop gate).

### 1. Core (Recommended)

From the project where you use Antigravity IDE:

```bash
npx skills add faizanio/Forge --skill forge --agent antigravity --yes
```

### Options:
- **Global Installation (All Workspaces)**:
  Add `--global` to make `/forge` available across every project on your machine:
  ```bash
  npx skills add faizanio/Forge --skill forge --agent antigravity --global --yes
  ```

- **Antigravity CLI (`agy`)**:
  Replace `antigravity` with `antigravity-cli`:
  ```bash
  npx skills add faizanio/Forge --skill forge --agent antigravity-cli --yes
  ```

The command creates `.agents/skills/forge/` in your project (or in your global Antigravity config when `--global` is specified).

### Verify Installation
Verify the installed files and health:

```bash
python3 .agents/skills/forge/scripts/doctor.py
```

### Update Core
```bash
npx skills update forge --project --yes
```

### Remove Core
```bash
npx skills remove forge --project --agent antigravity --yes
```

---

## 2. Native (Antigravity Runtime Hooks)

Native uses the local-plugin install workflow supported by Google Antigravity. Clone the repository, build the tracked distributable bundle, and install it:

```bash
git clone --depth 1 https://github.com/faizanio/Forge.git
cd Forge
bash scripts/build-native-bundle.sh
agy plugin install "$PWD/dist/forge-antigravity"
```

### Validate and Confirm Staging

```bash
agy plugin validate "$PWD/dist/forge-antigravity"
agy plugin list
```

Validation reports the processed skills, agents, and hooks. The list should include `forge-native`. In the Antigravity CLI TUI, `/hooks` shows loaded hooks.

### Refresh or Reinstall
To update the Native plugin, pull changes, run `bash scripts/build-native-bundle.sh`, and re-run:

```bash
agy plugin install "$PWD/dist/forge-antigravity"
```

### Uninstall Native Plugin
```bash
agy plugin uninstall forge-native
```

---

## 3. Direct Local Installer (`install.sh`)

If you cloned or downloaded this repository directly and prefer not to use `npx` or `agy`:

```bash
# Current workspace
./install.sh --workspace

# Specific workspace path
./install.sh --workspace /path/to/project

# Global machine-wide installation
./install.sh --global

# Interactive menu
./install.sh
```

---

## Troubleshooting

- **`npx` unavailable**: Install a current Node.js/npm release, or use `./install.sh`.
- **`agy` unavailable**: Ensure Antigravity CLI is installed and its binary directory is on your `$PATH`.
- **Core not visible in chat**: Start a new Antigravity conversation and ask which skills are available. Antigravity discovers workspace skills from `.agents/skills/`.
- **Native plugin absent from `agy plugin list`**: Rerun `bash scripts/build-native-bundle.sh`, then pass the absolute path to `dist/forge-antigravity` into `agy plugin install`.
- **Hooks not visible**: In the CLI TUI, run `/hooks` to inspect active hooks. Note that staging a plugin requires opening a new conversation turn or CLI session to register.
