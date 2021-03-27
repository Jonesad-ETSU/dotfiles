#!/bin/bash
printf "%s" "%{B$($SCRIPTS_FOLDER/conf.sh color2)}%{F$($SCRIPTS_FOLDER/conf.sh bg)}%{A:$SCRIPTS_FOLDER/lemon/yad-time.sh &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh time) $($SCRIPTS_FOLDER/time.sh)%{A} %{B-}%{F-}"
