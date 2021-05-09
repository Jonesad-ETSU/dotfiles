#!/bin/sh
pipe=$($SCRIPTS_FOLDER/conf.sh audio.pipe)
max=$($SCRIPTS_FOLDER/conf.sh  audio.max)
limited=$($SCRIPTS_FOLDER/conf.sh audio.limited)
fade=$($SCRIPTS_FOLDER/conf.sh audio.fadetime)

echo $fade
[ -p $pipe ] || mkfifo $pipe
[ $limited -eq 1 ] && ( tail -f $pipe | xob -m $max -t $fade )\
       	|| (tail -f $pipe | xob -t $fade )
