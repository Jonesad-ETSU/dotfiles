#!/bin/sh
echo "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/volbar.sh)%{A}"
