#!/bin/sh
printf "%s" "%{F$(xgetres a.color5)}%{A:$SCRIPTS_FOLDER/lemon/yad-power.sh:}$($SCRIPTS_FOLDER/id.sh)%{A}%{F-}"
