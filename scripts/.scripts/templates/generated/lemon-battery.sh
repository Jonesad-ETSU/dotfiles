#!/bin/bash
BATTERY_SCRIPT="$SCRIPTS_FOLDER/battery.sh"

[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ] && charging=1 || charging=0  

printf "%s" \
	  "%{T1}%{A:$SCRIPTS_FOLDER/lemon/dunst-battery.sh &:}%{F$([ $charging -eq 1 ] && echo '#A3BE8C' || echo '#81A1C1')}$($BATTERY_SCRIPT)%{A}%{T-}%{F-}"
