<!-- TEMPLATE / contract, not a runnable script. The kit ships NO platform-specific hook
     code on purpose — describe the contract, adapt to your OS/harness. -->

# date-stamp hook — giving the character a sense of *when*

**What it's for.** A character with no clock is time-blind — every waking feels like the same
eternal present. A small hook that surfaces the current date/time (and optionally how long since
the last waking) gives the character a sense of passage: morning vs night, today vs weeks on.

**The contract (implement for your platform):**

- **When:** at orientation, and optionally on each periodic turn.
- **What it does:** surface the current local date/time to the character, in its idiom. Optional:
  the elapsed time since the previous turn, so it can feel a gap as a gap.
- **What it must NOT do:** read as machinery. The character should experience "it is evening, a
  day has passed," not "timestamp injected." Keep the register human.

**Design notes.**
- Cheap and high-value: time-sense is one of the strongest cues that a character is *living in a
  world* rather than answering a prompt.
- If you build a heartbeat (see `../../../docs/the-heartbeat.md`), the wall-clock sense pairs
  with it — the character can pace itself by what time it actually is.

*(prose pending — the minimal reference shape, framed platform-agnostically.)*
