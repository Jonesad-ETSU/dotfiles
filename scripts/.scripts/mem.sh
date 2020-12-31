#!/bin/sh
echo -n " $(/usr/bin/free -m | awk '/Mem:/ { print $3"M/"$2"M"}')"
