#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config


echo "Hello $DEFAULTS"

for DEFAULT in $DEFAULTS; do
  echo "$BASE_DIR/defaults/$DEFAULT/1_packages.txt"
done
