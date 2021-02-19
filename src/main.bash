#!/usr/bin/env bash

# Defining Colors
x='\033'
RED="${x}[0;96m"
YELLOW="${x}[0;93m"
GREEN="${x}[0;92m"
NC="${x}[0m" # No Color

# Functions
# Checks if a package is installed
cmd_exists() {
  command -v $1 > /dev/null 2>&1
}

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


# Getting Config files
if [ -f $HOME/.config/alien-config.bash ];then
  info "Sourcing configuration...\n"
  source $HOME/.config/alien-config.bash
  success "Successfully sourced configuration.\n"
elif [ ! -f $HOME/.config/alien-config.bash ];then
  error "The Configuration has been either deleted or not created.\nPlease use the Installation script \"install.bash\" to create the configuration.\n"
fi


### === Main Program Code ===
# update respositories
info "Updating...\n"
sudo apt update
echo

# list upgradable
info "Listing Upgradable Packages...\n"
apt list --upgradable
echo

# upgrade packages
info "Upgrading...\n"
sudo apt upgrade -y
echo

# Checking if snapd is installed.
# if snapd is installed snap packages will be updated
# else nothing will be done
info "Trying to find snapd...\n"
if ! cmd_exists snapd;then
  info "Seems like snapd is not installed. Skipping...\n"
elif cmd_exists snapd;then
  info "Updating snap packages...\n"
  sudo snap refresh
else
  error "An error occured.\n"
fi
echo

# Checking if flatpak is installed
# if it is, the script will update every flatpak package on the system
# else nothing will be done
info "Trying to find flatpak...\n"
if ! cmd_exists flatpak;then
  info "Seems like flatpak is not installed. Skipping...\n"
elif cmd_exists flatpak;then
  success "Found Flatpak!\n"
  info "Updating flatpak packages...\n"
  echo
  flatpak update -y
else
  error "An error occured."
fi
echo

# Checking if pip or pip3 is installed
# If one of them is installed, then all packages will be updated
# if the configuration says so
if [ $ALIEN_UPDATE_PIP_PACKAGES == true ];then
  info "Trying to find the pyhton pip package...\n"
  if cmd_exists python3-pip;then
    info "Found pip3 installed! Updating outdated packages...\n"
    pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
  elif cmd_exists python-pip-whl;then
    info "Found pip installed! Updating outdated packages..."
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  else
    error "Didn't find pip or pip3 installed.\n"
  fi
elif [ $ALIEN_UPDATE_PIP_PACKAGES != true ];then
  info "Seems like you do not want to update pip packages, Skipping...\n"
fi
echo


# Checking if npm is installed
# If it is installed, then all packages will be updated
# if the configuration says so
if [ $ALIEN_UPDATE_GLOBAL_NPM_PACKAGES == true ];then
  info "Trying to find the npm command...\n"
  if cmd_exists npm;then
    info "Found npm! Updating global packages...\n"
    npm update -g
    success "Done!\n"
  else
    error "Didn't find npm installed! Skipping...\n"
  fi
elif [ $ALIEN_UPDATE_GLOBAL_NPM_PACKAGES != true ];then
  info "Seems like you do not want to update global npm packages, Skipping...\n"
fi
echo


# Checking if npm is installed
# If it is installed, then all packages will be updated
# if the configuration says so
if [ $ALIEN_UPDATE_NPM == true ];then
  info "Trying to find the npm command...\n"
  if cmd_exists npm;then
    info "Found npm! Updating it...\n"
    npm install -g npm
    success "Done!\n"
  else
    error "Didn't find npm! Skipping...\n"
  fi
elif [ $ALIEN_UPDATE_NPM != true ];then
  info "Seems like you do not want to update npm, Skipping...\n"
fi
echo


# Checking if antibody is installed
# If it is installed, then all packages will be updated
# if the configuration says so
if [ $ALIEN_UPDATE_ANTIBODY_PACKAGES == true ];then
  info "Trying to find the antibody command...\n"
  if cmd_exists antibody;then
    info "Found antibody! Updating global packages...\n"
    antibody update
    success "Done!\n"
  else
    error "Didn't find antibody! Skipping...\n"
  fi
elif [ $ALIEN_UPDATE_ANTIBODY_PACKAGES != true ];then
  info "Seems like you do not want to update antibody packages, Skipping...\n"
fi
echo



# Fixing Missing Packages
info "Installing Missing Packages...\n"
sudo apt --fix-missing install -y
echo

# Fixing Broken Packages
info "Fixing Broken Packages...\n"
sudo apt --fix-broken install -y
echo

# Autoremoving uneeded packages
info "Autoremoving uneeded Packages...\n"
sudo apt autoremove -y
echo
