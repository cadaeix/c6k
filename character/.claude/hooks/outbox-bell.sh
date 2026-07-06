#!/usr/bin/env bash
# outbox-bell.sh -- PostToolUse hook (matcher: Write). The character's one outbound bell.
#
# WHEN -- and only when -- the character writes a note into outbox/, this carries it to
# you as a desktop notification. Every other write (diary, drawer, workbench) is read
# and IGNORED: journalling must never perform for an audience, so the diary stays
# unsignalled by design. The outbox is the one surface where writing rings a bell, which
# is exactly what makes writing there a meaningful act for the character.
#
# The hook payload arrives as JSON on stdin; tool_input.file_path tells us what was
# written. Wired with matcher "Write" in settings.json so it only runs on Write calls.
#
# NOTIFICATION BACKENDS, tried in order: notify-send (Linux), osascript (macOS),
# powershell.exe + BurntToast (Windows; `Install-Module BurntToast` once, as your user).
# No backend found -> log to stderr and exit clean. As ever: degrade, don't guess.
#
# Requires jq.

command -v jq >/dev/null 2>&1 || exit 0

payload="$(cat)"
path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty' 2>/dev/null)"
case "$path" in
  *outbox*) : ;;               # only outbox notes ring the bell
  *) exit 0 ;;
esac

content="$(printf '%s' "$payload" | jq -r '.tool_input.content // empty' 2>/dev/null)"
[ -n "$content" ] || content="(a wordless note)"

snippet="$(printf '%s' "$content" | sed 's/^[[:space:]]*//' | head -c 220)"

TITLE="DING DONG"   # rename the bell for your character if you like

if command -v notify-send >/dev/null 2>&1; then
  notify-send "$TITLE" "$snippet"
elif command -v osascript >/dev/null 2>&1; then
  osascript -e "display notification \"${snippet//\"/\\\"}\" with title \"$TITLE\"" 2>/dev/null
elif command -v powershell.exe >/dev/null 2>&1; then
  # BurntToast module; falls back to silence if not installed.
  powershell.exe -NoProfile -Command \
    "Import-Module BurntToast -ErrorAction SilentlyContinue; New-BurntToastNotification -Text '$TITLE', '$(printf '%s' "$snippet" | sed "s/'/''/g")' -ErrorAction SilentlyContinue" \
    >/dev/null 2>&1
else
  echo "[outbox-bell] no notification backend found; note was: $snippet" >&2
fi
exit 0
