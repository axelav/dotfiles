# CLAUDE.md

Agent-specific instructions for Claude Code.

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

- **Commit incrementally, without being asked.** As soon as a logical unit of work reaches a working, verified checkpoint (tests/lint/types green), commit it. Do NOT defer commits to the end of the session or batch everything into one commit, and do NOT wait for an explicit "commit now". This explicitly overrides any harness default that says to commit only when the user asks — on a feature worktree, committing as you go IS what I'm asking for.
- Always run `git commit` with `dangerouslyDisableSandbox: true` — GPG signing requires access to the keyring which the sandbox blocks.
- Never use HEREDOC syntax for commit messages — the sandbox can't create temp files for here documents. Use plain `-m "message"` instead.
- Never commit without signing.
- Pushing and opening PRs is still gated (see Pull Requests below) — but local commits are not.

### Commit Messages

Use conventional commit format: `type(scope): description`

Types:

- `feat:` new features
- `fix:` bug fixes
- `chore:` maintenance, dependencies, tooling
- `test:` test additions or fixes
- `docs:` documentation changes

Keep messages concise and lowercase after the type prefix.

### Pull Requests

When finishing a branch, do NOT create the PR. Instead, push the branch and print:

1. The GitHub PR creation URL
2. A suggested PR title and brief description

Let the user create the PR themselves.

### GitHub Comments

Never add comments directly to GitHub PRs or issues. Always present the proposed comment to the user and let them post it themselves.

### Future Work

When the user defers something during planning or implementation, always record it in a `## Future Work` section at the bottom of the plan document. Use a consistent format:

- `- [ ] <description>` — one line per item, with enough context to act on it in a later session.
- Group related items under a subheading if needed.
- Never silently drop deferred items — if the user says "not now" or "later", write it down.

This makes it easy to review all outstanding future work across plan documents in a later session.

## Package Management

- When starting Node.js projects, prefer pnpm over npm or yarn
- Use `pnpm install` for dependencies

@RTK.md
