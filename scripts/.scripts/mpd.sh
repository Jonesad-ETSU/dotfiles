#!/bin/sh
#Should print part of song title
printf "%s" "$(mpc | head -n 1 | grep -v volume)"
