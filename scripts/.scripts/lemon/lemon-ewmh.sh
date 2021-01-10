#!/bin/bash
BAR_STR="%{T2}"

TAGS=$(xprop -root _NET_DESKTOP_NAMES | cut -d "=" -f 2 | sed 's/ //g')
CURRENT_TAG=$(xprop -root _NET_CURRENT_DESKTOP | cut -d "=" -f 2 | sed 's/ //g')

SEL_PRE="%{+u}%{B$(xgetres color1)} "
SEL_POST=" %{-u}%{B-}"
NORM_PRE=" "
NORM_POST=" "

get () {
  echo $TAGS | cut -d ',' -f $1 | xargs
}

add () {
  [ $2 -eq 1 ] && \
    BAR_STR="${BAR_STR}${SEL_PRE}$1${SEL_POST}" \
      || \
    BAR_STR="${BAR_STR}${NORM_PRE}%{A:dwmc view $(( $3 - 1 )) && pkill -46 lemontopc:}$1%{A}${NORM_POST}"
}

draw () {
  for i in {1..9}; do
    [ $(( CURRENT_TAG + 1 )) -eq $i ] && add $(get $i) 1 $i \
                                      || add $(get $i) 0 $i
  done
  echo -n "$BAR_STR %{T-}"
}
draw
