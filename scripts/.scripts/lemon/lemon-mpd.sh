#!/bin/sh

[ $(mpc|grep -c "play") -ge 1 ] && \
	pp="$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.pause)" || \
	pp="$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.play)" 

printf "%s" "%{F$(xgetres color12)}%{A:$TERMINAL -e ncmpcpp &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd)%{F-}%{T1} $($SCRIPTS_FOLDER/mpd.sh)%{T-}%{A} %{A:mpc prev &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.prev)%{A}%{A:mpc toggle &:} %{T2}$pp%{A}%{A:mpc next &:} $($SCRIPTS_FOLDER/lemon/get-symbol.sh mpd.next)%{A}%{T-}"
