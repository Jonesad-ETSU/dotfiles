#!/bin/bash
Condition=$(weather $ZIP --headers "Sky Conditions" -q)


echo $(echo $ConditionTemp | head -n 1)
[ "$(echo $ConditionTemp | head -n 1)" = "Sky conditions: clear" ] && \
	echo -n  Sunny || \
[ "$(echo $ConditionTemp | head -n 1)" = "Sky conditions: mostly clear" ] && \
	echo -n   Mostly Sunny || \
[ "$(echo $ConditionTemp | head -n 1)" = "Sky conditions: overcast" ] && \
	echo -n  Cloudy || \
	echo -n Not Sunny

#echo -n  $(grep -d ':' -f 2 $(tail -n 1 $ConditionTemp))


