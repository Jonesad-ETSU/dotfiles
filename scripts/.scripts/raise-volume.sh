#!/bin/sh
#If volume below 80, increase by 10%.
volOld=$(pamixer --get-volume)
[ $volOld -lt 80 ] && pactl set-sink-volume @DEFAULT_SINK@ +10%
kill -45 $(pidof dwmblocks)
echo $(( $volOld + 10 <= 80 ? $volOld + 10 : 80 )) >> /tmp/xobpipe
