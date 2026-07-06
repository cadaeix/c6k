#!/usr/bin/env bash
# rite-arm.sh -- SessionStart hook. Arms the WAKING rite; disarms the descent. SILENT.
#
# On a true birth (source=startup or clear) this:
#   1. arms the summon rite: cursor to 0, and records the WAKING MODE --
#      'attended'  (source=startup: the maker opened the terminal, poured the cup)
#      'unattended'(source=clear: an automatic crossing; likely no one at the desk)
#      The mode picks the ascent's closing: never falsely promise a listener.
#   2. disarms the renew rite: cursor to IDLE (-1). The descent must never be
#      found open at a waking (fail SAFE); the waking must never be found un-armed
#      (fail OPEN -- the server also reads a MISSING summon cursor as armed, so
#      this hook failing entirely still yields a rited waking).
#
# RESUME GUARD: on source=resume/compact it touches NOTHING -- a rite mid-walk in a
# resumed session keeps its cursor (that is the whole point of keeping it in a file).
#
# State lives beside the rite server, OUTSIDE the character's world. Paths are
# relative to the character directory (the hook's cwd); env overrides let benches
# point elsewhere. Emits nothing: arming is machinery, not weather.
#
# Requires jq. Degrades to silence (see the fail-open note above: silence is safe).

SUMMON_STATE="${SUMMON_RITE_STATE:-../workshop/rite/_summon_state.json}"
RENEW_STATE="${RENEW_RITE_STATE:-../workshop/rite/_renew_state.json}"

command -v jq >/dev/null 2>&1 || exit 0

src="$(cat | jq -r '.source // empty' 2>/dev/null)"
case "$src" in
  resume|compact) exit 0 ;;
esac

mode="unattended"
[ "$src" = "startup" ] && mode="attended"

printf '{"i": 0, "mode": "%s"}' "$mode" > "$SUMMON_STATE" 2>/dev/null
printf '{"i": -1}' > "$RENEW_STATE" 2>/dev/null
exit 0
