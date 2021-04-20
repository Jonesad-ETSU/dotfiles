#!/bin/bash
printf "%s" "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/get-symbol.sh volume) $($SCRIPTS_FOLDER/volume.sh)%{A}"
