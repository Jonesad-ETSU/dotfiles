#!/bin/sh
printf "%s" "%{F$(xgetres a.color11)}%{A:$SCRIPTS_FOLDER/lemon/yad-bright.sh &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh brightness) %{F-}$($SCRIPTS_FOLDER/brightness.sh)%{A}"
