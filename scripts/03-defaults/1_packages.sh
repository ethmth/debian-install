#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

packages=$(parse_defaults_files "1_packages.txt")
packages=$(echo "$packages" | xargs)

echo "Installing packages: $packages"

apt update && apt upgrade -y
apt install $packages -y