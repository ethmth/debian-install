#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config/install.conf"

if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
fi

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
