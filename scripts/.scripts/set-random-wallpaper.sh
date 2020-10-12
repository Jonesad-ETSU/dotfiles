#!/bin/sh
[ $(ps aux | grep "set-random-wallpaper" | wc -l) -gt 3 ] && exit 1
wallpaperdir='/home/jonesad/Wallpaper'
$HOME/.scripts/set-wallpaper.sh "$wallpaperdir/"$(ls $wallpaperdir | shuf -n 1) && sleep 1
