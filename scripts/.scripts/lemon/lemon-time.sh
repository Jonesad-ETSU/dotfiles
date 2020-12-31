#!/bin/sh
echo -n "%{A:$SCRIPTS_FOLDER/lemon/yad-time.sh &:}$($SCRIPTS_FOLDER/time.sh)%{A}"
