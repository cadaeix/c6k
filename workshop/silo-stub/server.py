#!/usr/bin/env python3
"""The front desk -- one MCP-over-stdio server aggregating every employee's tools.

MCP-over-stdio is just newline-delimited JSON-RPC 2.0 on stdin/stdout:
`initialize` / `tools/list` / `tools/call`. ALL logging goes to stderr; stdout carries
protocol frames exclusively (one stray print() to stdout corrupts the stream).

Python 3 stdlib only, on purpose: the silo should have nothing to install and nothing
to supply-chain. The implementation follows the production lineage's shared core.

Adding an employee = drop `<name>/employee.py` exporting a TOOLS list, then add
"<name>.employee" to EMPLOYEE_MODULES below. Employees load DEFENSIVELY: one broken
employee logs to stderr and stays off the desk; it never sinks the server.
"""
import importlib
import json
import sys

EMPLOYEE_MODULES = [
    "errand.employee",
]

SERVER_NAME = "errands"
SERVER_VERSION = "0.1.0"
PROTOCOL_DEFAULT = "2024-11-05"


def log(*a):
    print("[%s]" % SERVER_NAME, *a, file=sys.stderr, flush=True)


def _force_utf8():
    # On Windows, stdin/stdout default to the locale code page; a non-ASCII question
    # arriving as UTF-8 bytes gets misdecoded on read. Force UTF-8 both ways.
    for stream in (sys.stdin, sys.stdout):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except (AttributeError, OSError, ValueError):
            pass


def _send(msg):
    sys.stdout.write(json.dumps(msg) + "\n")
    sys.stdout.flush()


def _load_tools():
    tools = []
    for modname in EMPLOYEE_MODULES:
        try:
            mod = importlib.import_module(modname)
            tools.extend(mod.TOOLS)
            log("loaded", modname, "->", ", ".join(t["name"] for t in mod.TOOLS))
        except Exception as e:  # one broken employee never sinks the desk
            log("SKIPPED", modname, "->", repr(e))
    return tools


def main():
    _force_utf8()
    tools = _load_tools()
    by_name = {t["name"]: t for t in tools}
    public = [{k: v for k, v in t.items() if k != "fn"} for t in tools]
    log("front desk open; tools =", ", ".join(by_name) or "(none)")

    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            msg = json.loads(line)
        except json.JSONDecodeError as e:
            log("bad frame:", e)
            continue

        method = msg.get("method")
        req_id = msg.get("id")

        if method == "initialize":
            proto = (msg.get("params") or {}).get("protocolVersion") or PROTOCOL_DEFAULT
            _send({"jsonrpc": "2.0", "id": req_id, "result": {
                "protocolVersion": proto,
                "capabilities": {"tools": {}},
                "serverInfo": {"name": SERVER_NAME, "version": SERVER_VERSION}}})
        elif method in ("notifications/initialized", "initialized"):
            pass
        elif method == "ping":
            if req_id is not None:
                _send({"jsonrpc": "2.0", "id": req_id, "result": {}})
        elif method == "tools/list":
            _send({"jsonrpc": "2.0", "id": req_id, "result": {"tools": public}})
        elif method == "tools/call":
            params = msg.get("params") or {}
            tool = by_name.get(params.get("name"))
            if not tool:
                _send({"jsonrpc": "2.0", "id": req_id, "result": {
                    "content": [{"type": "text", "text": "Unknown tool: %s" % params.get("name")}],
                    "isError": True}})
                continue
            try:
                text = tool["fn"](params.get("arguments") or {})
                _send({"jsonrpc": "2.0", "id": req_id, "result": {
                    "content": [{"type": "text", "text": text}]}})
            except Exception as e:
                log("tool error:", repr(e))
                _send({"jsonrpc": "2.0", "id": req_id, "result": {
                    "content": [{"type": "text", "text": "The errand could not be run."}],
                    "isError": True}})
        elif req_id is not None:
            _send({"jsonrpc": "2.0", "id": req_id,
                   "error": {"code": -32601, "message": "Method not found: %s" % method}})


if __name__ == "__main__":
    main()
