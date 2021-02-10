#!/bin/sh
printf "%s" "%{F$(xgetres a.color10)}%{A:$TERMINAL -e ytop &:}$($SCRIPTS_FOLDER/mem.sh)%{A}%{F-}"
