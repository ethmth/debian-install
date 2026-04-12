#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$BASE_DIR/config/install.conf"

check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
  fi
}

check_non_root() {
  if [ "$EUID" -eq 0 ]; then
    echo "This script must not be run as root." >&2
    exit 1
  fi
}

check_config() {
  if ! [ -f "$CONFIG_FILE" ]; then
    echo "Config file not found." >&2
    exit 1
  fi
}

export_config() {
  if [ -f "$CONFIG_FILE" ]; then
    source "$CONFIG_FILE"

    # split DEFAULTS into
    DEFAULTS=$(echo "$DEFAULTS" | tr ',' '\n')
    export DEFAULTS="$DEFAULTS"
  fi
}
export_config