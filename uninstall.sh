#!/bin/bash
set -eu

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)/src"
APP_NAME="gadi-job"

INSTALL_DIR="$HOME/.local/bin/$APP_NAME"
rm -rf "$INSTALL_DIR"

# Remove everything between markers
sed -i '/# BEGIN gadi-job PATH/,/# END gadi-job PATH/d' "$HOME/.bashrc" 2>/dev/null || true