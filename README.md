<div align="center">
  <img height=256 width=256 src="./img/alien-icon.svg" alt="Alien Logo">
</div>

# Alien Update
is a command for ubuntu and ubuntu based-distros that updates a lot of packages (and can install new ones.)

# Features:

##### Update
- updates ubuntu repositories
- upgrades ubuntu packages
- updates snap packages\*
- updates flatpak packages\*
- pip packages \*\*
- global npm packages \*\*
- npm itself \*\*
- antibody packages \*\*
- sheldon plugins \*\*
- atom packages \*\*

\*: planet will check if the program exists before running an update command for it.  
\*\*: planet will check if the program exists before running an update command for it and if the configuration for it is set to `true`.

##### Install new things 🤯
- if you add a package as an argument, it will install said package.
  - **Example:**
```bash
$ # This will install libwacom2
$ alien-update libwacom2
```
- if you add a PPA as a second argument, it will add said PPA (and run `apt update ` afterwards)
  - **Example:**
```bash
$ # This will add the elementary-os/stable PPA and install elementary-meta
$ alien-update elementary-meta ppa:elementary-os/stable
```
- if you wan't to only add a PPA and not install any other packages, then set `skp_` (for Skip) as the first argument.
  - **Example:**
```bash
$ # This will ONLY Add the elementary-os/stable PPA
$ alien-update skp_ ppa:elementary-os/stable
```

# Installation:
Paste the following in a terminal:  
```bash
bash -c "$(curl https://raw.githubusercontent.com/ExtinctAxolotl/alien-update/main/src/remote-install.bash)"
```

# Configuration
The Standard Configuration file is in $HOME/.config/alien-config.bash  
Go there by typing `cd $HOME/.config` then `$EDITOR alien-config.bash`  

**The File itself:**
```bash
export ALIEN_UPDATE_PIP_PACKAGES=(value)
export ALIEN_UPDATE_GLOBAL_NPM_PACKAGES=(value)
export ALIEN_UPDATE_ANTIBODY_PACKAGES=(value)
export ALIEN_UPDATE_NPM=(value)
export ALIEN_UPDATE_SHELDON_PLUGINS=(value)
export ALIEN_UPDATE_APM_PACKGES=(value)
```
Currently there are ~~four~~ _six_ configuration options. (value) can be "true" or "false"
The Name should be pretty descriptive but heres a list:
- `ALIEN_UPDATE_PIP_PACKAGES` = if the value is true, all outdated pip packages will be updated. Else not.
- `ALIEN_UPDATE_ANTIBODY_PACKAGES` = if the value is true, all [antibody](https://github.com/getantibody/antibody) packages will be updated. Else not.
- `ALIEN_UPDATE_GLOBAL_NPM_PACKAGES` = if the value is true, all npm packages will be updated. Else not.
- `ALIEN_UPDATE_NPM` = if the value is true, npm will be update. Else not.
- `ALIEN_UPDATE_SHELDON_PLUGINS` = if the value is true, all [sheldon](https://github.com/rossmacarthur/sheldon) plugins will be updated. Else not.
- `ALIEN_UPDATE_APM_PACKGES` = if the value is true, all [atom](https://atom.io) packages will be updated, else not.
