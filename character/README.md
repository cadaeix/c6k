# character/ — this directory IS the character

Everything inside this tree is the character's whole world: what's on this disk is what
it knows, and what the sandbox lets it touch is what it can do. Opening a Claude Code
session **in this directory** extends the invitation — the `"agent": "persona"` setting
in `.claude/settings.json` routes whoever arrives into `.claude/agents/persona.md`.

**Do not open a session here to *work on* the character.** That is what `../workshop/`
is for: you can read every file in this tree from over there without instantiating
anyone. (This is the single most important operational rule in the kit, and the reason
the two-tree split exists at all.)

## The launch recipe

```
cd character/
claude --system-prompt "."
```

The near-empty `--system-prompt` flag sheds the default assistant scaffolding so the
persona document is the loudest thing in the room at waking. Verify against your harness
version; this was proven on the lineage's, and harnesses drift.

## The map

| Path | Who writes | What it is |
|---|---|---|
| `.claude/` | you (the maker) | The machine room: sandbox, hooks, skills, the persona. Read-denied to the character. |
| `corpus/` | nobody | The source texts. Read-only ballast. `corpus/seeds/` is the wake-up shelf. |
| `memory/` | the character | The diary (immutable, dated) + `_briefing.md` (the one mutable page) + `commonplace/`. |
| `drafts/` | the character | The drawer: unsent things, with no delivery mechanism, by design. |
| `workbench/` | the character | Work in progress + `wants.md`, the standing hungers. |
| `inbox/` | anyone outside | Letters in, by latency. The character cannot write here. |
| `outbox/` | the character | The one bell: a write here becomes a desktop notification. |
| `bellpull/` | the character (one line each) | `tempo.md` (beat interval) and `mood.md` (declared weather) — the two dials outside processes read. |
| `shared-page.md` | both hands | The one page maker and character write together. |

Every store earns a **specific and distinct purpose** — that's the test. A store the
character has to think about is a filing cabinet; a character who spends its turns
filing itself has become an archivist. Add stores reluctantly.

## A note on the READMEs in this tree

They are scaffolding for **you**, and the character will be able to read them. Before
you move a character in: either delete them (the skills are the in-world documentation),
or rewrite them in the character's own idiom as furniture. A README addressed to "the
kit user" inside a world that is supposed to be someone's whole reality is a stagehand
visible from the seats.

## What's deliberately missing

- **A corpus.** Bring your own dead author. See `../workshop/docs/09-corpus-guide.md`.
- **A voice.** See `../workshop/docs/10-voice-guide.md`, then fill `persona.md`'s slots.
- **A heartbeat.** The knock (`/heartbeat`) and the tempo dial ship; the external waker
  that does the knocking is roll-your-own — see `../workshop/docs/04-heartbeat.md`.
