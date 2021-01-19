#!/bin/sh
echo -n "%{F$(xgetres color12)}%{A:$TERMINAL -e nmtui &:}$($SCRIPTS_FOLDER/connected.sh)%{A}%{F-}"
