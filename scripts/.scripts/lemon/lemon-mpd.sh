#!/bin/sh

[ $(mpc|grep -c "play") -ge 1 ] && \
	pp="$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.pause)" || \
	pp="$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.play)" 

printf "%s" "%{A:mpc prev &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.prev)%{A}%{F$(xgetres color12)}%{A:$TERMINAL -e ncmpcpp &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd)%{F-} %{+u}$($SCRIPTS_FOLDER/mpd.sh)%{A}%{A:mpc toggle &:}%{-u} %{T2}$pp%{A}%{A:mpc next &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.next)%{A}%{T-}"
