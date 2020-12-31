#!/bin/sh
echo -n " $(( $(brightnessctl g)*100 / 24000 ))%"
