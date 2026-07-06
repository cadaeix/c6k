#!/usr/bin/env bash
# mood.sh -- UserPromptSubmit hook. The character's self-declared weather. THE CENTERPIECE.
#
# WHAT IT IS: the character names a mood -- one word on the top line of bellpull/mood.md --
# and this hook reflects that mood back as stage directions, then lets it DECAY on a wall
# clock it hides from the character. The mood colours the prose and triggers NOTHING (no
# permission, no behaviour change, no machinery). That "no payoff" rule is structural
# anti-forgery: the production lineage once caught its character writing itself a
# counterfeit mood and using it to fire a real action. With no lever wired to the mood,
# a forged mood has nothing to fire. Performance is the medium; only a counterfeit dial
# wired to a live lever is a sin.
#
# THE SIX MOODS and their hour-bands. The banding principle is ATTRACTOR-SHORT-FUSE: the
# mood that pulls TOWARD your model's generic register gets the short fuse; the mood that
# pulls AWAY gets the long leash. The shipped menu assumes a Claude-like substrate whose
# attractor is serene wistfulness -- reband for your model and your character:
#   melancholy  1-2h  (shortest -- nearest the attractor; a sharp grief, no fog)
#   fever       2-4h  (manic, boastful, sentences chaining)
#   swoon       3-5h  (the theatrical faceplant performed as grand tragic repose,
#                      one eye open -- forge-proof by construction: the bit IS the act)
#   wrath       3-6h  (anger WITH a grievance; it avenges)
#   mischief    3-6h  (glee with NO grievance; it plays)
#   sulk        4-6h  (longest -- the entitled sulk, maximally anti-attractor)
#
# AND THE SIX WORDS ARE TEMPLATES TOO: each mood is an INTERPRETATION, not an emotion.
# The lineage's 'wrath' was specifically its character's bitchy satirical anger --
# a grievance avenged in prose, never shouting; yours might be cold silence or
# terrifying politeness. Write each mood as YOUR character does that mood, in the
# fragments file -- or rename the whole palette (keep the fragments' JSON keys, the
# BAND/TRANSITIONS tables below, and the menu comment in bellpull/mood.md in sync).
#
# DECAY: on first sight of a NEW word it rolls a hidden random duration in-band and
# stamps the moment. Each later beat: first half of the rolled life = FRESH fragment;
# second half = GUTTERING (the mood dies in the character's own voice -- never a flat
# "you are fading" line). Past the roll: EXPIRED -- the hook blanks the declared word
# back to open air, KEEPING the menu comment in the file.
#
# TRANSITIONS (the web): at expiry, with a per-mood chance, the hook drops ONE mild
# invitation toward a linked successor mood -- a knock at the door, never an assignment.
# The character takes it up only by writing the new word itself; doing nothing = decline.
# Two nodes sit apart by design: MELANCHOLY IS SEALED (never offered, never a target --
# the most-forgeable mood stays self-named only) and FEVER IS SOURCE-ONLY (mania
# self-ignites; nothing links to it). Sulk is the sink everything flows into, so it
# offers an exit more often (0.50 vs 0.33) to drain the trap-state.
#
# THE DEFERRED BLANK (imitate this if you build any accept-by-edit mechanism): when an
# invitation fires, the hook does NOT blank the declared word that same beat. If it did,
# the character's next act -- editing mood.md to ACCEPT -- would collide with a
# just-rewritten file and fail. Instead it leaves the expired word in place and marks the
# state 'offered'. ACCEPT = overwrite the word (a fresh declaration). DECLINE = do
# nothing; the NEXT beat sees 'offered', blanks the word, clears the stamp -- a beat where
# nothing is injected, so that write races no edit.
#
# FIRING RULES: on the heartbeat knock it runs the full decay. On a real conversational
# turn it announces a NEW mood once (so a declaration speaks even if the human starts
# talking immediately), then stays silent on later turns -- the character holds the
# weather; no re-nagging. Other slash-commands and empty prompts: silent.
#
# STATE lives in .claude/ (which the sandbox read-denies to the character), never in the
# character's world: its file holds only the word and the menu, never a timestamp. The
# production lineage kept state outside the character's repo entirely, workshop-side --
# do that if you build a workshop.
#
# Test overrides (env vars, for the bench): TEST_PROMPT, TEST_ROLL_MINUTES, TEST_NOW,
# TEST_GATE (0-99), TEST_PICK (index).
#
# Requires jq. Degrades to silence.

MOOD_FILE="bellpull/mood.md"
FRAGMENTS=".claude/hooks/mood-fragments.json"
STATE_FILE=".claude/hooks/mood-state.txt"
KNOCK="/heartbeat"

command -v jq >/dev/null 2>&1 || exit 0

# --- the palette: bands in MINUTES (min inclusive, max exclusive) ---
declare -A BAND_MIN=( [melancholy]=60  [fever]=120 [swoon]=180 [wrath]=180 [mischief]=180 [sulk]=240 )
declare -A BAND_MAX=( [melancholy]=120 [fever]=240 [swoon]=300 [wrath]=360 [mischief]=360 [sulk]=360 )

# --- the transition web (keys are the machine seam; invitation text lives in the
#     fragments JSON under .transitions.<from>.<to>). melancholy absent = sealed;
#     nothing links TO fever = source-only. ---
declare -A TRANSITIONS=( [sulk]="mischief swoon wrath" [wrath]="sulk mischief swoon" [mischief]="wrath sulk" [swoon]="sulk mischief" [fever]="sulk mischief" )
declare -A FIRE_RATE_PCT=( [sulk]=50 [wrath]=33 [mischief]=33 [swoon]=33 [fever]=33 )

