export EDITOR=vim
export COMPOSITOR=picom
export TERMINAL="alacritty"
export XDG_SESSION_TYPE=x11
export LIBGL_DRI3_DISABLE=1
export FILE_MANAGER="$TERMINAL -e ranger"
export SCRIPTS_FOLDER="$HOME/.scripts"
export DMENU=1
export COLORS=nord
export QT_QPA_PLATFORMTHEME=gtk2
export PATH="$HOME/.cargo/bin:$HOME/.src/Discord:$SCRIPTS_FOLDER:$SCRIPTS_FOLDER/lemon:$SCRIPTS_FOLDER/dmenu:$PATH"

#paplay $HOME/Sounds/startup.wav &
WM_FOLDER="$HOME/.config/x"
option=$(dialog --clear --backtitle "Startx" --title "Desktop Enviornment" --stdout --menu "Choose one of the following: " 15 40 4 'b' 'BSPWM' 'c' 'CINNAMON' 'd' 'DWM' 'i' 'ICEWM' 's' 'SOWM') 
case $option in
  'd') export WM=dwm && startx $WM_FOLDER/dwm ;;
  'b') export WM=bspwm && startx $WM_FOLDER/bspwm ;;
  's') export WM=sowm && startx $WM_FOLDER/sowm ;;
  'i') export WM=icewm && startx $WM_FOLDER/icewm ;;
  'c') export WM=cinnamon && startx $WM_FOLDER/cinnamon ;;
   *) ;;
esac

#case $( echo "dwm\nfrankenwm\nfvwm\nsowm" | fzf ) in
#  'dwm') export WM=dwm && startx $HOME/.config/x/dwm ;;
#  'fvwm') export WM=fvwm && startx $HOME/.config/x/fvwm ;;
#  'sowm') export WM=sowm && startx $HOME/.config/x/sowm ;;
#  'frankenwm') export WM=frankenwm && startx $HOME/.config/x/frankenwm ;;
#   *) ;;
#esac 	

