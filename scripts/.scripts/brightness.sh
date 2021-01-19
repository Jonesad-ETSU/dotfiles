#!/bin/sh
echo -n "$(xgetres brightness.symbol) $(( $(brightnessctl g)*100 / 24000 ))%"
