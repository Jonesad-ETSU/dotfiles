#!/bin/bash
#If volume below $MAX, increase by $STEP%.

volOld=$(pamixer --get-volume)
max=$($SCRIPTS_FOLDER/conf.sh audio.max)
step=$($SCRIPTS_FOLDER/conf.sh audio.step)
pipe=$($SCRIPTS_FOLDER/conf.sh audio.pipe)

[ $volOld -lt $max ] && \
	pactl set-sink-volume @DEFAULT_SINK@ +$step%

echo $(( $volOld + $step < $max ? $volOld + $step : $max )) >> $pipe
pkill -51 lemontopc
