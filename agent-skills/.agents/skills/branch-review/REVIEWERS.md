# Reviewer contract

The parent supplies this contract plus one lens to each fresh reviewer. All lenses are read-only; do not run checks or create nested reviewers. Use the pinned diff, then read the necessary surrounding implementation and directly affected consumers. Review every assigned file, not just likely bug locations.

## Evidence gate

An actionable finding needs all of:

- A precise location and relationship to the candidate change.
- A supported, reachable input/state/failure path; cite the surrounding code or explicit requirement proving it.
- A material consumer-visible incorrect outcome, or a specific documented repository-rule breach. State assumptions that could invalidate the claim.
- A concrete, bounded correction and an observable way to verify it.

Agreement between reviewers is not proof. Do not turn naming preference, theoretical hardening, speculative future needs, optional test coverage, or an architectural taste into a defect. Tool-enforced hygiene belongs to verification, not speculative review comments. A test finding must identify a plausible behavior/boundary/transition that can regress, not assert that more tests would be nice.

Kinds: `defect`, `requirement`, `documented-policy`. Severity: `critical` (exploitable breach, irreversible data loss, broad outage), `high` (primary supported behavior broken), `medium` (bounded real wrong outcome). Objective policy violations may use `severity: policy` rather than invented runtime harm. All confirmed actionable severities require disposition; one high finding is never "approve with nits."

Use `nit/rejected` for unsupported or discretionary suggestions; use `ambiguous` when evidence establishes a consequential choice but cannot decide it. Include alternatives, consequences, and whether proceeding would expose secrets, weaken isolation/auth, destroy data, or contradict explicit intent. Those choices block publication pending the user's decision. Unrelated pre-existing defects are not auto-fix work; report a material one separately with its scope relationship.

## Correctness lens

Trace observable changed behavior through entrypoints, consumers, persistence, response/rendering, events, and external calls. Look for changed validation/serialization, ordering, failure translation, partial writes, state transitions, boundary handling, and precedence. Inspect affected tests as contract evidence, not proof they ran. Explain precisely where the candidate violates supported behavior; do not infer new feature requirements.

## Intent and standards lens

Map every stated acceptance criterion to changed behavior or a concrete gap. Compare with actual repository rules and existing patterns. Report missing/partial requirements and unrequested behavior with the source requirement. When intent is absent, state that spec compliance could not be established.

Investigate reuse, module placement, interface depth, coupling, unnecessary abstractions, stale comments, and domain terminology only where the diff provides evidence of real cost or a documented rule. A design hypothesis is an ambiguous decision, not a mandate to refactor. Repo guidance wins over generic smell lists. Cite any hard rule by file and requirement.

## Optional highest-risk specialist

Choose one lens from the touched boundaries; keep its scope narrow but trace necessary adjacent code:

| Boundary | Lens |
| --- | --- |
| Auth, credentials, untrusted input, webhooks, prompt/tool execution | Security: source-to-sink reachability and missing control |
| Persistence, migrations, ingestion, deletion, tenant/workspace scoping | Data integrity and isolation: guarantees, rollout, destructive effects |
| Queues, retries, transactions, locks, shared state, async coordination | Concurrency and failure recovery: interleavings and partial failure |
| Public interfaces, serialized types, generated consumers | Compatibility: affected callers and generated-contract drift |
| Hot queries/loops or resource lifecycle | Performance: demonstrable work/retention amplification, not guesses |
| Release, deploy, infrastructure or CI execution permissions | Deployment safety: trigger, permissions, rollout and recovery |

When several apply, route by worst credible impact and record why. Uncovered material independent risk is a gap/decision, not a claim that all risks passed.

## Each reviewer's output

```text
reviewed_head: <exact SHA>
lens: <assigned lens>
covered_files: [every assigned file actually inspected]
gaps: [file/contract plus reason]
findings:
- id: <lens-local ID>
  severity: critical | high | medium | policy
  kind: defect | requirement | documented-policy
  title: <one defect>
  location: <path:line>
  evidence: <reachable path + source citations + assumptions>
  impact: <specific wrong outcome or violated rule>
  correction: <minimal change>
  verification: <input/action and expected observable result>
ambiguous: [{location, source, question, options, consequence, blocks_publication}]
nits_or_rejected: [{location, suggestion, reason}]
prior_findings: [{id, disposition: resolved | persists | uncertain, evidence}]
```

Return explicit empty lists when none exist. A reviewer can be clean only after its assigned files are covered. `resolved` requires positive evidence of the required behavior, not merely disappearance of the old line. Runtime verification remains the parent's responsibility.
