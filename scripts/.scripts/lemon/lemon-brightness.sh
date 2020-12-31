#!/bin/sh
echo "%{F$(xgetres a.color3)}%{A:$SCRIPTS_FOLDER/lemon/yad-bright.sh:}$($SCRIPTS_FOLDER/brightness.sh)%{A}%{F-}"
