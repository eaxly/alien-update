#!/usr/bin/env bash

# Variables
export PLANET_MAIN_FILE="src/main.bash"
# Defining Colors
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

# === START ===
info "The Program has started!"
info "Welcome to the Planet installer!\n\n\n"
info "██████╗░██╗░░░░░░█████╗░███╗░░██╗███████╗████████╗░░░░░░██╗░░░██╗██████╗░██████╗░░█████╗░████████╗███████╗\n"
info "██╔══██╗██║░░░░░██╔══██╗████╗░██║██╔════╝╚══██╔══╝░░░░░░██║░░░██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝\n"
info "██████╔╝██║░░░░░███████║██╔██╗██║█████╗░░░░░██║░░░█████╗██║░░░██║██████╔╝██║░░██║███████║░░░██║░░░█████╗░░\n"
info "██╔═══╝░██║░░░░░██╔══██║██║╚████║██╔══╝░░░░░██║░░░╚════╝██║░░░██║██╔═══╝░██║░░██║██╔══██║░░░██║░░░██╔══╝░░\n"
info "██║░░░░░███████╗██║░░██║██║░╚███║███████╗░░░██║░░░░░░░░░╚██████╔╝██║░░░░░██████╔╝██║░░██║░░░██║░░░███████╗\n"
info "╚═╝░░░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝░░░╚═╝░░░░░░░░░░╚═════╝░╚═╝░░░░░╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚══════╝\n"
echo
success "█ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░ ▄▀█ ▀█▀ █ █▀█ █▄░█\n"
success "█ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄ █▀█ ░█░ █ █▄█ █░▀█\n"
echo
echo
echo
info "=== STARTING ===\n\n"

# Making main.bash executable
info "Step 1: Making main.bash executable...\n"
sudo chmod +x $PLANET_MAIN_FILE 
sleep 0.5
if [ -x $PLANET_MAIN_FILE ];then
  success "Successfully made main.bash executable!\n"
else
  error "Couldn't make main.bash executable! Exiting...\n"
  exit 1
fi
sleep 1

# Copying main.bash to /usr/bin/planet to add it to the PATH variable
info "Step 2: Copying main.bash to /usr/bin/planet.\n"
sudo cp "$PLANET_MAIN_FILE" /usr/bin/planet
sleep 0.5

if [ -f /usr/bin/planet ];then
  success "Successfully moved File!\n"
else
  error "An error occured, Exiting...\n"
fi
sleep 1

# Creating Configuration File in $HOME/.config/planet-config.bash
info "Step 3: Create Config file.\n"
sleep 0.5
info "I will now ask you if you want to update specific package types when you run planet.\nIf you don't know the package, just answer no, by pressing \"n\" on your keyboard\n\n"
sleep 2.5

read -p "Do you want to update all pip packages installed on your system? [y/N] " -n 1 answer
if [ $answer != "y" ];then
  info "\nPlanet will not update pip packages!\n"
  echo "export PLANET_UPDATE_PIP_PACKAGES=false" >> $HOME/.config/planet-config.bash
else
  info "\nPlanet will update pip packages!\n"
  echo "export PLANET_UPDATE_PIP_PACKAGES=true" >> $HOME/.config/planet-config.bash
fi
sleep 1

read -p "Do you want to update all global npm packages installed on your system? [y/N] " -n 1 answer
if [ $answer != "y" ];then
  info "\nPlanet will not update global npm packages!\n"
  echo "export PLANET_UPDATE_GLOBAL_NPM_PACKAGES=false" >> $HOME/.config/planet-config.bash
else
  info "\nPlanet will update global npm packages!\n"
  echo "export PLANET_UPDATE_GLOBAL_NPM_PACKAGES=true" >> $HOME/.config/planet-config.bash
fi
sleep 1

read -p "Do you want to update all antibody packages installed on your system? [y/N] " -n 1 answer
if [ $answer != "y" ];then
  info "\nPlanet will not update antibody packages!\n"
  echo "export PLANET_UPDATE_ANTIBODY_PACKAGES=false" >> $HOME/.config/planet-config.bash
else
  info "\nPlanet will update antibody packages!\n"
  echo "export PLANET_UPDATE_ANTIBODY_PACKAGES=true" >> $HOME/.config/planet-config.bash
fi
echo
sleep 1

# Copying desktop file to .local/share/applications
info "Step 4: Copying Desktop File.\n"
cp src/planet.desktop $HOME/.local/share/applications/
echo Icon=$HOME/.planet-update/img/planet-icon.png >> $HOME/.local/share/applications/planet.desktop
update-desktop-database  $HOME/.local/share/applications

if [ -f $HOME/.local/share/applications/planet.desktop ];then
  success "Successfully copied the desktop file!\n"
else
  error "Something wen't wrong whilst copying the desktop file!\n"
  info "Exiting..."
  exit 1
fi

info "----------------------------------------------------"
success "\nFinished Installation!\nHappy Updating! :D"
