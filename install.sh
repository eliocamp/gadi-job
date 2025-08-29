#!/bin/bash
set -eu

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
APP_NAME="pbs-workbench"

# First uninstall so we know we're starting fresh
bash "$SCRIPT_DIR/uninstall.sh"

INSTALL_DIR="$HOME/.local/bin/$APP_NAME"
mkdir -p "$INSTALL_DIR"

echo Copying $SRC_DIR into "$INSTALL_DIR"
cp -rT "$SRC_DIR" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/job"

echo Updating ~/.bashrc

BASHRC="$HOME/.bashrc"
echo "# BEGIN $APP_NAME" >> "$BASHRC"
echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$BASHRC"
echo "[ -f \"$INSTALL_DIR/completion.sh\" ] && source \"$INSTALL_DIR/completion.sh\"" >> "$BASHRC"
echo "# END $APP_NAME" >> "$BASHRC"

echo "Installation complete!"
echo "Please run: source ~/.bashrc or restart your terminal"

