#!/usr/bin/env bash

VERSION_CODENAME="trixie"

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <repository.yml>" >&2
  exit 1
fi

YML="$1"

if [[ ! -f "$YML" ]]; then
  echo "File not found: $YML" >&2
  exit 1
fi

if ! command -v yq &>/dev/null; then
  echo "yq is required but not installed." >&2
  exit 1
fi

name=$(yq -r '.repository.name' "$YML")
format=$(yq -r '.repository.format // "DEB822"' "$YML")
key_url=$(yq -r '.repository.key.url' "$YML")
key_file=$(yq -r '.repository.key.file' "$YML")
body=$(yq -r '.repository.body' "$YML")

echo "==> Installing repository: $name"

# Install GPG key. If the destination is a .gpg file, dearmor; otherwise save as-is.
mkdir -p "$(dirname "$key_file")"
if [[ "$key_file" == *.gpg ]]; then
  echo "curl -fsSL $key_url | gpg --dearmor | tee $key_file > /dev/null"
  curl -fsSL "$key_url" | gpg --dearmor | tee "$key_file" > /dev/null
else
  echo "curl -fsSL $key_url | tee $key_file > /dev/null"
  curl -fsSL "$key_url" | tee "$key_file" > /dev/null
fi
echo "  Key saved to $key_file"

# Expand any shell expressions embedded in the body (e.g. $(dpkg --print-architecture))
expanded_body=$(eval "cat <<__REPO_BODY__
$body
__REPO_BODY__
")

# Write the sources file based on format
if [[ "$format" == "DEB822" ]]; then
  sources_file="/etc/apt/sources.list.d/$name.sources"
else
  sources_file="/etc/apt/sources.list.d/$name.list"
fi

echo "$expanded_body" | tee "$sources_file" > /dev/null
echo "  Sources written to $sources_file"

# apt-get update

# Install each listed package
mapfile -t packages < <(yq '.repository.packages[]' "$YML")

# if [[ ${#packages[@]} -gt 0 ]]; then
#   echo "==> Installing packages: ${packages[*]}"
#   apt-get install -y "${packages[@]}"
# fi
