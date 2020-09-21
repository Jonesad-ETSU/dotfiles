#!/bin/sh
#If volume below 80, increase by 10%.
[ $(pamixer --get-volume) -lt 80 ] && pactl set-sink-volume @DEFAULT_SINK@ +10%
kill -45 $(pidof dwmblocks)
