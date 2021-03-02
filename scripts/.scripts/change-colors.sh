#!/bin/sh

conf_link ( ) {
	cd $1
	unlink $2
	if [ -z $3 ]; then
		ln -s $(/bin/ls -1A | shuf -n 1) $2
	else
		echo "Yes"
		ln -s $3 $2	
	fi
	}

conf_link $HOME/.config/x/color current 

killall -r "lemon*"
killall $WM
sleep 1
cd -
