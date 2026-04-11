#!/usr/bin/env bash


CONFIG_FILE="$HOME/programs/debian-install/config/install.conf"

if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  echo "Config file not found." >&2
  exit 1
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
