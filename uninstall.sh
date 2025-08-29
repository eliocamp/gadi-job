#!/bin/bash
set -eu

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)/src"
APP_NAME="gadi-job"

INSTALL_DIR="$HOME/.local/bin/$APP_NAME"
echo "Removing $INSTALL_DIR"
rm -rf "$INSTALL_DIR"

echo "Removing entrires in .bashrc"
# Remove everything between markers
sed -i '/# BEGIN gadi-job/,/# END gadi-job/d' "$HOME/.bashrc" 2>/dev/null || true

echo "Uninstallation complete!"