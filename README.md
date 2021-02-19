<div align="center">
  <img height=256 width=256 src="./img/planet-icon.svg" alt="Planet Logo">
</div>

# Planet Update
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
`bash -c "$(curl https://raw.githubusercontent.com/deepspacebird/planet-update/master/src/remote-install.bash)"`

# Configuration
The Standard Configuration file is in $HOME/.config/planet-config.bash  
Go there by typing `cd $HOME/.config` then `EDITOR planet-config.bash`  
**Please replace EDITOR with your favorite text editor** (vi, nano, vim, neovim...)  


**The File itself:**
```bash
export PLANET_UPDATE_PIP_PACKAGES = (value)
export PLANET_UPDATE_GLOBAL_NPM_PACKAGES = (value)
export PLANET_UPDATE_ANTIBODY_PACKAGES = (value)

```
Currently there are three configuration options. (value) can be "true" or "false"
The Name should be pretty descriptive but heres a list:
- `PLANET_UPDATE_PIP_PACKAGES` = if the value is true, all outdated pip packages will be updated. If the value is false, it will not.
- `PLANET_UPDATE_ANTIBODY_PACKAGES` = if the value is true, all [antibody](https://github.com/getantibody/antibody) packages will be updated. If the value is false, it will not.
- `PLANET_UPDATE_GLOBAL_NPM_PACKAGES` = if the value is true, all npm packages will be updated. If the value is false, it will not.
