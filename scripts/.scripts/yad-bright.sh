#!/bin/sh
brightnessctl s "$(yad --scale --mouse)%"
/usr/bin/kill --signal USR1 $(pidof lemonbar.sh)
