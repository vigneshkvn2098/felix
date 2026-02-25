#!/bin/sh
set -e

echo "[felix] state dir: $OPENCLAW_STATE_DIR"
echo "[felix] workspace dir: $OPENCLAW_WORKSPACE_DIR"

# Run openclaw's configure script to merge env vars into config
echo "[felix] running configure..."
node /app/configure.js 2>/dev/null || true

# Run doctor (non-fatal)
echo "[felix] running doctor..."
openclaw doctor --fix 2>/dev/null || true

# Start gateway directly on PORT (no nginx needed)
echo "[felix] starting gateway on port ${PORT:-8080}..."
exec openclaw gateway --port "${PORT:-8080}"
