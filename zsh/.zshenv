export XDG_CONFIG_HOME="/home/jonesad/.config"
export DESKTOP_SESSION="X11"
source "$HOME/.cargo/env"
if [ -e /home/jonesad/.nix-profile/etc/profile.d/nix.sh ]; then . /home/jonesad/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
