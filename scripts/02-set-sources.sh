#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

SOURCES_FILE="$BASE_DIR/config/debian.sources"

if ! [ -f "$SOURCES_FILE" ]; then
	echo "$SOURCES_FILE doesn't exist"
	exit 1
fi

TARGET_FILE="/etc/apt/sources.list.d/debian.sources"

cp "$SOURCES_FILE" "$TARGET_FILE"
chmod 644 "$TARGET_FILE"

if [ -f "/etc/apt/sources.list" ]; then
	rm "/etc/apt/sources.list"
fi

# install needed packages
apt update && apt install fzf jq yq git curl wget -y