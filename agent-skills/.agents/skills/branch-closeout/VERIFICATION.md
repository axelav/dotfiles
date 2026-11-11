# Verification

Run after integrated repairs, before publication. Derive commands from current repository scripts, app guidance, existing test configuration, and CI; do not hard-code a monorepo's commands as universal defaults. Verification applies to one candidate **tree** and is bound to its eventual head SHA.

## Plan the smallest sufficient checks

Map each behavioral slice to an expected outcome from intent/spec or an established contract, affected tests, type/build/lint gates, runtime smoke, and CI coverage. Every slice needs observed behavior or a specific unavailable prerequisite; a static review is not runtime proof.

Default: run focused affected tests and required local gates, then exercise the real changed path. Use finite non-watch commands. Expand to adjacent/integration suites for changed persistence, authorization, public contracts, migrations, or concurrency when repository conventions require it. Distinguish an environmental blocker from an introduced failure. Infrastructure unavailability never becomes a fake pass.

`--ci-first`: delegate automated tests only when current workflows demonstrably cover the affected paths and run on drafts. Retain local runtime smoke and any mandatory local repository checks. If CI coverage is missing or its draft trigger skips the needed suite, run the suite locally or report a blocker; empty/green unrelated CI cannot substitute.

For each check record: command and cwd, candidate tree/head, expectation, actual relevant output, exit/status, and artifact path or CI URL. An earlier pass is valid only for identical relevant content/config; edits after checks invalidate affected evidence. A disappeared intermittent failure remains recorded, not silently PASS.

## Observe the surface

- **API/backend:** launch or use the actual service on this candidate, issue a real request/event, and inspect response plus relevant durable effects. For persistence/tenant boundaries use isolated disposable data, not production credentials.
- **UI:** use the available browser automation, confirm the running stack serves the candidate, interact with the changed route/state, inspect rendered output and relevant console/network failures, and capture/inspect sanitized screenshots when useful. Tests alone are not visual proof. Close only tabs/processes you own; do not restart the user's stack or kill their browser as a recovery shortcut.
- **CLI/library/state logic:** launch the actual command or a throwaway script through the real public entrypoint. Assert exact outputs/transitions/boundaries; imported behavior is evidence, a source-text assertion is not.
- **Docs/config-only:** exercise the applicable parser/build/command or validate the documented operation. Say when the changed surface has no runnable path; do not manufacture an irrelevant smoke check.

Never run destructive migrations, mutate production data, disclose credentials, or upload browser evidence without explicit separate authorization. A worktree is isolation of files, not a security sandbox. Stop only resources this invocation started.

## Durable fixes and tests

Prefer existing tests and patterns. Add a permanent regression test when it defends a plausible consumer-visible bug: a boundary, invariant, transition, precedence, failure, or actual requirement. Keep it deterministic, isolated, and full-suite-safe. Do not add wiring/mock echoes, source-text checks, incidental-wording/default assertions, bare not-throw tests, or duplicated cases. Remove obsolete incidental-behavior tests rather than re-pinning them.

After runtime proof, update the docs/changelog the repository requires, regenerate affected contracts using its canonical generators, and remove throwaway probes/scaffolds. Verification artifacts live outside the patch. If docs/generation/hooks change behavior or checked content, revisit affected verification and final review.

## Axion starting points — re-read before use

These were discovered during installation, not permanent per-repo policy:

| Surface | Current repository sources |
| --- | --- |
| Backend/shared | Root `package.json` backend/shared test commands; backend Vitest configs and app guidance; `.github/workflows/backend-pull-request.yaml` builds, unit/shared coverage, Mongo/AlloyDB integration shards |
| Frontend | Root/frontend scripts and test config; `.github/workflows/frontend-pull-request.yaml` build/design-system gate, unit shards and shared tests; browser-check the actual changed UI |
| TypeScript contracts | `.github/workflows/typescript-pull-request.yaml` compile and backend-spec typecheck; generated clients require canonical generator paths |
| Python services | The affected app's Makefile/pyproject and its current workflows; do not assume JS test commands apply |
| End-to-end | Root Playwright commands and actual `.github/workflows/e2e-pull-request.yaml` / `run-e2e-tests.yaml` triggers; optional manual suites are not evidence unless actually run |

**Completion:** every required available check is observed passing for the candidate; each changed behavior is observed or has an explicit blocking prerequisite; the final packet distinguishes focused coverage from full-suite and local from CI evidence.
