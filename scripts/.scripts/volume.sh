#!/bin/sh
printf "%s" "$(pamixer --get-volume-human)"
