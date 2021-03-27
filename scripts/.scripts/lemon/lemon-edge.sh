#!/bin/bash
printf "%s" "%{B$($SCRIPTS_FOLDER/conf.sh lemon.bordercolor)}%{F$($SCRIPTS_FOLDER/conf.sh lemon.borderfg)} $($1) %{F-}%{B-}"
