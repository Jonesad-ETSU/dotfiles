#!/bin/sh
if [ $WM = "dwm" ]; then
  dwmc view $1
  pkill -47 lemonmainc
elif [ $WM = 'bspwm' ];then
  bspc desktop --focus $1
  pkill -47 lemonmainc
fi


