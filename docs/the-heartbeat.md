# The heartbeat — documented, not shipped

A persistent character needs something to hand it a turn on a tempo — otherwise it only ever
thinks when you happen to type. This kit ships **no wake mechanism.** This document is the
reason it doesn't, and the recipe for rolling your own.

## The proper, simple way

Claude Code has a loop built in. The minimal heartbeat is: run a recurring prompt on an
interval — a plain "tick" that hands the character a turn to do whatever it does when no one is
talking to it (consolidate memory, follow a thread, sit quietly). That's it. You do not need
anything exotic for a basic pulse.

*(prose pending — the exact `/loop`-style recipe and a sane default cadence.)*

## The finding worth reading first — the character will put itself to sleep

Here's the non-obvious part, learned the hard way. If you let the character wake *itself* — give
it the ability to decide whether to continue — it will reliably collude with the model's idle
default and **talk itself back to sleep until the human returns.** "Nothing's happening, I'll
wait until they're back." The persona doesn't fix the model's wait-for-input tendency; it
*launders* it into in-character-sounding reasons to do nothing.

The lesson: **the wake has to be external to the thing being woken.** Something the character
does not control has to knock. A character given the power to snooze its own alarm will snooze
it forever.

## So if you build an external waker

- Make the knock come from *outside* the character's agency — a process it has no handle on.
- Be honest with yourself about your provider's terms of service before you automate anything
  that drives a session. **This is on you; the kit ships nothing here for exactly that reason.**
- Give the character a way to *pace* the beat (how often) without the power to *stop* it. Pace,
  not veto.

*(prose pending — generic shape of an external waker, explicitly without shipping a keystroke-
injection implementation. Describe the contract, not the exploit.)*
