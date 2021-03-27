#!/bin/bash
printf "%s" "%{F$($SCRIPTS_FOLDER/conf.sh color10)}%{A:$TERMINAL -e ytop &:}$($SCRIPTS_FOLDER/mem.sh)%{A}%{F-}"
