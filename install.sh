#!/bin/bash
set -eu

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)/src"
APP_NAME="gadi-job"

# First uninstall so we know we're starting fresh
bash "$SCRIPT_DIR/uninstall.sh"

INSTALL_DIR="$HOME/.local/bin/$APP_NAME"
mkdir -p "$INSTALL_DIR"

echo Copying $SCRIPT_DIR into "$INSTALL_DIR"
cp -rT "$SCRIPT_DIR" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/job"

BASHRC="$HOME/.bashrc"

echo "# BEGIN gadi-job" >> "$BASHRC"
echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$BASHRC"
echo "[ -f \"$INSTALL_DIR/completion.sh\" ] && source \"$INSTALL_DIR/completion.sh\"" >> "$BASHRC"
echo "# END gadi-job" >> "$BASHRC"
echo "Added $INSTALL_DIR to PATH in $BASHRC"

echo "Installation complete!"
echo "Please run: source ~/.bashrc or restart your terminal"

