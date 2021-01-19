#!/bin/sh
echo -n "$(xgetres wifi.symbol) $(nmcli -t -f active,ssid dev wifi | grep '^yes' | head -n 1 | cut -d ':' -f 2)"
