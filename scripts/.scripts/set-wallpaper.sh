#!/bin/sh
command -v xwallpaper > /dev/null 2>&1 && xwallpaper --zoom $1 && echo $1 > $HOME/.wallpaper
command -v feh > /dev/null  2>&1 && feh --bg-scale $1
echo $1 > $HOME/.wallpaper
