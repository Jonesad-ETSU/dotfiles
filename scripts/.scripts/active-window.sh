#!/bin/sh
#relies on lsw, find on suckless website.
printf "%s" $(lsw | head -n 1 | cut -d ' ' -f 2)
