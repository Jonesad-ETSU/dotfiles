#!/bin/sh
printf "%s" "%{B$(xgetres a.color5)}%{F$(xgetres background)} $($SCRIPTS_FOLDER/id.sh) %{B-}%{F-}"
