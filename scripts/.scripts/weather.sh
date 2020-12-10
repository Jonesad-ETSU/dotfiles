#!/bin/bash
Condition=$(weather $ZIP --headers "Sky Conditions" -q)

[ $Condition = "Sky conditions: clear" ] && \
	echo -n  Sunny || \
[ $Condition = "Sky conditions: mostly clear" ] && \
	echo -n   Mostly Sunny || \
[ $Condition = "Sky conditions: overcast" ] && \
	echo -n  Cloudy || \
	echo -n Not Sunny

#echo -n  $(grep -d ':' -f 2 $(tail -n 1 $ConditionTemp))


