#!/bin/bash
umask 000
cd $SCRIPTS_FOLDER
for f in $(cat $SCRIPTS_FOLDER/templates/use); do
	./conf_to_script.sh $f
done
./conf_to_script.sh $HOME/.config/polybar/config.teplate
cd -
umask 002
