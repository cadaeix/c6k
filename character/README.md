# character/ — the character itself

This tree is **the thing that gets instantiated.** Opening Claude Code inside a directory like
this (once you've filled it in) is what wakes the character.

**It does not run as shipped.** Every persona-shaped file here is a placeholder. There is no
default character to boot — that's the kit's whole stance (see the top-level README, *"Why it
doesn't run"*).

## To use it

1. **Copy this whole tree out** into its own working directory, next to — *not inside* — a copy
   of `../workshop/`. See `../docs/the-boundary.md`.
2. Fill in, editing **from the workshop**, not from here:
   - `corpus/` — your real human-written texts (see `corpus/README.md`).
   - `.claude/agents/character.md.example` → your invitation system-prompt.
   - `.claude/settings.json.example` → your settings (wire in the agent + hooks).
   - the skills in `.claude/commands/` — orientation, handover, re-immersion.
   - the hooks in `.claude/hooks/` — date-stamp, corpus-injection (adapt to your platform).
   - `memory/` — leave empty; the character fills it as it lives.

## Layout

```
character/
  .claude/
    settings.json.example     wire the agent + hooks here (rename, fill in)
    agents/
      character.md.example    THE INVITATION. the most important file. see its comments.
    commands/
      orientation.md          the waking / step-into-the-role skill
      handover.md             how a session hands off to the next
      re-immersion.md         go re-read the corpus when drifting toward assistant-voice
    hooks/
      date-stamp.md           log time/date so the character has a sense of when it is
      corpus-inject.md        place the calibration sample at orientation
  corpus/                     YOUR texts. injected-sample vs browsable. see README.
  memory/                     append-only diary the character greps/globs. starts empty.
```
