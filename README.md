<div align="center">
  <img height=256 width=256 src="./img/alien-icon.svg" alt="Alien Logo">
</div>

# Alien Update
is a command for ubuntu and ubuntu based-distros that does stuff.
It:
- updates ubuntu repositories
- upgrades ubuntu packages
- updates snap packages\*
- updates flatpak packages\*
- pip packages \*\*
- global npm packages \*\*
- antibody packages \*\*

\*: means that it will only be updated if the package is installed  
\*\*: means the above and if it is configurated so  
# Installation:
Paste the following in a terminal:  
`bash -c "$(https://raw.githubusercontent.com/ExtinctAxolotl/alien-update/main/src/remote-install.bash)"`

# Configuration
The Standard Configuration file is in $HOME/.config/alien-config.bash  
Go there by typing `cd $HOME/.config` then `EDITOR alien-config.bash`  
**Please replace EDITOR with your favorite text editor** (vi, nano, vim, neovim...)  


**The File itself:**
```bash
export ALIEN_UPDATE_PIP_PACKAGES = (value)
export ALIEN_UPDATE_GLOBAL_NPM_PACKAGES = (value)
export ALIEN_UPDATE_ANTIBODY_PACKAGES = (value)

```
Currently there are three configuration options. (value) can be "true" or "false"
The Name should be pretty descriptive but heres a list:
- `ALIEN_UPDATE_PIP_PACKAGES` = if the value is true, all outdated pip packages will be updated. If the value is false, it will not.
- `ALIEN_UPDATE_ANTIBODY_PACKAGES` = if the value is true, all [antibody](https://github.com/getantibody/antibody) packages will be updated. If the value is false, it will not.
- `ALIEN_UPDATE_GLOBAL_NPM_PACKAGES` = if the value is true, all npm packages will be updated. If the value is false, it will not.
