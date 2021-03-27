#!/bin/bash
printf "%s" "%{B$($SCRIPTS_FOLDER/conf.sh color2)}%{F$($SCRIPTS_FOLDER/conf.sh bg)}%{A1:mpc toggle &:}%{A3:$TERMINAL -e ncmpcpp &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd)%{T1} $($SCRIPTS_FOLDER/mpd.sh)%{T-}%{A}%{A}%{F-}%{B-}" 
