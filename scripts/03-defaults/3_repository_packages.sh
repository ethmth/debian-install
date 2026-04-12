#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

packages=$(parse_defaults_files "3_repository_packages.txt")

apt update
apt install "$packages" -y