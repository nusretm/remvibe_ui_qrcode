# Repository agent instructions

Before planning, implementing, reviewing, or changing this repository, read:
1. `docs/WORKING_RULES.md`
2. `docs/continuity/README.md`
3. `docs/continuity/CURRENT_TARGET.md`
4. `docs/continuity/ARCHITECTURE.md`

The repository working rules are authoritative; global user rules supplement them.
This is a **small Flutter widget package**, not an application or service framework.
Do not add services, singleton managers, registries, providers, authentication,
network protocols, or unrelated RemVibe dependencies.

Never begin a new implementation checkpoint, merge a branch, or change an approved
public contract without the user's explicit approval. Work on a feature branch;
inspect repository state and actual changed files before reporting completion.

Prefer usable widget behavior and real Windows QR display / Android camera evidence
over excessive synthetic tests. Never claim a platform was verified without running
it. Keep continuity and README synchronized with what was actually done.
Do not run `dart format` on pure Dart sources unless the user explicitly approves it.
