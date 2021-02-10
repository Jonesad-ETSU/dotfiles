#!/bin/sh
printf "%s" "%{F$(xgetres color5)}%{R}%{A:$SCRIPTS_FOLDER/menu/launch-menu.sh &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh launcher) %{A}%{R}%{F-}"
