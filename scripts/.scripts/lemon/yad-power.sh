#!/bin/bash
#Need to do this
yad --form --width 200 --height 80 --text "What should I do?" \
  --buttons-layout=center \
  --field="Shutdown":fbtn \
    " yad --mouse --text 'Are you sure?' --button='Cancel':1 --button='Shutdown':0 && 'alacritty'" \
  --field="Kill-X":fbtn \
    " yad --mouse --text 'Are you sure?' --button='Cancel':1 --button='Kill-X':0 && 'firefox'" \
  --button="Cancel":1 \
  --mouse \
  --fixed \
  --close-on-unfocus \
  --skip-taskbar \
  --title "Transparent"
