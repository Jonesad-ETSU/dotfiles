#!/bin/sh
printf "%s" "%{F$(xgetres color14)}$($SCRIPTS_FOLDER/cpu.sh)%{F-}"
