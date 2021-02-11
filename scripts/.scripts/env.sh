#!/bin/sh

linker () {
	[ -L $1/$2 ] && unlink $1/$2
	ln -s $1/$3 $1/$2
}

linker ~/.config/sxhkd sxhkdrc $WM
linker ~/.config/dunst dunstrc dunstrc-$COLORS
linker ~/.config/xob styles.cfg $COLORS.cfg
