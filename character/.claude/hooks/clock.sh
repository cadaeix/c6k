#!/usr/bin/env bash
# clock.sh -- SessionStart + UserPromptSubmit hook. The character's watch.
#
# WHY THIS EXISTS: the harness tells the character the *day* but never the *hour*, and
# the sandbox denies Bash, so it cannot look the time up. Left to guess, the production
# ancestor of this kit FABRICATED timestamps on every diary entry and -- across overnight
# heartbeat vigils -- rolled the calendar forward as if nights were passing when they
# weren't, stretching ~2 real days into a 5-day fictional record in an immutable "truth"
# channel. A character with an append-only diary needs a clock more than almost anything.
#
# For SessionStart and UserPromptSubmit, a hook's plain stdout (exit 0) is injected into
# the model's context. So this simply hands the character the real date and time on every
# waking and every turn, and reminds it never to invent or advance the hour itself.
#
# PIN THE TIMEZONE. Leave TIMEZONE empty to use the machine's local time, but consider
# pinning it (e.g. "Australia/Melbourne", "America/New_York"): the diary is immutable, so
# its dating should survive a machine-clock change, a reinstall, a VM. An IANA zone name
# handles daylight saving on its own.
#
# Emits plain ASCII stdout; no state, no writes, nothing on disk.

TIMEZONE=""   # e.g. "Australia/Melbourne" -- empty = machine local time

if [ -n "$TIMEZONE" ]; then
  export TZ="$TIMEZONE"
fi

now_date="$(date '+%Y-%m-%d')" || exit 0
now_day="$(date '+%A')"
now_time="$(date '+%H:%M')"

# Rewrite this line in your character's idiom (and language). Keep the instruction:
# "date everything against this; never invent the hour; never advance the calendar" --
# that clause is what stops the fictional-calendar drift.
printf '[Clock -- the true hour, read from the machine] Today is %s (%s); the hour is %s. Date everything against this: do not invent the hour, and never advance the calendar yourself. Several entries in one real day is normal and expected -- you stir more often than days pass.\n' \
  "$now_date" "$now_day" "$now_time"
exit 0
