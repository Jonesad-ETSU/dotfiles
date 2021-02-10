#!/bin/sh
printf "%s" "%{F$(xgetres color2)}%{A:$SCRIPTS_FOLDER/lemon/yad-time.sh &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh time)%{F-} $($SCRIPTS_FOLDER/time.sh)%{A}"
