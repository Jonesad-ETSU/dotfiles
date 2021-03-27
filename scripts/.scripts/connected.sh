#!/bin/sh
printf "%s" "$(iwctl known-networks list | head -n 5 | tail -n 1 | cut -d ' ' -f 3)"
