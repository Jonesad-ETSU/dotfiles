#!/bin/bash
BATTERY_SCRIPT="/home/jonesad/.scripts/battery.sh"

[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ] && charging=1 || charging=0  

printf "%s" \
	  "%{A:/home/jonesad/.scripts/lemon/dunst-battery.sh &:}$($BATTERY_SCRIPT)%{A}"
