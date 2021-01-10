#!/bin/sh
sudo xbps-install -Syu
sudo xbps-install -Sy void-repo-multilib void-repo-nonfree void-repo-multilib-nonfree
sudo xbps-install -Sy stow vim xorg git nvidia feh mesa-dri-32bit nvidia-libs-32bit kitty xterm steam  ytop fzf bandwhich xtools scrot rofi libX11-devel libXft-devel libXinerama-devel lemonbar-xft zsh zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search lm_sensors gucharmap fd lxappearance pulseaudio pavucontrol dunst firefox lsd mpd ncdu ncmpcpp mpv patch i3lock-color udiskie runit-swap yad zathura vulkan-loader-32bit pkg-config lvm2 libreoffice arandr cpufrequtils alsa-utils alsa-firmware bluez-alsa cava brightnessctl ranger picom xob sxhkd xbanish ImageMagick NetworkManager breeze-obsidian-cursor-theme pamixer    

#Enable Services
sudo ln -s /etc/sv/NetworkManager /var/service
sudo ln -s /etc/sv/dbus /var/service
sudo ln -s /etc/sv/mpd /var/service
sudo ln -s /etc/sv/alsa /var/service
sudo ln -s /etc/sv/bluez-alsa /var/service
sudo ln -s /etc/sv/pulseaudio /var/service

#Downlad my dotfiles and symlink them to right place in $HOME
cd ~ && git clone https://github.com/Jonesad-ETSU/dotfiles.git
cd ~/dotfiles && stow xgetres sxhkd dmenu dwm-ewmh scripts xob picom Wallpaper xinit ranger dunst xresources zsh aliases 

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


