option=$(dialog --clear --backtitle "Startx" --title "Desktop Enviornment" --stdout --menu "Choose one of the following: " 15 40 4 'a' 'awesome' 'd' 'dwm' 'f' 'fvwm' 'm' 'mate-session' 'o' 'openbox') 
case $option in
  'd') startx dwm ;;
  'o') startx openbox ;;
  'f') startx fvwm ;;
  'm') startx mate-session ;;
  'a') startx awesome ;;
esac

export PATH="$HOME/.cargo/bin:$PATH"
