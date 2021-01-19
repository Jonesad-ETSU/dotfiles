#!/bin/bash
counter=0
for (( i=0; i<${#1}; i++ )); do	
	(( counter = (counter*100) + $(printf '%d' "'${1:$i:1}") )) 
done
printf "%d\n" "$counter"
