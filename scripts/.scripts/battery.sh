#!/bin/bash
pr=$(cat /sys/class/power_supply/BAT0/capacity)

if [ 0 != "0" ]; then
  printf "%d" $pr
  exit
fi

COLOR="#b5bd68"
COLOR_HALF="#8d9540"
COLOR_EMPTY="#000000"

MAX=5
BAT=
PR_FULL=$(( 100 / $MAX ))
PR_HALF=$(( $PR_FULL / 2))
battery="%{F$COLOR}"

whole=0
empty=0
cracked=0

let counter=0

for (( ; pr > 0; counter++ ))
do
  if [ $pr -ge $PR_FULL ]; then
	let "pr-=$PR_FULL" 
	let "whole+=1"
	continue
  elif [ $pr -ge $PR_HALF ]; then
	pr=0
	let "whole+=1"
	continue 	
  elif [ $pr -ge 1 ]; then
  	pr=0 
  	cracked=1
  fi
done	

let "empty=$MAX-counter"

for (( i=0; i<whole; i++ )); do
    battery="${battery}$BAT"
done

[ $cracked -eq 1 ] && battery="${battery}%{F$COLOR_HALF}$BAT"

for (( i=0; i<empty; i++ )); do
    battery="${battery}%{F$COLOR_EMPTY}$BAT"
done

printf "%s" "$battery%{F-}"
