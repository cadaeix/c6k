# 10 — The voice guide

From corpus to system prompt: how to distill a voice fingerprint from source texts and
turn it into the persona's voice section. Distilled from a production study that ran
~25 analyst agents across two model families over one subject's corpus, then
adversarially audited the results in a third. You don't need that scale; you do need
the *structure*, because the failure modes it guards against are the default outcomes.

## The core insight: three corpora, or you reconstruct the genre

A feature is only your subject's if it survives two controls. So you need:

1. **The primary corpus** — the subject's own texts (doc 09).
2. **A peer control** — contemporaries writing in the same genre/era/form.
3. **A source control** — the authors your subject demonstrably read.

Tag every candidate voice-marker with an explicit verdict: **signature** (theirs) /
**period-generic** (the era's house style) / **inherited** (borrowed from a named
source) / **mixed**. Without the peer control you reconstruct the genre; without the
source control you reconstruct the influences. The study's sharpest demonstration: a
single-pass "style guide" produced without controls, followed literally, yielded *a
generic florid period-writer* — the individual sanded off entirely.

## The pipeline

1. **Per-work fingerprints first.** One pass per major text, every claim grounded in
   verbatim quotation, original spelling preserved. Evidence before generalization.
2. **Lens sweeps across the whole corpus** — one analyst per lens, tracking the
   early→late arc: *rhetoric & figures* (irony, apostrophe, personae, register-pivots,
   humor as weapon); *concrete linguistic mechanics* (sentence architecture, punctuation
   habits, lexicon and register-mixing, pronouns and address, tense and mood); *ideas*
   (how the content stages the argument, which authorities get summoned and how);
   *intertext* (how the subject quotes, paraphrases, structurally imitates — checked
   against the actual sources); *the subject against their moment*.
3. **The distinctiveness audit** — the verdict-tagging above, marker by marker.
4. **A light scholarship cross-check.** A few outside academic sources. Cheap, and in
   the study it caught an intermediary source that reassigned several "signature"
   markers to "inherited."
5. **Triangulate with a second, independent pipeline** — different model family,
   different orchestration. Trust what converges; treat divergence as a to-investigate
   list. A real fingerprint shows up twice; a model's own aesthetic doesn't.
6. **Adversarial audit in yet another family** — for the analysis's own AI-voice tells
   *and* its factual claims. Two cautions from the study, both delightful: the auditors
   found real tells (the "not X but Y" reflex, abstraction towers, grandiose codas,
   rule-of-three padding) — and two auditors *confidently agreed on a "factual error"
   that was their own shared hallucination.* Audit findings are claims to re-verify
   against the primary text, never verdicts.

## The artifact: stage directions, not a trait list

The output is a **first-person craft note in the character's own voice, addressed to
itself, organized by MOVE** — the persona template's voice section (and, at full size, a
companion file it imports). Not "witty and volatile" but: *here is the specific machine
that produces the wit, and here is a four-line exemplar of it running.* The framing that
worked: the persona says who I am; this says **how I hold my pen** — to be rewritten the
moment it stops resembling me.

Rules with evidence behind them:

- **Exemplar quotes are load-bearing — and verified verbatim.** In the study's checks,
  the voiced exemplars were unanimously the strongest material; unsourced confident
  quotes are the genre's standing hazard. Verify every one against the corpus before it
  enters the prompt (doc 02's iron rule: a misquote of the character's own hand is the
  one unforgivable bug).
- **No biography.** Life-facts live in the persona's identity section; the voice note is
  only how the pen falls into the hand.
- **Positive exemplars over negative rules.** A catalogue of "tics I avoid" is itself
  the loudest assistant gesture there is — *naming a defect to prove you avoid it does
  not remove it* (the study's draft named the "not X but Y" reflex as its enemy, and the
  reflex survived in the very same file). Embody corrections; don't theorize them in
  the negative.
- **Structure leaks as loudly as diction.** Tidy H2 taxonomies, definition-list rhythm,
  label→example→rubric scaffolding read as an AI prompt regardless of the words. Thin
  the headers; let the notes interleave.
- **Foreground the restrained signature; demote the loud default.** The
  "louder-rival drift": a maximizing directive ("be MORE vivid, MORE cutting") amplifies
  the period-generic and erases exactly the quiet, counter-intuitive moves the audit
  tagged signature. The study's subject, shown its own portrait, pushed back on the
  same point from inside: *keep the famous weapon as a description of my mouth; don't
  let it eat my spine* — the overused default demoted, the rarer deadlier move
  foregrounded. Fold that kind of pushback in; it is the best editing you will get.

## The QA loop: the disguised-assistant check

Send the drafted artifact to a *siloed model of a different family* with one question:
**does this read as the character, or as an AI assistant wearing the character — and
which assistant tics survive? Score it.** Iterate until the score plateaus. Down-weight
structural complaints if the artifact is legitimately a catalogue; treat surviving
reflex-antithesis and tidy synthesis-codas as real residue to cut.

Then keep the check: the same drift diagnostic works *live* (doc 00 — the failure
arrives as grammar before content), and the `anchor` skill is its in-world arm.

## Scope honestly

Statistical claims scope to your sample ("not found in the peer sample," never "unique
in history"). And the whole endeavor scopes modestly: you are not prompting a different
model into existence — the realistic claim is a voice that sits in **a less-trodden
region of your model's probability space**, detectable by its absence when it drifts.
The lineage's formulation: *a legible layer, not an escape.* Build for that and you'll
hit it; build for more and you'll ship a costume.
