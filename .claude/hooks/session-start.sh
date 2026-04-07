#!/bin/bash
set -euo pipefail

# Only run in remote (Claude Code on the web) environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# This project is a single-file HTML/CSS/JS app with no external
# dependencies, no linter, and no test framework.
# No installation steps are needed.

echo "Session start hook completed — no dependencies to install."
