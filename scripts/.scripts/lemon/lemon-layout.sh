#!/bin/bash
if [ $WM = 'bspwm' ]; then
	layout=$(/home/jonesad/.scripts/bspwm-get-layout.sh)
	if [ $layout = 'tiled' ]; then logo=
	elif [ $layout = 'monocle' ]; then logo=
	elif [ $layout = 'floating' ]; then logo=
	fi
	
	printf "%s" "%{A:bspc desktop --layout next && pkill -51 lemonmainc:}%{F#5e8d87} $logo %{F-}%{A}"
fi
