#!/bin/sh
echo -n " $($SCRIPTS_FOLDER/pound-bar.sh \
  $(( $(pamixer --get-volume) / 10 )) \
  8 \
  $(pamixer --get-mute > /dev/null 2>&1 && \
    echo 'X' \
    || echo '#') 
  )"
