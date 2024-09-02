while true; do

    declare -a SYSTEM_INFO=()

    # Jan 1 12:34
    DATETIME=$(date "+%b %-d %H:%M")

    # Music player
    MUSIC_STATUS=$(playerctl status)
    if [[ $MUSIC_STATUS = "Playing" ]] then
        SONG=$(playerctl metadata title)
        ARTIST=$(playerctl metadata artist)
        SYSTEM_INFO+=("🎶 $SONG ($ARTIST) ")
    fi

    # Connection status
    NETWORK_STATUS=$(nmcli general status | tail -n 1 | awk '{print $1}')
    if [[ $NETWORK_STATUS = "connected" ]] then
        SYSTEM_INFO+=("🔗")
    else
        SYSTEM_INFO+=("🚫")
    fi

    # VPN status
    VPN_STATUS=$(tailscale status --json | jq -r '."ExitNodeStatus"."TailscaleIPs"[0] // "offline"')
    if [[ $VPN_STATUS != "offline" ]] then
        EXIT_NODE=$(tailscale status --json | jq -r '."Peer"[] | select(."ExitNode"==true)."HostName"')
        SYSTEM_INFO+=("🪱 $EXIT_NODE")
    fi

    # Battery percentage
    BATTERY_FILE="/sys/class/power_supply/BAT0/capacity"
    if [[ -f "$BATTERY_FILE" ]]; then
        BATTERY=$(cat "$BATTERY_FILE")
        if [[ $BATTERY = "214" ]] || [[ $BATTERY = "100" ]]; then
            SYSTEM_INFO+=("🔋 100%")
        elif [[ $BATTERY -gt 25 ]]; then
            SYSTEM_INFO+=("🔋 $BATTERY%")
        else
            SYSTEM_INFO+=("🪫 $BATTERY%")
        fi
    fi

    # Join system information into string
    SYSTEM_STR=$(IFS=" " ; echo "${SYSTEM_INFO[*]}")

    xsetroot -name " $DATETIME ; $SYSTEM_STR "
    sleep 1

done
