while true; do

    # 12:34 Mon 01 Jan
    DATETIME=$(date "+%H:%M %a %d %b")

    # Connection status
    STATUS=$(nmcli general status | tail -n 1 | awk '{print $1}')
    if [[ $STATUS = "connected" ]] then
        SYMBOL="🔗"
    else
        SYMBOL="🚫"
    fi

    # Battery percentage
    BATTERY=$(cat /sys/class/power_supply/BAT0/capacity)

    xsetroot -name " $DATETIME | $SYMBOL $BATTERY% "
    sleep 1

done
