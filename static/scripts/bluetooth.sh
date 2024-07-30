#!/usr/bin/env bash
set -euo pipefail

# Adapated from https://github.com/Edesem/bluetooth-connect-script

DEVICE_COUNT=$(bluetoothctl devices | wc -l)

if [[ $DEVICE_COUNT = 1 ]]; then
	MAC=$(bluetoothctl devices | awk {'print $2'})
		[ -z $MAC ] && MAC=NoDeviceFound # Prevents accidental disconnect error
else
	DEVICE=$(bluetoothctl devices | awk {'print $3'} | dmenu -l 10)
	MAC=$(bluetoothctl devices | grep $DEVICE | awk {'print $2'}) 
		[ -z $MAC ] && MAC=NoDeviceFound # Prevents accidental disconnect error
fi

CONNECT=$(bluetoothctl info $MAC | grep Connected: | awk '{print $2}')
if [[ $CONNECT = "no" ]]; then 
	# notify-send "Attempting to connect to $DEVICE"
	bluetoothctl connect $MAC # || notify-send "Failed to Connect"
elif [[ $CONNECT = "yes" ]]; then
	# notify-send "Attempting to disconnect $DEVICE"
	bluetoothctl disconnect $MAC 
fi
