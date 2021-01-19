#!/bin/sh
brightnessctl s "$(yad --scale \
  --mouse \
  --min-value=2 \
  --max-value=100 \
  --step=5 \
  --enforce-step \
  --skip-taskbar \
  --close-on-unfocus \
  --title "Transparent" )%" >/dev/null 2>/dev/null && \
pkill -44 lemontopc 


#/usr/bin/kill --signal USR1 $(pidof lemonbar.sh)
