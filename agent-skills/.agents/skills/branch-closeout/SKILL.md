---
name: branch-closeout
description: Independently review a completed branch, fix proven issues, verify behavior, commit and push scoped changes, create a draft PR, and wait for exact-head CI.
disable-model-invocation: true
argument-hint: "[base ref] [Jira key/spec] [--local-only | --ci-first | --no-wait]"
---

# Branch Closeout

One branch, one fixer, fresh reviewers, an honest draft handoff. Invoking this skill authorizes **in-scope local fixes, scoped commits, normal pushes, and creating/updating an owned draft PR**. Default verification is focused local checks plus a behavioral smoke run, then CI. Permission never extends to merge, approval, ready-for-review, force-push, rebase/amend, queue operations, resolving threads, or unrelated cleanup.

Overrides: `--local-only` reviews/fixes/verifies/commits locally with no remote mutation; `--ci-first` keeps local smoke and repository-mandated local gates but delegates automated tests to covering CI; `--no-wait` publishes the draft and reports one observed CI snapshot. Explicit user restrictions override defaults. Read-only review uses `/branch-review`, not this skill.

## 1. Establish scope and ownership

Read [../branch-review/SKILL.md](../branch-review/SKILL.md) and resolve its base/intent/standards prerequisites. Pin root, named branch, selected base tip, worktree identity, initial head, remote/head branch, and all PRs referencing that exact head repository + branch; inspect their bases, heads, states, and authors before selecting a target. Do not hide a PR behind a base filter: a later push would advance it too. Work only in this checkout; do not hunt or modify unrelated open PRs. Detached head, a base/default branch as the current branch, another author's PR, a closed/merged target, an additional affected open PR/conflicting base, or a live merge queue are blockers. An existing ready PR is not permission to convert it to draft or edit it: ask for that state change first. In offline `--local-only` mode, record unavailable remote/PR metadata as unchecked publication prerequisites, not local-review blockers.

Inventory staged, unstaged, and untracked paths. Prepare uncommitted work only if its intended scope is explicit or unambiguous from this task. Ask for path/hunk selection if mixed or unknown; never blanket `git add`, stash, reset, or discard. Commit intended work using the repo's normal hooks and conventions so reviewers see a clean snapshot. Hooks are executable code; use the trusted repository workflow, and never bypass them. If a hook changes content, that new content must be reviewed and verified. Preserve unrelated user work; if it prevents a clean review, stop and request its disposition rather than silently excluding it.

Keep the local state/ledger outside the diff at the directory returned by `git rev-parse --git-path branch-closeout`. Record repository, worktree, branch, base tip, merge-base, candidate head, initial dirty scope, PR identity, remote tip, review coverage, findings/dispositions, commands/results/evidence, and repair count. Persist no credentials. On resume, re-resolve identities and evidence; cached "clean" or "green" is never authority for a different candidate.

**Done:** a clean, scoped committed candidate and explicit publication target exist; permissions and any blockers are known.

## 2. Review and triage

Execute `/branch-review` through a fresh review coordinator or follow its orchestration in this parent with fresh reviewer subagents. Never review your own fixes as the only reviewer. Incomplete review coverage blocks completion/publication.

Reconcile every finding into the ledger with a stable ID:

- **Actionable:** proven in-scope bug, unmet explicit requirement, or objective documented-policy breach with a bounded correction. Accept or reject with source evidence, not votes.
- **Nit/rejected:** preference, duplicate, unsupported claim, unrelated change, or demonstrably already satisfied requirement. Record why; do not generate refactor churn.
- **Ambiguous:** product/design/rollout/security choices requiring the user's judgment, including any human-participated thread. Present credible options and consequences; do not implement the choice first and ask afterward.

Continue independent safe work despite an ambiguity. Ask only decisions that materially change the fix or publication safety. Existing exploitable vulnerabilities, secret exposure, destructive data changes, weakened authorization/isolation, and contradictory explicit requirements block publication until the user decides the safe route. A draft PR is still disclosure.

**Done:** every reviewer and existing-thread item has one disposition; the safe repair queue and human decisions are explicit.

## 3. Repair, observe, and freshly re-review

Use a **global budget of three repair rounds per invocation**, shared by review and later CI failures. One round may fix several independent accepted issues. Preserve each finding's original evidence, chosen correction, changed paths, fix commit, and verification. Repeated findings with no concrete progress stop the loop; never relax the evidence gate to finish.

For each accepted bug, establish a tight failing-before/passing-after scenario from existing evidence or a focused reproducer. Do not rerun a user-reported failure merely to confirm it. Prefer a regression test for a plausible consumer-visible boundary; if impractical, retain the observed smoke evidence and explain the gap. Fix the cause using existing patterns and migrate affected callers/contracts. Skip builds/lint/tests/formatters while parallel edit agents are active; a single owner integrates, then runs verification.

Read and execute [VERIFICATION.md](VERIFICATION.md). Repair relevant failing checks within the same budget. Update required docs/changelog after smoke proof. Stage only scoped paths and commit with normal hooks. Check for hook-produced content; pin the resulting clean head, then require a **fresh `/branch-review` over the full branch diff**, with positive resolution coverage for accepted findings. Re-run verification if content changed after the observed checks; a content-identical commit does not require duplicating checks, but bind their tree evidence to its SHA.

After the third repair round, still perform final verification and fresh review. If an actionable finding persists, coverage is incomplete, a required check cannot pass, or a publication-blocking decision remains, report the exact blocker and stop **before new publication**. Already-created drafts stay drafts with truthful status. Do not claim "ready" on an exhausted loop.

**Done:** no actionable findings remain; accepted fixes have observed verification and independent resolution coverage for the final clean head; required documentation is current.

## 4. Publish and watch

In `--local-only`, finish with local evidence and remaining decisions; do not call the publishing path. Otherwise read and execute [../draft-pr/SKILL.md](../draft-pr/SKILL.md), passing the exact reviewed head/tree/base, review/verification packet, Jira/spec, human decisions, permissions, and remaining repair budget. It owns push, template-preserving draft publication, and bounded CI monitoring.

If CI exposes a deterministic in-scope defect, diagnose from its logs and evidence, use a remaining repair round, then repeat verification and fresh full-diff review **before** another normal push. Re-enter publication with the new candidate; do not let the draft publisher edit code. Keep the original absolute CI-monitoring deadline across repairs. If CI failures are unrelated, infrastructure-only, ambiguous, approval-held, or the budget is exhausted, retain the draft and report the evidence/blocker. No blind test reruns or workflow approval.

Any unexplained local/remote head, base target, ownership, or PR-state change invalidates assurance and stops autonomous publishing. Do not overwrite another writer's commits or keep following a moving remote head.

**Done:** the draft URL and exact reviewed/tested/pushed head agree; required CI was observed successful, or the result explicitly says pending/failed/blocked/not observed without claiming readiness.

## 5. Handoff

Report: branch/base/head; fresh reviewer lenses and coverage; accepted fixes and dispositions; commands and actual results; runtime evidence paths; draft URL or why publication stopped; CI links and exact-head status; unresolved human decisions and the next concrete action.

Status is one of `draft-verified`, `draft-pending`, `draft-blocked`, `local-verified`, or `blocked`. Even `draft-verified` means evidence is complete for the recorded candidate, **not** approval or permission to merge. Never claim all tests passed if only focused tests ran.
