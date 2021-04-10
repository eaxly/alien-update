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

read -p "Are you sure you want to uninstall Alien? [y/n] " -n 1 answer
echo
if [ $answer != "y" ];then
  info "Exiting...\n"
  exit 1
fi

info "Removing /usr/bin/alien-update...\n"
sudo rm /usr/bin/alien-update
echo
sleep 1

info "Removing $HOME/.alien-update...\n"
sudo rm -r $HOME/.alien-update
echo
sleep 1

read -p "Do you want to remove the Configuration file? [y/n] " -n 1 answer
echo
if [ $answer != "y" ];then
  info "Configuration File will be kept in $HOME/.config/alien-config.bash\n"
  sleep 1
else
  info "Removing Configuration file...\n"
  rm $HOME/.config/alien-config.bash
fi
sleep 1

info "Removing Desktop file...\n"
rm $HOME/.local/share/applications/alien.desktop
success "\nSuccessfully uninstalled alien!\nWe will miss you! D:"
