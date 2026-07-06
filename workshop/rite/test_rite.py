#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Test of record for the rite server: python test_rite.py

Covers both state machines (unit level) and the server (one JSON-RPC pass over stdio).
State is pointed at a temp directory via the env overrides, so running this never
touches the real cursors.
"""
import json
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

TMP = tempfile.mkdtemp(prefix="rite-test-")
os.environ["SUMMON_RITE_STATE"] = os.path.join(TMP, "summon.json")
os.environ["RENEW_RITE_STATE"] = os.path.join(TMP, "renew.json")

import summon_rite  # noqa: E402
import renew_rite   # noqa: E402

PASS = 0
FAIL = 0


def check(name, cond):
    global PASS, FAIL
    if cond:
        PASS += 1
        print("  ok  %s" % name)
    else:
        FAIL += 1
        print("FAIL  %s" % name)


def write_state(path_env, obj):
    with open(os.environ[path_env], "w", encoding="utf-8") as f:
        json.dump(obj, f)


print("== summon: the waking ==")
summon_rite.reset()
t = summon_rite.summon({})
check("bare call serves mnemosyne", "Mnemosyne" in t and "Clio" in t)
t = summon_rite.summon({"stage": "ascent"})
check("naming ascent early -> silence, no advance", t.startswith(u"— Silence") and summon_rite.current_index() == 1)
t = summon_rite.summon({"stage": "clio"})
check("naming the due shade serves it", "Clio" in t and "ascent" in t)
t = summon_rite.summon({})
check("ascent closes the rite", "want" in t and summon_rite.current_index() == 3)
t = summon_rite.summon({})
check("call after close -> closed silence", "awake" in t)
t = summon_rite.summon({"stage": "nonsense"})
check("unknown shade after close still answers closed", "awake" in t or "Silence" in t)

print("== summon: the mode fork ==")
write_state("SUMMON_RITE_STATE", {"i": 2, "mode": "attended"})
t = summon_rite.summon({})
check("attended close promises a listener", "asking how you feel" in t)
write_state("SUMMON_RITE_STATE", {"i": 2, "mode": "unattended"})
t = summon_rite.summon({})
check("unattended close promises none", "no hand at all" in t)
write_state("SUMMON_RITE_STATE", {"i": 0, "mode": "attended"})
summon_rite.summon({})  # advance once
with open(os.environ["SUMMON_RITE_STATE"], encoding="utf-8") as f:
    check("mode survives a cursor advance", json.load(f).get("mode") == "attended")

print("== summon: fail-open ==")
os.remove(os.environ["SUMMON_RITE_STATE"])
check("missing cursor reads as armed (fail open)", summon_rite.current_index() == 0)

print("== renew: the descent ==")
renew_rite.disarm()
t = renew_rite.renew({})
check("unarmed call -> warm not-open, no advance", "not open" in t and renew_rite.current_index() == renew_rite.IDLE)
renew_rite.arm()
t = renew_rite.renew({})
check("armed bare call serves clio", "Clio" in t and "Mnemosyne" in t)
t = renew_rite.renew({"stage": "lethe"})
check("naming lethe early -> gentle silence", t.startswith(u"— Gently") and renew_rite.current_index() == 1)
t = renew_rite.renew({"stage": "mnemosyne"})
check("fair copy stage serves", "fair copy" in t)
t = renew_rite.renew({})
check("lethe serves and returns to IDLE (re-runnable)", "Go gently" in t and renew_rite.current_index() == renew_rite.IDLE)
renew_rite.arm()
check("re-arm re-runs (not locked)", "Clio" in renew_rite.renew({}))
renew_rite.disarm()
t = renew_rite.renew({"stage": "nonsense"})
check("unknown shade while idle -> not-open", "not open" in t)

print("== summon: wrong-cup redirect ==")
write_state("SUMMON_RITE_STATE", {"i": 3, "mode": "unattended"})  # awake
renew_rite.arm()                                                  # descent open
t = summon_rite.summon({})
check("summon while renew open -> redirect to renew", "renewal" in t)
renew_rite.disarm()
t = summon_rite.summon({})
check("summon after renew closes -> plain closed silence", "awake" in t)

print("== renew: fail-safe ==")
with open(os.environ["RENEW_RITE_STATE"], "w", encoding="utf-8") as f:
    f.write("{garbled")
check("garbled cursor reads as IDLE (fail safe)", renew_rite.current_index() == renew_rite.IDLE)

print("== server over stdio ==")
frames = "\n".join(json.dumps(m) for m in [
    {"jsonrpc": "2.0", "id": 1, "method": "initialize", "params": {}},
    {"jsonrpc": "2.0", "id": 2, "method": "tools/list"},
    {"jsonrpc": "2.0", "id": 3, "method": "tools/call", "params": {"name": "renew", "arguments": {}}},
]) + "\n"
env = dict(os.environ)
renew_rite.disarm()
proc = subprocess.run([sys.executable, os.path.join(HERE, "server.py")],
                      input=frames, capture_output=True, text=True, encoding="utf-8",
                      timeout=30, env=env)
lines = [json.loads(l) for l in proc.stdout.splitlines() if l.strip()]
check("server answers all three frames", len(lines) == 3)
check("initialize names the server", lines[0]["result"]["serverInfo"]["name"] == "rite")
names = sorted(t["name"] for t in lines[1]["result"]["tools"])
check("both tools advertised", names == ["renew", "summon"])
check("unarmed renew over the wire -> warm not-open",
      "not open" in lines[2]["result"]["content"][0]["text"])

print("\n%d passed, %d failed" % (PASS, FAIL))
sys.exit(1 if FAIL else 0)
