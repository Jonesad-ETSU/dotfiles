#!/bin/sh
if [ $WM = 'bspwm' ]; then
	layout=$($SCRIPTS_FOLDER/bspwm-get-layout.sh)
	if [ $layout = 'tiled' ]; then logo=$($SCRIPTS_FOLDER/lemon/get-symbol.sh tiled) 
	elif [ $layout = 'monocle' ]; then logo=$($SCRIPTS_FOLDER/lemon/get-symbol.sh monocle)
	elif [ $layout = 'floating' ]; then logo=$($SCRIPTS_FOLDER/lemon/get-symbol.sh floating)
	fi

	printf "%s" "%{A:bspc desktop --layout next && pkill -51 lemontopc:}%{F$(xgetres color6)} $logo %{F-}%{A}"
fi
