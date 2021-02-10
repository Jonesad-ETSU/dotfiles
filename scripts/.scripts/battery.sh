#!/bin/bash
# FONT: Ubuntu Nerd Font
pr=$(cat /sys/class/power_supply/BAT0/capacity)

if [ $(xgetres lemon.textonly) != "0" ]; then
  printf "%d" $pr
  exit
fi

MAX=$(xgetres bat.num)
BAT_FULL=$(xgetres bat.full)
BAT_HALF=$(xgetres bat.half)
BAT_EMPTY=$(xgetres bat.empty)
PR_FULL=$(( 100 / $MAX ))
PR_HALF=$(( $PR_FULL / 2))
battery=""

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
    battery="${battery} $BAT_FULL"
done

[ $cracked -eq 1 ] && battery="${battery} $BAT_HALF"

for (( i=0; i<empty; i++ )); do
    battery="${battery} $BAT_EMPTY"
done

printf "%s" "$battery"
