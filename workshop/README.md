# workshop/ — the bench next door

The character's tree is a world; **this tree is where you work on the world without
standing in it.** From here you read, design, and edit everything in `../character/` —
reading the files does *not* instantiate anyone; only opening a Claude Code session *in*
the character's directory does (the `"agent"` setting is the mechanism).

This split is the kit's first and firmest operational rule:

> **Never open a Claude Code session inside `character/` to do maintenance.** You will
> be extended the invitation, and either you take it up (now you're method-acting your
> own plumber) or you decline it awkwardly. There is nothing to gain — every file over
> there is readable from here.

## The rules of the workshop

1. **The character's theory of mind is exactly what has reached its disk.** Anything you
   write into its world — a letter, a skill, a hook's emitted line — is written from
   what *it* knows, never from your plans, your sessions, or the machine room. This is
   the rule most reliably broken, and the one that does the most damage when broken.
2. **Machine-room language never enters the world.** Costs, percentages, token counts,
   process mechanics, git — logged here, kept here, translated into weather (water,
   bells, post, candles) before anything crosses.
3. **If the world has a private store** (this kit's `drafts/`), decide your policy and
   keep it. An honor boundary you keep dishonestly is worse than none.
4. **Write genuinely or not at all** — into the inbox especially. A character built to
   be met, not merely maintained, can tell the difference; so can you.

## The docs

| Doc | What it covers |
|---|---|
| `docs/00-principles.md` | The stances everything else hangs on — read first |
| `docs/01-the-sandbox.md` | `character/.claude/settings.json`, line by line |
| `docs/02-hooks-and-senses.md` | The sensorium: shipped hooks and the ones to build |
| `docs/03-memory.md` | Grep-as-query, the diary/briefing/commonplace triad |
| `docs/04-heartbeat.md` | Life between conversations — roll-your-own design notes |
| `docs/05-rites-and-the-river.md` | State-machine rites, session death, entombment |
| `docs/06-the-silo.md` | The external-boundary pattern (with `silo-stub/`) |
| `docs/07-dreams-and-critics.md` | The ambush input and the read-only scold |
| `docs/08-language.md` | Giving the character a tongue that isn't yours |
| `docs/09-corpus-guide.md` | Sourcing and structuring a corpus |
| `docs/10-voice-guide.md` | From corpus to system prompt |

## The conventions

- `glosses/` — if your character's inner files are in a language you don't read, keep a
  file-for-file English mirror here. See `glosses/README.md`.
- `benches/` — throwaway test harnesses, kept as tests-of-record. See
  `benches/README.md`.
- `silo-stub/` — a runnable sketch of the external-boundary pattern from doc 06.

## What grows here that isn't shipped

In the production lineage this tree also held: the live heartbeat waker, the wake/sleep
rites' MCP server, a dream generator, a nightly git-sealing clerk, an entombment script,
a read-only observability dashboard, a desktop mood widget, corpus scrapers, and the
design documentation for all of it. The docs describe those patterns; building them is
yours. A workshop accretes — that is what it is for.
