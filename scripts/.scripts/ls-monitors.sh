#!/bin/sh
_xrandr=$(xrandr -q)
_monitors=$(echo $_xrandr | grep connected)
for i in $(echo $_monitors|wc -l); do
done
