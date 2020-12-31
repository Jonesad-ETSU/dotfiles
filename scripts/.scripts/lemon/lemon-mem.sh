#!/bin/sh
echo -n "%{F$(xgetres a.color10)}%{A:$TERM -e gotop &:}$($SCRIPTS_FOLDER/mem.sh)%{A}%{F-}"
