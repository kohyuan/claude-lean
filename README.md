# claude-setup

A shareable, machine-level [Claude Code](https://www.claude.com/product/claude-code)
setup: global permissions, personal memory, custom skills, and slash commands.
Clone it, run one script, and your `~/.claude/` is configured.

```
claude/
  settings.json   # global permission baseline (read-only allows + safety denies)
  CLAUDE.md       # personal cross-project preferences (user memory)
  skills/         # custom skills (each a folder with SKILL.md)
  commands/       # custom slash commands (*.md)
```

## Install (for users)

```bash
git clone https://github.com/kohyuan/claude-setup
cd claude-setup
./install.sh
```

`install.sh` copies the four pieces into `~/.claude/`. Anything it would
overwrite is **backed up first** to `~/.claude/.backup-<timestamp>/` — nothing
is silently replaced. `skills/` and `commands/` are merged per-item, so your
existing skills and commands are left intact unless they share a name (those are
backed up too). Restart Claude Code afterward.

To undo: delete the files this added from `~/.claude/`, and restore from the
backup folder if needed.

## Update your shared copy (for the maintainer)

If you change your own `~/.claude/` and want the repo to match:

```bash
./pack.sh                 # copies your live ~/.claude into ./claude
git add -A && git commit -m "Update setup" && git push
```

`pack.sh` copies only `settings.json`, `CLAUDE.md`, `skills/`, and `commands/`.

## Security

This repo holds config that is meant to be public. **Do not commit secrets.**
`pack.sh` never copies `~/.claude.json` (auth tokens, MCP config, session
history) or `settings.local.json`. Review the `claude/` folder before pushing,
and keep the provided `.gitignore` in place.

## Notes

- The `settings.json` deny list is opinionated (blocks `curl`, `git push`, etc.).
  Adjust to taste — see the comments in that file's section of the README, or
  move items from `deny` to an `ask` list.
- Skills and commands are the parts that could *also* be shipped as a Claude Code
  plugin (`/plugin install`). The global `settings.json` and `CLAUDE.md` cannot
  be distributed via a plugin, which is why this repo uses an install script to
  cover everything in one place.
