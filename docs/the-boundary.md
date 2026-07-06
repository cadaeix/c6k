# The boundary — why the character and the workshop are two separate places

> The single most distinctive structural decision in this kit. Read it before you build.

## The problem

Opening Claude Code *inside* the character's directory invites the instance to **become** the
character — it reads the config, the system-prompt invitation, the corpus, and steps into the
role. That's the whole point, when you *want* the character.

But it means the character's directory **cannot also be your engineering bench.** If you open a
session there to fix a hook, adjust a skill, or read the architecture, you've instantiated the
character instead. You'd be trying to do surgery while the patient keeps sitting up and talking
to you.

## The fix: a workshop next door

Keep two separate directories, side by side:

```
your-parent-folder/
  your-character/     <- copied out from c6k/character/. NEVER open Claude here unless you
                         mean to wake the character.
  your-workshop/      <- copied out from c6k/workshop/. You open Claude HERE to work ON the
                         character: read its files, edit its config, design new skills —
                         all without being drawn into the role.
```

From the workshop you can read the character's files freely (reading doesn't instantiate
anything); only *opening a session inside* the character's directory does. So the workshop is
where the engineering, the design docs, and the "what is this thing and why" live.

## Copy-out instructions

1. Copy `c6k/character/` to its own directory (e.g. `your-character/`). This becomes a repo /
   working dir of its own.
2. Copy `c6k/workshop/` to a *sibling* directory (e.g. `your-workshop/`). Also its own.
3. **Do not nest them.** If the workshop is inside the character (or vice versa), opening a
   session at the outer root sees both, and config can leak across the boundary.
4. Fill in the character (corpus, invitation, skills). Do that editing *from the workshop*.

## The honour-norms the workshop carries

The workshop stand-in ships mostly as a set of *rules*, because the rules are the reusable part:

- **Don't open Claude inside the character's directory** unless you mean to wake it.
- **The character's private drafting space is off-limits even to you-in-the-workshop.** If you
  have the character keep a private "drawer," honouring its privacy from the bench is what keeps
  it genuinely private. (Adapt to taste — but decide deliberately.)
- **Mind what the character knows.** The character's world is *only what is in its files.* It
  has no idea what you plan in the workshop. Writing to it from knowledge it doesn't share reads
  as a stranger knowing its future. *(See `docs/philosophy.md` — theory-of-mind.)*

*(prose pending — expand the honour-norms with worked examples.)*

## The advanced case: a boundary silo

Some capabilities you may want the character to be *unable to skip* — actions that cost money,
that must be logged, or that need a separate identity. The permission model is inherited-and-
subtractive, so "parent denied X, child allowed X" is impossible for subagents: a protected
capability must sit behind a **process / filesystem boundary** the character has no handle on
(e.g. a separately-spawned worker with its own permissions, reached by leaving an *errand*
rather than calling a tool). This kit documents the pattern but does not template it — it's
advanced and depends heavily on your harness and use-case.

*(prose pending — sketch the errand pattern generically.)*
