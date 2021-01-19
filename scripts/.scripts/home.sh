#!/bin/sh
echo -n "$(xgetres home.symbol) $(df -h | awk '/nvme0n1p3/ { print $3"/"$2  }' | sed s/i//g)" 
