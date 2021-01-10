#!/bin/sh
for f in $(ls $1);do 
    ln -s $1/$f ./$f 
done
