#!/bin/bash
#Draws Pound Bar eg: <vol> #########-----
String=" {"
for (( i=1; i<=$1; i++ ))
do
	String="${String}$3"
done
for (( i=1; i<= ($2-$1); i++))
do
	String="${String}--"
done
echo "$String}"
