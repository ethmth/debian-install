#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_non_root

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DEFAULT_DIRS=$(ls -1 "$SCRIPT_DIR/../defaults" | grep -v "base")
DEFAULT_DIRS=$(echo "$DEFAULT_DIRS" | fzf -m --prompt="Select defaults: ")
DEFAULT_DIRS=$(echo "$DEFAULT_DIRS" | tr '\n' ',' | sed 's/,$//')

echo "DEFAULTS=base,$DEFAULT_DIRS" > "$CONFIG_FILE"
cat "$CONFIG_FILE"