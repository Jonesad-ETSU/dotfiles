#!/bin/bash
BATTERY_SCRIPT="$SCRIPTS_FOLDER/battery.sh"

[ "$(cat /sys/class/power_supply/BAT0/status)" != "Discharging" ] && charging=1 || charging=0  

echo \
  "%{F$(xgetres a.color3)}%{T2}%{A: $SCRIPTS_FOLDER/lemon/dunst-battery.sh &:}%{F$([ $charging -eq 1 ] && xgetres a.color5 || xgetres a.color1)}$($BATTERY_SCRIPT)%{A}%{T-}%{F-}"
