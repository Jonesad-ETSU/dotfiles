#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

case $2 in
dwm)
	$HOME/.fehbg &
	xbanish &
	sxhkd &
	urxvtd &
	tail -f /tmp/xobpipe | xob -m 80 &
	dwmblocks &
	steam -silent &
	picom -b --config $HOME/.config/picom.conf &
	exec dbus-run-session dwm
;;
xfce4)
	xbanish &
	sxhkd &
	urxvtd &
	steam -silent &
	exec dbus-run-session startxfce4
;;
esac

