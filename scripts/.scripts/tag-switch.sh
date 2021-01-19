#!/bin/sh
if [ $WM = "dwm" ]; then
  dwmc view $1
  pkill -47 lemontopc
fi


