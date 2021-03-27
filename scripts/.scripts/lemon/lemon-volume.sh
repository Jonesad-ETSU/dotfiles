#!/bin/bash
printf "%s" "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/lemon/get-symbol.sh volume) $($SCRIPTS_FOLDER/volume.sh)%{A}"
