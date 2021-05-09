#!/bin/bash
#[ $(ps aux | grep "set-random-wallpaper" | wc -l) -gt 3 ] && exit 1
$SCRIPTS_FOLDER/set-wallpaper.sh "$(realpath ~/Wallpaper)/$(ls $(realpath ~/Wallpaper)| shuf -n 1)" && sleep 1
