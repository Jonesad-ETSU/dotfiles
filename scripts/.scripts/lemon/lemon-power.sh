#!/bin/bash
printf "%s" "%{A:$SCRIPTS_FOLDER/lemon/yad-power.sh &:}$($SCRIPTS_FOLDER/get-symbol.sh power)%{A}"
