#!/bin/bash
printf "%s" "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/volbar.sh)%{A}"
