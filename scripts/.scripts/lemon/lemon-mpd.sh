#!/bin/bash
printf "%s" "%{F#98971a}%{A1:mpc toggle &:}%{A3:$TERMINAL -e ncmpcpp &:} %{T1}$(/home/jonesad/.scripts/mpd.sh)%{T-}%{A}%{A} %{F-}" 
