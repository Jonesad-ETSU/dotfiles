#!/bin/bash
DESKTOP_NAMES=$(xprop -root _NET_DESKTOP_NAMES)

match() {
  for i in ${!TAGS[@]}; do
    [ ${TAGS[$i]} = $1 ] && echo $(( ($i + 1)*2 )) && return
  done
  echo "Tag not in Xresources => Failing"
  exit -1
}

print () { 
  echo $DESKTOP_NAMES | cut -d '"' -f $1
}
echo $DESKTOP_NAMES
print $(match "II")
#print
#echo -n "Desktop II should be printed now => "
#echo $DESKTOP_NAMES | cut -d '"' -f 4
