#!/bin/sh
printf "%s" "%{+u}$($SCRIPTS_FOLDER/active-window.sh)%{-u}"
