#!/bin/bash

printf "%s" "Opening the pacman.conf file... \nPlease uncomment all the non-testing repositories."

while :; do
	printf "%s" "vi or nano? [1/2]?"
	read response 

	if [ $response = '1' ]; then
		sudo nano /etc/pacman.conf
		break
	elif [ $response = '2' ]; then
		sudo vi /etc/pacman.conf
		break
	fi
done

sudo pacman -Syu

sudo pacman -S --needed base-devel

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

echo 1 | paru -y $(awk '$1 !~ /^#/ {print}' ~/dotfiles/pkglist)

stow $(cat stow-list) 

#for (( i = 0; i < $(cat ~/dotfiles/pkglist | wc -l); i++ )); do
#	echo 1 | paru -y $(awk 'NR==$i && $1 !~ /^#/ {print}' ~/dotfiles/pkglist)
#done
