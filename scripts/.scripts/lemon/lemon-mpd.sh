#!/bin/bash
printf "%s" "%{B#8c9440}%{F#000000}%{A1:mpc toggle &:}%{A3:$TERMINAL -e ncmpcpp &:} %{T1}$(/home/jonesad/.scripts/mpd.sh)%{T-}%{A}%{A} %{F-}%{B-}" 
