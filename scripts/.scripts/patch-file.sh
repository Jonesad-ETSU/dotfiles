#!/bin/bash

usage() {
	printf "%s" "[USAGE] patch-file.sh fileToPatch optionalCommand"
}

[ $# -lt 1 ] && usage ; exit

[ $# -lt 2 ] && ( pacman -Qe | cut -d ' ' -f1 > ~/.cmd_tmp ) \
	|| ( $($2) > ~/.cmd_tmp )

[ $(cmp -s ~/.cmd_tmp $1) -eq 0 ] && \
	printf "%s" "Package list up to date." ; \
	exit
	
for i in $(cat ~/.cmd_tmp); do
	awk "$1 !~ /^#?$i$/ {print}" $1 >> $1	
done
