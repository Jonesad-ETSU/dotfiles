#!/bin/sh
echo " $(( $(brightnessctl g)*100 / 24000 ))%"
