#!/bin/bash
USER_DIR="/home/jonesad" #Needed so root uses same picture
sleep 1 && scrot -o -f "$USER_DIR/.lockscreen.png"

convert $USER_DIR/.lockscreen.png -blur 5x4 -font 'Ubuntu-Nerd-Font-Complete' \
  -pointsize 48 -fill $(/usr/local/bin/xgetres a.color1) -gravity center \
  -annotate +0+340 "Type Password to Unlock" $USER_DIR/.scripts/icons/lock.png \
  -gravity center -composite $USER_DIR/.lockscreen.png

i3lock -e -i $USER_DIR/.lockscreen.png \
  --indicator \
  --radius=300 \
  --insidecolor="#00000000" \
  --insidevercolor="#00000000" \
  --ringvercolor="#00000000" \
  --ringwrongcolor="#FFFFFFFF" \
  --keyhlcolor=$(/usr/local/bin/xgetres a.foreground) \
  --bshlcolor=$(/usr/local/bin/xgetres a.color1) \
  --insidewrongcolor="#00000000" \
  --ringcolor=$(/usr/local/bin/xgetres a.color1) \
  --linecolor="#00000000" \
  --wrongtext="Incorrect Password" \
  && [ $# -eq 1 ] && $1
