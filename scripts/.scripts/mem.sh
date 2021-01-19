#!/bin/sh
echo -n "$(xgetres mem.symbol) $(/usr/bin/free -m | awk '/Mem:/ { print $3"M/"$2"M"}')"
