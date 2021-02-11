#!/bin/sh
printf "%s" "%{A:$SCRIPTS_FOLDER/menu/launch-menu.sh &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh launcher)%{A}"
