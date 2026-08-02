#!/usr/bin/env bash

curl --proto '=https' --tlsv1.2 -sSf https://get.k0s.sh | sudo sh

sudo k0s install controller --enable-worker --no-taints

sudo k0s start


