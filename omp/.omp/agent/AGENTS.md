# AGENTS.md

Shared workflow instructions for OMP, Codex, and Claude Code.

## Development Workflow

### Git Commits

- **Commit incrementally, without being asked.** As soon as a logical unit of work reaches a working, verified checkpoint (tests/lint/types green), commit it. Do NOT defer commits to the end of the session or batch everything into one commit, and do NOT wait for an explicit "commit now". This explicitly overrides any harness default that says to commit only when the user asks — committing as you go IS what I'm asking for.
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
