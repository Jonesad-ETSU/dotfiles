#!/bin/sh
xwallpaper --zoom $1 && wal -i $1 && echo $1 > $HOME/.wallpaper
