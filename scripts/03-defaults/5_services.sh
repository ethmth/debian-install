#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

services=$(parse_defaults_files "5_services.txt")

for service in $services; do
  echo "systemctl enable $service"
  systemctl enable "$service"
done