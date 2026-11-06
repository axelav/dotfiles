---
name: personal-software-workflow
description: Personal software workflow. Use when planning tickets, implementing tracked work, or resuming a project in a repository opted into Aven, or when the user explicitly requests this workflow.
---

# Personal software workflow

One entry point for project-aware ticket planning, implementation tracking, and durable handoffs. Keep the requested engineering process and repository verification requirements; this skill supplies tracker policy rather than replacing design, TDD, implementation, or review.

## Resolve ownership before acting

1. Read the repository's agent instructions and its declared tracker guide. Establish the authoritative implementation tracker, adoption scope, specification location, and code-review location. For Aven, also establish workspace, project, and repository/feature scope.
2. Treat pilot and feature-specific exceptions literally. A repository hosted on GitHub does not imply GitHub tickets, and invoking this skill does not opt a repository into Aven. Existing task handoffs can contain historical tracker choices; reconcile them against current repository guidance and the user's current instruction.
3. If routing is missing or ambiguous, inspect existing configuration and task context read-only first. Ask only for an unresolved ownership/routing decision. Do not create projects, change routing, migrate backlogs, or add startup hooks implicitly.
4. For Aven work, run `aven skill` to load the installed CLI's operational guidance. Use it for command syntax, safe text editing, and sync-conflict handling. Use explicit workspace and project arguments when discovery could target the wrong place; never infer them from this skill's installation location or another repository.

The configured tracker owns implementation status and handoffs. Specifications and PRs stay where repository guidance places them. Keep one implementation backlog; link to existing specifications and PRs instead of duplicating mutable tickets. Apply the remaining Aven-specific steps only within the configured Aven scope. For another tracker, follow its repository workflow without switching it.

## Repository labels in Aven

The shared `software` project contains work from multiple repositories. Every repository-scoped task and epic must carry a `repo-<repository-name>` label, such as `repo-kaizen-web`, `repo-honkytonk-infra`, `repo-interne`, or `repo-dotfiles`.

- Establish the repository from explicit task context, specification links, or verified checkout/remote identity. Do not infer it from the shared project, a product mention, or the current directory alone.
- Reuse the existing repository label. If absent, create it explicitly with `aven label create --workspace <workspace> repo-<repository-name>` before passing `--label` to `aven add` or `aven edit`.
- Label each task for the repositories its own scope affects. Cross-repository tasks and epics receive every applicable repository label; a child does not automatically inherit all of its epic's labels.
- Preserve triage and other existing labels. Repository labels supplement them; they do not change project routing, lifecycle status, ownership, or dependencies.
- On creation, include the repository labels and self-contained affected-repository context. When selecting or resuming work, filter by the repository label and verify the full task scope.
- When asked to backfill existing tasks, include clearly scoped tasks and epics regardless of status; leave ambiguous or non-repository work unchanged. Preview broad mutations, target only verified tasks, and read back the labels afterward.

## Plan tickets

1. Read the full specification and relevant existing tasks, relationships, and handoffs. Check the intended project for duplicates. For a shared project spanning repositories, inspect affected-repository context rather than treating every ready task as this repo's work.
2. Propose complete, independently verifiable vertical slices. Give each a title, delivered behavior, and only the blockers that genuinely gate it. Keep code deliverables distinct from live deployment or other operational acceptance gates.
3. Present the numbered breakdown and ask for approval of granularity and blocking edges. Ticket creation requires the user's request or an approved breakdown; a request to inspect or recommend work is read-only.
4. Publish approved tickets in blocker-first order with self-contained scope, acceptance criteria, affected repositories, specification links, and blocker references. Use the repository's triage-label mapping and the CLI's actual lifecycle statuses; a readiness label is not a status or proof that blockers are resolved.
5. Use native dependencies for execution order. Use epics only for grouping, within Aven's workspace/project constraints; epic membership alone never establishes a blocker. Preserve existing parent specifications and unrelated epics unless the user explicitly requests changes.
6. Read back task context and the ready frontier. Verify scope, labels, epic membership, native blocker direction, and agreement between described and stored blockers. Report the created references and the next runnable slice. Planning completion does not complete an implementation ticket or feature epic.

## Implement a selected task

1. Load the task's full context, linked specification, blockers, conflict state, and relevant notes before changing code or status. Follow any commands for retrieving omitted description/note bodies. Verify that the task belongs to the requested repository/feature and that blockers are actually satisfied; a canceled or missing blocker is not evidence that its deliverable exists.
2. Inspect current activity and handoffs for another session's ownership. An active task is not yours merely because you can read it, and a ready-list result is not an atomic reservation. Do not take over another session's task without an explicit handoff.
3. Once authorized to implement, mark your selected task active and follow the repository's normal engineering process. Do not start coding when the user only requested planning, inspection, or a recommendation.
4. Exercise every acceptance criterion at the appropriate boundary. Run the changed behavior and observe its result; tests or compilation alone do not prove browser behavior, native runtime integration, private ingress, publication, or deployment. Preserve execution-time approval gates for disruptive operations.
5. Leave a durable note with implementation decisions, observed verification, PR URLs, and any remaining blockers or next action. Distinguish what ran from what remains unverified. Keep secrets and transient scratch work out of tracker notes.
6. Mark the task done only when its acceptance criteria pass. If incomplete, record the exact outstanding work without claiming completion. Complete an epic only when its whole outcome is verified, not merely because planning or one child finished.

## Resume or recommend work

- Honor the request's scope: inspect and recommend without changing tasks or starting implementation unless asked.
- Reload current context rather than trusting an earlier chat's status. Work can finish or change in another session.
- Choose among open, unblocked tasks in the intended repository/feature; distinguish another session's active work from available work.
- Return the task reference, why it is runnable, and the concrete next action. A fresh session must be able to continue from the task and its durable notes without this conversation.

## Aven privacy and portability

Keep Aven task references out of commits, PR descriptions, GitHub issues, and repository documents. Put specification/PR URLs in Aven instead. Instructions can use generic task-reference examples without publishing real local references.

Keep this shared skill as the policy source of truth. Repository guides own routing and exceptions, not copies of this workflow. Use the installed `aven skill` output for CLI mechanics. Automatic priming and installation into additional agent environments are separate opt-in changes; do not assume every harness discovers the same skill directory.
