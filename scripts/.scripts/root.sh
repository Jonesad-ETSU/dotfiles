#!/bin/sh
printf "%s" "$(df -h | awk '/nvme0n1p2/ { print $3"/"$2  }' | sed s/i//g)" 
