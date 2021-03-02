#!/bin/sh
printf "%s" "%{B$(xgetres lemon.bordercolor)}%{F$(xgetres lemon.borderfg)} $($1) %{F-}%{B-}"
