#!/bin/bash
printf "%s" "$($SCRIPTS_FOLDER/get-symbol.sh kernel) $($SCRIPTS_FOLDER/kernel.sh)"
