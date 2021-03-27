#!/bin/bash
if [ $($SCRIPTS_FOLDER/conf.sh lemon.textonly) = '0' ]; then
	$SCRIPTS_FOLDER/conf.sh lemon.$1.icon
else
	$SCRIPTS_FOLDER/conf.sh lemon.$1.text
fi
