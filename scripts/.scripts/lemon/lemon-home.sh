#!/bin/sh
echo "%{F$(xgetres a.color6)}%{A:$TERM -e ncdu &:}$($SCRIPTS_FOLDER/home.sh)%{A}%{F-}"
