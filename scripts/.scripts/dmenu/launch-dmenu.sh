#!/bin/sh
background=$(xgetres a.background)
foreground=$(xgetres a.foreground)
color14=$(xgetres a.color14)
scriptFolder="$HOME/.scripts"
wallpaperFolder="$HOME/Wallpaper"

_dmenu() {
  dmenu -c -l 10 -fn "DejaVu Sans:size=16" -nb $background -nf $foreground -sb $color14 -sf $background -p | cut -d ' ' -f 2
}

_start() {
  [ -d $1 ] && (_loop $(echo "$(ls -1 $1)" | _dmenu | cut -d ' ' -f 2) $2) \
    || (_loop $(cat $scriptFolder$1 | _dmenu | cut -d ' ' -f 2) $2)
}

_loop () {
  case $2 in
  1)  #Wallpapers
    case $1 in
      'Cancel') _start /dmenu/dmenu-gen & ;;
      *) $scriptFolder/set-wallpaper.sh $wallpaperFolder/$1 && _start /dmenu/dmenu-gen;;
    esac ;;
  2)  #Games
    case $1 in
      'Cancel') _start /dmenu/dmenu-gen & ;;
      'Steam') exec steam & ;;
      'Lutris') exec lutris & ;;
    esac ;;
  *)  #General
    case $1 in
      'Terminal') exec alacritty & ;;
      'Firefox') exec firefox & ;;
      'Games') _start /dmenu/games/game-options 2 & ;;
      'Vim') exec alacritty -e nvim & ;;
      'Record') exec alacritty -e echo "working on it" & ;;
      'Discord') exec discord & ;;
      'Files') exec alacritty -t Files -e ranger & ;;
      'Mail') exec firefox "outlook.office365.com" & ;;
      'System-Monitor') exec alacritty -t 'SysMon' -e bashtop & ;;
      'Drive-Analyzer') exec alacritty -t 'Disk Analyzer' -e ncdu & ;;
      'Tools') _start /dmenu/tools/tools & ;;
      'Screenshot') exec scrot -d 1 & ;;
      'Bandwhich') exec alacritty -e bandwhich & ;;
      'Settings') _start /dmenu/settings/settings & ;;
      'Font-Viewer') exec gucharmap & ;;
      'Power') _start /dmenu/power/shutdown-prompt & ;;
      'Theme') exec lxappearance & ;;
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Scripts-Folder') exec alacritty -t Scripts --working-directory $scriptFolder & ;;
      'Shutdown') shutdown now & ;;	
      'Cancel') _start /dmenu/dmenu-gen & ;;
      'Lutris') exec lutris & ;;
    esac ;;
  esac
}

_start /dmenu/dmenu-gen 
