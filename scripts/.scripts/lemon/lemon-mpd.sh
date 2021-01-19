#!/bin/sh
echo -n "%{+u}%{A:$TERMINAL -e ncmpcpp &:}$($SCRIPTS_FOLDER/mpd.sh)%{A}  PLAY%{-u}"
