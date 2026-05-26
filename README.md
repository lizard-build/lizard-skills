# lizard-skills

Plugin marketplace for the [Lizard](https://lizard.build) deployment platform. Works with both Claude Code and Codex.

## Plugins

### `lizard-core`

Deploy and manage anything Lizard supports — projects, services, managed databases (postgres / redis / s3), domains, secrets — from inside your agent.

What it ships:

- **`lizard` skill** — drives the `lizard` CLI to handle the full deploy lifecycle. Auto-activates when you ask to deploy, add a database, check logs, etc. Can also be invoked explicitly (`/lizard-core:lizard` in Claude Code, `@lizard-core` in Codex).
- **SessionStart hook** — installs `@lizard-build/cli` globally on first session (one-time, via curl or npm) and reports auth status. Subsequent sessions are instant.

Prerequisites: Node.js 18+ (for the CLI).

## Install

### Claude Code

```
/plugin marketplace add lizard-build/lizard-skills
/plugin install lizard-core@lizard-skills
```

### Codex

```
codex plugin marketplace add lizard-build/lizard-skills
codex plugin install lizard-core@lizard-skills
```

Then run `! lizard login` once to authenticate, and ask your agent to deploy.
