#!/bin/sh
#If volume above 0, go down by 10%.
step=$(xgetres audio.step)
pipe=$(xgetres audio.pipe)

pactl set-sink-volume @DEFAULT_SINK@ -$step%
echo $(pamixer --get-volume) >> $pipe
pkill -51 lemontopc
