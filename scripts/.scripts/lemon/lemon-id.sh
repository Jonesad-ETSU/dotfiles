#!/bin/bash
printf "%s" "%{B$($SCRIPTS_FOLDER/conf.sh color5)}%{F$($SCRIPTS_FOLDER/conf.sh bg)} $($SCRIPTS_FOLDER/id.sh) %{B-}%{F-}"
