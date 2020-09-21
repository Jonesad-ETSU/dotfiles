#!/bin/sh
scriptFolder="/home/jonesad/.scripts/dmenu"
case $1 in
	'Terminal') exec alacritty & ;;
	'Firefox') exec firefox & ;;
	'Games') $scriptFolder/launch-dmenu.sh dmenu-games-options & ;;
	'Record') exec alacritty -e echo "working on it" & ;;
	'Discord') exec $HOME/Downloads/ripcord.AppImage & ;;
	'Mail') exec firefox "outlook.office365.com" & ;;
	'System-Monitor') exec alacritty -t 'SysMon' -e /home/jonesad/Downloads/bpytop/bpytop.py & ;;
	'Drive-Analyzer') exec alacritty -t 'Disk Analyzer' -e ncdu & ;;
	'Settings') exec alacritty -e echo "working on settings too.." & ;;
	'Shutdown') $scriptFolder/launch-dmenu.sh dmenu-shutdown && shutdown now & ;;	
	'Cancel') $scriptFolder/launch-dmenu.sh dmenu-gen & ;;
	'Melee-Offline') /usr/share/applications/Melee-Offline.desktop & ;;
	'Melee-Online') /usr/share/applications/Melee-Online.desktop & ;;
	'Counter-Strike:Global Offensive') /usr/share/applications/csgo.desktop & ;;
	'Lutris') exec lutris & ;;
esac
