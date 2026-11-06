---
name: pr-review
description: Review one GitHub pull request read-only through an evidence-gated, risk-routed reviewer pair. Use when a PR needs an autonomous review report without GitHub mutations.
argument-hint: "<PR URL or number>"
---

# PR Review

Review exactly one open pull request. The review is read-only: it reports high-confidence defects and human decisions; it never writes GitHub comments, resolves threads, changes files, starts CI runs, or pushes.

A finding earns a report only when it is specific, materially harmful, demonstrably reachable from the supplied diff and surrounding code, and has a concrete correction. Naming, style, speculative future-proofing, and test preference findings do not qualify.

## 1. Resolve the PR

Require a PR URL or number. Resolve it in one call:

```bash
gh pr view <argument> --json number,title,url,state,isDraft,baseRefName,headRefName,headRefOid,body,author,additions,deletions,changedFiles,reviewDecision
```

Stop and report if the PR is closed, merged, or inaccessible. Gather the changed files, diff, and commits:

```bash
gh pr diff <url> --name-only
gh pr diff <url>
gh pr view <url> --json commits --jq '.commits[] | {oid, messageHeadline}'
```

Fetch only the unresolved review-thread metadata necessary to avoid duplicating a current human concern. A human thread remains a human decision: summarize it but do not answer, resolve, or fix it.

If local code inspection requires a worktree, create it detached at the reviewed HEAD inside a fresh external temporary directory (`mktemp -d "${TMPDIR:-/tmp}/pr-review.XXXXXX"`). Never place review worktrees under the repository (including `<repo>/.worktrees/`): nested worktrees can inherit the parent pnpm workspace. Remove only the worktree and temporary directory created by this review when finished, using `git worktree remove --force <tmpdir>/wt && rmdir <tmpdir>` as separate steps. Never use `rm -rf` for cleanup: it is denied by the user's settings. If `rmdir` fails because the directory is not empty, list what is left and report it rather than force-deleting.

## 2. Route risk

Run a correctness reviewer for every non-draft PR. Add one specialist only if the diff touches a risk area:

| Changed area | Specialist lens |
| --- | --- |
| Auth, authorization, credentials, external input, webhooks, prompt/tool execution | Security and trust boundaries |
| Mongo/Postgres schema, migrations, deletes, data ingestion, tenant/workspace scoping | Data integrity and isolation |
| Queues, retries, transactions, locks, shared mutable state, async orchestration | Concurrency and failure recovery |
| Public API contracts, generated clients, serialization | Compatibility and generated-contract drift |

A diff can select multiple areas; choose the single highest-risk lens. For a low-risk diff, use only the correctness reviewer. Both reviewers use the session's default model and work independently.

Spawn the reviewer agents in parallel. Supply each agent with the PR metadata, changed-file list, full diff, relevant commit messages, and a concise scope. Each agent must read the changed code's local context before judging it.

### Correctness reviewer brief

> Review this PR for regressions, incorrect behavior, missing boundary handling, and tests that fail to defend an observable changed contract. Report only findings that meet the evidence gate. Do not report style, naming, abstract smells, optional tests, hypothetical risks, or changes outside the diff's behavioral surface.

### Specialist reviewer brief

> Review this PR only through the assigned risk lens. Trace concrete inputs, state changes, and failure paths through surrounding code. Report only findings that meet the evidence gate. Do not report generic best practices, style, or theoretical concerns.

Each reviewer returns this exact structure:

```text
FINDINGS:
- severity: critical|high|medium
  title: <short defect>
  location: <path:line>
  evidence: <diff and surrounding-code path proving reachability>
  impact: <specific broken behavior, security consequence, or data loss>
  correction: <concrete minimal correction>
HUMAN_DECISIONS:
- <unresolved human review thread or design choice that cannot be proved wrong>
NONE: <why no reportable finding exists>
```

Severity means: `critical` is an exploitable security breach, irreversible data loss, or broad outage; `high` breaks a primary supported behavior; `medium` causes a bounded but real incorrect behavior. Do not emit lower severities.

## 3. Triage and report

Deduplicate equivalent findings across the pair. Reject a finding if its evidence is incomplete, its impact is conjectural, its correction is not specific, or it is already covered by an unresolved human thread.

Return:

```markdown
## PR review: <owner/repo>#<number> — <title>

Reviewed HEAD: `<sha>`
Reviewers: correctness[, <specialist lens>]

### Actionable findings
1. **[high] title** — `path:line`
   - Evidence: ...
   - Impact: ...
   - Correction: ...

### Human decisions
- ...

### Verdict
<no actionable findings | N actionable finding(s); human attention required for M decision(s)>
```

The completion criterion is an evidence-gated report for this exact HEAD, with every qualifying reviewer finding represented once and every unresolved human thread explicitly categorized.
