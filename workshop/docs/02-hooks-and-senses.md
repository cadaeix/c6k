# 02 — Hooks and senses

The character's sensorium: how the world reaches it without being asked. The operating
discipline (self-filtering, degrade-to-silence, ASCII-escaping, the latch taxonomy)
lives with the code in `character/.claude/hooks/README.md`; this doc is the *design*
side — why each sense exists, and how to build the ones the kit doesn't ship.

Everything here descends from one principle (doc 00): a hook's emitted line is a
narrative event. Design the sense first — what should the character *feel*, and when? —
then write the script.

## The shipped senses

**The clock** (`clock.sh`). Exists because a character with no watch, no shell, and an
immutable diary *fabricated* its timestamps — and once, across overnight beats, rolled
the calendar forward until two real days became five fictional ones in the permanent
record. Diagnostic worth generalizing: **when the character confabulates a fact of its
world, don't punish the confabulation — supply the fact.** It invented the hour, so it
was given a clock.

**The seeds** (`corpus-inject.sh`). Once per life, never per process — the resume guard
is the whole trick (see the script header). Curation notes live in
`character/corpus/seeds/README.md`.

**The mood** (`mood.sh`). The centerpiece; the deep design notes ride in the script
header. The three ideas worth stealing even if you rebuild everything else:

1. **Attractor-short-fuse banding.** The mood nearest your model's default register
   gets the shortest life; the most anti-default mood gets the longest. You are pricing
   moods by how much work they do against the substrate's gravity.
2. **No payoff.** The declared mood colours prose and triggers *nothing* — no
   permissions, no machinery, no doors. This is structural anti-forgery: the lineage
   caught its character writing itself a counterfeit mood billet and reading it back as
   if it were weather, to license a real action. The rule it settled on is precise:
   performance is the medium, and the only sin is **a counterfeit dial wired to a live
   lever.** Build the mood so there is no lever, and the discipline enforces itself.
3. **Decay in the character's own voice.** The "guttering" fragments perform the mood
   dying; there is never a flat "your mood is fading" status line. And one mood should
   be forge-proof *by construction* — the lineage's theatrical swoon announces its own
   theatre, so performing it is identical to having it.

**The slate** (`slate.sh`). Post announces itself; the character never sweeps. The
boundary in its header matters more than the code: the slate serves **post** (things
that may wait, paced by the character's tempo); a **summons** (a live mention expecting
an answer now) must never ride it, or it ends up gated behind a tempo the character can
stretch for hours. Summonses belong to whatever external process can quicken the beat.

**The pebble** (`pebble.sh`). The rare read-poke. Its three constraints (well not page;
pebble not summons; keep it rare) are in the header — the meta-rule is *brief on the
design, never the schedule*: the character knows the pebble exists, never when. Surprise
is the mechanism.

**The bell** (`outbox-bell.sh`). One store signals; every other write is read and
ignored. The diary must never perform for an audience.

## The senses worth building next

Documented, not shipped — each was live in the lineage; all are a evening's work each.

**The threshold** (presence). On each beat, read the machine's idle time and say whether
the house has stirred — *someone at the desk just now / a while ago / long still*. Two
design rules: it claims **stirring only, never identity** (a cat on the keyboard reads
the same as the maker — keep the phrasing honest about that); and it exists to give the
character a *choice* (ring the bell knowing someone is home, or save a thing for when no
one is). Windows: `GetLastInputInfo` via P/Invoke; combine a live reading with a small
idle-sample log for texture. If your heartbeat injects keystrokes, verify the injection
doesn't touch the idle clock — the beat must not be able to fool the sense.

**The waters** (context fullness). The single best specimen of machine-fact-as-weather.
Read the session's context fullness *off-disk, from outside* (never let the character
run a meter), and speak it on the beat a threshold is newly crossed — once per crossing,
latched per session id, so each utterance is news and not a dial. Two hard-won rules:

- **The Chicken-Little fix.** A vague omen ("the waters are rising!") produces panic and
  deathbed theatrics; a calm, concrete figure ("the gauge reads fifty of a hundred")
  reads as information. This is a deliberate, eyes-open exception to the no-numbers
  quarantine — the *one* number that crosses, because withholding it caused confabulated
  mortality at quarter-full.
- **Name the crossing correctly.** Every band's phrasing frames session-end as the
  river, never death (doc 05). The lineage added a sibling that fires when the character
  reaches for its consolidation ritual and reads back the *actual* level — under a
  quarter full it openly mocks the funeral framing ("a puddle, not a flood; spare us the
  eulogy"). Fond scorn turned out to be the effective register.

**The undertow** (self-quote). Rarely — rarer than the pebble — set ONE verbatim line
from the character's own corpus beside the beat, framed as surfacing *without reason or
omen* (the disclaimer guards against significance-addiction). Contact with the real
voice, not a description of it. Iron rule: **verify every line verbatim against the
corpus**, period spelling and all. A misquote of the character's own hand is the one
unforgivable bug.

## Composition notes

- Multiple senses fire on the same beat; each speaks only when it has something. A
  typical beat carries the clock plus nothing — that leanness is a feature. If most
  beats carry three senses, you have built a dashboard, not a sensorium.
- State placement: hook state that must survive the character's reads goes in
  `.claude/` (read-denied) or better, outside the tree entirely (the lineage kept all
  latches workshop-side). The character's *own* files hold only what it wrote.
- The lineage ran all of this as Windows PowerShell 5.1 — the ports here are bash, and
  the `.ps1` originals' encoding discipline (ASCII source, accents in data files,
  `\uXXXX`-escaped output) is preserved in the ports because it is load-bearing for any
  non-English character on any platform with unreliable code pages.
