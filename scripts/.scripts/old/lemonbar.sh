#!/bin/bash
#Lemonbar script containing formatting and signal based updating
scripts="/home/jonesad/.scripts"
barpid=$$
dimensions="1920x32+0+0"
fifo="$HOME/.lemontop_fifo"

trap "killall lemonbar.sh; exit 0" SIGHUP SIGINT SIGTERM

setup() {
	[ $(pgrep -cx lemonbar) -gt 0 ] && ( dunstify "ERROR:Top Bar is already running" ; exit 1 )

	[ -e $fifo ] && rm $fifo 
	mkfifo $fifo
}

bar() {
	lemonbar -d -g $dimensions -f "$(xgetres dwm.font)" -o -7 -f "Ubuntu Nerd Font:size=20" -o 0 -f "Ubuntu Nerd Font:size=18" -o -1 -F "$(xgetres a.foreground)" -B "$(xgetres a.background)"	
}

draw () {
	#killall -q lemonbar
	while :; do 
		user
		sleep 100000
       	done > $fifo &

	while :; do 
		home
		sleep 60 &
		wait
	done > $fifo &
	
	while :; do 
		mem
		sleep 5 &
		wait
	done > $fifo &
	
	while :; do 
		clock
		sleep 30 &
		wait
	done > $fifo &
	
	while :; do
	       	brightness
		sleep 30 &
		wait
       	done > $fifo &
	
	while :; do 
		bat
		sleep 30 &
		wait
	done > $fifo &
	
	while read -r line ; do
		case $line in
			#vol*) volume="${line:3}" ;;
			bat*) battery="${line:3}" ;;
			clock*) clock="${line:5}" ;;
			user*) user="${line:4}" ;;
			brightness*) brightness="${line:10}" ;;
			home*) home="${line:4}" ;;
			mem*) mem="${line:3}" ;;
		esac
		printf "%s\n" "%{l}  [ ${user} ] [T] => tags%{r} [ ${brightness} ] [ ${mem} ] [ ${home} ]  [ music  ] %{c}%{F$(xgetres a.color3)} ${clock} | %{F$(xgetres a.color1)}{battery} %{F-}"
	done < "$fifo" | bar | bash ; exit
}

mem() {
	printf "%s\n" "mem%{A:$TERM -e gotop &:}$($scripts/mem.sh)%{A}"
}
home() {
	printf "%s\n" "home%{A:$TERM -e ncdu &:}$($scripts/home.sh)%{A}"
}
brightness () {
	printf "%s\n" "brightness%{A:sh $scripts/yad-bright.sh && kill -12 $barpid &:}$($scripts/brightness.sh)%{A}"
}
user () {
	printf "%s\n" "user%{A:$TERM &:}$($scripts/id.sh)%{A}"
}
clock () {
	printf "%s\n" "%{A:yad --calendar --mouse & :}%{T2}$($scripts/time.sh)%{T-}%{A}"
}
#vol () { 
#	printf "%s\n" "{A:pavucontrol:}$($scripts/volbar.sh)%{A}"
#}
bat () { 
	printf "%s\n" "%{A:dunstify Battery $(cat /sys/class/power_supply/BAT0/capacity) & :}$($scripts/battery.sh)%{A}"
}

setup | draw

