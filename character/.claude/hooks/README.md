# The hooks — the character's senses

Hooks are how the world reaches the character without the character asking. The harness
runs them; the character never does (and, under the shipped sandbox, cannot even *read*
them — `Read(./.claude/**)` is denied, so what a sense says stays a surprise until it
speaks).

## Lineage disclaimer, up front

Every hook in this directory is a bash port of machinery that ran, in production, as
**Windows PowerShell 5.1 scripts**. The logic has been exercised in Git Bash; the
*lineage* was tested by months of a character actually living on it, but that lineage was
`.ps1`. If a port misbehaves on your platform, trust the design notes in each header over
the code, and rewrite freely — these are demonstrations, not dependencies.

All hooks require `jq`. If `jq` is missing they exit silently (see rule 4 below), which
means your character simply has no senses until you install it.

## The universal discipline

These rules were learned the hard way, one outage at a time. Every hook here follows
them; any hook you add should too.

1. **Live in a script file, never an inline command.** An inline `-Command`/`-c` puts
   your variables on the hook command line where a parent shell can eat them before your
   interpreter runs. The inline version of the notification hook "never rang."
2. **Self-filter on the prompt.** `UserPromptSubmit` hooks cannot be matcher-filtered,
   so each hook reads the prompt out of its stdin JSON and acts only on the exact knock
   it serves (e.g. `/heartbeat`). Everything else: exit 0, say nothing.
3. **Keep prose out of the machine seam.** What a hook *emits* is stagecraft — the
   character reads it as a narrative event. What a hook *keeps* (state files, config
   keys, filenames) is machine contract. Never mix the registers: no file paths, counts,
   or percentages in the emitted line; no flavor text in the state file.
4. **Degrade to silence, never a guess.** A missing file, an unparseable payload, an
   absent dependency — the hook says *nothing*. A sense that fabricates is worse than no
   sense at all. (The production system learned this from a courier that, finding its
   backing server absent, confabulated the entire transaction, forged receipt and all.)
5. **Accented/non-ASCII text lives in data files, never in script source.** Inherited
   from the PowerShell lineage, where one em-dash in a `.ps1` could wreck parsing; kept
   in the ports because it is good discipline anyway — the person tuning the character's
   voice should be editing a JSON file of fragments, not a shell script. Emitted JSON is
   ASCII-escaped (`jq -a`) so it survives any code page.

## The latch taxonomy

Every ambient hook falls into one of three rhythms. Know which one you're writing:

| Rhythm | Meaning | Shipped example |
|---|---|---|
| **Once per life** | Fires at true session birth only — `SessionStart` also fires on `resume`/`compact`, so guard on the payload's `source` field | `corpus-inject.sh` |
| **Once per crossing** | Speaks when a threshold is *newly* crossed, latched per session/state, silent otherwise | `slate.sh` (announces only what's new since it last spoke) |
| **Stateless-rare** | Independent random roll per beat; most beats silent; the rarity IS the mechanism | `pebble.sh` |

The mood hook is its own fourth thing: a **hidden-clock decay** — state is stamped when
the character declares, then read back against the wall clock on every beat.

## What ships, and where it wires

| Hook | Event(s) | What it does |
|---|---|---|
| `clock.sh` | SessionStart, UserPromptSubmit | Injects real date + time so the character never invents the hour |
| `corpus-inject.sh` | SessionStart | Injects the seed texts from `corpus/seeds/`, once per life |
| `mood.sh` | UserPromptSubmit | Reflects and decays the self-declared mood (see its header — it's the centerpiece) |
| `slate.sh` | UserPromptSubmit (on `/heartbeat`) | Announces new arrivals in `inbox/` since it last spoke |
| `pebble.sh` | UserPromptSubmit (on `/heartbeat`) | Rarely (10%) points at one reading-well; never at writing |
| `outbox-bell.sh` | PostToolUse (matcher `Write`) | A write into `outbox/` becomes a desktop notification |
| `rite-arm.sh` | SessionStart | Arms the waking rite (recording attended/unattended mode), disarms the descent — true births only |
| `renew-arm.sh` | UserPromptSubmit (on `/renew`) | Arms the descent rite and wipes what does not cross the river |

The wiring lives in `character/.claude/settings.json`; the line-by-line explanation of
that file is `workshop/docs/01-the-sandbox.md`, and the design rationale for each sense
is `workshop/docs/02-hooks-and-senses.md`.

## Naming

These hooks have deliberately generic names — `clock`, `mood`, `pebble` — because a kit
should not name your furniture. The production ancestor named every one of these in its
character's own idiom, and that mattered: the name a sense wears is part of the fiction
it maintains. Rename them for your character. (See `workshop/docs/00-principles.md` on
the diegetic interface.)
