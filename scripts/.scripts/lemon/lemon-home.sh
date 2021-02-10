#!/bin/sh
printf "%s" "%{F$(xgetres a.color6)}%{A:cd / && $TERMINAL -e ncdu &:}$($SCRIPTS_FOLDER/home.sh)%{A}%{F-}"
