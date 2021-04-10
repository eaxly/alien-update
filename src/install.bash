#!/usr/bin/env bash

# Variables
export ALIEN_MAIN_FILE="src/main.bash"

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
info "Welcome to the Alien installer!\n\n\n"
info "▄▀█ █░░ █ █▀▀ █▄░█ ▄▄ █░█ █▀█ █▀▄ ▄▀█ ▀█▀ █▀▀\n"
info "█▀█ █▄▄ █ ██▄ █░▀█ ░░ █▄█ █▀▀ █▄▀ █▀█ ░█░ ██▄\n"
echo

success "█ █▄░█ █▀ ▀█▀ ▄▀█ █░░ █░░ ▄▀█ ▀█▀ █ █▀█ █▄░█\n"
success "█ █░▀█ ▄█ ░█░ █▀█ █▄▄ █▄▄ █▀█ ░█░ █ █▄█ █░▀█\n"
echo
echo
echo
info "=== STARTING ===\n\n"

# Making main.bash executable
info "Step 1: Making main.bash executable...\n"
sudo chmod +x $ALIEN_MAIN_FILE 
sleep 0.5
if [ -x $ALIEN_MAIN_FILE ];then
  success "Successfully made main.bash executable!\n"
else
  error "Couldn't make main.bash executable! Exiting...\n"
  exit 1
fi
sleep 1

# Copying main.bash to /usr/bin/alien-update to add it to the PATH variable
info "Step 2: Copying main.bash to /usr/bin/alien-update.\n"
sudo cp "$ALIEN_MAIN_FILE" /usr/bin/alien-update
sleep 0.5

if [ -f /usr/bin/alien-update ];then
  success "Successfully moved File!\n"
else
  error "An error occured, Exiting...\n"
fi
sleep 1

# Creating Configuration File in $HOME/.config/alien-config.bash
if [ -f $HOME/.config/alien-config.bash ];then
  info "Seems like a configuration file already exists!\nSkipping...\n"
else
	info "Step 3: Create Config file.\n"
	sleep 0.5
	info "I will now ask you if you want to update specific package types when you run alien.\nIf you don't know the package, just answer no, by pressing \"n\" on your keyboard\n\n"
	sleep 2.5


	# PIP PACKAGES
	# ------------

	read -p "Do you want to update all pip packages installed on your system? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update pip packages!\n"
		echo "export ALIEN_UPDATE_PIP_PACKAGES=false" > $HOME/.config/alien-config.bash
	else
		info "\nAlien will update pip packages!\n"
		echo "export ALIEN_UPDATE_PIP_PACKAGES=true" > $HOME/.config/alien-config.bash
	fi
	sleep 1


	# GLOBAL NPM PACKAGES
	# -------------------

	read -p "Do you want to update all global npm packages installed on your system? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update global npm packages!\n"
		echo "export ALIEN_UPDATE_GLOBAL_NPM_PACKAGES=false" >> $HOME/.config/alien-config.bash
	else
		info "\nAlien will update global npm packages!\n"
		echo "export ALIEN_UPDATE_GLOBAL_NPM_PACKAGES=true" >> $HOME/.config/alien-config.bash
	fi
	sleep 1


	# ANTIBODY PACKAGES
	# -----------------

	read -p "Do you want to update all antibody packages installed on your system? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update antibody packages!\n"
		echo "export ALIEN_UPDATE_ANTIBODY_PACKAGES=false" >> $HOME/.config/alien-config.bash
	else
		info "\nAlien will update antibody packages!\n"
		echo "export ALIEN_UPDATE_ANTIBODY_PACKAGES=true" >> $HOME/.config/alien-config.bash
	fi
	sleep 1


	# NPM ITSELF
	# ---------

	read -p "Do you want to update npm? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update npm!\n"
		echo "export ALIEN_UPDATE_NPM=false" >> $HOME/.config/alien-config.bash
	else
		info "\nAlien will update npm!\n"
		echo "export ALIEN_UPDATE_NPM=true" >> $HOME/.config/alien-config.bash
	fi
	sleep 1


	# SHELDON PACKAGES/PLUGINS
	# ------------------------

	read -p "Do you want to update sheldon plugins? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update sheldon plugins!\n"
		echo "export ALIEN_UPDATE_SHELDON_PLUGINS=false" >> $HOME/.config/alien-config.bash
	else
		info "\nAlien will update sheldon plugins!\n"
		echo "export ALIEN_UPDATE_SHELDON_PLUGINS=true" >> $HOME/.config/alien-config.bash
	fi
	sleep 1


	# ATOM PACKAGES
	# -------------

	read -p "Do you want to update atom packages? [y/n] " -n 1 answer
	if [ $answer != "y" ];then
		info "\nAlien will not update atom packages!\n"
		echo "export ALIEN_UPDATE_APM_PACKAGES=false" >> $HOME/.config/alien-config.bash
	else
		info "\nAlien will update sheldon plugins!\n"
		echo "export ALIEN_UPDATE_APM_PACKAGES=true" >> $HOME/.config/alien-config.bash
	fi
	sleep 1
	echo
fi
# Copying desktop file to .local/share/applications
# -------------------------------------------------

info "\nStep 4: Copying Desktop File.\n"
cp src/alien.desktop $HOME/.local/share/applications/
echo Icon=$HOME/.alien-update/img/alien-icon.png >> $HOME/.local/share/applications/alien.desktop
update-desktop-database  $HOME/.local/share/applications

if [ -f $HOME/.local/share/applications/alien.desktop ];then
  success "Successfully copied the desktop file!\n"
else
  error "Something wen't wrong whilst copying the desktop file!\n"
  info "Exiting..."
  exit 1
fi

info "----------------------------------------------------"
success "\nFinished Installation!\nHappy Updating! :D"
