#!/usr/bin/env bash
set -euo pipefail

# Maintainer helper: copy your live ~/.claude config into this repo so you can
# share it. Copies ONLY the pieces meant to be public. Review before committing.
#
# Deliberately NOT copied:
#   ~/.claude.json          (auth tokens, MCP config, session history)
#   settings.local.json     (personal local overrides)
# For settings.json, ONLY the "permissions" block is packed — your personal
# statusLine, enabledPlugins, and extraKnownMarketplaces stay on your machine
# and are never pushed.

SRC="$HOME/.claude"
DEST="$(cd "$(dirname "$0")" && pwd)/claude"
mkdir -p "$DEST"

# settings.json: pack permissions only (drops statusLine/plugins/marketplaces).
if [ -f "$SRC/settings.json" ]; then
  if command -v jq >/dev/null 2>&1; then
    jq '{permissions}' "$SRC/settings.json" > "$DEST/settings.json"
    echo "packed settings.json (permissions only)"
  else
    cp -f "$SRC/settings.json" "$DEST/settings.json"
    echo "packed settings.json (jq not found — review for personal keys!)"
  fi
fi

# CLAUDE.md: personal cross-project memory.
if [ -f "$SRC/CLAUDE.md" ]; then
  cp -f "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"
  echo "packed CLAUDE.md"
fi

# skills/ and commands/: copy wholesale.
for sub in skills commands; do
  if [ -d "$SRC/$sub" ]; then
    rm -rf "${DEST:?}/$sub"
    cp -R "$SRC/$sub" "$DEST/$sub"
    echo "packed $sub/"
  fi
done

echo
echo "Packed into $DEST"
echo "Review for secrets/API keys, then: git add -A && git commit && git push"
