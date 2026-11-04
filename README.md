# dotfiles

## Installation

Install MacOS command line tools, homebrew, homebrew packages/casks, dotfiles,
etc.

```sh
$ install.sh
```

## Usage

Use `stow` to install symlinks to your dotfiles:

`stow git gpg <...> --verbose`

Codex config should be stowed without directory folding so `~/.codex` stays a
real local state directory and only `~/.codex/config.toml` is linked:

`stow --no-folding codex --verbose`

OMP uses the same layout so `~/.omp` remains a real local state directory.
Only `~/.omp/agent/config.yml` is linked; MCP settings and generated runtime
state remain local:

`stow --no-folding omp --verbose`

Herdr also needs no-folding so logs, sockets, and session state stay local.
Its main config and the resurrect plugin's settings/allowlist are linked:

`stow --no-folding herdr --verbose`

Herdr uses `Ctrl+Space` as its prefix, matching the tmux configuration.
`Ctrl+Space`, then `;`, toggles to the last focused pane across workspaces and
tabs. This is pane history, not a strict last-used-workspace or session toggle.

[source](https://stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html)

## Herdr recovery

[herdr-resurrect](https://github.com/ntindle/herdr-resurrect) supplements Herdr's
built-in layout and native agent conversation restore with command relaunch.
Install it separately after stowing the Herdr package:

```sh
herdr plugin install ntindle/herdr-resurrect
herdr config check
herdr server reload-config
```

The plugin settings and allowlist live under
`herdr/.config/herdr/plugins/config/ntindle.herdr-resurrect/`.
OMP and Pi have explicit native-session resume command overrides.
Automatic restore is disabled; inspect the restore preview before replaying work.
The executable-name allowlist includes Neovim, pagers, monitors, and lazygit.
General runtimes, task runners, and infrastructure commands are excluded because
replaying them can repeat destructive work.

| Keys (release the prefix first) | Action |
| --- | --- |
| `Ctrl+Space`, `Ctrl+S` | Save snapshot |
| `Ctrl+Space`, `Ctrl+P` | Preview latest snapshot restore |
| `Ctrl+Space`, `Ctrl+R` | Restore latest snapshot |

Action output, including previews, is available through
`herdr plugin log list --plugin ntindle.herdr-resurrect`.
Event-driven snapshots are automatic. For 15-minute snapshots even when the
layout does not change, open the plugin's timer pane and leave it running:

```sh
herdr plugin pane open --plugin ntindle.herdr-resurrect --entrypoint autosave --no-focus
```

Reopen the timer pane after a reboot; it is not on the command-relaunch allowlist.
Do not override its working directory: the plugin uses relative script paths.
Snapshots remain local under
`~/.local/state/herdr/plugins/ntindle.herdr-resurrect/sessions/<session>/`.
The latest 20 are retained. Autosave can replace the latest snapshot with
post-restart state; use the plugin's versioned snapshots when recovering an older
pre-shutdown session rather than blindly restoring the latest one.

Neovim configuration is unchanged: resurrect restarts the captured `nvim`
command, not its in-memory editor layout. LazyVim's existing persistence plugin
saves editor sessions on normal exit; `<leader>qs` restores the current directory's
saved session. There is no new periodic buffer writing or buffer autosave.

## Tmux recovery

`tmux/.tmux.conf` uses
[Resurrect](https://github.com/tmux-plugins/tmux-resurrect) to save layouts,
working directories, and selected commands.
[Continuum](https://github.com/tmux-plugins/tmux-continuum) automates saving
and restores when the tmux server starts; neither checkpoints process memory.
Manual save/restore uses `Ctrl-Space` followed by `Ctrl-S` / `Ctrl-R`.
Existing panes are normally left alone during restore.

The agent allowlist relaunches OMP and Claude with their saved arguments.
Claude's native `~/.local/bin/claude` path is mapped to `claude` on `PATH`.
Explicit `--resume <id>` arguments retain conversation identity; bare agent
commands do not reliably identify the old conversation, and positional prompts
can be replayed. Do not force `--continue` globally when multiple panes use the
same directory.

The Vim/Neovim session strategy loads `Session.vim` from the pane directory
when present; it does not create that file. Save it from the editor with
`:mksession! Session.vim` when editor-session recovery is wanted.

For development servers, prefer explicit project pane commands in
`.workmux.yaml`, or add narrowly matched, safe-to-restart commands to
`@resurrect-processes` after inspecting `~/.local/share/tmux/resurrect/last`.
See [Resurrect's command matching rules](https://github.com/tmux-plugins/tmux-resurrect/blob/master/docs/restoring_programs.md).
Avoid `:all:` and blanket Node/package-manager entries: restore reruns commands
and their side effects rather than resuming their former runtime state.

`workmux resurrect --dry-run` previews recovery of missing worktree windows
in the current repository. `workmux resurrect` recreates those windows using
`--continue`; it skips already-open worktrees, including windows whose layout
was restored by Continuum. It is not an exact per-pane conversation restore.
See [workmux recovery](https://github.com/raine/workmux#workmux-resurrect).

Herdr has its own [recovery setup](#herdr-recovery); it is a separate multiplexer,
not a tmux plugin.

## `env` vars, credentials, etc

If `~/.extra` exists, it will be sourced along with the other files. This is
best adding commands you don't want to commit to a public repository.

### MacOS defaults

Decent defaults when settings up a new machine:

```sh
./macos
```
