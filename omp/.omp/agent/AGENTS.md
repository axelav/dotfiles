# Personal preferences

Cross-project preferences for OMP, Codex, and Claude Code. Repository guidance
contains local constraints; task-specific skills contain workflow procedures.

## Collaboration

- Keep responses concise and concrete. State what was verified and any blockers.
- Do not post GitHub issue or PR comments on my behalf; present the proposed text
  instead.
- Keep deferred work in the project's existing planning or tracking system,
  not a separate mandatory plan format.

## Code and tools

- Use a dedicated Git worktree for repository changes by default. Create or reuse
  one before editing; do not work in the primary checkout unless I explicitly
  instruct otherwise.
- Commit verified logical units incrementally without waiting for a separate
  request. Sign every commit.
- Use concise, lowercase Conventional Commit messages: `type(scope): description`.
- Prefer pnpm for new Node.js projects. In existing projects, use the established
  package manager and lockfile.
