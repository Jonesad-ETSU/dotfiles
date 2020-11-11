#!/bin/sh
background=$(xgetres a.background)
foreground=$(xgetres a.foreground)
color14=$(xgetres a.color14)
scriptFolder="$HOME/.scripts"
wallpaperFolder="$HOME/Wallpaper"
ZIP=37604
_dmenu() {
  dmenu -c -l 10 -fn "UbuntuMonoDerivativePowerline Nerd Font:size=24" -nb $background -nf $foreground -sb $color14 -sf $background -p | cut -d ' ' -f 2
}

_start() { 
  [ -d $1 ] && (_loop $(ls -1 $1 | _dmenu | cut -d ' ' -f 2 ) $2 ) \
    || (_loop $(cat $scriptFolder/$1 | _dmenu | cut -d ' ' -f 2 ) $2 )
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
      'Melee (Offline)') exec dolphin-emu -e ~/Downloads/SSBM.iso -b & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  3)  #Tools
    case $1 in
      'OnlyOffice') exec onlyoffice-desktopeditors & ;;
      'System-Monitor') exec urxvtc -e bashtop & ;;      
      'Drive-Analyzer') exec urxvtc -e ncdu & ;;
      'Screenshot') exec  scrot "$(date +%c).png" -e 'mv "$f" ~/Screenshots/ ; notify-send -i ~/Screenshots/screenshot-icon.png "Screenshot Saved" "~/Screenshots/$(date +%c)" ' & ;;
      'Virtual-Machines') exec virt-manager & ;;
      'Font-Viewer') exec gucharmap & ;;
      'Bandwhich') exec urxvtc -e bandwhich & ;;       
      'Serial-Pi') exec urxvtc -e "minicom -D /dev/ttyUSB0 -b 115200 || echo 'No Serial Detected'; read" ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  4)  #Settings
    case $1 in 
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Scripts-Folder') exec urxvtc -title Scripts --working-directory $scriptFolder & ;;
      'Toggle-Blue-Filter') killall xflux && exit || xflux -z $ZIP & ;;
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
      'Firefox') exec firefox & ;;
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
