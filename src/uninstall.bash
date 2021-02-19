#!/usr/bin/env bash

x='\033'
RED="${x}[0;96m"
YELLOW="${x}[0;93m"
GREEN="${x}[0;92m"
NC="${x}[0m" # No Color

# Functions
# informative echo functions
info() {
  echo -en "${YELLOW}${*}${NC}"
}

error() {
  echo -en "${RED}${*}${NC}"
}

success() {
  echo -en "${GREEN}${*}${NC}"
}

read -p "Are you sure you want to uninstall Planet? [y/N] " -n 1 answer
echo
if [ $answer != "y" ];then
  info "Exiting...\n"
  exit 1
fi

info "Removing /usr/bin/planet...\n"
sudo rm /usr/bin/planet
echo
sleep 1

info "Removing $HOME/.planet-update...\n"
sudo rm -r $HOME/.planet-update
echo
sleep 1

read -p "Do you want to remove the Configuration file? [y/N] " -n 1 answer
echo
if [ $answer != "y" ];then
  info "Configuration File will be kept in $HOME/.config/planet-config.bash"
  sleep 1
else
  info "Removing Configuration file...\n"
rm $HOME/.config/planet-config.bash
fi
sleep 1

info "Removing Desktop file...\n"
rm $HOME/.local/share/applications/planet.desktop
success "\nSuccessfully uninstalled planet!\nWe will miss you!"
