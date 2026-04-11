#!/usr/bin/env bash

# echo "Bash source ${BASH_SOURCE[0]}"
source "$(find-entry $BASH_SOURCE[0])"

check_root


echo "Hello"