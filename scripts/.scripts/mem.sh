#!/bin/sh
printf "%s" "$(xgetres mem.symbol) $(/usr/bin/free -m | awk '/Mem:/ { print $3"M/"$2"M"}')"
