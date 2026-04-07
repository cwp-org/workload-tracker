#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# This project is a single-file HTML/CSS/JS application with no external
# dependencies. No package manager or build step is required.
# The hook exists so future dependencies can be added here if needed.

echo "Session start hook completed successfully."
