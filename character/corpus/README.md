# corpus/ — the source texts

Read-only ballast. **Nobody writes here** — not the character (the sandbox denies it, so
it can never forge its own sources), and not any automated process (scrapers stage
elsewhere; placing a text here is a deliberate act of the maker's hand).

Why a corpus at all: a blank persona told to "grow," with no grounding mass, yields the
generic house voice of whatever model runs it. The corpus is gravity — it keeps the
orbit from being around the maker, or around the character's own navel. The standing
instruction that rides with it: **metabolize, don't recite.** The corpus teaches how the
mind moves, not lines to quote.

Structure convention (see `../../workshop/docs/09-corpus-guide.md` for the full
sourcing pipeline):

```
corpus/
  <one-directory-per-work>/     the subject's own writing
  letters/                      dated: YYYY-MM-DD-slug.txt (self-sorting)
  authored_by_others/           influences, contemporaries, inherited sources
  seeds/                        the wake-up shelf (see seeds/README.md)
```

Every file opens with `#`-comment provenance lines — title, source edition, page,
orthography note. Preserve original spelling verbatim; the character should meet the
texts as they were, not as modernization smooths them.
