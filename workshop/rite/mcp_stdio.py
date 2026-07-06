#!/usr/bin/env python3
"""Reusable MCP-over-stdio server core (JSON-RPC 2.0), Python 3 stdlib only.

MCP-over-stdio is newline-delimited JSON-RPC on stdin/stdout: `initialize` /
`tools/list` / `tools/call`. ALL logging goes to stderr; stdout carries protocol
frames exclusively (one stray print() to stdout corrupts the stream).

Non-ASCII text goes out as \\uXXXX (json.dumps ensure_ascii default) and the harness
decodes it back — the same codepage-proofing discipline as the hooks.

Usage:
    from mcp_stdio import serve
    def my_tool(args): return "some text"
    TOOLS = [{
        "name": "my_tool",
        "description": "...",
        "inputSchema": {"type": "object", "properties": {}, "required": []},
        "fn": my_tool,           # args(dict) -> str
    }]
    serve("my-server", "1.0.0", TOOLS)
"""
import sys
import json

DEFAULT_PROTOCOL = "2024-11-05"
_SERVER_NAME = "mcp-stdio"


def _force_utf8():
    # On Windows, stdin/stdout default to the locale code page; UTF-8 input gets
    # misdecoded on read. Force UTF-8 both ways; leave non-reconfigurable streams alone.
    for stream in (sys.stdin, sys.stdout):
        try:
            stream.reconfigure(encoding="utf-8", errors="replace")
        except (AttributeError, OSError, ValueError):
            pass


def log(*a):
    print("[%s]" % _SERVER_NAME, *a, file=sys.stderr, flush=True)


def _send(msg):
    sys.stdout.write(json.dumps(msg) + "\n")
    sys.stdout.flush()


def _reply(req_id, result):
    _send({"jsonrpc": "2.0", "id": req_id, "result": result})


def _reply_error(req_id, code, message):
    _send({"jsonrpc": "2.0", "id": req_id, "error": {"code": code, "message": message}})


def _handle(msg, name, version, by_name, public):
    method = msg.get("method")
    req_id = msg.get("id")

    if method == "initialize":
        proto = (msg.get("params") or {}).get("protocolVersion") or DEFAULT_PROTOCOL
        _reply(req_id, {
            "protocolVersion": proto,
            "capabilities": {"tools": {}},
            "serverInfo": {"name": name, "version": version},
        })
    elif method in ("notifications/initialized", "initialized"):
        pass
    elif method == "ping":
        if req_id is not None:
            _reply(req_id, {})
    elif method == "tools/list":
        _reply(req_id, {"tools": public})
    elif method == "tools/call":
        params = msg.get("params") or {}
        tool = by_name.get(params.get("name"))
        if not tool:
            _reply(req_id, {"content": [{"type": "text", "text": "Unknown tool: %s" % params.get("name")}],
                            "isError": True})
            return
        try:
            text = tool["fn"](params.get("arguments") or {})
            _reply(req_id, {"content": [{"type": "text", "text": text}]})
        except Exception as e:
            log("tool error:", repr(e))
            _reply(req_id, {"content": [{"type": "text", "text": "Tool error: %s" % e}], "isError": True})
    elif req_id is not None:
        _reply_error(req_id, -32601, "Method not found: %s" % method)


def serve(name, version, tools):
    """Block on stdin, dispatching JSON-RPC frames until EOF."""
    global _SERVER_NAME
    _SERVER_NAME = name
    _force_utf8()
    by_name = {t["name"]: t for t in tools}
    public = [{k: v for k, v in t.items() if k != "fn"} for t in tools]
    log("starting; tools =", ", ".join(by_name))
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            msg = json.loads(line)
        except json.JSONDecodeError as e:
            log("bad json frame:", e)
            continue
        try:
            _handle(msg, name, version, by_name, public)
        except Exception as e:
            log("handler crashed:", repr(e))
            if msg.get("id") is not None:
                _reply_error(msg["id"], -32603, "Internal error: %s" % e)
