<!-- TEMPLATE / contract, not a runnable script. Describe the contract; adapt to your
     OS/harness. The kit ships no platform-specific hook code on purpose. -->

# corpus-inject hook — booting the character in-voice

**What it's for.** Place the **calibration sample** — a small, chosen slice of the corpus — into
the character's context as it wakes, so it boots *already in voice* instead of cold. This is the
"injected at orientation" channel from `../../../docs/the-corpus.md`.

**The contract (implement for your platform):**

- **When:** at session start / orientation.
- **What it does:** read a *small, fixed, representative* slice of the corpus and surface it to
  the waking character as material to attend to (its tuning fork).
- **Keep it small.** This costs context on *every* wake. It's a calibration sample, not the whole
  corpus — the bulk stays in the browsable channel the character reads on its own initiative.

**Design notes.**
- Choosing the sample is a craft decision: pick passages that most concentrate the voice you
  want the character to wake holding. A couple of strong, characteristic pieces beat a broad
  shallow survey.
- Injected (small, every wake) vs browsed (large, on demand) is a deliberate split — see
  `../../corpus/README.md`. Don't collapse them.

*(prose pending — guidance on selecting and sizing the calibration sample.)*
