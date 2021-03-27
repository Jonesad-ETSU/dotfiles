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

