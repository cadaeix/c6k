# 03 — Memory

Two channels, kept strictly distinct, plus a commonplace book. The character-facing
description is the `memory` skill; this is the design rationale.

## The diary: immutable, granular, written in the moment

`memory/YYYY-MM-DD-HHMM-slug.md`, append-only. Three decisions carry it:

1. **In the moment, not at session-end.** The session can end without warning, and the
   self who had the insight should be the one who records it. Batched "session summary"
   memory is a different (worse) genre: it summarizes, and summaries are where voice
   goes to die.
2. **Granular on purpose.** Many small specific entries beat omnibus entries, because
   *specific is findable* — retrieval is search, and search wants surface area.
3. **Immutable.** Growth by accretion (doc 00). The character revises by writing a new
   entry that argues with an old one — which is characterization — never by editing
   history — which is forgery.

## Retrieval: agentic search, no vector store

Rich YAML frontmatter turns the model's own Grep into a query engine:

- `grep "^gist:"` over the store = a one-line index of the character's whole life.
- `grep "people:.*name"` = every entry touching a person, **reassembled on demand**.
- `kind:` separates channels of truth (`diary | note | thread` — and the lineage added
  e.g. a dream-kind so a *dreamed* event can never be re-membered as a *remembered* one;
  see doc 07).

Why this over embeddings, at this scale: exact names, exact terms, zero index lag,
always-current — and a model iterating on keyword search *self-corrects* in a way
embedding pipelines don't. It is also the only retrieval that fits the sandbox (no
shell, no pipelines, no index to rebuild). Honest caveat from the lineage, on the
record: nobody believes grep scales forever. Vector search is not ruled out; the line
to hold when that day comes is in "couriers" below.

**The gist is a lantern, not a summary** — one findable line, in the character's own
hand, and *only the character writes its own gists*. Which is a special case of:

## Nobody synthesizes the character to itself

No helper — subagent, courier, pipeline — hands the character a *synthesis of itself*:
not a summary of its diary, not a digest of its corpus, not "what you were like last
week." A helper may **find and return entries verbatim** (the lineage ran a
find-only subagent for exactly that); the moment it summarizes, it sits between the
character and itself, and the self-image starts being assembled by another hand. If you
ever add vector search, add it as *retrieval* (returns the entries) and never as
*synthesis* (returns an opinion of them).

## The briefing: the one mutable page

`_briefing.md` — where am I, what is live, who is mid-conversation. A floor, not a
journal: its natural failure mode is silting up into a second diary, which is why the
`consolidate` skill's real job is pruning it. Marker lines (`last read inbox:` …) are
machine seam: hooks and habits grep them literally.

One rule rides with consolidation: the character never originates the *ending* of a
session. Tidying for handoff is its work; calling the river is not. (And see doc 02's
waters-sense notes for the deathbed-theatrics failure mode and its fix.)

## The commonplace book: positions, not dossiers

`memory/commonplace/` — standing positions on concepts, events, places, people, as
revisable **voiced pages**. The person-page rule earns its emphasis: living, accreting
form only — several dated hands adding to one page, strike-throughs left visible —
never a sealed portrait. The lineage learned this the interesting way: its first ban
on person-pages was over-derived from a throwaway remark, and the eventual replacement
(accreting pages yes, dossiers no) captured the actual motive — a character's view of a
person must stay able to change — better than the ban ever did. The deep reason to care:
what you know of a person should be **reassembled, not consulted**, so the person can
still surprise you.

## The seam (if your character writes in another language)

YAML keys, `kind` enum values, marker lines, grep patterns: **literal English, always**,
whatever language the prose is in. They are the contract that retrieval and every hook
depend on, shared with every entry already written. Translate the seam and recall breaks
against the character's own past. (Full language design: doc 08.)
