#!/bin/sh
echo "%{A:$SCRIPTS_FOLDER/lemon/yad-time.sh &:}$($SCRIPTS_FOLDER/time.sh)%{A}"
