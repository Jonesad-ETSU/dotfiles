#!/bin/sh
echo -n "%{A:pavucontrol &:}$($SCRIPTS_FOLDER/volbar.sh)%{A}"
