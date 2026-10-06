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

[source](https://stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html)

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

[Herdr](https://herdr.dev/docs/session-state/) is a separate multiplexer whose
current Claude and OMP integrations can capture native session references for
conversation resumption. Its core restore recreates layouts, not arbitrary
processes; generic command relaunch requires additional tooling such as
[herdr-resurrect](https://github.com/ntindle/herdr-resurrect).
Evaluate it separately rather than treating it as a tmux plugin upgrade.

## `env` vars, credentials, etc

If `~/.extra` exists, it will be sourced along with the other files. This is
best adding commands you don't want to commit to a public repository.

### MacOS defaults

Decent defaults when settings up a new machine:

```sh
./macos
```
