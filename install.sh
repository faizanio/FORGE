#!/usr/bin/env bash
# Forge Skill Installer for Antigravity IDE
# Usage:
#   ./install.sh                      # Interactive menu
#   ./install.sh --workspace [path]   # Install to workspace .agents/skills/forge
#   ./install.sh --global             # Install globally to ~/.gemini/config/skills/forge
#   ./install.sh --all                # Install to both

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_SKILL="$SCRIPT_DIR/skills/forge"
GLOBAL_DIR="$HOME/.gemini/config/skills/forge"

if [[ ! -d "$SOURCE_SKILL" ]]; then
  echo "Error: Source skill not found at $SOURCE_SKILL" >&2
  exit 1
fi

install_workspace() {
  local target_root="${1:-.}"
  local dest="$target_root/.agents/skills/forge"
  echo "Installing Forge skill to workspace: $dest"
  mkdir -p "$dest"
  cp -R "$SOURCE_SKILL/"* "$dest/"
  chmod +x "$dest"/scripts/*.sh "$dest"/scripts/*.py 2>/dev/null || true
  echo "✓ Workspace installation complete: $dest"
}

install_global() {
  echo "Installing Forge skill globally to: $GLOBAL_DIR"
  mkdir -p "$GLOBAL_DIR"
  cp -R "$SOURCE_SKILL/"* "$GLOBAL_DIR/"
  chmod +x "$GLOBAL_DIR"/scripts/*.sh "$GLOBAL_DIR"/scripts/*.py 2>/dev/null || true
  echo "✓ Global installation complete: $GLOBAL_DIR"
}

MODE="${1:-}"

if [[ "$MODE" == "--workspace" || "$MODE" == "-w" ]]; then
  TARGET="${2:-.}"
  install_workspace "$TARGET"
elif [[ "$MODE" == "--global" || "$MODE" == "-g" ]]; then
  install_global
elif [[ "$MODE" == "--all" || "$MODE" == "-a" ]]; then
  install_workspace "."
  install_global
elif [[ -n "$MODE" && "$MODE" != "--help" && "$MODE" != "-h" ]]; then
  # Target directory passed directly
  install_workspace "$MODE"
else
  echo "============================================="
  echo "       FORGE SKILL INSTALLER FOR ANTIGRAVITY "
  echo "============================================="
  echo "Where would you like to install the /forge skill?"
  echo ""
  echo "  1) Current Workspace (.agents/skills/forge)"
  echo "  2) Global Antigravity Config (~/.gemini/config/skills/forge)"
  echo "  3) Both Workspace and Global"
  echo "  4) Cancel"
  echo ""
  read -r -p "Enter choice [1-4]: " choice
  case "$choice" in
    1)
      install_workspace "."
      ;;
    2)
      install_global
      ;;
    3)
      install_workspace "."
      install_global
      ;;
    *)
      echo "Installation cancelled."
      exit 0
      ;;
  esac
fi

echo ""
echo "============================================="
echo "  Forge Skill successfully installed!"
echo "  You can now type: /forge in Antigravity chat"
echo "============================================="
