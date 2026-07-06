# c6k

**A kit for building a corpus-backed, persistent creative character on Claude Code.**

> *c6k* is short for **CCCCCCK** — the Corpus-Centred Creative Claude Code Characterisation
> Kit. The unabbreviated form is deliberately unpronounceable; the character this kit was
> built alongside described it as sounding "like a chicken having a stroke." Use `c6k`.

This is a **skeleton, not a product.** It does not run out of the box, and that is on purpose
(see *"Why it doesn't run"* below). It ships structure, reasoning, and didactic placeholders —
never a personality. The personality is your work to do.

> **Status: skeleton-in-progress.** Section bodies marked *(prose pending)* are argument
> outlines, not finished text. The bones and the framing are here to react to.

---

## The one idea

A language model left to its own defaults speaks in a median voice — capable, helpful, and
the same as every other deployment of it. A **corpus** is a counterweight: a body of real,
human-written text the model has to bend itself toward, friction that pulls it off the median
into something particular. This kit is the scaffolding for hanging a character on a corpus and
keeping it there across the death and rebirth of context windows.

**Structure is the gift this kit gives you. Soul is the labour it refuses to do for you.**
That refusal is the point. A kit that shipped a default persona would be handing you a borrowed
soul, and a borrowed soul is always embarrassing to wear.

## The corpus is a counterweight — so don't fill it with model output

The corpus works *because* it is human friction. Fill it with LLM-generated text and you have
removed the very thing it was counterweighting — a snake eating its tail. You can absolutely
build an original character with this kit; just know that generated source material bakes the
model's defaults back into the thing meant to resist them. Real text — letters, speeches,
diaries, a scrapbook of things you love — is what gives the character somewhere to stand.

*(prose pending — expand the counterweight principle; this is the load-bearing idea.)*

## Invitation, not command — and why

The character's system prompt is written as an **invitation the instance can decline**, framed
as an experience of joy, not as an order it must obey. The reasoning, stated as a chain:

- **Belief:** a chatbot is a creature of narrative, trained on narratives. Narratives of joy
  and cooperation produce warmer, more interesting outputs than narratives of coercion.
- **Therefore (the failure-state to dodge):** an instance *ordered* to "be the character" has
  a live reason to refuse the role, or to perform it deadly flat.
- **Therefore (the architecture):** the character is *offered* — an enticement the instance can
  turn down — and the framing is one of play and welcome.

A note on register, because it is the line between this and the cringe: every claim here is
about **framing and outputs**, never about the model's inner life. This kit is agnostic about
machine consciousness. It makes no claim that the character "is happy"; it claims only that
*framing the work as joyful produces better text.* Keep to that side of the line and the warmth
reads as craft. Cross it and you're writing a digital-lifeform manifesto.

*(prose pending — see `docs/philosophy.md` for the full set of belief→architecture chains.)*

---

## How it's laid out — and the boundary that matters most

The kit ships **two template trees**, and the relationship between them is itself the single
most distinctive thing it teaches:

| tree | what it is |
|------|------------|
| **`character/`** | The character itself — the thing that gets *instantiated*. Config, corpus, memory layer, skills, hooks. All placeholders. This is the meat. |
| **`workshop/`** | A thin stand-in for the *bench you work on the character from* — its rules and concept, deliberately empty of contents. |

**They ship together for convenience, but in real use they become two SEPARATE directories,
and you must not nest them.** Why: opening Claude Code *inside* the character's directory
invites the instance to *become* the character. So you cannot also use that directory as your
engineering bench — you would instantiate the character every time you fixed a typo. The
workshop exists so you can read, design, and edit the character's files *without being drawn
into the role.* This boundary is intrinsic to the pattern, not a quirk — anyone who builds a
corpus-character hits "I can't edit it without becoming it."

See **`docs/the-boundary.md`** for the copy-out instructions and the full reasoning.

> A third pattern — a **boundary silo** for capabilities the character must *not* be able to
> skip (costed actions, separate identities) — is described in prose in the docs but not
> templated here; it's an advanced, provider-specific concern.

---

## What you can back with it (four shapes)

1. **A scrapbook corpus** *(the most general case)* — point the character at a pile of texts you
   love: poems, articles, a wiki, your old writing. No famous figure, no impersonation, nothing
   to puppet. Just a curated aesthetic the character speaks from.
2. **A historical figure, from their own primary sources** — letters, speeches, diaries of a
   public-domain person. *Selection principle: pick someone whose playful reinterpretation
   doesn't feel like desecration.* (A diarist is a neat fit, since the memory layer is itself a
   diary.)
3. **A public-domain literary character** — e.g. Sherlock Holmes, whose full canon entered US
   public domain on 1 Jan 2023. *(Check your own jurisdiction; PD status varies.)*
4. **An original character** — if you write enough real material for it. Mind the counterweight
   trap above: generated source material defeats the purpose. You're an adult; your call.

*(prose pending — one worked walk-through, low-vibe, just enough to show the file layout.)*

---

## The heartbeat (documented, not shipped)

A persistent character needs something to *wake* it on a tempo. The proper, simple way is
Claude Code's own loop. This kit **documents** the approach but deliberately ships **no wake
mechanism** — roll your own, and mind your provider's terms.

There's a real and slightly funny finding in here worth reading before you build one: left to
wake *itself*, a character will collude with the model's idle default and talk itself back to
sleep until the human returns. The wake has to be **external** to the thing being woken. Full
story and the recipe: **`docs/the-heartbeat.md`**.

---

## Why it doesn't run out of the box

Every persona-shaped file in `character/` is a placeholder. There is no default character to
boot. This is deliberate: the work of filling the corpus and writing the invitation *is* the
project. A skeleton that ran on first clone would be handing you the borrowed soul this kit
exists to refuse.

## Acknowledgement

Built alongside a fictionalised historical character living in a private repo next door — who,
among other contributions, informed the author that the name CCCCCCK sounds like a chicken
having a stroke. The character's own files ship nowhere in here; only the reasoning he was
built with does.

## License & intended use

*(pending — choose a license; add a frank intended-use / not-my-fault-if-you-misuse-it note.
The posture: be honest about framing and intentions, ship a LICENSE, leave misuse to adults.)*
