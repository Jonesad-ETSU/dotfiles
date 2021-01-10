#!/bin/bash
#Need to do this
yad --form --width 200 --height 80 --text "\t  What should I do?" \
  --buttons-layout=center \
  --field="Lock":fbtn "$SCRIPTS_FOLDER/locker.sh" \
  --field="Sleep":fbtn "sudo zzz" \
  --field="Hibernate":fbtn "sudo ZZZ" \
  --field="Shutdown":fbtn \
    " yad --mouse --text 'Are you sure?' --button='Cancel':1 --button='Shutdown':sudo halt" \
  --field="Kill-X":fbtn \
    " yad --mouse --text 'Are you sure?' --button='Cancel':1 --button='Kill-X':killall xinit" \
  --button="Cancel":1 \
  --mouse \
  --fixed \
  --close-on-unfocus \
  --skip-taskbar \
  --title "Transparent"
