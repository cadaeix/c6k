# benches/ — tests-of-record

Throwaway test harnesses, **kept**. When you probe how the harness behaves — does
SessionStart reach subagents? does the sandbox still deny what it denied last version?
does keystroke injection touch the idle clock? — the probe and its findings live here in
a dated directory, permanently.

The convention exists because harness behavior is (a) load-bearing for everything in
this kit, (b) undocumented at the level you need, and (c) **subject to change without
notice on version bumps.** A test-of-record turns "we verified this once, trust us"
into "here is the probe; re-run it."

Each bench gets a directory and a README stating: what question it answers, the harness
version it was run against, the finding, and how to re-run it. When a mechanism built on
a bench goes live, the bench stays — it is the mechanism's birth certificate and its
regression test.

Things the lineage benched that you will probably need to bench too, on your own harness
version: SessionStart `source` values and subagent reach; permission-inheritance
behavior; hook stdout vs `additionalContext` handling per event type; what a spawned
headless process inhales from parent directories (doc 06's cardinal rule); console
keystroke injection (doc 04).
