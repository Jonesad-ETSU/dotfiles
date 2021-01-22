#!/bin/sh
currdir=$(pwd)
cd $HOME/.config/x/color && \
rm current && \
cp $(/bin/ls -1A | shuf -n 1) current && \
killall $WM && \
sleep 1 && \
cd $currdir
