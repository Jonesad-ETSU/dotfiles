#!/bin/sh
echo -n "%{F$(xgetres a.color11)}%{A:$SCRIPTS_FOLDER/lemon/yad-bright.sh &:}$($SCRIPTS_FOLDER/brightness.sh)%{A}%{F-}"
