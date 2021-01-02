export EDITOR=vim
export COMPOSITOR=picom
export TERMINAL="alacritty"
export XDG_SESSION_TYPE=x11
export FILE_MANAGER="$TERMINAL -e ranger"
export SCRIPTS_FOLDER="$HOME/.scripts"
export DMENU=0
export ZIP=37604
export MAX_HEARTS=5
export QT_QPA_PLATFORMTHEME=gtk2
export PATH="$HOME/.cargo/bin:$HOME/.src/Discord:$SCRIPTS_FOLDER:$SCRIPTS_FOLDER/lemon:$SCRIPTS_FOLDER/dmenu:$PATH"

#option=$(dialog --clear --backtitle "Startx" --title "Desktop Enviornment" --stdout --menu "Choose one of the following: " 15 40 4 'd' 'DWM' 'f' 'FVWM' 'g' 'GNOME' 'x' 'XFCE') 
#case $option in
#  'd') export WM=dwm && startx $HOME/.config/x/dwm ;;
#  'f') export WM=fvwm && startx $HOME/.config/x/fvwm ;;
#  'g') export WM=gnome && startx $HOME/.config/x/gnome ;;
#  'x') export WM=xfwm && startx $HOME/.config/x/xfce ;;
#   *) ;;
#esac

case $( echo "awesome\ndwm\nfvwm\ngnome\nxfce" | fzf ) in
  'dwm') export WM=dwm && startx $HOME/.config/x/dwm ;;
  'fvwm') export WM=fvwm && startx $HOME/.config/x/fvwm ;;
  'gnome') export WM=gnome && startx $HOME/.config/x/gnome ;;
  'xfce') export WM=xfwm && startx $HOME/.config/x/xfce ;;
  'awesome') export WM=awesome && startx $HOME/.config/x/awesome ;;
   *) ;;
esac 	

