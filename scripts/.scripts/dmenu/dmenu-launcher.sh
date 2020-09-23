#!/bin/sh
scriptFolder="/home/jonesad/.scripts/dmenu"
case $1 in
	'Terminal') exec alacritty & ;;
	'Firefox') exec firefox & ;;
	'Games') $scriptFolder/launch-dmenu.sh games/game-options & ;;
	'Record') exec alacritty -e echo "working on it" & ;;
	'Discord') exec $HOME/Downloads/ripcord.AppImage & ;;
  'Files') exec alacritty -t Files -e ranger & ;;
	'Mail') exec firefox "outlook.office365.com" & ;;
	'System-Monitor') exec alacritty -t 'SysMon' -e bashtop & ;;
	'Drive-Analyzer') exec alacritty -t 'Disk Analyzer' -e ncdu & ;;
	'Tools') $scriptFolder/launch-dmenu.sh tools/tools & ;;
	'Settings') $scriptFolder/launch-dmenu.sh settings/settings & ;;
  'Font-Viewer') exec gucharmap & ;;
	'Power') $scriptFolder/launch-dmenu.sh power/shutdown-prompt & ;;
	'Wallpaper') $scriptFolder/launch-dmenu.sh $(ls /home/jonesad/Wallpaper) & ;;
	'Shutdown') shutdown now & ;;	
	'Cancel') $scriptFolder/launch-dmenu.sh dmenu-gen & ;;
	'Melee-Offline') /usr/share/applications/Melee-Offline.desktop & ;;
	'Melee-Online') /usr/share/applications/Melee-Online.desktop & ;;
	'Counter-Strike:Global Offensive') /usr/share/applications/csgo.desktop & ;;
	'Lutris') exec lutris & ;;
esac
