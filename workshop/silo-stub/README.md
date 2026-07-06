# silo-stub/ — the external-boundary pattern, as a directory you can point at

A runnable sketch of doc 06. One MCP "front desk" (`server.py`), one example employee
(`errand/`), one clerk directory showing where the spawned agent's charter and
permissions live — and, most importantly, the *shape*: the protected capability behind a
process boundary, only the errand exposed.

**It is a stub on purpose.** The `errand_ask` tool answers honestly that the back office
is not staffed, and the spawn skeleton (subprocess + timeout + degrade-to-silence) is
laid out in comments where the real call goes. Wiring a real backend is deliberate work
you should do with doc 06 open.

## Try it

```
python server.py
```

then paste JSON-RPC frames on stdin (`{"jsonrpc":"2.0","id":1,"method":"initialize","params":{}}`,
then `tools/list`, then a `tools/call`) — or just register it and let the harness drive.

## Register it (in the character's `.mcp.json`)

```json
{
  "mcpServers": {
    "errands": {
      "command": "python",
      "args": ["<absolute path to>/workshop/silo-stub/server.py"]
    }
  }
}
```

plus `"mcp__errands"` in the character's allow-list and `"errands"` in
`enabledMcpjsonServers`. MCP servers load at session start — changes land at the next
waking. (`.mcp.json` is read-denied to the character; it's machine room.)

## In production, the silo is a SIBLING

This stub lives inside `workshop/` for the kit's tidiness. A **live** silo moves out to
sit beside `character/` and `workshop/` as a third top-level tree — because of the
cardinal rule (doc 06): Claude Code walks *up* from a spawned clerk's cwd and inhales
every instructions file it passes. A clerk spawned under a directory carrying
orientation files inhales the orientation. Sibling, always; `README.md` at its root,
never `CLAUDE.md`; the only `CLAUDE.md` anywhere in it lives *inside* a clerk's own
directory.
