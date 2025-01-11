#!/usr/bin/env bash

# Check player status
MUSIC_STATUS=$(playerctl status 2>/dev/null)
if [[ $? -eq 1 ]]; then
    echo " "; echo "Not Playing"; echo "deactivated"
    exit
fi

# Determine metadata for tooltip
TITLE=$(playerctl metadata title)
if [[ $? -eq 1 ]]; then
    echo " "; echo "Not Playing"; echo "deactivated"
    exit
fi

ARTIST=$(playerctl metadata artist)
if [[ $? -eq 1 ]]; then
    echo " "; echo "Not Playing"; echo "deactivated"
    exit
fi

if [[ -n $ARTIST ]]; then
    TOOLTIP="$TITLE ($ARTIST)"
else
    TOOLTIP="$TITLE"
fi

if [[ $MUSIC_STATUS != "Playing" ]]; then
    echo " "; echo "$TOOLTIP"; echo "deactivated"
else
    echo " "; echo "$TOOLTIP"; echo "activated"
fi
