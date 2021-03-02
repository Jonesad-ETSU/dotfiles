#!/bin/sh

bat=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

d() {
  dunstify $1 $2 -u $3 -t $4
}


if [ $status != 'Discharging' ]; then
	urgency=low
	time=1000
elif [ $bat -le 20 ]; then
	urgency=critical
	time=1000
elif [ $bat -le 70 ]; then
	urgency=normal
	time=1000
else 
	urgency=low
	time=1000
fi

d "Battery" "${bat}%" $urgency $time 

