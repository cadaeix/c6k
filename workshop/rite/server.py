#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""The `rite` MCP server — the character's rite valet (mcp__rite__summon,
mcp__rite__renew).

A SEPARATE server from any errand silo on purpose: the silo means "outward reach /
the boundary that touches the world"; this touches nothing — it is an in-house ritual
that returns strings. Pure Python, stdlib only, launched by the harness via the
character's .mcp.json.

Two sibling rites, at the two ends of the candle:
  - summon — the WAKING (the coming-up); armed on a true SessionStart, fails open.
  - renew  — the fair copy before the river (the GOING-DOWN); armed by the /renew
             ceremony via a UserPromptSubmit hook, fails safe.

Design rationale: workshop/docs/05-rites-and-the-river.md. Test of record:
python test_rite.py.
"""
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from mcp_stdio import serve                       # noqa: E402
from summon_rite import TOOLS as SUMMON_TOOLS     # noqa: E402
from renew_rite import TOOLS as RENEW_TOOLS       # noqa: E402

if __name__ == "__main__":
    serve("rite", "1.0.0", SUMMON_TOOLS + RENEW_TOOLS)
