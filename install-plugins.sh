#!/usr/bin/env bash
set -euo pipefail

# Optional. Installs the plugins this setup recommends.
# Not run by install.sh — opt-in only, since it pulls third-party code.

if ! command -v claude >/dev/null 2>&1; then
  echo "The 'claude' CLI isn't on your PATH."
  echo "Open Claude Code and install plugins with /plugin instead."
  exit 0
fi

echo "This adds plugin marketplaces and installs 4 plugins:"
echo "  caveman, claude-hud (third-party), superpowers, frontend-design (official)"
printf "Continue? [y/N] "
read -r reply
case "$reply" in
  y|Y) ;;
  *) echo "Skipped."; exit 0 ;;
esac

# Marketplaces (idempotent-ish; ignore errors if already added).
claude plugin marketplace add anthropics/claude-code   || true
claude plugin marketplace add JuliusBrussee/caveman     || true
claude plugin marketplace add jarrodwatts/claude-hud    || true

# Plugins (name@marketplace).
claude plugin install superpowers@claude-plugins-official     || true
claude plugin install frontend-design@claude-plugins-official || true
claude plugin install caveman@caveman                          || true
claude plugin install claude-hud@claude-hud                    || true

echo
echo "Done. Restart Claude Code so it picks up the plugins."
echo "If any line failed, run it manually to see the error, or use /plugin inside Claude Code."
