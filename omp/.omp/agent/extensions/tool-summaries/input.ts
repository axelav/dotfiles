import { createHash } from "node:crypto";

function canonical(value: unknown): unknown {
  if (Array.isArray(value)) return value.map(canonical);
  if (value === null || typeof value !== "object") return value;
  return Object.fromEntries(Object.entries(value)
    .filter(([, child]) => child !== null && child !== undefined)
    .sort(([left], [right]) => left.localeCompare(right))
    .map(([key, child]) => [key, canonical(child)]));
}

/** Execution events omit intent and null placeholders retained by transcript cards. */
export function inputHash(toolName: string, args: unknown): string {
  const executableArgs = args !== null && typeof args === "object" && !Array.isArray(args)
    ? Object.fromEntries(Object.entries(args).filter(([key]) => key !== "i"))
    : args;
  return createHash("sha256")
    .update(`${toolName}\0${JSON.stringify(canonical(executableArgs)) ?? "null"}`)
    .digest("hex");
}
