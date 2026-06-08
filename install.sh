#!/usr/bin/env bash
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/claude"
DEST="$HOME/.claude"
ts="$(date +%Y%m%d-%H%M%S)"
backup="$DEST/.backup-$ts"
backed_up=0

mkdir -p "$DEST"

backup_file() {
  local rel="$1"
  if [ -e "$DEST/$rel" ]; then
    mkdir -p "$backup/$(dirname "$rel")"
    cp -R "$DEST/$rel" "$backup/$rel"
    backed_up=1
  fi
}

# Single files: back up any existing copy, then install.
for f in settings.json CLAUDE.md; do
  if [ -f "$SRC/$f" ]; then
    backup_file "$f"
    cp "$SRC/$f" "$DEST/$f"
    echo "installed $f"
  fi
done

# skills/ and commands/: copy per item so we never wipe the user's own entries.
for sub in skills commands; do
  [ -d "$SRC/$sub" ] || continue
  mkdir -p "$DEST/$sub"
  for item in "$SRC/$sub"/*; do
    [ -e "$item" ] || continue
    name="$(basename "$item")"
    case "$name" in README.md|.gitkeep) continue ;; esac
    if [ -e "$DEST/$sub/$name" ]; then
      mkdir -p "$backup/$sub"
      cp -R "$DEST/$sub/$name" "$backup/$sub/$name"
      backed_up=1
    fi
    cp -R "$item" "$DEST/$sub/$name"
    echo "installed $sub/$name"
  done
done

if [ "$backed_up" -eq 1 ]; then
  echo
  echo "Existing files were backed up to: $backup"
fi
echo
echo "Done. Restart Claude Code so it picks up the changes."
