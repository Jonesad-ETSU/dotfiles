#!/bin/sh
printf "%s" "%{F$(xgetres color4)}%{A:$TERMINAL -e sudo nmtui-connect && pkill -50 lemontopc&:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh wifi) %{F-}$($SCRIPTS_FOLDER/connected.sh)%{A}"
