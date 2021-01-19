#!/bin/sh
id=$(dunstify -i $2 "$1" "5..." -p )
sleep 1
dunstify -i $2 "$1" "5... 4..." -r $id -t 2000
sleep 1
dunstify -i $2 "$1" "5... 4... 3..." -r $id -t 2000
sleep 1
dunstify -i $2 "$1" "5... 4... 3... 2..." -r $id -t 2000
sleep 1
dunstify -i $2 "$1" "5... 4... 3... 2... 1..." -r $id -t 1000
sleep 1
