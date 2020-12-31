#!/bin/bash
TAGS=$(xprop -root _NET_DESKTOP_NAMES)
CURRENT=$(xprop -root _NET_CURRENT_DESKTOP | cut -d '=' -f 2 | xargs)
BAR_STRING=""
SEL_PRE="%{+u}%{F}"
SEL_POST="%{-u}"
NORM_PRE=""
NORM_POST=""

get () {
  echo $TAGS | cut -d "=" -f 2 | cut -d ',' -f $1 | cut -d '"' -f 2
}

get-selected() {
  echo $TAGS | cut -d '=' -f 2 | cut -d ',' -f $(( $CURRENT + 1 ))
}

add () {
  if [[ $2 -eq 1  ]]; then
    BAR_STRING="${BAR_STRING} ${SEL_PRE} $1 ${SEL_POST}"  
  else
    BAR_STRING="${BAR_STRING} ${NORM_PRE} $1 ${NORM_POST}"  
  fi
}

draw() {
  for i in {1..9}; do
    [ $(( CURRENT + 1 )) -eq $i ] && add $(get $i) 1 \
                        || add $(get $i) 0
  done
  echo $BAR_STRING
}

draw
