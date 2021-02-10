#!/bin/sh
printf "%s" "%{F$(xgetres color12)}%{A:$TERMINAL -e ncmpcpp &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd)%{F-} %{+u}$($SCRIPTS_FOLDER/mpd.sh)%{A}%{A:mpc toggle:}%{-u} %{T2}%{A}%{A:mpc next:} %{A}%{T-}"
