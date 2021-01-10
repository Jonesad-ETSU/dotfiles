#!/bin/sh
echo -n "%{F$(xgetres a.color10)}%{A:$TERMINAL -e ytop &:}$($SCRIPTS_FOLDER/mem.sh)%{A}%{F-}"
