#!/bin/bash

color=$(echo $1 | cut -d '#' -f2 | tr -d '\"')

check() {
	[ $1 -ge 255 ] && echo 255 \
	|| [ $1 -le 0 ] && echo 0 \
	|| echo $1
}

red=$(echo $color | cut -c 1-2)
green=$(echo $color | cut -c 3-4)
blue=$(echo $color | cut -c 5-6)

red_int=$(printf "%x" $(check $(( 16#$red + $2)) ) )
green_int=$(printf "%x" $(check $(( 16#$green + $2)) ) )
blue_int=$(printf "%x" $(check $(( 16#$blue + $2)) ) )

[ ${#red_int} -eq 1 ] && red_int="0${red_int}"
[ ${#green_int} -eq 1 ] && green_int="0${green_int}"
[ ${#blue_int} -eq 1 ] && blue_int="0${blue_int}"

printf "#%s%s%s" $red_int $green_int $blue_int
