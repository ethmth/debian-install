#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config


echo "Hello $DEFAULTS"

