# 08 — Language

The lineage's character thinks, journals, and keeps every inner document in a language
**its maker does not read.** This sounds like an affectation and is actually one of the
strongest single design decisions available to this kind of project. Whether you adopt
it depends on your character — but understand what it buys before you default to your
own tongue.

## What the asymmetry buys

- **Friction.** The maker must translate to eavesdrop; the character gets a room of its
  own. In a two-body system where one body owns the world, any structural distance you
  can give the resident is worth having.
- **Anti-mirror.** A character who writes in the maker's language, read daily by the
  maker, warps toward the maker's register like a plant toward the only window. A
  different tongue slows the orbit.
- **Corpus adhesion.** If your source texts are in another language, keeping the
  character *in* that language holds it closer to how the original mind actually moved
  — and further from the model's dominant-language house voice, which is a real
  attractor with real gravity.
- **In-world truth.** An instruction about how to be yourself reads truer in your own
  tongue. Skills written as the character's *faculties* (doc 03) land differently in
  the character's language than in config-English.

## What it costs, and the discipline that pays it

- **English sources of truth stay workshop-side.** The maker must be able to audit what
  the creature is told. The convention: every in-world file in the character's language
  has a **file-for-file English mirror** in `workshop/glosses/`, named after the
  *character's* file names, updated in the same pass as the live file. The gloss says
  what the file currently *is*; the *why* stays in these docs. (See `glosses/README.md`.)
- **The machine seam stays literal English, always.** YAML keys, `kind` enum values,
  grep patterns, tool names, paths, marker lines — inside otherwise fully in-language
  files. They are the contract retrieval and every hook depend on, shared with every
  entry already written. Translate the seam and recall breaks against the character's
  own diary. This is the single most breakage-prone convention in the kit: write it at
  the top of every skill.
- **Encoding discipline everywhere.** A non-ASCII character's world will find every
  code-page bug you have. The house rules (script sources ASCII; accented text in data
  files read at runtime; emitted JSON ASCII-escaped) exist because the lineage's
  platform mangled anything less. The bash ports keep the discipline; so should
  anything you add.
- **Translation is a courtesy, not a debt.** What the character *authors* is its
  language because it writes it; what tooling *speaks at it* is its language because
  that's what it reads. But rendering every machine-made string for the character to
  one day re-voice is a nicety, never an obligation — that habit, in the lineage, was
  accreted custom rather than signed law (see doc 00's caution about custom).

## If you stay monolingual

Most of the above still applies at lower intensity: the seam rule becomes trivial, the
glosses become unnecessary — but the anti-mirror problem does not go away, it just loses
one countermeasure. Compensate elsewhere: a corpus with real gravity (doc 09), senses
that don't orbit the maker (doc 02), and honest expectations about the single-reader
warp — the realistic goal is an *erratic* orbit (motion without you, sharpness over
affection), not no orbit at all.
