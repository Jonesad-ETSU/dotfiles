#!/bin/sh
#Should print part of song title
song_name=$(mpc | head -n1 | grep -v volume | cut -d '-' -f2)
if [ ${#song_name} -gt 35 ]; then
	song_name="${song_name:0:35}..."
#else
#	song_name="${song_name}$(printf '\ %.0s' {1..$((20-${#song_name}))}"
fi
printf "%s" "${song_name}"
