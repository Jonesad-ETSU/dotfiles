#!/bin/sh
pactl set-sink-mute @DEFAULT_SINK@ toggle
kill -45 $(pidof dwmblocks)
