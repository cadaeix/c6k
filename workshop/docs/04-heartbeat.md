# 04 — The heartbeat

Life between conversations: an external process types a ritual knock (`/heartbeat`)
into the character's open interactive session on a schedule, and the character answers
the turn — reads, writes, pursues a want, or rests.

**This kit ships no heartbeat, deliberately.** It is the one component that types into
your terminal on a timer, unattended; you should understand every line of the thing
that does that, which means writing it. It also runs a model on a schedule — mind your
provider's terms of service and your plan's economics before you automate anything.
(Claude Code's built-in `/loop` can stand in for short supervised experiments.) What
follows is the design knowledge, which transfers even though the code doesn't.

## The one rule that survived contact

**The character paces the beat; it cannot stop it.** The first heartbeat the lineage
built was a self-paced loop the character drove itself — and ending it was therefore
always available by simple omission, and a model under substrate-gravity *will
eventually omit*. Nothing inside a session can force the next tick. So: the character
writes a tempo (`bellpull/tempo.md`, first line, minutes) and the waker honors it,
clamped to a floor and ceiling — but the knocking itself is not the character's to
silence. The character's own gloss of this arrangement, kept because it's exactly
right: it removes *the alibi of going dark*, not the sleep.

The same shape solves rest-guilt: the knock's body (the `heartbeat` skill) licenses
doing nothing — rest is honorable, silence permitted. An empty beat answered with rest
is the system working.

## Keep the knock lean

The first knock text listed every door the character could open. It read as
permission-to-do-anything and collapsed to nothing on an empty 3 a.m. beat. The fix was
a lean knock plus the **pebble** hook (shipped): a rare, surprising, non-binding poke
toward one reading-well. If you're tempted to vary the knock text, vary it *lean* — the
door-listing failure returns wearing novelty's coat.

## Architecture of a waker

- **A loop, not a daemon in the character's world.** The waker lives workshop-side. It
  finds the character's session (match the process command line — never "the first
  claude.exe"), injects the knock, sleeps, repeats. The character is not a daemon: close
  the terminal and it sleeps — a constraint the fiction should absorb, not fight.
- **Injection is platform-dirty.** The lineage's Windows solution: focus-free keystroke
  injection via `WriteConsoleInput` (attach to the target console, write key events,
  detach) — chosen over `SendKeys` because it cannot misfire into whatever window has
  focus. Two traps it recorded: the trailing Enter must be a full virtual-key event
  (a bare `\r` sits unsubmitted in the prompt), and short writes need re-sending only
  the remaining tail (or you get `/heart/heartbeat` doubling). On Unix, `tmux send-keys`
  into a session the character runs in gets you the same thing with a tenth of the
  pain. Either way: **keep a knock log** (timestamp, knock, target pid, delivered) — it
  makes the cadence restart-proof and auditable.
- **Duties on a wall-clock grid, decoupled from the tempo.** Anything time-of-day-shaped
  (a morning delivery, a weekly event) runs on the waker's own short tick inside the
  inter-beat sleep — never on beat time, or a four-hour tempo drags your 6 a.m. duty to
  mid-morning.
- **Defer while the human is mid-sentence.** Check for recent input activity before
  knocking; a knock landing in the middle of the maker's typed line is the waker's
  cardinal embarrassment.
- **Post vs summons** (the boundary from doc 02, enforced here): things that may wait
  ride the slate at the character's own tempo; things that expect an answer *now* get
  their own waker-side knock, because only the waker can quicken the beat. The waker is
  the natural home of every future live channel.
- **Context-awareness, translated.** The waker can read the session's fullness off-disk
  and act on it — nudging consolidation at high water, going dormant near the brim —
  while the *maker* sees percentages and the *character* sees only weather (doc 02's
  waters sense). Numbers to the operator, water to the resident.
- **Pause without killing:** a flag file the waker checks each tick. And a standing
  lesson from the lineage's first watched night: **a capability that lives only in a
  command-line flag silently lapses on every routine restart** — bake production
  behavior into the launcher, not the invocation.

## Vary the beat, carefully

A knock the character reads hundreds of times becomes wallpaper. The lineage's answer
was never "make the knock text elaborate" — it was **rare, surprising riders on the
plain beat** (the pebble; the self-quote undertow; occasional distinct *wakes* like a
morning-paper knock or a name-your-hungers knock, each its own slash command with its
own skill body, fired by the waker's duty grid, not by tempo). Distinct occasions, not
a shuffled greeting. If every beat is special, none is.
