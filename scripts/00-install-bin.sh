#!/usr/bin/env bash


if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BIN_DIR="$SCRIPT_DIR/../bin"

for SOURCE in "$BIN_DIR"/*; do
    NAME="$(basename "$SOURCE")"
    TARGET="/usr/local/bin/$NAME"
    cp "$SOURCE" "$TARGET"
    chmod 755 "$TARGET"
    echo "$NAME installed successfully."
done