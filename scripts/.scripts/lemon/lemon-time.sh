#!/bin/sh
echo -n "%{F$(xgetres color10)}%{A:$SCRIPTS_FOLDER/lemon/yad-time.sh &:}$($SCRIPTS_FOLDER/time.sh)%{A}%{F-}"
