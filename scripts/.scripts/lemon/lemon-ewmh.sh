#!/bin/bash
BAR_STR="%{T2}"

TAGS=$(xprop -root _NET_DESKTOP_NAMES | cut -d "=" -f 2 | sed 's/ //g')
CURRENT_TAG=$(xprop -root _NET_CURRENT_DESKTOP | cut -d "=" -f 2 | sed 's/ //g')
NUM_TAGS=$(xprop -root _NET_NUMBER_OF_DESKTOPS | cut -d "=" -f 2 | sed 's/ //g')

SEL_PRE="["
SEL_POST="] "
NORM_PRE=""
NORM_POST=" "

get () {
  printf "%s" "$TAGS" | cut -d ',' -f $1 | xargs
}

add () {
  [ $2 -eq 1 ] && \
    BAR_STR="${BAR_STR}${SEL_PRE}$1${SEL_POST}" \
      || \
    BAR_STR="${BAR_STR}${NORM_PRE}%{A:$SCRIPTS_FOLDER/tag-switch.sh $(( $3 - 1 )) &:}$1%{A}${NORM_POST}"
}

draw () {
let i=1
while [ $i -le $NUM_TAGS  ]; do
    [ $(( CURRENT_TAG + 1 )) -eq $i ] && add $(get $i) 1 $i \
                                      || add $(get $i) 0 $i
    let i++
  done
  printf "%s"  "$BAR_STR%{F-}%{T-}"
}
draw
