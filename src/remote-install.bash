#!/usr/bin/env bash

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


cmd_exists() {
  command -v $1 > /dev/null 2>&1
}

# === Start ===

info "█▀ ▀█▀ ▄▀█ █▀█ ▀█▀\n"
info "▄█ ░█░ █▀█ █▀▄ ░█░\n"
echo
info "Cloning repository..."

if cmd_exists git;then
  info "Found git on your system!\n"
else
  info "Seems like git is not installed on your system!\n"
  read -p "Do you want to install it?" -n 1 answer
  if [ $answer != "y" ];then
    info "Cannot install without git. Exiting...\n"
    exit 1
  else
    sudo apt install git
  fi
fi

info "Cloning git repo...\n"
mkdir -p $HOME/.alien-update
git clone https://github.com/ExtinctAxoltol/alien-update.git $HOME/.alien-update
info "Installing..."
cd "$ALIEN_DIR_NAME"
./src/install.bash
