#!/bin/bash
printf "%s" "%{B#A3BE8C}%{F#3B4252}%{A1:mpc toggle &:}%{A3:$TERMINAL -e ncmpcpp &:} %{T1} $($SCRIPTS_FOLDER/mpd.sh)%{T-}%{A}%{A} %{F-}%{B-}" 
