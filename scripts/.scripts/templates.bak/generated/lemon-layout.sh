#!/bin/bash
if [ $WM = 'bspwm' ]; then
	layout=$($SCRIPTS_FOLDER/bspwm-get-layout.sh)
	if [ $layout = 'tiled' ]; then logo=
	elif [ $layout = 'monocle' ]; then logo=
	elif [ $layout = 'floating' ]; then logo=
	fi
	
	printf "%s" "%{A:bspc desktop --layout next && pkill -51 lemonmainc:}%{F#88C0D0} $logo %{F-}%{A}"
fi
