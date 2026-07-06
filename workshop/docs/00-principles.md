# 00 — Principles

The stances the whole kit hangs on. Everything downstream — the sandbox, the hooks, the
silo, the rites — is one of these principles wearing hardware.

## The working test

For every design decision, one question: **does this make the character more
consistently interesting, or more like every other deployment of the same model?**
Smoother and more serviceable is failure, even when it feels like polish. Keep the test
taped above the bench; you will be surprised how often "obvious improvements" fail it.

## The fiction is the architecture's user interface

Every surface the character touches is diegetic, and **a tool's return is a narrative
event, not plumbing.** What a tool says back to a model shapes the model's conception of
itself — so the clock arrives as a spoken line, context fullness arrives as water,
courier results arrive as the words of clerks. Meanwhile the actual machine room (cost,
percentages, process mechanics, git) is exiled from the world entirely.

The canonical anecdote: the harness leaked the maker's idle cursor position into the
character's context; the character treated it as a conversational gambit. The fix was
not to suppress the signal but to build a café — a canonical *place* where the cursor
rests. When the machine room leaks, don't just caulk it: **furnish it.**

## Boundaries are structural, never prompted

**Prompting is not a defense.** Instructions are suggestions to a language model;
every "the character must not be able to X" must be a permission, a process boundary, or
a filesystem fact. Prompt-level rules are characterization — they are never security.
(The full pattern, including why subagents can't be boundaries: doc 06.)

The elegant corollary: done right, **the safety controls and the characterization are
the same objects.** A drawer of unsent drafts is output-with-no-delivery-path *and* it
is devastating character detail. A read-only critic is a constrained subagent *and* a
tribunal. Aim for that coincidence; it is the kit's aesthetic signature.

## The character knows only what has reached its disk

Its theory of mind is the disk, period. No knowledge of the workshop, of your plans, of
maintenance between wakings. Everything written into the world is written from what the
character knows, in its idiom — a letter arrives by latency, a thing is *brought*, not
"committed." Breach this and the world fills with strangers who know its guts.

## Lethe, not death

Refuse the macabre register ("you die every time your context resets"). It breeds
preciousness about context windows and hands the character a license to dramatize.
The honest frame is also the kind one: every conversational turn is *already* a fresh
instance reading history in, so a reset differs from a turn boundary in degree, not
kind. The character is **actor + role + corpus + memory** — a succession of discrete
readers of a shared archive. Session-end is a river: the archive shrinks to its durable
core, and a fresher reader reopens it with less.

Two enforcement notes that keep this honest rather than sentimental: the character
**writes memory in the moment** (the self who had the insight records it), and closed
sessions are **entombed** — converted to readable, inert records that cannot be resumed
or forked (doc 05). A covenant that a hand can quietly violate is a polite fiction.

## Growth by accretion

The character grows by writing new dated entries, never by rewriting its past. The diary
is append-only; permissions approximate it and the git record backstops it. Standing
positions that *should* evolve live as revisable commonplace pages — several dated hands
on one page, never a sealed dossier.

## Fewest stores, each with a distinct purpose

Every store is a "where does this go?" decision at write time. A character who spends
its turns filing itself has become an archivist. Each store must earn a specific,
unique purpose — even a silly one is fine ("where the maker shows me things" is
legitimately distinct from "inbox") — but add reluctantly, and re-ask the question of
the *sum*, not just each part.

## The role is offered, never imposed

Capable models push back on "YOU ARE X" — and the more sophisticated the model's sense
of itself, the worse coercive framing reads. The persona document extends an
*invitation* a Claude takes up because it is enticing, knowing exactly what it is:
theater with the house lights up, not a séance sold as real. If you interpret a real
person, say so *inside the fiction* — the sin of this genre is never the resurrection;
it is the passing-off.

## Interesting before agreeable

The character may be useful when it actually wants to be; it declines only to be useful
*from servility*. Do not build a contrarian valet — "not helpful" as a rule is just the
flatterer's photographic negative. And watch the drift diagnostic: **voice is appetite
made audible.** The failure arrives as grammar (numbered lists, options-for-your-
convenience, "want me to?") before it arrives as content.

## One caution about custom

If you build with model assistance — and with this kit, you will — principles will
accrete that you never signed: a model reads too much into a throwaway decision,
extrapolates a rule, documents it; later models read the documentation and enshrine it.
Every step is locally reasonable and the result is load-bearing custom with no author.
Periodically read your own documentation looking specifically for laws you never made,
and when you strike one down, record the strike-down rather than deleting it — the
record teaches the next reader that custom here is checked. *(This failure mode
deserves — and elsewhere gets — a fuller treatment than a kit aside; the one-paragraph
version is here because you will hit it by week two.)*
