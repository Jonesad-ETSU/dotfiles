#!/bin/sh
# Runs programs in performant state; kills pretty programs that use too much Resources
killall picom
sleep 1
$1 
picom &
