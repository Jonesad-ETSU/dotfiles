export EDITOR=vim
export COMPOSITOR=picom
export FILE_MANAGER="urxvtc -e ranger"
export PATH="$HOME/.cargo/bin:$HOME/.src/Discord:$PATH"

option=$(dialog --clear --backtitle "Startx" --title "Desktop Enviornment" --stdout --menu "Choose one of the following: " 15 40 4 'd' 'dwm' 'f' 'fvwm' 'x' 'xfce4') 
case $option in
  'd') export WM=dwm && startx dwm;;
  'f') export WM=fvwm && startx fvwm;;
  'x') export WM=xfwm && startx xfce4 ;;
esac

