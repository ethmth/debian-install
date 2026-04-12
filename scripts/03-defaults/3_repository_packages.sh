#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

packages=$(parse_defaults_files "3_repository_packages.txt")
packages=$(echo "$packages" | xargs)

apt update && apt upgrade -y
apt install $packages -y