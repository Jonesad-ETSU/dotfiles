#!/bin/sh
printf "%s" "%{B$(xgetres lemon.edgecolor)}%{F$(xgetres background)} $($1) %{F-}%{B-}"
