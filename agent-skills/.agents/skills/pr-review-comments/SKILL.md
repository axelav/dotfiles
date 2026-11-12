---
name: pr-review-comments
description: Turn a completed pr-review report into draft GitHub comments anchored to verified file/line locations, plus mentions for human decisions. Use after /pr-review when the user wants draft comments, file/line numbers for findings, or wording for human decisions. Never posts.
argument-hint: "[PR URL or number] [finding numbers]"
---

# PR review comments

Follow-up to `pr-review`. Convert its actionable findings and human decisions into comments the user can paste into GitHub. This skill is read-only: it never posts comments, submits reviews, replies to or resolves threads, or edits code. The user posts everything themselves.

## 1. Locate the review

Use the most recent `pr-review` report in this conversation. If the user names finding numbers, draft only those; otherwise draft every actionable finding and every human decision.

If no report is in context, ask for one rather than inventing findings. If the user supplies only a PR, offer to run `pr-review` first.

Take the PR URL and reviewed HEAD from the report. Check that HEAD is still current:

```bash
gh pr view <url> --json headRefOid,state --jq '{headRefOid, state}'
```

If HEAD moved, say so, re-check each finding's location against the new HEAD, and mark any finding that no longer reproduces as stale instead of drafting it.

## 2. Verify each location

A report's `path:line` is a claim, not a GitHub anchor. For each finding, confirm the line in the PR's HEAD version of the file:

```bash
gh api "repos/<owner>/<repo>/contents/<path>?ref=<head-sha>" --jq .content | base64 -d | sed -n '<start>,<end>p'
gh pr diff <url> -- <path>   # or filter `gh pr diff <url>` to the file
```

Pick the anchor that best shows the defect:

- **Inline (RIGHT side):** the line exists in HEAD and sits inside a diff hunk. Prefer the changed line that introduces the defect; use a line range when the defect spans a block.
- **Inline (LEFT side):** the defect is a removed line; anchor to the base-side line number.
- **File-level or top-level:** the problem line is outside every hunk (GitHub cannot anchor there). Name the closest in-hunk line that triggers it, or fall back to a top-level comment that cites `path:line` and the HEAD permalink.

If the line cannot be confirmed, say so; never guess a number.

## 3. Draft the comments

Write as a peer reviewer, in the user's voice, without mentioning AI or the review tooling. These are inline PR comments, not mini review reports: default to 1–2 short sentences. Add detail only when necessary to make the risk or fix clear. Skip preambles, repetition of the code or finding title, and background the diff already makes obvious.

**Findings:** one comment per finding. State the concrete problem and consequence concisely; include the triggering condition only when it is not obvious from the anchor. Add a brief fix or question when useful, not a mandatory problem/scenario/impact/fix breakdown. Use a GitHub `suggestion` block only for a small, exact replacement of the anchored lines; do not repeat the suggestion in prose. Keep severity labels out unless it is blocking — then start with `**Blocking:**`.

**Human decisions:** ask one short question or present a choice that needs an owner; include the trade-off only if needed to decide. Anchor inline when it is about specific code; otherwise put it in the review summary. For an existing unresolved human thread, draft a reply for that thread (name the thread author and location) instead of a new comment, and only if there is something to add.

**Review summary:** a short optional top-level body naming the blocking findings and open decisions, and a suggested review state (`Request changes` when any finding is blocking, otherwise `Comment`).

## 4. Output

Return, in order:

````markdown
## Draft comments: <owner/repo>#<number>

Reviewed HEAD: `<sha>` (<current | moved to `<sha>`>)

### 1. <finding title> — inline, `path:line` (RIGHT)
<HEAD permalink to the line>

```markdown
<comment body>
```

### Human decisions
#### A. <decision> — <inline `path:line` | reply to @author's thread on `path:line` | summary>

```markdown
<comment body>
```

### Review summary — suggested state: <Request changes | Comment>

```markdown
<summary body>
```

### Not drafted
- <stale or unverifiable finding and why>
````

Fence each body so it copies cleanly. Permalinks use `https://github.com/<owner>/<repo>/blob/<head-sha>/<path>#L<start>[-L<end>]`. Omit empty sections.
