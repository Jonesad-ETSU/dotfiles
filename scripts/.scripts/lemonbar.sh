#!/bin/bash
#Lemonbar script containing formatting and signal based updating
scripts="/home/jonesad/.scripts"
barpid=$$
dimensions="1920x32+0+0"
fifo="$HOME/.lemontop_fifo"
setup() {
	[ $(pgrep -cx lemonbar) -gt 0 ] && ( dunstify "ERROR:Top Bar is already running" ; exit 1 )

	[ -e $fifo ] && rm $fifo 
	mkfifo $fifo
}

bar() {
	lemonbar -d -g $dimensions -p -f "$(xgetres dwm.font)" -F "$(xgetres a.foreground)" -B "$(xgetres a.background)"	
}

draw () {
	#killall -q lemonbar
	while :; do vol;sleep 1;done > $fifo &
	while :; do bat;sleep 10;done >> $fifo &
	
	while read -r line ; do
		case $line in
			vol*) volume="${line:3}" ;;
			bat*) battery="${line:3}" ;;
		esac
		printf "%s\n" "%{l}jonesad|workspaces%{r}${volume}|brightness|Mem|Home|Layout%{c}clock|${battery}|music"
	done < "$fifo" | bar | bash ; exit
}

clock () {
	echo "clock%{A:}%{A}"
}
vol () { 
	echo "vol%{A:pavucontrol:}$($scripts/volbar.sh)%{A}"
}
bat () { 
	echo "bat%{A:dunstify Battery Clicked:}$($scripts/battery.sh)%{A}"
}

setup | draw

