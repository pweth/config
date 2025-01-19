#!/usr/bin/env bash

# Check exit node status
STATUS=$(tailscale status --json | jq -r '.ExitNodeStatus.TailscaleIPs[0] // "offline"')

if [[ $STATUS -eq "offline" ]]; then
    echo " "; echo "Offline"; echo "deactivated"
    exit
fi

# Determine exit node hostname
EXIT_NODE=$(tailscale status --json | jq -r '."Peer"[] | select(."ExitNode"==true)."HostName"')
echo " "; echo "$EXIT_NODE"; echo "activated"
