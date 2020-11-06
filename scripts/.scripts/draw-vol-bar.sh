#!/bin/bash
#Draws volume bar eg: <vol> #########-----
volString=" ["
for (( i=1; i<=$1; i++ ))
do
	volString="${volString}$3"
done
for (( i=1; i<= ($2-$1); i++))
do
	volString="${volString}--"
done
echo "$volString]"
