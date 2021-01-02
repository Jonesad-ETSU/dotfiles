#!/bin/bash

d () {
  dunstify -t $3 "$1" "$2" -i $SCRIPTS_FOLDER/icons/battery.png -u $4 
}
bat=$(cat /sys/class/power_supply/BAT0/capacity)
charging=$(cat /sys/class/power_supply/BAT0/status)

let level=$bat/20
case $charging in
  'Discharging')
    case $level in
      0) d "HALP" "I'm dying !! Send Help !! ($bat%)" 0 critical ;;
      1) d "YO..." "My dude, plug me up ($bat%)" 10000 normal;;
      2) d "HMM..." "I'm doing okay ($bat%)" 5000 normal;;
      3) d "HMM..." "Nice :) ($bat%)" 5000 normal;;
      4) d "HMM..." "I'm Lovin' It ($bat%)"5000 normal;;
      5) d "HMM..." "Redbull gives you wings ($bat%)"5000 normal;;
    esac
    ;;
  *)
    case $level in
      0) d "Thank God" "($bat%)" 5000 normal;;
      1) d "HMM..." "That was close ($bat%)" 5000 normal;;
      2) d "HMM..." "($bat%)" 5000 normal;;
      3) d "HMM..." "Might actually make it an hour on battery now ($bat%)" 5000 normal;;
      4) d "HMM..." "Thank you for the charge :) ($bat%)" 5000 normal;;
      5) d "HMM..." "Redbull gives you wings ($bat%)" 5000 normal;;
    esac
    ;;
esac
