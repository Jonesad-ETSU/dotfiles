#!/bin/bash
printf "%s" "%{F$($SCRIPTS_FOLDER/conf.sh color6)}%{A:cd / && $TERMINAL -e ncdu &:}$($SCRIPTS_FOLDER/home.sh)%{A}%{F-}"
