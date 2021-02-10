#!/bin/bash
BATTERY_SCRIPT="$SCRIPTS_FOLDER/battery.sh"

[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ] && charging=1 || charging=0  

printf "%s" \
  "%{T3}%{A:$SCRIPTS_FOLDER/lemon/dunst-battery.sh &:}%{F$([ $charging -eq 1 ] && xgetres bat.charge.color || xgetres bat.discharge.color)}$($BATTERY_SCRIPT)%{A}%{T-}%{F-}"
