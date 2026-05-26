#!/usr/bin/env bash
# SessionStart: ensure the lizard CLI is installed, report auth status.
# Silent on the happy path. Output is shown to Claude as session context.

set -u

# ── 1. Install CLI if missing ────────────────────────────────────────────────

if ! command -v lizard >/dev/null 2>&1; then
  if ! command -v node >/dev/null 2>&1; then
    echo "[lizard-core] Node.js not found. Install Node 18+ from https://nodejs.org and restart Claude Code to use the lizard CLI."
    exit 0
  fi

  NODE_MAJOR=$(node -e "process.stdout.write(String(parseInt(process.version.slice(1))))" 2>/dev/null || echo "0")
  if [ "$NODE_MAJOR" -lt 18 ]; then
    echo "[lizard-core] Node $(node -v) is too old; the lizard CLI needs Node 18+. Upgrade and restart Claude Code."
    exit 0
  fi

  echo "[lizard-core] Installing lizard CLI (one-time)..."
  INSTALLED=0

  if command -v curl >/dev/null 2>&1; then
    if curl -fsSL https://raw.githubusercontent.com/lizard-build/lizard-cli/main/install.sh | bash >/dev/null 2>&1; then
      if command -v lizard >/dev/null 2>&1; then
        INSTALLED=1
      fi
    fi
  fi

  if [ "$INSTALLED" -eq 0 ] && command -v npm >/dev/null 2>&1; then
    if npm install -g @lizard-build/cli --silent >/dev/null 2>&1; then
      if command -v lizard >/dev/null 2>&1; then
        INSTALLED=1
      else
        echo "[lizard-core] npm reported success but 'lizard' is not on PATH. Add npm's global bin to PATH: export PATH=\"\$(npm prefix -g)/bin:\$PATH\""
        exit 0
      fi
    fi
  fi

  if [ "$INSTALLED" -eq 1 ]; then
    echo "[lizard-core] lizard CLI installed: $(lizard --version 2>/dev/null || echo 'version unknown')"
  else
    echo "[lizard-core] Failed to install lizard CLI. Try manually: curl -fsSL https://raw.githubusercontent.com/lizard-build/lizard-cli/main/install.sh | bash"
    exit 0
  fi
fi

# ── 2. Auth status (only mention when action is needed) ──────────────────────

if ! lizard whoami --json >/dev/null 2>&1; then
  echo "[lizard-core] Not logged in. Run \`! lizard login\` to authenticate before deploying."
fi

exit 0
