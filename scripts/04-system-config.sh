#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root

echo "%sudo	ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers.d/70-sudo-nopasswd