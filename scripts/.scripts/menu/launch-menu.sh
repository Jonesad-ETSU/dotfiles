#!/bin/bash


conf() {
	yq .$1 ~/conf.yml | sed 's/"//g'
}

menu=$(conf menutype)
if [ $menu = "dmenu" ];then
	background=$(conf bg)
	foreground=$(conf fg)
	terminal=$(conf term)
	dmenu_font=$(conf lemon.iconfont)
	color5=$(conf color5)
elif [ $menu = "rofi" ];then
	rofi_font="xft:$(conf lemon.iconfont)"
	rofi_theme=$(conf menu.theme)
fi

wallpaperFolder="$HOME/Wallpaper"
_menu() {
  [ $menu = "dmenu" ] && \
	dmenu -c -l 11 -fn "$dmenu_font" -nb $background -nf $foreground -sb $color5 -sf $background -p | cut -d ' ' -f 2 \
                    || \
	rofi -i  -lines 11 -matching fuzzy -dmenu -p ' ' -font "U $${rofi_font} 22" /us-config r/share/rofi/themes/$rofi_theme.rasi | cut -d ' ' -f 2 
}

_start() { 
  [ -d $1 ] && (_loop $(ls -1 $1 | _menu | cut -d ' ' -f 2 ) $2 ) \
    || (_loop $(cat $SCRIPTS_FOLDER/$1 | _menu | cut -d ' ' -f 2 ) $2 )
}

_loop () {
  case $2 in
  1)  #Wallpapers
    case $1 in
      'Cancel') _start menu/general & ;;
      *) feh --bg-scale $wallpaperFolder/$1 && _start menu/general ;;
    esac ;;
  2)  #Games
    case $1 in
      'Steam') exec steam & ;;
      'Lutris') exec lutris & ;;
      'Melee') _start menu/melee 6 & ;;
      'Slay-The-Spire') exec prime-run ~/.steam/steam/steamapps/common/SlayTheSpire/SlayTheSpire & ;;
      'Minecraft') exec prime-run MultiMC & ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  3)  #Tools
    case $1 in
      'LibreOffice') exec libreoffice & ;;
      'Install-Packages') exec $terminal -e $SCRIPTS_FOLDER/fuzzypkg/fuzzypkg & ;;
      'System-Monitor') exec $terminal -e bashtop & ;;      
      'Drive-Analyzer') exec $terminal -e ncdu & ;;
      'Screenshot') exec  scrot "$(date +%c).png" -e 'mv "$f" ~/Pictures/Screenshots/ ; notify-send -i ~/.scripts/icons/camera.png "Screenshot Saved"' & ;;
      'Virtual-Machines') exec virt-manager & ;;
      'Font-Viewer') exec gucharmap & ;;
      'Bandwhich') exec $terminal -e bandwhich & ;;       
      'Serial-Pi') exec $terminal -e "minicom -D /dev/ttyUSB0 -b 115200 || echo 'No Serial Detected'; read" ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  4)  #Settings
    case $1 in 
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Scripts-Folder') exec $terminal --working-directory $SCRIPTS_FOLDER & ;;
      'Toggle-Blue-Filter') killall xflux && exit || xflux -z $ZIP & ;;
      'Theme') exec lxappearance & ;;
      'Network') exec $terminal -e nmtui & ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  5) #Power
    case $1 in
      'Logout') killall xinit & ;;
      'Lock') $SCRIPTS_FOLDER/locker.sh & ;;
      'Hibernate') sudo ZZZ & ;;
      'Sleep') sudo zzz & ;;
      'Shutdown') systemctl poweroff & ;;
      'Kill-X') killall xinit &;;
      'Reboot') systemctl reboot ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  6) #Melee
    case $1 in
      'Netplay') exec prime-run ~/Downloads/Slippi_Online-x86_64.AppImage -e ~/Downloads/SSBM.iso -b & ;;
      'Offline') exec prime-run dolphin-emu -e ~/Downloads/SSBM.iso -b & ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  7) #Music
  case $1 in
	  'Player') exec $terminal -e ncmpcpp & ;;
	  'Spotify') exec spotify & ;;
    	  'Cancel') _start menu/general & ;;
  esac ;;
  *)  #General
    case $1 in
      'Terminal') exec $terminal & ;;
      'Firefox') exec firefox & ;;
      'Games') _start menu/games 2 & ;;
      'Music') _start menu/music 7 & ;;
      'Vim') exec $terminal -e vim & ;;
      'Record') exec $terminal -e echo "working on it" && read & ;;
      'Discord') exec discord & ;;
      'Files') exec $terminal -e ranger & ;;
      'Mail') exec firefox "http://outlook.office365.com" & ;;
      'Tools') _start menu/tools 3 & ;;
      'Settings') _start menu/settings 4 & ;;
      'Power') _start menu/shutdown-prompt 5 & ;;
      'Wallpaper') _start $wallpaperFolder 1 & ;;
      'Cancel') _start menu/general & ;;
    esac ;;
  esac
}

_start menu/general 
