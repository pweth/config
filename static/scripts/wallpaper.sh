#!/usr/bin/env bash
set -euo pipefail

FOLDER="/etc/nixos/config/static/images"

BACKGROUND=$(ls $FOLDER | dmenu -l 10)

if [[ $? = 0 ]]; then
    feh --bg-scale $FOLDER/$BACKGROUND
    echo $FOLDER/$BACKGROUND > ~/.wallpaper
fi
