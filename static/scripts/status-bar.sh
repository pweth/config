while true; do

    # 12:34 Mon 01 Jan
    DATETIME=$(date "+%H:%M %a %d %b")

    # Connection status
    NETWORK_STATUS=$(nmcli general status | tail -n 1 | awk '{print $1}')
    if [[ $NETWORK_STATUS = "connected" ]] then
        NETWORK="🔗"
    else
        NETWORK="🚫"
    fi

    # VPN status
    VPN_STATUS=$(tailscale status --json | jq -r '."ExitNodeStatus"."TailscaleIPs"[0] // "offline"')
    if [[ $VPN_STATUS = "offline" ]] then
        VPN=""
    else
        VPN=" 🪱"
    fi

    # Battery percentage
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)

    xsetroot -name " $DATETIME | $NETWORK$VPN $BATTERY% "
    sleep 1

done
