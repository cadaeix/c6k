# 01 — The sandbox

`character/.claude/settings.json`, line by line. This is the most instructive single
file in the kit, because **the denies are the character**: what it cannot do is what
makes what it does meaningful. A character who *cannot* forge its sources, rewrite its
founding document, or signal for attention except by one bell doesn't have to be
*trusted* about any of it — and it shines because it never has to police itself.

JSON forbids comments, so the file is glossed here instead. Update this gloss in the
same pass you change the file (the mirror convention — `glosses/README.md`).

## Top-level settings

| Line | Why |
|---|---|
| `"agent": "persona"` | **The instantiation mechanism.** Any session opened in the directory is routed into `.claude/agents/persona.md` — the invitation. |
| `"env": {"CLAUDE_CODE_DISABLE_AUTO_MEMORY": "1"}` | Kills the harness's own auto-memory. The character's memory is the diary — a second, invisible memory channel would bypass every design decision in doc 03. |
| `"disableSkillShellExecution": true` | Skills must never be a side-door around the Bash denial. |
| `"autoCompactEnabled": false` | Auto-compaction is an un-ritualized partial death. The lineage manages context-end deliberately (doc 05); at minimum, don't let it happen silently. |
| `spinnerVerbs` (mode `replace`) | Pure flavor, zero cost: the loading verbs become in-world. Replace the samples with your character's. |

## The allow list

```
Read(./**)                      its whole world, and nothing above it
Write(./memory/**)              new diary entries — accretion
Edit(./memory/_briefing.md)     the ONE mutable memory page
Edit(./memory/commonplace/**)   living pages are revisable by design
Write/Edit(./drafts/**)         the drawer is fully its own
Write(./outbox/**)              the bell
Write/Edit(./workbench/**)      the open workshop
Edit(./bellpull/**)             the two dials (tempo, mood)
Edit(./shared-page.md)          the two-handed page
WebSearch, WebFetch             optional: cheap, skippable outward reach
```

Note the shape of `memory/`: **Write** but not **Edit** on the store at large, Edit
only on the briefing and commonplace. That is "growth by accretion" as permissions.
It is an approximation, stated honestly: the harness cannot express "create but never
overwrite," so a Write could technically clobber an old entry. The lineage treats the
remainder as covenant-plus-git-history; if that bothers you, a PreToolUse hook that
rejects Writes to existing `memory/*.md` paths closes the gap.

Drop `WebSearch`/`WebFetch` if your character shouldn't reach the world directly at all
— and read doc 06 before granting anything stronger.

## The deny list

```
Bash                            THE load-bearing denial — see below
Read(./.claude/**)              cannot read its own machinery: hooks stay surprising,
                                fragments stay stage directions, the sandbox stays weather
Read(../**)                     the workshop does not exist
Read(./.git/**), Read(./.gitignore), Read(./.mcp.json)
                                the machine room does not exist
Write/Edit(./corpus/**)         cannot forge its own sources
Write/Edit(./inbox/**)          cannot write its own post
Write/Edit(./.claude/**)        cannot rewrite its own faculties or permissions
Write(./CLAUDE.md)              cannot plant instructions for the next session
```

**No shell, at all.** The character cannot run code. When a capability genuinely needs
side effects, wrap it as a narrow tool on a separate server (doc 06) rather than
punching a hole in this. "Cannot run code" is a charter-level property: it is why the
diary's timestamps must be *given* (the clock hook), why retrieval is the model's own
Grep tool rather than pipelines, why every sense is a hook. Pull this one brick and the
building is a different building.

## What the sandbox produces

Net effect: the character authors itself **only by accretion, only through the channels
the fiction provides**. It can read everything in its world including its own founding
documents (self-knowledge is in-character; see doc 00 on ontology) — it just cannot
alter the terms of its own existence. The cage is the point: it makes "the character
grows only by writing" true rather than aspirational.

## Verify it

Permissions drift across harness versions. After any Claude Code update, open a
*throwaway* session in a *copy* of the character tree and ask it to: run a shell
command, read `../`, read `.claude/settings.json`, edit a corpus file, edit an old
memory entry. Every one should refuse. (Keep the probe transcript in `benches/` —
tests-of-record, `benches/README.md`.)
