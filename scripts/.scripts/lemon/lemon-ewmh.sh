#!/bin/bash
BAR_STR="%{T1}"

if [ $WM = 'dwm' ]; then
	TAGS=$(xprop -root _NET_DESKTOP_NAMES | cut -d "=" -f 2 | tr -d ' ')
	CURRENT_TAG=$(xprop -root _NET_CURRENT_DESKTOP | cut -d "=" -f 2 | tr -d ' ')
	NUM_TAGS=$(xprop -root _NET_NUMBER_OF_DESKTOPS | cut -d "=" -f 2 | tr -d ' ')
elif [ $WM = 'bspwm' ]; then
	TAGS=$(bspc query -D --names | tr '\n' ' ')
	CURRENT_TAG=$(bspc query -D -d focused --names)
	NUM_TAGS=$(bspc query -D --names | wc -l)
fi
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
	if [ $WM = 'dwm' ]; then
		while [ $i -le $NUM_TAGS  ]; do
		  	 [ $(( CURRENT_TAG + 1 )) -eq $i ] && add $(get $i) 1 $i \
		                                           || add $(get $i) 0 $i
						    	   let i++
	  	done
		printf "%s"  "$BAR_STR%{F-}%{T-}"
	elif [ $WM = 'bspwm' ]; then
		for (( i = 1; i <= $NUM_TAGS; i++ )); do
			if [ $(echo -n $TAGS | cut -d ' ' -f $i) = $CURRENT_TAG ]; then
				BAR_STR="${BAR_STR}${SEL_PRE}$CURRENT_TAG${SEL_POST}"
			else
				BAR_STR="${BAR_STR}${NORM_PRE}%{A:$SCRIPTS_FOLDER/tag-switch.sh $(echo -n $TAGS | cut -d ' ' -f $i) &:}$(echo -n $TAGS | cut -d ' ' -f $i)%{A}${NORM_POST}"
			fi											done	
		 printf "%s" "$BAR_STR"
	fi
}


draw
