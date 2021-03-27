#!/bin/bash
BATTERY_SCRIPT="$SCRIPTS_FOLDER/battery.sh"

[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ] && charging=1 || charging=0  

printf "%s" \
	  "%{T1}%{A:$SCRIPTS_FOLDER/lemon/dunst-battery.sh &:}%{F$([ $charging -eq 1 ] && $SCRIPTS_FOLDER/conf.sh lemon.bat.color.charge || $SCRIPTS_FOLDER/conf.sh lemon.bat.color.discharge)}$($BATTERY_SCRIPT)%{A}%{T-}%{F-}"
