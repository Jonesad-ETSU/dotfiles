#!/bin/sh
pipe=$(xgetres audio.pipe)
max=$(xgetres audio.max)

[ -f $pipe ] || mkfifo $pipe
tail -f $pipe | xob -m $max  
