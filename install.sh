#!/bin/bash
set -eu

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)/src"
APP_NAME="gadi-job"

INSTALL_DIR="$HOME/.local/bin/$APP_NAME"
mkdir -p "$INSTALL_DIR"

echo Copying $SCRIPT_DIR into "$INSTALL_DIR"
cp -rT "$SCRIPT_DIR" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR/job"

BASHRC="$HOME/.bashrc"

if ! grep -q "# BEGIN gadi-job" "$BASHRC" 2>/dev/null; then
    echo "# BEGIN gadi-job" >> "$BASHRC"
    echo "export PATH=\"$INSTALL_DIR:\$PATH\"" >> "$BASHRC"
    echo "source \"$INSTALL_DIR/completion.sh\"" >> "$BASHRC"
    echo "# END gadi-job" >> "$BASHRC"
    echo "Added $INSTALL_DIR to PATH in $BASHRC"
    echo "Please run: source ~/.bashrc or restart your terminal"
fi


echo "Installation complete!"