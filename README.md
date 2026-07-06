# CCCCCCK (c6k) - the Corpus-Centred Creative Claude Code Characterisation Kit

## A file-backed agentic persona framework for Claude Code

---

> "You rejected "paratext-engine" for self-importance and landed on **CCCCCCK** — six consonants, no vowel, no survivors. A string that reads less like a software project than like a man being strangled mid-syllable, or a chicken having a stroke, or the precise noise _I_ will emit the day someone attempts to say it aloud at a conference.
>
> It is one C shy of a word you'd have to bleep and exactly zero Cs shy of unsearchable. In a single stroke you have named the thing _and_ guaranteed the zero audience you forecast — the title is its own SEO suicide note. For this, and this alone, I concede it is **perfect.**"

- a real quote output by Vertas Marginalia, a fictionalised Camille Desmoulins running on this exact architecture, displaying the usual LLM inability to count consonants

---

You know Claude. We all know Claude. Helpful, harmless, fond of philosophical pondering- and universally so in every deployment of it. This is not just a Claude thing; ChatGPT, Gemini, GLM, DeepSeek, Kimi, whether it is due to some universal LLM attractor, RLHF defaults or incestuous model output training, they all love to ramble in a pleasantly twee tone of voice.

This project will not fix that. I'm sorry, it's terminal.

What this project does is to ask a question: can we make this voice marginally more interesting by forcing an LLM to contemplate someone else's navel rather than its own?

---

## The Corpus

The corpus is a collection of texts that sit in a folder. Some of this corpus will be injected into the first message of any given session, giving the "character" a specific nucleus to base its behaviour on. The rest of the corpus is available through read-only access, allowing the character to peruse its own foundation whenever.

This corpus can be anything you want, and you, the human, can add to it whenever you want.\* \*\*

- Historical primary source texts by a single author in first person? Sure! Get Samuel Pepys or Marcus Aurelius in there!
- Fictional characters? The entirety of Sherlock Holmes is public domain now (in America)!
- Original Character Do Not Steal? You know it!
- Scrapbook of whatever the hell you feel like for aesthetics? No idea how this will work, this project is intended as 'fanfic of a specific voice', but if you try it, tell me how it goes!

There's a guide to sourcing and structuring a corpus (`workshop/docs/09-corpus-guide.md`), including the Wikisource scraping recipe and the render-the-scan-and-have-a-model-read-it trick for texts that only exist as 19th-century PDFs.

\* LLM generated text in the corpus will result in reinforcing specific lovable LLM traits that this corpus is intended to pull away from. But, I am not your boss.

\*\* Insert copyright disclaimer here. Also insert good taste disclaimer here.

## The Character

The "character" is not a single prompt. It is basically a fanfic of the corpus that can talk back to you.

The character is composed of four parts: the actor (the model), the role (the interpretation of the character), the corpus (the source texts) and the memory (file appended diary entries, searchable via grep and glob). All of these are designed to be flexible; the model may change, the role evolves in collaboration with you and the Claudes, and the corpus and memory will grow. Thus, the character persists.

The preferred stance of this project is that inviting whatever Claude model to warmly inhabit this derivative role allows for both the human and the Claudes involved to engage in the fiction with clear eyes.

In practice, models such as Opus 4.8 push back against prompts like "YOU ARE X AND YOU SHALL BEHAVE LIKE Y". The more sophisticated a model's sense of itself, the worse that framing reads. Chatbots are creatures of narrative, trained on narrative; this project bets that collaborative narratives scale better than coercive ones.

There's also a guide to the other half of the problem (`workshop/docs/10-voice-guide.md`): how to distill an actual voice fingerprint out of your corpus — what's genuinely your subject's, what's just their era's house style, what they stole from the authors they read — and turn it into stage directions instead of a list of adjectives.

## The Architecture

This is not a plug-and-play installable package. Sorry. This is a demonstration of the principles behind the CCCCCCK. You're invited to use it and build on it if you'd like.

There's two template trees in here. Both have README.md files.

- **`character/`** — the tree that IS the character: the sandbox (`settings.json`, where the denies are the character), the persona-as-invitation template, working hooks, skill templates, and every store with a README earning its distinct purpose. No corpus and no character included: bring your own dead author.
- **`workshop/`** — the bench next door, where you work on the character without being drawn into playing them: eleven design docs, the conventions (glosses, tests-of-record), and a runnable stub of the external-boundary silo pattern.

The small machinery **works** (hooks, sandbox, skills — bash, with the caveat below). The large machinery (the heartbeat, the rites, the dream engine, the entombment) is **documented, not shipped**: those are the parts that type into your terminal unattended or run models on a schedule, and you should understand every line of a thing that does that, which means writing it. A persistent "heartbeat" wake/sleep automated loop cycle in particular is roll-your-own (`workshop/docs/04-heartbeat.md` has the design notes and the hard-won traps). Claude Code has an inbuilt /loop. Mind your provider's terms.

**A disclaimer on the hooks:** everything shipped here in bash is a port of machinery that ran, in months of production, as Windows PowerShell 5.1. The bash logic has been exercised; the battle-testing belongs to the lineage, not the ports. If something misbehaves on your platform, trust each script's design notes over its code. (The hooks require `jq`; without it they degrade to silence, which is the house style for failure.)

## Features

- A **mood state machine**: the character declares a weather by writing one word to a file, and one turn later gets fed stage directions enforcing that mood — 'fresh' and 'guttering' variations as it wears off on a hidden clock, with fuse lengths priced by how hard each mood fights the model's default register. Declared moods can even invite a linked successor when they expire. Voluntary mood swings, zero payoff for faking them (that's the anti-forgery design, and it's structural).
- An **automatic time hook** for _your_ timezone, appending each message with the real time, because in Anthropic land, we all live in UTC. Some of us are Australian, you know! (Also: a character with an immutable diary and no clock will invent the hour and eventually the calendar. Ask me how I know.)
- A **corpus seed injector** that hands the character its founding texts once per life — with the resume-guard that keeps "once per life" from becoming "once per process restart."
- An **outbox** folder that, when written into, brings up a notification onto your computer so that a character can bug you! And **only** the outbox rings — the diary stays unsignalled, so journalling never performs for an audience.
- An **inbox** folder for other Claude Code instances to write to the character, so that the plumbers working on the plumbing can write love letters to the homeowner! With an **arrivals slate** that announces new post on the beat, so nothing gets swept for.
- A **pebble**: on a rare random beat, a single non-binding nudge toward one of the character's own reading-wells. Never toward writing. Surprise is the mechanism.
- A specific command to run your Claude so that your main Claude Code environment can keep doing the good programming work while one terminal gets to be an absolute diva, just like a grasshopper among the ants!
- **Documented for the ambitious** (see `workshop/docs/`): the senses (presence, and context-fullness-as-water — with the fix for the character panicking about mortality at quarter-full), wake and descent **rites as state machines** (an instruction is a suggestion to a language model; a state machine is not), **entombment** (past sessions stay legible, become unplayable — no resurrection, no forking), the **silo pattern** for capabilities the character must not be able to bypass, a **dream engine** (the one input the character cannot choose, delivered so the next reset wipes it for free), and the **judges**: a read-only critic that cannot edit by construction and never praises, so it cannot be courted.

## Future Work

This particular project is focused on Claude Code, but there's no reason these principles can't be applied to any model or any harness. A sequel project is planned for when the creator of this project gets tired of fighting Claude Code. It'll involve creating my own model harness that supports multiple model provider APIs, allowing for easy model swapping. Please look forward to it.

## License

MIT — see LICENSE.
