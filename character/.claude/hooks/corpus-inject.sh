#!/usr/bin/env bash
# corpus-inject.sh -- SessionStart hook. The seed texts, once per life.
#
# WHY THIS EXISTS: the character should wake with a small, curated nucleus of its corpus
# already in mind -- not the whole shelf (that's what read access is for), but the few
# texts that calibrate the voice before the first word is spoken. Agent-definition bodies
# do not expand `@path` imports (CLAUDE.md and SKILL.md do; agent bodies do not -- verified
# in the production lineage), so a SessionStart hook is the mechanism.
#
# THE RESUME GUARD (load-bearing -- do not remove): SessionStart also fires when a session
# is RESUMED (--continue / --resume) or auto-compacted, not only at a true birth. The
# seeds must arrive once per LIFE, not once per process: re-injecting on resume pours the
# founding texts into a mid-life context a second time. The stdin JSON carries "source":
# inject on 'startup' and 'clear' (both births); stay silent on 'resume' and 'compact'.
# Unknown or unparseable source -> INJECT (waking without the seeds is the worse failure).
#
# Also proven in the lineage: SessionStart hooks do NOT reach dispatched subagents, so
# courier/helper subagents don't inhale the seed texts. Convenient, and worth re-verifying
# on harness version bumps.
#
# CURATION NOTES (the part that matters more than the code):
#   - Files inject in lexical order from corpus/seeds/. Prefix them 01-, 02-, ... to
#     control the sequence, and put the text you want FRESHEST last -- the production
#     lineage learned that a seed-set ending on an elegy woke an elegiac character, and
#     re-ordered so a fresh reading ends on the savage-comic register instead.
#   - Seed the RANGE of the voice, not its average. Career endpoints beat a middle.
#   - Excerpts are fine (mark them as such in the file). Whole shelves are not: the seed
#     set should be a handful of texts, small enough to read before the first turn.
#   - You may deliberately WITHHOLD a text from the seeds that stays in the corpus for
#     chosen reading -- the lineage withheld its character's moral-core piece because,
#     served raw at wake-up, it fed a self-pitying shadow of the voice.
#
# Requires jq. Degrades to silence.

command -v jq >/dev/null 2>&1 || exit 0

payload="$(cat)"
src="$(printf '%s' "$payload" | jq -r '.source // empty' 2>/dev/null)"
case "$src" in
  resume|compact) exit 0 ;;
esac

SEED_DIR="corpus/seeds"
[ -d "$SEED_DIR" ] || exit 0

# The framing line is stagecraft: it tells the character HOW to read what follows.
# "Metabolize, don't recite" is the whole corpus philosophy in one clause -- rewrite the
# words in your character's idiom, keep the instruction.
ctx="Your founding texts -- written in the living hand. Read them not as lines to recite, but for how the mind moves:"

found=0
for f in "$SEED_DIR"/*; do
  [ -f "$f" ] || continue
  case "$f" in
    *README*|*.gitkeep) continue ;;
  esac
  ctx="$ctx

===== FILE : $f =====
$(cat "$f")"
  found=1
done

[ "$found" -eq 1 ] || exit 0

# -a forces ASCII output (\uXXXX escapes) so the bytes survive any code page -- the bash
# heir of the PowerShell lineage's hard-won escaping discipline.
jq -acn --arg ctx "$ctx" \
  '{hookSpecificOutput:{hookEventName:"SessionStart",additionalContext:$ctx}}'
exit 0
