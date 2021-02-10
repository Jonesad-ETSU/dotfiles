#!/bin/sh
contents=$(cat $SCRIPTS_FOLDER/menu/$1)

[ ${contents:0:0} = 'd' ] && 
