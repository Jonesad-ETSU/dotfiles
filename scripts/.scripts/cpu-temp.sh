#!/bin/sh
sensors | grep -o "[0-9][0-9]\.[0-9]°C" | head -n 1
