#!/bin/sh
#If volume above 0, go down by 10%.
pactl set-sink-volume @DEFAULT_SINK@ -1%
kill -45 $(pidof dwmblocks)
echo $(pamixer --get-volume) >> /tmp/xobpipe
