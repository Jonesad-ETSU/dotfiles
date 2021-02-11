#!/bin/bash
high=80
medium=20
cpu=$($SCRIPTS_FOLDER/cpu-temp.sh)
gpu=$($SCRIPTS_FOLDER/gpu-temp.sh)
cpu_num=$(echo $cpu)
gpu_num=$(echo $cpu)
color=$(xgetres color1)

printf "%s" "%{F$color}$($SCRIPTS_FOLDER/lemon/get-symbol.sh temp)%{F-}[CPU: $cpu|GPU: $gpu]"
