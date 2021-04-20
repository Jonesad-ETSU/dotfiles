#!/bin/bash
printf "%s" "%{F$($SCRIPTS_FOLDER/conf.sh color4)}%{A:$TERMINAL -e sudo iwctl && pkill -50 lemontopc&:}$($SCRIPTS_FOLDER/get-symbol.sh wifi) %{F-}$($SCRIPTS_FOLDER/connected.sh)%{A}"
