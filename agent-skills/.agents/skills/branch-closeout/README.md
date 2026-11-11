# Local branch closeout skills

Canonical source lives in `~/.agents/skills`. Claude Code loads personal skills from `~/.claude/skills`, so `branch-review`, `branch-closeout`, and `draft-pr` are exposed there as directory symlinks to the canonical source. This keeps supporting files and cross-skill references together without duplicate copies. Claude Code [supports symlinked skill directories](https://code.claude.com/docs/en/skills#where-skills-live).

Claude Code normally detects additions to its existing personal skills directory during a session. If the menu is stale, run `/reload-skills`, then `/skills`, or start a fresh session. Other harnesses may snapshot their skill index at startup and require a new session. No repo manifests or harness configuration were changed.

## Entry points

| Skill | Use | Side effects |
| --- | --- | --- |
| `/branch-closeout` | Finished a branch; review, fix, observe, verify, and publish a draft | Scoped local edits/commits, normal push, owned draft creation/body updates; bounded exact-head CI watch |
| `/branch-review` | Independent pre-PR review without fixing/publishing | Read-only source/PR inspection, selected-base fetch, local report artifacts |
| `/draft-pr` | Already reviewed/verified; publish a template-faithful draft and watch CI | Normal immutable-candidate push and owned draft creation/body updates; standalone invocation obtains missing review/local evidence |

Typical run:

```text
/branch-closeout
```

Optional explicit base/key (replace the example key with the actual issue):

```text
/branch-closeout main CORE-123
```

Smaller entry points and overrides:

```text
/branch-review main path/to/spec.md
/branch-closeout main CORE-123 --local-only
/branch-closeout main CORE-123 --ci-first
/branch-closeout main CORE-123 --no-wait
/draft-pr --prepare-only
```

- `--local-only`: review/fix/test/smoke/scoped commit, with no remote mutation. Offline remote/PR metadata is an unchecked publication prerequisite, not a local-review blocker.
- `--ci-first`: keep behavioral smoke and mandatory local gates; delegate automated tests only to demonstrably covering draft CI.
- `--no-wait`: publish a draft, then report one actual CI snapshot instead of waiting.
- `--prepare-only`: prepare truthful title/body/commands without stage/commit/push/PR/CI mutations. It deliberately does **not** call `gh pr create --dry-run`, which may push.

A bare closeout derives base from the existing PR, configured PR merge-base, or repository default—not the feature-branch tracking upstream. It derives intent/key from available user/spec/issue/branch/PR evidence, asking only genuinely unresolved decisions. A dirty/mixed checkout requires scoped selection; it never commits unrelated work wholesale.

## Defaults selected during installation

Fresh correctness and intent/standards reviewers, at most one highest-risk specialist; current supported model by default. Tiny entirely mechanical changes can use one fresh combined reviewer. Findings are triaged as actionable, nit/rejected, or ambiguous; every accepted fix requires observed verification and fresh resolution coverage. Optional design preferences are not auto-refactor work.

Three total repair rounds, shared across initial review and later CI defects. A final fresh review/verification still runs after the last round. Default local verification is focused affected tests plus actual changed-path observation. Default CI watch is 30 minutes absolute with 30-second intervals; repair/push does not reset the deadline.

Remote publication checks every PR sharing the head ref before filtering by base: a push can advance another PR using that branch. Conflicting bases/states/ownership, remote drift, publication-blocking decisions, missing review coverage, unresolved actionable findings, or required local failures stop new publication. Already-created drafts remain drafts with truthful blocked/pending status.

No approval, ready-for-review transition, merge/auto-merge, force-push, rebase/amend, merge-queue operation, workflow approval/rerun/dispatch, thread reply/resolution, or evidence upload by default. Human-participated threads remain human decisions. Exposing a vulnerability in a draft is still disclosure and requires the safe-route decision.

## Repository fidelity

Each invocation reads current repo guidance, scripts, test configuration, workflow policy and PR template. For Axion: `<JIRA_KEY> - <concise summary>` and the complete root `pull_request_template.md`, preserving heading/checklist order. Only observed creator actions are checked; human reviewer boxes remain unchecked. Missing Loom/Jira evidence is explicit, never fabricated or silently exempted. Existing draft prose is preserved; synchronization updates only unchanged tool-owned evidence content.

Local evidence and the finding ledger live under `git rev-parse --git-path branch-closeout`, outside the patch. They bind root/worktree, branch/base/merge-base, exact candidate, review coverage, findings/dispositions, test/smoke outcomes, repair budget, draft identity and CI observations. Resume revalidates identities instead of trusting cached green state.

Existing `/pr-review`, `/pr-understand`, `/code-review`, and `/open-pr` are unchanged. `/pr-understand` remains available for a fuller post-publication walkthrough; it is not silently run as another reviewer. These skills complement the main Matt flow at the **completed branch** boundary, rather than introducing another idea/spec/implementation process.

See [SOURCES.md](SOURCES.md) for the article, linked repositories, and deliberate adaptations. The detailed research notes are under `references/`; they are reading context, not runtime requirements.

## Installation verification — 2026-10-13

- All three skill frontmatters and agent-display YAML parsed successfully; required relative references resolved.
- Executed `/branch-closeout main SPEC.md --local-only` in a disposable pricing branch. Independent initial review found an actual percentage calculation defect; a later fresh review found intermediate numeric precision loss. Two repair rounds produced scoped commits, documented fixes, 8/8 passing focused tests, successful actual-public-export acceptance/boundary smokes, and fresh positive resolution evidence for both findings.
- The final closeout correctly retained a publication-blocking ambiguity about the fixture's unbounded integer domain versus its Number-only result. The fixture specification was not narrowed and the public API was not silently changed; the handoff was `blocked`, not a false unconditional readiness claim.
- Executed standalone offline `/draft-pr --prepare-only` on a separate fixture. Fresh review and runtime smoke exposed a half-cent defect despite passing named acceptance examples. Preparation generated a truthful blocked body/commands without candidate edits or publication. Structural comparison confirmed all six Axion template headings and eleven checklist items in order, with all five human-reviewer boxes unchecked.
- Independent static workflow review found that base-filtered PR discovery could miss another PR sharing the head ref. The guard was corrected at preflight, pre-push and pre-create, and independently rechecked.

No live draft creation/update, push, CI waiting/repair/rerun, approval, merge, or thread operation was exercised. Publication and the CI lifecycle remain operational verification limits, not observed successes. Disposable repositories/probes were removed after inspection; no production app code, existing review skills, repo manifest, or harness settings were changed.

## Claude Code discovery repair — 2026-10-14

The initial installation populated only `~/.agents/skills`, leaving these names absent from Claude Code's personal skill directory. Added the three directory symlinks under `~/.claude/skills`; left existing skills, synced account manifests, and configuration untouched.

A fresh Claude Code 2.1.299 process reported `branch-review`, `branch-closeout`, and `draft-pr` in **both** the `skills` and `slash_commands` arrays of its actual `system/init` event. The probe disabled tools and stopped after discovery; no review/fix/publication workflow ran. Frontmatter parsed and all required bundled/cross-skill references resolved through the Claude-facing symlink paths.
