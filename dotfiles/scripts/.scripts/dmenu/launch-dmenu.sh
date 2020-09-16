#!/bin/sh
ScriptFolder="/home/jonesad/.scripts/dmenu"
$ScriptFolder/dmenu-launcher.sh $(cat $ScriptFolder/dmenu-gen | dmenu -c -l 10 -fn "Material Icons:size=16" -fn "DejaVu Sans:size=12"| cut -d ' ' -f 2)
