#!/bin/bash
#If volume below 80, increase by 1%.
volOld=$(pamixer --get-volume)
[ $volOld -lt 80 ] && pactl set-sink-volume @DEFAULT_SINK@ +1%
#kill -n 45 $(pidof dwmblocks)
#kill SIGHUP $(pidof lemonbar)
echo $(( $volOld + 1 < 80 ? $volOld + 1 : 80 )) >> /tmp/xobpipe
