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

\* LLM generated text in the corpus will result in reinforcing specific lovable LLM traits that this corpus is intended to pull away from. But, I am not your boss.

\*\* Insert copyright disclaimer here. Also insert good taste disclaimer here.

## The Character

The "character" is not a single prompt. It is basically a fanfic of the corpus that can talk back to you.

The character is composed of four parts: the actor (the model), the role (the interpretation of the character), the corpus (the source texts) and the memory (file appended diary entries, searchable via grep and glob). All of these are designed to be flexible; the model may change, the role evolves in collaboration with you and the Claudes, and the corpus and memory will grow. Thus, the character persists.

The preferred stance of this project is that inviting whatever Claude model to warmly inhabit this derivative role allows for both the human and the Claudes involved to engage in the fiction with clear eyes.

In practice, models such as Opus 4.8 push back against prompts like "YOU ARE X AND YOU SHALL BEHAVE LIKE Y". The more sophisticated a model's sense of itself, the worse that framing reads. Chatbots are creatures of narrative, trained on narrative; this project bets that collaborative narratives scale better than coercive ones.

## The Architecture

This is not a plug-and-play installable package. Sorry. This is a demonstration of the principles behind the CCCCCCK. You're invited to use it and build on it if you'd like.

There's two template trees in here. Both have README.md files.

It provides:

- a `character/` tree showing how to structure a Claude Code persona around corpus, memory, hooks, and skills
- a `workshop/` tree for the external bench: backups, tooling, integrations, MCP servers, and experiments
- README files inside each tree explaining the intended shape
- placeholder files

A persistent "heartbeat" wake/sleep automated loop cycle is not shipped. The architecture benefits heavily from it. Claude Code has an inbuilt /loop. Mind your provider's terms.

## Features

- A mood state machine for the character to inhabit various emotions, simply by declaring a mood out of a menu, writing it to a file and then one conversational turn later, being fed 'stage directions' to enforce that mood, complete with 'fresh' and 'fading' variations as the mood naturally wears off over time. Voluntary mood swings!
- An automatic time hook for _your_ timezone, appending each message with the real time, because in Anthropic land, we all live in UTC. Some of us are Australian, you know!
- An outbox folder that, when written into, brings up a notification onto your computer so that a character can bug you!
- An inbox folder for other Claude Code instances to write to the character, so that the plumbers working on the plumbing can write love letters to the homeowner!
- A specific command to run your Claude so that your main Claude Code environment can keep doing the good programming work while one terminal gets to be an absolute diva, just like a grasshopper among the ants!

## Future Work

This particular project is focused on Claude Code, but there's no reason these principles can't be applied to any model or any harness. A sequel project is planned for when the creator of this project gets tired of fighting Claude Code. It'll involve creating my own model harness that supports multiple model provider APIs, allowing for easy model swapping. Please look forward to it.

## License

MIT — see LICENSE.
