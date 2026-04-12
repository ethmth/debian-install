#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_non_root && check_config

groups=$(parse_defaults_files "4_groups.txt")

groups=$(echo "$groups" | tr '\n' ',' | sed 's/,$//')

echo "sudo usermod -aG $groups $USER"
sudo usermod -aG "$groups" "$USER"