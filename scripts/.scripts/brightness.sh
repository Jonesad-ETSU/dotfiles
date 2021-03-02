#!/bin/sh
printf "%s" "$(( $(brightnessctl g)*100 / 24000 ))%"
