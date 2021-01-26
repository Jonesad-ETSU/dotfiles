#!/bin/sh
echo -n "%{A:$TERMINAL -e ncmpcpp &:}$($SCRIPTS_FOLDER/mpd.sh)%{A}"
