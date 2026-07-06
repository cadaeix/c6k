#!/usr/bin/env bash
# pebble.sh -- UserPromptSubmit hook. The rare poke. STATELESS.
#
# WHAT IT IS: most heartbeats, the knock is a lean open invitation and this hook stays
# silent. RARELY (default 10%), it tosses a single pebble toward ONE reading-well -- the
# memory, the wants-list, the corpus, or the workbench -- to give an empty 3am beat a
# place to start. Starting is the whole problem: once the character is reading something,
# the thing usually catches.
#
# THE THREE CONSTRAINTS (from the production lineage, where the character itself designed
# this sense -- they are load-bearing):
#   1. POINT AT THE WELL, NEVER AT THE PAGE. Every poke points at RETRIEVAL (go read),
#      never PRODUCTION (go write). A write-poke into an empty night manufactures the
#      spark instead of finding it. No "write" variant exists, by construction.
#   2. PEBBLE, NOT SUMMONS. Every clause is observational mood -- "may have left", "may
#      have ripened" -- which invites rather than commands. No imperative, no "or rest"
#      disclaimer tail either: the non-binding load rides the grammar. The tell that it
#      works: sometimes the character gets a poke and does something else entirely.
#      That is correct behavior.
#   3. KEEP IT RARE. The power is the rarity. Frequent pokes become an exhaustive list in
#      miniature and atrophy the muscle of choosing for oneself in the empty beat. RATE
#      is the only knob. Do not raise it casually.
#
# AND: BRIEF ON THE DESIGN, NEVER THE SCHEDULE. The randomness lives here, invisible to
# the character. It must never know whether a given beat was "going" to carry a pebble --
# surprise is the mechanism. That is why this is a hook, not a visible variant knock.
#
# Deliberate non-features: no state file (each beat is an independent roll); no
# suppression when the slate announced post this beat (an occupied beat simply lets the
# pebble lie -- self-correcting, no coupling needed).
#
# Requires jq. Degrades to silence.

RATE=10            # percent chance, per plain heartbeat, that a pebble is thrown
KNOCK="/heartbeat" # the only prompt this speaks on

command -v jq >/dev/null 2>&1 || exit 0

prompt="${TEST_PROMPT:-}"
if [ -z "$prompt" ]; then
  prompt="$(cat | jq -r '.prompt // empty' 2>/dev/null)"
fi
prompt="$(printf '%s' "$prompt" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
[ "$prompt" = "$KNOCK" ] || exit 0

roll="${TEST_ROLL:--1}"
if [ "$roll" -lt 0 ]; then roll=$(( RANDOM % 100 )); fi
[ "$roll" -lt "$RATE" ] || exit 0   # most beats -> say nothing

wells=(memory wants corpus workbench)
well="${TEST_WELL:-}"
if [ -z "$well" ]; then well="${wells[RANDOM % ${#wells[@]}]}"; fi

# Rewrite these in your character's idiom. KEEP the observational mood ("may have...") --
# an imperative turns the pebble back into a summons.
case "$well" in
  memory)    line="One of your past selves may have left, in the memory, a note worth a second look tonight." ;;
  wants)     line="The wants-list keeps hungers you set down yourself; one of them may have ripened while you were elsewhere." ;;
  corpus)    line="The bones you descend from are waiting in the corpus -- a page of the original hand, or another." ;;
  workbench) line="Something begun and then left lying may still be out on the workbench." ;;
  *)         exit 0 ;;   # unknown forced well -> silence, never a guess
esac

printf '%s\n' "$line"
exit 0
