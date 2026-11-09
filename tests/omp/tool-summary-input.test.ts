import assert from "node:assert/strict";
import { test } from "node:test";
import { inputHash } from "../../omp/.omp/agent/extensions/tool-summaries/input.ts";

test("a transcript call matches its normalized execution event without mutating either", () => {
  const transcript = { i: "Checking files", command: "printf hello", timeout: null, cwd: null, ready: { port: 3000, log: null } };
  const execution = { ready: { port: 3000 }, command: "printf hello" };
  const original = structuredClone(transcript);
  assert.equal(inputHash("bash", transcript), inputHash("bash", execution));
  assert.deepEqual(transcript, original);
});

test("changed command, working directory, language, or tool cannot reuse a summary", () => {
  assert.notEqual(inputHash("bash", { command: "printf first" }), inputHash("bash", { command: "printf second" }));
  assert.notEqual(inputHash("bash", { command: "pwd", cwd: "/first" }), inputHash("bash", { command: "pwd", cwd: "/second" }));
  assert.notEqual(inputHash("eval", { code: "print(1)", language: "py" }), inputHash("eval", { code: "print(1)", language: "js" }));
  assert.notEqual(inputHash("bash", {}), inputHash("eval", {}));
});
