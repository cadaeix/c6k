#!/usr/bin/env bash
# renew-arm.sh -- UserPromptSubmit hook. Arms the DESCENT rite on the /renew knock
# and clears what does not cross the river. SILENT.
#
# Fires only when the prompt is exactly /renew -- the ceremony knock, typed by the
# maker or injected by a waker; the skill is disable-model-invocation, so the
# character cannot pour this cup for itself. On any other prompt: exit, touch nothing.
#
# Two jobs:
#   1. Arm the renew cursor ({"i": 0}) so the mcp__rite__renew tool will answer.
#      (Fail-safe pairing: if this hook never fires, the rite stays warmly closed.)
#   2. Clear the things that do not cross the river (the .gitignore boundary, enforced
#      at the descent): the declared mood -- state file removed, the declared word
#      blanked back to open air with the menu comment preserved (mirroring mood.sh's
#      own reset exactly). If you add transient stores (chat dispatches, scratch
#      sheets), wipe them here too.
#
# Emits nothing: arming is machinery, not weather. Requires jq; degrades to silence
# (a missed arm leaves the rite closed, which is the safe direction).

KNOCK="/renew"
RENEW_STATE="${RENEW_RITE_STATE:-../workshop/rite/_renew_state.json}"
MOOD_FILE="bellpull/mood.md"
MOOD_STATE=".claude/hooks/mood-state.txt"

command -v jq >/dev/null 2>&1 || exit 0

prompt="${TEST_PROMPT:-}"
if [ -z "$prompt" ]; then
  prompt="$(cat | jq -r '.prompt // empty' 2>/dev/null)"
fi
prompt="$(printf '%s' "$prompt" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
[ "$prompt" = "$KNOCK" ] || exit 0

# 1. arm the descent
printf '{"i": 0}' > "$RENEW_STATE" 2>/dev/null

# 2. the mood does not cross the river
rm -f "$MOOD_STATE" 2>/dev/null
if [ -f "$MOOD_FILE" ]; then
  tmp="${MOOD_FILE}.tmp.$$"
  awk '!f && /^[[:space:]]*<!--/ {f=1; print ""; print ""} f {print}' \
    "$MOOD_FILE" > "$tmp" && mv "$tmp" "$MOOD_FILE"
fi
exit 0
