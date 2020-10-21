#!/bin/sh
#Draws volume bar eg: <vol> #########-----
vol=$1
remainder=$(( $2 - $1 ))
volString=" ["
for (( i=1;i<=$vol;i++ ))
do
	volString="${volString}#"
done
for (( i=1;i<=$remainder;i++))
do
	volString="${volString}"
done
echo "$volString]"
