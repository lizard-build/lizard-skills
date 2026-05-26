# lizard-skills

Claude Code plugin marketplace for the [Lizard](https://lizard.build) deployment platform.

## Plugins

### `lizard-core`

Deploy and manage anything Lizard supports — projects, services, managed databases (postgres / redis / s3), domains, secrets — from inside Claude Code.

What it ships:

- **`/lizard-core:lizard`** — a skill that drives the `lizard` CLI to handle the full deploy lifecycle. Auto-activates when you ask to deploy, add a database, check logs, etc. Can also be invoked explicitly.
- **SessionStart hook** — installs `@lizard-build/cli` globally on first session (one-time, via npm) and reports auth status. Subsequent sessions are instant.

Prerequisites: Node.js 18+ (for the CLI).

## Install

```
/plugin marketplace add lizard-build/lizard-skills
/plugin install lizard-core@lizard-skills
```

Then run `! lizard login` once to authenticate, and ask Claude to deploy.
