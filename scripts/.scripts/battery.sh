#!/bin/bash
# FONT: Ubuntu Nerd Font

battery=""
pr=$(cat /sys/class/power_supply/BAT0/capacity)
whole=0
empty=0
cracked=0

let counter=0

for (( ; pr > 0; counter++ ))
do
	if [ $pr -ge 20 ]; then
		let "pr-=20" 
		let "whole+=1"
		continue
	elif [ $pr -ge 10  ]; then
		pr=0
		let "whole+=1"
		continue 	
	elif [ $pr -ge 1 ]; then
		pr=0 
       		cracked=1
	fi
done	

let "empty=$MAX_HEARTS-counter"

for (( i=0; i<whole; i++ )); do
    battery="${battery} "
done

[ $cracked -eq 1 ] && battery="${battery} "

for (( i=0; i<empty; i++ )); do
    battery="${battery} "
done

echo $battery
#echo "Battery Testing"
#echo "whole: $whole"
#echo "cracked: $cracked"
#echo "empty: $empty"
