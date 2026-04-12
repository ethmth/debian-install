#!/usr/bin/env bash
source "$(find-entry $BASH_SOURCE[0])"
check_root && check_config

repositories=$(parse_defaults_files "2_repositories.txt")

for repository in $repositories; do
  bash "$BASE_DIR/repositories/install_repository.sh" "$BASE_DIR/repositories/$repository.yml"
done

apt update