#!/bin/sh
echo -n "\nAre you using Intel CPU [y/n]?"
read intel

echo -n "\nAre you using Nvidia [y/n]?"
read nvidia

echo -n "\nDo you want Gaming stuff [y/n]?"
read games

[ $games = 'y' ] && echo -n "\nDo you want Gamecube Controller Support [y/n]?" && read gcn 

echo -n "\nSpotify [y/n]?"
read spotify

echo -n "\nDiscord [y/n]?"
read discord

echo -n "\nLibreOffice [y/n]?"
read libre

sudo xbps-install -Syu
sudo xbps-install -Sy void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Sy stow vim xorg git feh alacritty xterm ytop fzf bandwhich xtools scrot rofi libX11-devel libXft-devel libXinerama-devel lemonbar-xft zsh zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search lm_sensors gucharmap fd lxappearance pulseaudio pavucontrol dunst firefox lsd mpd ncdu ncmpcpp mpv patch i3lock-color udiskie runit-swap yad zathura pkg-config lvm2 arandr cpufrequtils alsa-utils alsa-firmware bluez-alsa cava brightnessctl ranger picom xob sxhkd xbanish ImageMagick NetworkManager breeze-obsidian-cursor-theme pamixer ueberzug procs openntpd 

[ $games = 'y' ] && \
	sudo xbps-install -Sy steam mesa-dri-32bit nvidia nvidia-libs32-bit lutris vulkan-loader-32bit vulkan-loader nvidia-opencl 

[ $libre = 'y'] && sudo xbps-install -Sy libreoffice

[ $intel = 'y' ] && sudo xbps-install -Sy intel-ucode


#Enable Services
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/mpd /var/service
sudo ln -s /etc/sv/alsa /var/service
sudo ln -s /etc/sv/bluez-alsa /var/service
sudo ln -s /etc/sv/fancontrol /var/service
sudo ln -s /etc/sv/iptables /var/service
sudo ln -s /etc/sv/ip6tables /var/service
sudo ln -s /etc/sv/wpa_supplicant /var/service
sudo ln -s /etc/sv/runit-swap /var/service
sudo ln -s /etc/sv/polkitd /var/service
sudo ln -s /etc/sv/openntpd /var/service/

#Downlad my dotfiles and symlink them to right place in $HOME
cd ~ && git clone https://github.com/Jonesad-ETSU/dotfiles.git 
cd ~/dotfiles && stow xgetres sxhkd dmenu dwm-ewmh scripts xob picom Wallpaper xinit ranger dunst xresources zsh aliases gruvbox-dark-gtk dracula-gtk 

#Installing xgetres, dwm, and dmenu from source
cd ~/.src/xgetres/ && make && sudo make install
cd ~/.src/dwm-ewmh && make clean && sudo make install
cd ~/.src/dmenu/ && make clean && sudo make install

#Setup TTY
sudo cp ~/dotfiles/xorg.conf.d/issue /etc/
sudo $SCRIPTS_FOLDER/ttyfont.sh

#Copies xorg config for optimus laptop
sudo cp ~/dotfiles/xorg.conf.d/10-intel-nvidia-drm-outputclass.conf /usr/share/X11/xorg.conf.d/

#Installs Ubuntu Nerd Font
/bin/mkdir -p /usr/share/fonts && sudo cp ~/dotfiles/Ubuntu-Nerd.ttf /usr/share/fonts/ && fc-cache -f -v  

/bin/mkdir -p ~/Pictures/Screenshots
sudo usermod -s /bin/zsh $(whoami)

#Set up acpi buttons
sudo cp ~/dotfiles/acpi/handler.sh /etc/acpi/handler.sh

#Get void-pkgs and allow restricted packages
[ ! -d $HOME/.src/void-pkg ] && git clone https://github.com/void-linux/void-packages.git $HOME/.src/void-pkg &&  echo XBPS_ALLOW_RESTRICTED=yes >> $HOME/.src/void-pkg/etc/conf

cd $HOME/.src/void-pkg && ./xbps-src binary-bootstrap 
[ $discord = 'y' ] && \
	sudo xbps-install -Sy libatomic libcxx && ./xbps-src pkg discord && xi discord
[ $spotify = 'y' ] && ./xbps-src pkg spotify && xi spotify

#Gamecube Adapter Recognition
[ $gcn = 'y' ] && \
	sudo rm -f /etc/udev/rules.d/51-gcadapter.rules && sudo /usr/bin/mkdir -p /etc/udev/rules.d/ && sudo touch /etc/udev/rules.d/51-gcadapter.rules && echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null && sudo udevadm control --reload-rules

