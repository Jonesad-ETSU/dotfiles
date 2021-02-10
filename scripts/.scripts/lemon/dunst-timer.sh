#!/bin/bash
let length=$3
id=$(dunstify -i $2 "$1" "$length..." -p )
str="$length... "
sleep 1
for (( i = $length-1; i > 0; i-- )); do
	printf "%s%d%s" "Counting[",$i,']'
	str="${str}$i... "
	printf "%s" $str
	dunstify -i $2 "$1" "$str" -r $id -t 2000 
done

#dunstify -i $2 "$1" "5... 4..." -r $id -t 2000
#sleep 1
#dunstify -i $2 "$1" "5... 4... 3..." -r $id -t 2000
#sleep 1
#dunstify -i $2 "$1" "5... 4... 3... 2..." -r $id -t 2000
#sleep 1
#dunstify -i $2 "$1" "5... 4... 3... 2... 1..." -r $id -t 1000
#sleep 1
