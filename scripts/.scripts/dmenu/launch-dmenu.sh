#!/bin/sh
background=$(xgetres a.background)
foreground=$(xgetres a.foreground)
color14=$(xgetres a.color14)
scriptFolder="$HOME/.scripts"
wallpaperFolder="$HOME/Wallpaper"

_dmenu() {
  dmenu -c -l 10 -fn "UbuntuMonoDerivativePowerline Nerd Font:size=16" -nb $background -nf $foreground -sb $color14 -sf $background -p | cut -d ' ' -f 2
}

_start() {
  echo $1
  [ -d $1 ] && (_loop $(echo "$(ls -1 $1)" | _dmenu | cut -d ' ' -f 2) $2) \
    || (_loop $(cat $scriptFolder/$1 | _dmenu | cut -d ' ' -f 2) $2)
}

_loop () {
  case $2 in
  1)  #Wallpapers
    case $1 in
      'Cancel') _start dmenu/general & ;;
      *) feh --bg-scale $wallpaperFolder/$1 && _start dmenu/general ;;
    esac ;;
  2)  #Games
    case $1 in
      'Steam') exec steam & ;;
      'Lutris') exec lutris & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  3)  #Tools
    case $1 in
      'OnlyOffice') exec onlyoffice-desktopeditors & ;;
      'System-Monitor') exec urxvtc -t 'SysMon' -e bashtop & ;;      
      'Drive-Analyzer') exec urxvtc -t 'Disk Analyzer' -e ncdu & ;;
      'Screenshot') exec scrot -d 1 & ;;
      'Font-Viewer') exec gucharmap & ;;
      'Bandwhich') exec urxvtc -e bandwhich & ;;       
    esac ;;
  4)  #Settings
    case $1 in 
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Scripts-Folder') exec urxvtc -title Scripts --working-directory $scriptFolder & ;;
      'Network') exec urxvtc -e nmtui & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  5) #Power
    case $1 in
      'Logout') ;;
      'Shutdown') sudo halt & ;;
      'Kill-X') killall xinit &;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  *)  #General
    case $1 in
      'Terminal') exec urxvtc -title Terminal & ;;
      'Chromium') exec chromium & ;;
      'Games') _start dmenu/games 2 & ;;
      'Vim') exec urxvtc -e vim & ;;
      'Record') exec urxvtc -e echo "working on it" && read & ;;
      'Discord') exec discord & ;;
      'Files') exec urxvtc -title Files -e ranger & ;;
      'Mail') exec chromium "http://outlook.office365.com" & ;;
      'Tools') _start dmenu/tools 3 & ;;
      'Settings') _start dmenu/settings 4 & ;;
      'Power') _start dmenu/shutdown-prompt 5 & ;;
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  esac
}

_start dmenu/general 
