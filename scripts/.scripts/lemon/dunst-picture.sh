#!/bin/sh
id=$(dunstify -p "Taking a Screenshot" "in... 3...")
sleep 1
dunstify -r $id "Taking a Screenshot" "in... 3... 2..."
sleep 1
dunstify -r $id "Taking a Screenshot" "in... 3... 2... 1..."
sleep 1
dunstify -r $id "Screenshot Taken" -t 1000

