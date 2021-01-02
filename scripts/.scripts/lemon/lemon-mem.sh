#!/bin/sh
echo -n "%{F$(xgetres a.color10)}%{A:$TERMINAL -e gotop &:}$($SCRIPTS_FOLDER/mem.sh)%{A}%{F-}"
