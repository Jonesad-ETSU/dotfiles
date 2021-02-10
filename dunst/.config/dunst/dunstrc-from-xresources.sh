#!/bin/sh
fg=$(xgetres foreground)
bg=$(xgetres background)

rm -rf $1
cp dunstrc.bak $1
sed -i "s/background = \"#******\"/background = \"$bg\"/gi" $1
sed -i "s/foreground = \"#******"/foreground = "$fg"/gi" $1

