#!/bin/sh
batteryIcons=' , , , , '
batteryLevel=$(cat /sys/class/power_supply/BAT0/capacity)
chargingStatus=$(cat /sys/class/power_supply/BAT0/status)
[ "${chargingStatus}" != "Discharging" ] && batteryString="${batteryLevel}%"
[ "${chargingStatus}" = "Discharging"  ] && batteryString=$(echo $batteryIcons | cut -d ',' -f $(( $batteryLevel/25 +1 ))) && batteryString="${batteryString}. ${batteryLevel}%"
echo $batteryString
