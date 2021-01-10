#!/bin/bash
#If volume below $MAX, increase by $STEP%.

volOld=$(pamixer --get-volume)
max=$(xgetres audio.max)
step=$(xgetres audio.step)
pipe=$(xgetres audio.pipe)

[ $volOld -lt $max ] && \
	pactl set-sink-volume @DEFAULT_SINK@ +$step%

echo $(( $volOld + $step < $max ? $volOld + $step : $max )) >> $pipe
