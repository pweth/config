#!/usr/bin/env bash
set -euo pipefail

BACKGROUND=$(ls /etc/nixos/config/static/images | dmenu -l 10 -fn Monospace-13)

if [[ $? = 0 ]]; then
    feh --bg-scale /etc/nixos/config/static/images/$BACKGROUND
fi
