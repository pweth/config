#!/usr/bin/env bash
set -euo pipefail

SELECTION=$(
    tailscale exit-node list |
    tail -n +3 |
    head -n -3 |
    sed -e "s/.adelie-monitor.ts.net//" |
    awk -F '[[:space:]][[:space:]]+' '{print $2, "("$4",", $3")"}' |
    sed -e "s/(-, -)//" |
    (echo "Offline"; cat -) |
    dmenu -i -l 10 |
    awk '{print $1}'
)

if [[ $SELECTION = "Offline" ]] then
    tailscale set --exit-node=
else
    tailscale set --exit-node=$SELECTION
fi
