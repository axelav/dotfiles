# Dotfiles

Personal macOS dotfiles managed with GNU Stow. Installation and tool-specific
operations are documented in [README.md](README.md).

## Sources of truth

- Package directories mirror paths under `$HOME`. Edit the versioned sources in
  this checkout; installed files may be symlinks, so edits can affect the live
  environment immediately.
- Shared personal preferences live in `omp/.omp/agent/AGENTS.md`. Codex's
  `codex/.codex/AGENTS.md` links to that source; Claude imports it from
  `claude/.claude/CLAUDE.md`. Keep RTK instructions Claude-only.
- Versioned personal skills live under `agent-skills/.agents/skills/`.
  Third-party skills remain externally installed; new files created in installed
  skill directories are not automatically tracked here.

## Local constraints

- Stow `omp`, `codex`, `herdr`, and `agent-skills` with `--no-folding` so runtime
  state and externally installed files remain local. See README for
  package-specific flags; the default Codex installation deliberately skips
  `config.toml`.
- `install.sh` is machine bootstrap: it installs or upgrades packages and changes
  the home directory. `macos` changes system preferences and uses administrator
  privileges. Neither is a validation command.
- Keep Neovim plugin specs in `nvim/.config/nvim/lua/config/lazy.lua`,
  following the existing convention rather than introducing per-plugin files.

## Verification

- For link changes, use `stow --simulate --verbose --target="$HOME" <package>` with
  the package-specific flags from README. Resolve conflicts before applying links.
- Validate changed configuration with the owning tool and exercise the affected
  behavior. Do not run machine bootstrap or reload unrelated applications to check
  a configuration edit.
