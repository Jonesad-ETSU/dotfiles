#!/bin/sh
background=$(xgetres a.background)
foreground=$(xgetres a.foreground)
terminal=$(xgetres a.terminal)
font=$(xgetres dmenu.font)
[ $terminal = "urxvtc" ] && title="-title" || \
[ $terminal = "alacritty" ] && title="--title" || \
	title="-T"
color5=$(xgetres a.color5)
scriptFolder="$HOME/.scripts"
wallpaperFolder="$HOME/Wallpaper"
ZIP=37604
_dmenu() {
  dmenu -c -l 11 -fn "$font" -nb $background -nf $foreground -sb $color5 -sf $background -p | cut -d ' ' -f 2
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
      'Melee') _start dmenu/melee 6 & ;;
      'Minecraft') exec prime-run MultiMC & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  3)  #Tools
    case $1 in
      'OnlyOffice') exec onlyoffice-desktopeditors & ;;
      'Install-Packages') exec $terminal $title Packages -e $scriptFolder/fuzzypkg/fuzzypkg & ;;
      'System-Monitor') exec $terminal $title Monitor -e bashtop & ;;      
      'Drive-Analyzer') exec $terminal $tile Disk -e ncdu & ;;
      'Screenshot') exec  scrot "$(date +%c).png" -e 'mv "$f" ~/Screenshots/ ; notify-send -i ~/Screenshots/screenshot-icon.png "Screenshot Saved" "~/Screenshots/$(date +%c)" ' & ;;
      'Virtual-Machines') exec virt-manager & ;;
      'Font-Viewer') exec gucharmap & ;;
      'Bandwhich') exec $terminal -e bandwhich & ;;       
      'Serial-Pi') exec $terminal -e "minicom -D /dev/ttyUSB0 -b 115200 || echo 'No Serial Detected'; read" ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  4)  #Settings
    case $1 in 
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Scripts-Folder') exec $terminal $title Scripts --working-directory $scriptFolder & ;;
      'Toggle-Blue-Filter') killall xflux && exit || xflux -z $ZIP & ;;
      'Network') exec $terminal $title Network -e nmtui & ;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  5) #Power
    case $1 in
      'Logout') killall xinit & ;;
      'Shutdown') sudo halt & ;;
      'Kill-X') killall xinit &;;
      'Cancel') _start dmenu/general & ;;
    esac ;;
  6) #Melee
    case $1 in
       'Netplay') exec prime-run ~/Downloads/Slippi_Online-x86_64.AppImage -e ~/Downloads/SSBM.iso -b & ;;
       'Offline') exec prime-run dolphin-emu -e ~/Downloads/SSBM.iso -b & ;;
       'Cancel') _start dmenu/general & ;;
    esac ;;
  7) #Music
  case $1 in
	  'Player') exec $terminal $tile Music -e ncmpcpp & ;;
	  'Spotify') exec spotify & ;;
       	  'Cancel') _start dmenu/general & ;;
  esac ;;
  *)  #General
    case $1 in
      'Terminal') exec $terminal $title Terminal& ;;
      'Firefox') exec firefox & ;;
      'Games') _start dmenu/games 2 & ;;
      'Music') _start dmenu/music 7 & ;;
      'Vim') exec $terminal -e vim & ;;
      'Record') exec $terminal -e echo "working on it" && read & ;;
      'Discord') exec Discord & ;;
      'Files') exec $terminal $title Terminal -e ranger & ;;
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
