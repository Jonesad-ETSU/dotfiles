#!/bin/bash
# parms: $1 => capacity; $2 => max $3 => Charging (1 = charging)
# FONT: IOSEVKA
batteryString=""

let whole=$1/20
let wholeRemainder=$1%20
let half=$wholeRemainder/10
let empty=$2-whole-half
 
for (( i=0; i<whole; i++ )); do
  if [ $3 -eq 0 ]; then
    batteryString="${batteryString} "
  else
    batteryString="${batteryString} "
  fi
done

for (( i=0; i<half; i++)); do
  if [ $3 -eq 0 ]; then
    batteryString="${batteryString} "
  else
    batteryString="${batteryString} "
  fi
done

for (( i=0; i<empty; i++ )); do
  if [ $3 -eq 0 ]; then
    batteryString="${batteryString} "
  else
    batteryString="${batteryString} "
  fi
done

echo $batteryString
