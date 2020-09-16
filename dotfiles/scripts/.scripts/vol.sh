#!/bin/sh
#Script to output volume 
let vol-div-five=$(./simple-calc.sh divide $(pamixer --get-volume) 5) 
echo $(vol-div-five)

