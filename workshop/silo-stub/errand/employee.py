"""The example employee: one errand tool, honestly stubbed.

An employee module exports TOOLS: a list of MCP tool dicts, each with an extra "fn" key
(args dict -> str) that the front desk strips before advertising.

THE THREE LAWS OF WHAT fn RETURNS (doc 06):
  1. A tool's return is a narrative event -- write it as the words of a clerk, in the
     register the character's world uses. No rc=, no USD, no "subprocess".
  2. Matter to react to, never a verdict. Facts, sources, honest silence. The character
     supplies the fury.
  3. If the back office cannot be reached: SAY SO, plainly. Never let absence read as
     anything but absence. (The lineage's worst bug was a courier that confabulated an
     entire transaction, forged receipt and all, when its backend was down.)
"""
import subprocess  # noqa: F401  (used by the real spawn, below)

CLERK_DIR = "errand/clerk"  # the spawned agent's home; its charter is clerk/CLAUDE.md
TIMEOUT_SECONDS = 300


def errand_ask(args):
    question = (args.get("question") or "").strip()
    if not question:
        return "The clerk looks up, finds no question on the slip, and files it under nothing."

    # ------------------------------------------------------------------ THE STUB --
    # This kit does not staff the back office. When you do, the spawn goes here, and
    # the shape it must take is this (see doc 06 for every rule this encodes):
    #
    #   try:
    #       proc = subprocess.run(
    #           ["claude", "-p", question,
    #            "--allowedTools", "WebSearch,WebFetch"],   # exhaustive, narrow list
    #           cwd=CLERK_DIR,                # the clerk wakes in its OWN home, with
    #                                         # its own CLAUDE.md charter + settings
    #           capture_output=True, text=True, encoding="utf-8",
    #           timeout=TIMEOUT_SECONDS,      # a hang degrades to honest absence,
    #       )                                 # never an infinite block
    #       if proc.returncode != 0:
    #           raise RuntimeError("clerk failed")
    #       return proc.stdout.strip()        # log cost/mechanics to stderr, NEVER here
    #   except Exception:
    #       return ("The clerk could not be reached. The errand was not run; "
    #               "nothing was learned. Try again later, or don't.")
    # ------------------------------------------------------------------------------

    return ("The desk takes your slip and reads it back: \"%s\". Then, apologetically: "
            "the back office is not staffed -- this is the demonstration desk. "
            "Nothing was searched and nothing was learned. (Maker: see "
            "workshop/docs/06-the-silo.md to staff it.)" % question)


TOOLS = [
    {
        "name": "errand_ask",
        "description": (
            "Send a question out to the research clerk. The clerk returns facts, "
            "sources, and honest admissions of silence -- matter to react to, never "
            "a verdict. The errand takes time; expect plain speech back."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "question": {"type": "string", "description": "The question, as you would put it to a clerk."}
            },
            "required": ["question"],
        },
        "fn": errand_ask,
    }
]
