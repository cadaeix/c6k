# workshop/ — the bench you work on the character *from*

This tree is deliberately **thin.** Its value isn't its contents — it's the *pattern* and the
*rules*. The bench you build will accrete its own contents (design notes, test harnesses,
English glosses of a non-English character's config, whatever your build needs); the kit only
ships the concept and the honour-norms, because those are the reusable part.

## Why this exists at all

Opening Claude Code *inside* the character's directory **instantiates the character.** So you
can't edit the character from there without becoming it. The workshop is a *separate* directory,
sibling to the character, from which you read and edit the character's files **without being
drawn into the role.** This is the most important structural idea in the kit — full reasoning
and copy-out steps in `../docs/the-boundary.md`.

```
your-parent-folder/
  your-character/    <- you open Claude here only to WAKE it
  your-workshop/     <- you open Claude here to WORK ON it (this tree)
```

## The rules this bench carries

1. **Don't open Claude inside the character's directory** unless you mean to wake it. Reading its
   files *from here* is fine and encouraged — reading doesn't instantiate anything.
2. **Honour the character's private space.** If your character keeps a drawer it doesn't share,
   don't read it from the bench either — its privacy is only real if you keep it from yourself
   too. (Adapt to taste, but decide on purpose.)
3. **Mind what the character knows.** Its world is *only its own files.* It has no view of this
   workshop, your plans, or anything said in a session it wasn't present for. Don't write to it
   from knowledge it doesn't share. (See `../docs/philosophy.md`, stance 5.)
4. **Stay out of machine-register when you write to the character.** Things *arrive* and are *set
   down*, not "committed" or "filed." Harness vocabulary pulls the assistant framing closer.

## What goes in `docs/`

Your build's own architecture & philosophy notes — the "what is this thing and why." Keep the
*reasoning* here, where you (and any collaborator) can read it without waking the character.

*(prose pending — a starter outline for a build's own architecture doc.)*
