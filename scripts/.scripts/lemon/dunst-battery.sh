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
      0) d $(xgetres dunst.bat.title.scared) "$(xgetres dunst.bat.le20) ($bat%)" 0 critical ;;
      1) d $(xgetres dunst.bat.title.concerned) "$(xgetres dunst.bat.gt20) ($bat%)" 10000 normal;;
      2) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt40) ($bat%)" 5000 normal;;
      3) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt60) ($bat%)" 5000 normal;;
      4) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt80) ($bat%)" 5000 normal;;
      5) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.eq100) ($bat%)" 2500 normal;;
    esac
    ;;
  *)
    case $level in
      0) d $(xgetres dunst.bat.title.concerned) "$(xgetres dunst.bat.le20.charge) ($bat%)" 5000 normal;;
      1) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt20.charge) ($bat%)" 5000 normal;;
      2) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt40.charge) ($bat%)" 5000 normal;;
      3) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt60.charge) ($bat%)" 5000 normal;;
      4) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.gt80.charge) ($bat%)" 5000 normal;;
      5) d $(xgetres dunst.bat.title.normal) "$(xgetres dunst.bat.eq100.charge) ($bat%)" 5000 normal;;
    esac
    ;;
esac
