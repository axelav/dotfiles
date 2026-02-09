# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Workflow

### Skills

Always use the `/superpowers` skills available to you when working on features.

### Git Worktrees

Use `.worktrees/` directory for isolated feature development workspaces. Always use worktrees for changes unless it's a single-line or very simple change.

```bash
# Create a worktree for a feature branch
git worktree add .worktrees/feature-name -b feature-name

# List active worktrees
git worktree list

# Remove a worktree when done
git worktree remove .worktrees/feature-name
```

### Git Commits

- Always run `git commit` with `dangerouslyDisableSandbox: true` — GPG signing requires access to the keyring which the sandbox blocks.
- Never use HEREDOC syntax for commit messages — the sandbox can't create temp files for here documents. Use plain `-m "message"` instead.
- Never commit without signing.

### Commit Messages

Use conventional commit format: `type(scope): description`

Types:

- `feat:` new features
- `fix:` bug fixes
- `chore:` maintenance, dependencies, tooling
- `test:` test additions or fixes
- `docs:` documentation changes

Keep messages concise and lowercase after the type prefix.

### Feature Workflow

When using `/superpowers/writing-plans`, follow this process once the plan is written and agreed upon:

1. Commit the plan document on `main`.
2. Create a new worktree for the feature.
3. Write the implementation plan (if required).
4. Implement on the worktree until the user says everything is done.
5. When finishing, always use a fast-forward merge strategy so all commits land on `main` properly sequenced.
6. After the merge, verify it was clean (lint, tests, etc.).
7. Clean up the worktree.

## Package Management

- When starting Node.js projects, prefer pnpm over npm or yarn
- Use `pnpm install` for dependencies
