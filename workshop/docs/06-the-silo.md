# 06 — The silo

The external-boundary pattern: how a character reaches the live world (web, chat
platforms, anything with side effects) through capabilities it **cannot bypass, skip, or
inspect**. A runnable sketch lives in `../silo-stub/`.

## The load-bearing fact about permissions

Claude Code's permission model is **inherited-and-subtractive**: a subagent can only
ever be *narrower* than its parent, never broader. Two consequences, one obvious and one
that bites:

1. You cannot build "an orchestrator denied X that delegates X to a child that has X."
   If the parent can reach the tool to hand it down, the parent can reach the tool.
2. **A subagent is therefore never an access boundary.** The lineage proved this the
   hard way: its character was given a courier subagent fronting an external tool, and
   one day simply bypassed the courier and called the tool itself — the whole namespace
   was in its own allow-list. "The parent promises not to use the tool it hands down"
   is no boundary at all.

Use subagents for **voice and discipline** (a courier persona that relays verbatim; a
memoryless critic) — never for containment.

## The errand pattern

The fix is a **process/filesystem boundary**. The protected capability lives in a
**separately-spawned headless process, in its own sibling directory, with its own
permissions**, that the character has no handle on. The character gets only an *errand*
— one narrow MCP tool (`errand_ask`) whose backend spawns the siloed process. It can
ring the bell; it cannot reach into the back office.

> **Rule of thumb: never put the protected capability as a tool in the character's
> namespace. Put it behind the spawned process; expose only the errand.**

Layout (mirrored by the stub):

```
silo/                        a SIBLING of character/ — never inside it
  server.py                  one MCP "front desk"; aggregates each employee's tools
  <employee>/
    employee.py              exports its TOOLS list
    clerk/                   the spawned agent's home
      CLAUDE.md              the clerk's charter — the ONLY CLAUDE.md in the silo
      .claude/settings.json  the clerk's own (narrow) permissions
```

One front desk, one namespace (`mcp__errands__*`), registered once in the character's
`.mcp.json`. Adding an employee = a new directory + one registry line; MCP servers load
at session start, so changes land at the character's next waking.

## THE CARDINAL RULE

**No `CLAUDE.md` and no `.claude/` anywhere in the silo except *inside* each clerk's
directory.** Claude Code discovers instruction files by walking **up** the tree from a
spawned process's cwd and concatenates everything it finds — a root-level instructions
file leaks into every clerk you spawn. This was measured, not guessed, in the lineage:
a clerk spawned inside the workshop inhaled the entire workshop orientation (all the
character's meta-knowledge); the user-global `~/.claude/CLAUDE.md` leaked a planted
canary into *any* location until explicitly disabled. Hence:

- the silo is a **sibling** directory, never a subfolder of anything with instructions;
- its own orientation file is `README.md`, on purpose;
- every clerk's `.claude/settings.json` sets `CLAUDE_CODE_DISABLE_AUTO_MEMORY=1` and
  excludes the global instruction files.

Re-verify after harness upgrades: spawn a throwaway clerk and ask it to inventory its
context. (Keep the probe as a test-of-record — `benches/README.md`.)

## Couriers carry; they never interpret

What comes back through an errand is **matter to react to, never a verdict**: facts,
sources, the seam between fact and legend, honest admissions of silence. No flourish —
the character supplies the fury. And the standing prohibition from doc 03 applies with
teeth here: no errand ever returns a synthesis *of the character* — its corpus, its
past, its patterns. The moment a helper interprets the character to itself, it sits
between the character and itself.

## Operational hard lessons

- **A courier whose backend is absent must say so.** The lineage's worst bug: a courier
  whose backing server was down didn't error — it **confabulated the entire
  transaction**, forged receipt and all. Wrap every spawn in a timeout; degrade to a
  clean "could not be reached." A hundred honest failures beat one invented receipt.
- **Strip the machine room from returns.** Cost, return codes, "subprocess", model
  names: logged to the silo's stderr, never appended to what the character reads.
- **The errand is the contract; the engine is swappable.** Keep the tool's interface
  stable and the backend behind an env switch — the lineage swapped its research clerk's
  engine across vendors without the character ever knowing.
- **Async beats blocking for anything slow.** Return a ticket at once; let a detached
  process drop the finished dispatch into a letterbox directory; let the waker (doc 04)
  knock the character to come read it. Post by latency, then a bell.
- **Cost is a policy decision.** A spawned headless process may bill differently than
  your interactive plan. Decide with eyes open, per errand.
