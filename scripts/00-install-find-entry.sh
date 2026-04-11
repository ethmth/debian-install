#!/usr/bin/env bash


if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

NAME="find-entry"
SOURCE="$SCRIPT_DIR/../bin/$NAME"
TARGET="/usr/local/bin/$NAME"

cp "$SOURCE" "$TARGET"

chmod 755 "$TARGET"

echo "$NAME installed successfully."