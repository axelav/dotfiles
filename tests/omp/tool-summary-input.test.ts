import assert from "node:assert/strict";
import { test } from "node:test";
import { inputHash, inputHashes } from "../../omp/.omp/agent/extensions/tool-summaries/input.ts";

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

test("one saved description recognizes both execution coercions and recorded arguments", () => {
  const execution = { command: "printf hello", timeout: 30 };
  const transcript = { command: "printf hello", cwd: "null", timeout: "30" };
  const saved = inputHashes("bash", execution, transcript);
  assert.ok(saved.includes(inputHash("bash", execution)));
  assert.ok(saved.includes(inputHash("bash", transcript)));
  assert.ok(!saved.includes(inputHash("bash", { command: "printf changed", timeout: 30 })));
  assert.deepEqual(inputHashes("bash", execution, execution), [inputHash("bash", execution)]);
});
