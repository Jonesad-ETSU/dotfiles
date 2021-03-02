#!/bin/sh

linker () {
	[ -L $1/$2 ] && sudo unlink $1/$2
	sudo ln -s $1/$3 $1/$2
}

linker ~/.config/sxhkd sxhkdrc $WM
linker ~/.config/dunst dunstrc $(xgetres theme.name)
linker ~/.config/xob styles.cfg $(xgetres theme.name)

sed '2d' ~/.config/gtk-3.0/settings.ini > ~/.config/gtk-3.0/settings.ini
#echo "gtk-theme-name:$(xgetres gtk.theme)" >> ~/.config/gtk-3.0/settings.ini
