#!/bin/sh
printf "%s" "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/volbar.sh)%{A}"
