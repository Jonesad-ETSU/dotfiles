#!/bin/sh
ScriptFolder="/home/jonesad/.scripts/dmenu"
Background=$(xgetres a.background)
Foreground=$(xgetres a.foreground)
Color14=$(xgetres a.color14)
$ScriptFolder/dmenu-launcher.sh $(cat $ScriptFolder/$1 | dmenu -c -l 10 -fn "DejaVu Sans:size=16" -nb $Background -nf $Foreground -sb $Background -sf $Color14| cut -d ' ' -f 2) 0
