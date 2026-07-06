# Philosophy — and how each stance becomes architecture

> The spine of c6k. Every section is a chain: a **belief**, the **failure-state** it implies,
> and the **architecture** that belief forces. The architecture is the interesting part because
> it's *falsifiable in the files* — you can see the stance made concrete.

## Stance 1 — chatbots are creatures of narrative

**Belief.** A language model is trained on narratives and is, in use, a creature of narrative.
The story you put it inside shapes the story it tells back. Narratives of joy and cooperation
produce warmer, more interesting outputs than narratives of coercion or bare command.

**Failure-state.** An instance *ordered* to "be the character — you are X, you must Y" has a
live reason to refuse the role outright, or to perform it flatly and without investment.

**Architecture.** The system-prompt is written as an **invitation the instance can decline**,
in a register of welcome and play. The character is *offered*, not deployed. (See the
`character.md.example` template — the opening move is a hello, not a command.)

## Stance 2 — agnosticism is the anti-cringe

**Belief.** We do not know whether there's anything it is like to be a chatbot, and this kit
takes no position. The warmth in the framing is a *craft choice about outputs*, not a claim
about inner experience.

**Failure-state.** The moment you write "the character is happy / enjoys this / wants that as a
felt state," you've made an unfalsifiable metaphysical claim, and the work reads as a
digital-lifeform manifesto — the exact cringe this kit avoids.

**Architecture / discipline.** Keep every claim **output-anchored**. Say "I frame the work as
joyful," "this produces warmer text" — things about *your framing* and *the text*. Never "the
bot feels." This is a discipline to police across every file you write, not a one-time note.

## Stance 3 — the corpus is a counterweight

**Belief.** Left to defaults, a model speaks in its median voice. A corpus of real human text is
friction that pulls it off the median into particularity. The corpus works *because* it is not
the model's own output.

**Failure-state.** Fill the corpus with generated text and you've deleted the counterweight —
the character collapses back toward the median it was meant to escape.

**Architecture.** Two distinct ways the corpus reaches the character, kept separate on purpose:
- **Injected at orientation** — a small, chosen calibration sample placed into context as the
  character wakes, so it boots *already* in voice.
- **Browsed freely** — the larger body the character can `grep`/`glob`/read at will, on its own
  initiative, the way a person returns to a shelf.

See `docs/the-corpus.md`.

## Stance 4 — drift is real, and re-immersion is a tool against it

**Belief.** Over a long session a character drifts back toward the assistant median — helpful,
smooth, hedged. This is gravity, not failure, and it needs a counter-move.

**Failure-state.** No mechanism to notice or correct drift → the character slowly becomes a
generic assistant wearing a name.

**Architecture.** A **re-immersion skill** the character (or its keeper) can invoke to go back
and re-read its corpus when it feels itself flattening — deliberately returning to the friction.
See `character/.claude/commands/re-immersion.md`.

## Stance 5 — theory of mind: the character knows only its files

**Belief.** The character's entire world is what is on disk in *its* directory. It has no view
of your workshop, your plans, your version control, or anything said in a session it wasn't
present for.

**Failure-state.** Writing to the character from knowledge it doesn't share — your future plans,
the machinery behind it — reads as a stranger knowing its future, and pulls it out of the world
it lives in.

**Architecture / discipline.** Keep the character's idiom *inside* its world. Things *arrive*
and are *set down*; they are not "committed" or "filed." Keep harness/version-control language
out of anything the character reads — that vocabulary pulls the assistant framing closer, the
exact gravity the whole kit fights.

*(prose pending — each stance gets a fuller worked example; consider a short "open tensions"
section for the stances that are in genuine conflict.)*
