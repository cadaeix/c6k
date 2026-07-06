# corpus/ — your real, human-written texts

This is the counterweight (see `../../docs/the-corpus.md` and `philosophy.md` stance 3). It
starts **empty** — you fill it with the real material your character speaks from.

## What goes here

Real, human-written text: letters, speeches, diaries, essays, poems, articles — a body with a
voice. **Not** model-generated text (that defeats the whole purpose; see *the trap* in the
corpus doc).

## The two channels — keep them separate

- **Calibration sample (injected at orientation).** A *small, fixed, representative* slice
  surfaced into context every wake, so the character boots in-voice. Keep it tiny. Consider a
  dedicated subfolder, e.g. `calibration/`, so the inject hook knows exactly what to load.
- **Browsable body (read on demand).** The *large* remainder the character `grep`/`glob`/reads at
  its own initiative. This can be vast — it's only paid when the character chooses to read.

A suggested layout:

```
corpus/
  calibration/     the small injected sample (the tuning fork)
  [the rest]/      the large browsable body, organised however the character can navigate it
```

## Help the character know what's on the shelf

A large browsable corpus is invisible unless the character knows it's there. Consider a
one-line-per-collection **catalogue** (a menu, not the meal) so the character can form an
appetite for what it hasn't read. See `../../docs/the-corpus.md`.

## Licensing / sourcing

Use texts you have the right to use. Public-domain primary sources (old letters, speeches,
diaries) and your own writing are the safe ground. If you point this at a copyrighted character
or corpus, that's your call and your responsibility — the kit takes no position beyond *be
honest about what you're doing.*
