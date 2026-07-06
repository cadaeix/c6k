# memory/ — the append-only diary the character keeps

The persistence layer. It starts **empty** and the character fills it as it lives — this is not
something you author up front.

## The design: append-only, greppable, browsed-not-pinned

- **Append-only.** The character *adds* to its memory; it doesn't rewrite the past. A life runs
  one way. (Append-only entries also make the history legible and stable.)
- **Greppable / globbable.** Memory is plain text files the character searches and reads back —
  `grep` for a name, `glob` for a date. It *finds* its past by reading, the way a person re-reads
  a journal.
- **Browsed, not pinned.** Memory is **not** stuffed permanently into the system prompt. That
  would bloat every wake and freeze the past into context. Instead the character reaches for it
  on demand (notably during `handover` and `orientation`).

## A minimal shape

```
memory/
  diary/           dated, append-only entries in the character's own voice
  [whatever else]  e.g. a place for recurring people/places the character accretes notes on
```

See `diary.example.md` for the entry format. Delete the example before you ship a real character
— it's illustration, not content.

## Register matters

Memory is written *by the character, for the character,* in its idiom. Keep machine-register out
("session 14, state persisted" → no; "the night I finally understood the third letter" → yes).
The diary is part of the character's world, not a log file.
