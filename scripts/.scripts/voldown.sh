#!/bin/sh
#If volume above 0, go down by 10%.
step=$($SCRIPTS_FOLDER/conf.sh audio.step)
pipe=$($SCRIPTS_FOLDER/conf.sh audio.pipe)

pactl set-sink-volume @DEFAULT_SINK@ -$step%
echo $(pamixer --get-volume) >> $pipe
pkill -51 lemontopc
