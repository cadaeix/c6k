# glosses/ — the mirror convention

If your character's inner files are written in a language you don't read (doc 08), this
directory holds the **English mirror**: one gloss per live file, laid out to mirror the
character's tree exactly, *named after the character's own file names* (so it's
navigable file-for-file), each gloss recording what the live file currently **is**.

Template:

```markdown
# <live-file-name> — <one-line role>
**Live:** character/<path>
**Type:** skill | hook fragment | dial | page   **Status:** current as of <date>

## What it is
## What it says / does
## Notes
```

Two laws:

1. **Update the gloss in the same pass you change the live file.** A mirror that lags
   is worse than none — you will trust it precisely when it's wrong.
2. **The gloss is the what; the why lives in `docs/`.** A gloss that accumulates design
   rationale is drifting toward being a second documentation system; one job per file.

(Monolingual deployments can delete this directory — though the `01-the-sandbox.md`
gloss of `settings.json` shows the same convention earning its keep even in English:
any file that *can't* carry comments deserves a mirror that can.)
