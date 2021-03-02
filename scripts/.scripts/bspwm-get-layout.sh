#!/bin/sh
bspc query -T -d | jq -r .layout