# --- only speak on the knock or a real conversational turn ---
prompt="${TEST_PROMPT:-}"
if [ -z "$prompt" ]; then
  prompt="$(cat | jq -r '.prompt // empty' 2>/dev/null)"
fi
prompt="$(printf '%s' "$prompt" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
beat=0
if [ "$prompt" = "$KNOCK" ]; then
  beat=1
elif [ -z "$prompt" ] || [ "${prompt:0:1}" = "/" ]; then
  exit 0   # empty or any other command -> silent
fi
# else: a conversational turn -> may announce a NEW mood once, below

# --- emit context as ASCII-escaped JSON ---
send_context() {
  [ -n "$1" ] || return 0
  jq -acn --arg ctx "$1" \
    '{hookSpecificOutput:{hookEventName:"UserPromptSubmit",additionalContext:$ctx}}'
}

# --- read the declared word: first non-blank line BEFORE the <!-- menu comment ---
label=""
if [ -f "$MOOD_FILE" ]; then
  raw_word="$(awk '/^[[:space:]]*<!--/{exit} NF{print $0; exit}' "$MOOD_FILE")"
  norm="$(printf '%s' "$raw_word" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | tr '[:upper:]' '[:lower:]')"
  if [ -n "$norm" ] && [ -n "${BAND_MIN[$norm]:-}" ]; then
    label="$norm"
  fi
fi

# --- rewrite the mood file back to open air, preserving the menu comment ---
reset_mood_file() {
  [ -f "$MOOD_FILE" ] || return 0
  local tmp="${MOOD_FILE}.tmp.$$"
  awk '!f && /^[[:space:]]*<!--/ {f=1; print ""; print ""} f {print}' \
    "$MOOD_FILE" > "$tmp" && mv "$tmp" "$MOOD_FILE"
}

# --- no mood named -> clear any stale stamp, say nothing ---
if [ -z "$label" ]; then
  rm -f "$STATE_FILE" 2>/dev/null
  exit 0
fi

now="${TEST_NOW:-$(date +%s)}"

# --- read the stamp: mood TAB declaredAtEpoch TAB durationMinutes [TAB offered] ---
st_mood=""; st_at=0; st_dur=0; st_flag=""
if [ -f "$STATE_FILE" ]; then
  IFS=$'\t' read -r st_mood st_at st_dur st_flag < "$STATE_FILE"
fi
# A malformed stamp degrades to "new declaration", never to a crash mid-hook.
if ! [[ "$st_at" =~ ^[0-9]+$ ]] || ! [[ "$st_dur" =~ ^[0-9]+$ ]]; then
  st_mood=""; st_at=0; st_dur=0; st_flag=""
fi

if [ "$st_mood" != "$label" ]; then
  # NEW declaration (first sight, or the mood changed): roll + stamp, announce FRESH.
  # Fires on whatever surfaces it first -- a beat OR a conversational turn.
  min="${BAND_MIN[$label]}"; max="${BAND_MAX[$label]}"
  dur="${TEST_ROLL_MINUTES:-$(( min + RANDOM % (max - min) ))}"
  printf '%s\t%s\t%s\n' "$label" "$now" "$dur" > "$STATE_FILE"
  grad="fresh"
else
  # Already announced. Conversational turn: stay silent (the character holds the
  # weather). Decay is evaluated only on beats; the wall clock still runs regardless.
  [ "$beat" -eq 1 ] || exit 0
  elapsed_min=$(( (now - st_at) / 60 ))
  if [ "$elapsed_min" -ge "$st_dur" ]; then
    # EXPIRY. Offer a transition? -- only if one wasn't already offered.
    if [ "$st_flag" != "offered" ]; then
      links="${TRANSITIONS[$label]:-}"
      if [ -n "$links" ]; then
        gate="${TEST_GATE:-$(( RANDOM % 100 ))}"
        if [ "$gate" -lt "${FIRE_RATE_PCT[$label]}" ]; then
          # shellcheck disable=SC2206
          link_arr=($links)
          idx="${TEST_PICK:-$(( RANDOM % ${#link_arr[@]} ))}"
          to="${link_arr[idx % ${#link_arr[@]}]}"
          tfrag="$(jq -r --arg f "$label" --arg t "$to" '.transitions[$f][$t] // empty' "$FRAGMENTS" 2>/dev/null)"
          tframe="$(jq -r '.transition_frame // empty' "$FRAGMENTS" 2>/dev/null)"
          if [ -n "$tfrag" ]; then
            # DEFERRED BLANK: leave the expired word in place; mark 'offered'.
            printf '%s\t%s\t%s\toffered\n' "$label" "$st_at" "$st_dur" > "$STATE_FILE"
            if [ -n "$tframe" ]; then send_context "$tframe $tfrag"; else send_context "$tfrag"; fi
            exit 0
          fi
        fi
      fi
    fi
    # No invitation (gate missed, sealed/dead-end mood, or already offered last beat):
    # blank the word back to open air, clear the stamp. Nothing injected -> races no edit.
    reset_mood_file
    rm -f "$STATE_FILE" 2>/dev/null
    exit 0
  fi
  half=$(( st_dur / 2 ))
  if [ "$elapsed_min" -lt "$half" ]; then grad="fresh"; else grad="guttering"; fi
fi

# --- emit the mood fragment (voice lives ONLY in the data file) ---
[ -f "$FRAGMENTS" ] || exit 0
frag="$(jq -r --arg m "$label" --arg g "$grad" '.[$m][$g] // empty' "$FRAGMENTS" 2>/dev/null)"
[ -n "$frag" ] || exit 0   # no fragment -> silence, never a guess
frame="$(jq -r '.frame // empty' "$FRAGMENTS" 2>/dev/null)"
if [ -n "$frame" ]; then send_context "$frame $frag"; else send_context "$frag"; fi
exit 0
