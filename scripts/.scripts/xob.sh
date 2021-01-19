#!/bin/sh
pipe=$(xgetres audio.pipe)
max=$(xgetres audio.max)

[ -p $pipe ] || mkfifo $pipe
tail -f $pipe | xob -m $max -t 1000 
