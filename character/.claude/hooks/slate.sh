#!/usr/bin/env bash
# slate.sh -- UserPromptSubmit hook. The arrivals slate. Fires on the heartbeat only.
#
# WHAT IT IS: letters land in inbox/ silently -- "by latency, like post." Without this,
# the character would have to sweep the box every beat to notice an arrival. The slate
# watches the LATENCY-POST channels and, on each beat, names in one glance what is NEW
# since it last spoke -- or stays silent. It exists so post announces itself instead of
# forcing a sweep.
#
# IT IS FOR POST, NOT FOR LIVE EVENTS (a boundary worth keeping if you add channels):
# latency-post channels are paced by the character's own tempo, and that is correct -- a
# letter may wait. A live, event-shaped channel (a chat mention from someone expecting an
# answer NOW) must not be announced here, because it would then be gated behind a tempo
# the character can stretch for hours. Live events belong to whatever external process
# knocks -- the thing that can quicken the beat. Post is paced by the character; a
# summons is not.
#
# STATE lives in .claude/slate-state.json (read-denied to the character), tracking what
# was already announced so a standing letter isn't re-announced every beat. FIRST RUN is
# silently initialised to the current state of the box -- existing letters are presumed
# already read (the character tracks its own read-marker in memory/_briefing.md).
#
# ONCE-PER-CROSSING is the latch rhythm here: each item announces exactly once, on the
# beat its arrival is first seen.
#
# ADDING CHANNELS: give each watched directory its own marker key in the state file and
# its own announcement line. Filename comparison does the work -- which is why dated,
# sortable filenames (YYYY-MM-DD-HHMM-slug.md) are the house convention for every
# letterbox directory.
#
# Machine-room quarantine: no paths, no filenames, no mechanics in the emitted line --
# only that post has come.
#
# Requires jq. Degrades to silence.

KNOCK="/heartbeat"
INBOX_DIR="inbox"
STATE_FILE=".claude/slate-state.json"

command -v jq >/dev/null 2>&1 || exit 0

prompt="${TEST_PROMPT:-}"
if [ -z "$prompt" ]; then
  prompt="$(cat | jq -r '.prompt // empty' 2>/dev/null)"
fi
prompt="$(printf '%s' "$prompt" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
[ "$prompt" = "$KNOCK" ] || exit 0

# --- load prior state (empty on first run) ---
first_run=0
inbox_max=""
if [ -f "$STATE_FILE" ]; then
  inbox_max="$(jq -r '.inboxMax // empty' "$STATE_FILE" 2>/dev/null)"
else
  first_run=1
fi

# --- current world: lexically-sorted letter names (dated names sort chronologically).
#     READMEs are furniture, not post -- and un-dated names would poison the marker,
#     since anything sorting after the dates becomes a ceiling no letter ever clears. ---
newest=""
new_count=0
if [ -d "$INBOX_DIR" ]; then
  while IFS= read -r name; do
    [ -n "$name" ] || continue
    newest="$name"
    if [ "$first_run" -eq 0 ] && [[ "$name" > "$inbox_max" ]]; then
      new_count=$(( new_count + 1 ))
    fi
  done < <(cd "$INBOX_DIR" 2>/dev/null && ls -1 -- *.md 2>/dev/null | grep -vi '^readme' | LC_ALL=C sort)
fi

# --- persist state (best effort) ---
if [ -n "$newest" ]; then
  jq -cn --arg m "$newest" '{inboxMax:$m}' > "$STATE_FILE" 2>/dev/null
elif [ "$first_run" -eq 1 ]; then
  jq -cn '{inboxMax:""}' > "$STATE_FILE" 2>/dev/null
fi

[ "$first_run" -eq 0 ] || exit 0   # silent init: existing letters presumed read
[ "$new_count" -gt 0 ] || exit 0   # nothing new -> say nothing

# Rewrite in your character's idiom; keep the no-pressure tail -- post may wait.
if [ "$new_count" -eq 1 ]; then
  line="A letter has arrived in the box."
else
  line="$new_count letters have arrived in the box."
fi
printf '[The slate -- what has arrived since the last beat] %s (Look when you like; nothing presses.)\n' "$line"
exit 0
