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

### mise trust for Herdr worktrees

Install the managed mise config with `stow mise --verbose` after reconciling
any existing regular config file.

`mise/.config/mise/config.toml` trusts configs under `~/.herdr/worktrees`,
including newly created worktrees. Only place repositories you trust there:
mise configs can execute code. Configs elsewhere still require `mise trust`.
See [mise's trust-by-path documentation](https://mise.jdx.dev/security.html#trust-by-path).

### Personal agent skills

`agent-skills` tracks only `personal-software-workflow`, including its agent
metadata. Third-party and agent-managed skills remain externally installed.
Install the package from this checkout with an explicit home target:

```sh
stow --no-folding --target="$HOME" agent-skills --verbose
```

OMP discovers the skill through `~/.agents/skills/`. No additional agent-specific
links are installed. No-folding keeps the destination directories real so
third-party skills can coexist. Edit and add files under
`agent-skills/.agents/skills/` in this repository; new files created directly in
the installed directories are not automatically tracked. Existing regular files
at the destination must be reconciled before stowing.

### Agent and terminal configuration

OMP and Codex should be stowed without directory folding so their state
directories remain local:

```sh
stow --no-folding omp --verbose
stow --no-folding --ignore='(^|/)config\.toml$' codex --verbose
```

Shared cross-project preferences live in `omp/.omp/agent/AGENTS.md`, installed as
`~/.omp/agent/AGENTS.md`. Codex's package contains a relative symlink to that
same file, installed as `~/.codex/AGENTS.md`. Migrate any existing regular
`~/.codex/AGENTS.md` before stowing; Stow will not overwrite it.

Claude's `~/.claude/CLAUDE.md` imports `~/.omp/agent/AGENTS.md` and keeps a
separate `@RTK.md` import. RTK instructions belong only in Claude, not in the
shared policies.

OMP configuration files are also linked. The Codex install skips `config.toml`
to preserve existing local configuration; omit the ignore flag to install the
versioned config after reconciling any existing regular file. Generated runtime
state remains local.

Herdr also needs no-folding so logs, sockets, and session state stay local.
Its main config and plugin settings/allowlists are linked:

`stow --no-folding herdr --verbose`

Herdr uses `Ctrl+Space` as its prefix, matching the tmux configuration.
`Ctrl+Space`, then `;`, toggles to the last focused pane across workspaces and
tabs. This is pane history, not a strict last-used-workspace or session toggle.
`Ctrl+Space`, then `Ctrl+A`, opens Aven's task UI in a 100% popup; exit Aven
to close it. `Ctrl+Space`, then `Ctrl+G`, opens lazygit in the same style.

[source](https://stevenrbaker.com/tech/managing-dotfiles-with-gnu-stow.html)

## OMP tool summaries

The native extension in `omp/.omp/agent/extensions/tool-summaries/` describes
long built-in Bash and Eval calls in the main interactive transcript. Install
with `stow --no-folding --target="$HOME" omp --verbose`, then restart OMP.
`config.yml` enables `extensionRenderers.transcriptPresenters` and selects the
authenticated `tiny` role (`openai-codex/gpt-6-luna:low`).

Descriptions run asynchronously; they never delay or replace tool execution.
Collapsed cards show intended actions, not verified outcomes or safety judgments.
Press `Ctrl+O` to see the original commands and results. Errors remain marked
as failed. Descriptions reflow when the terminal is resized. Saved descriptions
are custom session entries, not model context; resume restores them without
regenerating them, including calls whose arguments OMP coerced during execution.
OMP runtime state remains outside this repository; the package's Stow ignore
rule excludes `config.yml.lock`.

- `/tool-summaries`: status, selected model, pending/saved counts, and last issue.
- `/tool-summaries off`: cancel requests; saved descriptions remain visible.
- `/tool-summaries on`: enable requests for subsequent eligible calls.

Requests are on for new interactive sessions; the on/off choice is saved on the
current session branch. Only scripts of at least 150 characters are eligible.
The extension sends up to 24,000 serialized input characters, runs at most two
requests concurrently, and aborts requests after eight seconds. Short,
oversized, busy, failed, or unavailable-model calls keep native rendering.
There is no backfill or model/provider fallback. Subagents and non-interactive
sessions do not generate descriptions.

**Privacy and quota:** full execution arguments, including inline credentials
or private code, go to the `tiny` model and consume its provider quota or incur
API charges. Tool results and conversation history are not sent. Turn requests
off before sensitive work; cancellation cannot retract data already sent.

Fingerprint regression checks (Node.js 24+):

```sh
node --experimental-strip-types --test tests/omp/tool-summary-input.test.ts
```

## Herdr PR status

[Spaces PR Status](https://github.com/jmarbutt/herdr-spaces-pr-status) adds PR
state, CI counts, review status, and resolvable review-thread counts to space
rows. Agent rows are unchanged. Requires Node.js 20+ and authenticated `gh`.
Install the inspected revision separately after stowing:

```sh
herdr plugin install jmarbutt/herdr-spaces-pr-status --ref 23d26455f9d77863771fee75f287a75e52409e92
herdr config check
herdr server reload-config
herdr plugin action invoke jmarbutt.spaces-pr-status.refresh
```

The refresh action is one-shot; the startup hook starts automatic polling on
the next normal Herdr server start. Polling defaults to every 90 seconds.
Default branches and spaces without PRs have no extra status rows.

Settings live in
`herdr/.config/herdr/plugins/config/jmarbutt.spaces-pr-status/config.json`.
Notifications are disabled for a quiet sidebar. `openPrLimit` is 20 because
the default 100-PR query returned GitHub HTTP 502 during setup; branches outside
the batch still receive targeted lookups.

The inspected code uses read-only GitHub queries and has no npm dependencies or
build hooks. It is unsandboxed, not a security guarantee. Avoid the optional
checks pane: PR titles/check names are not sanitized for terminal controls.
Poller startup is not locked against concurrent launches, and non-GitHub origins
can be queried against the wrong host. Reinspect before updating the pinned
revision.

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


## Tmux window labels

The status bar abbreviates workmux ticket names such as
`_wm-agc-490-workflows-in-issues-chat` to `_wm-agc-490` and limits displayed
names to 20 characters. Actual window names remain unchanged for workmux;
`Ctrl-Space w` lists full names. Both active and inactive labels use this format.

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
