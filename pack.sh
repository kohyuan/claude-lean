#!/usr/bin/env bash
set -euo pipefail

# Maintainer helper: copy your live ~/.claude config into this repo so you can
# share it. Copies ONLY the pieces meant to be public. Review before committing.
#
# Deliberately NOT copied:
#   ~/.claude.json          (auth tokens, MCP config, session history)
#   settings.local.json     (personal local overrides)
# Never commit those.

SRC="$HOME/.claude"
DEST="$(cd "$(dirname "$0")" && pwd)/claude"
mkdir -p "$DEST"

if [ -f "$SRC/settings.json" ]; then
  cp -f "$SRC/settings.json" "$DEST/settings.json"
  echo "packed settings.json"
fi

if [ -f "$SRC/CLAUDE.md" ]; then
  cp -f "$SRC/CLAUDE.md" "$DEST/CLAUDE.md"
  echo "packed CLAUDE.md"
fi

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
