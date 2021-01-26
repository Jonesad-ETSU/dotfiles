#!/bin/sh
echo -n "%{F$(xgetres color12)}%{A:$TERMINAL -e nmtui && pkill -50 lemontopc&:}$($SCRIPTS_FOLDER/connected.sh)%{A}%{F-}"
