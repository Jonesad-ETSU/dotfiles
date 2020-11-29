export EDITOR=vim
export COMPOSITOR=picom
export TERMINAL="urxvtc"
export FILE_MANAGER="$TERMINAL -e ranger"
export ZIP=37604
export MAX_HEARTS=5
export QT_QPA_PLATFORMTHEME=gtk2
export PATH="$HOME/.cargo/bin:$HOME/.src/Discord:$PATH"

option=$(dialog --clear --backtitle "Startx" --title "Desktop Enviornment" --stdout --menu "Choose one of the following: " 15 40 4 'd' 'DWM' 'e' 'ENLIGHTENMENT' 'f' 'FVWM' 'x' 'XFCE') 
case $option in
  'd') export WM=dwm && startx dwm ;;
  'f') export WM=fvwm && startx fvwm ;;
  'x') export WM=xfwm && startx xfce4 ;;
  'e') export WM=el && startx enlightenment_start ;;
esac

