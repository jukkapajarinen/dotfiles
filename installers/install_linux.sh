#!/bin/bash

# ##############################################################################
# Linux installation script for Jukka's dotfiles
# ##############################################################################

# Declare other variables
bashDir="$(dirname ${BASH_SOURCE[0]})";
scriptDir="$(cd ${bashDir//installers/} >/dev/null 2>&1 && pwd)";
homeDir="/home/$USER";
mkdir="mkdir -vp";
ln="ln -isv";
cp="cp -iv --remove-destination";
os="Linux";

# Print the directory paths
echo "Welcome ${USER}, to Jukka's dotfiles installation script.";
echo "- Operating system: $os";
echo "- Source directory: $scriptDir";
echo "- Target directory: $homeDir";

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "==> Are you sure to force installation? (files will be overwritten) [y/N] " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    ln="ln -svf";
    cp="cp -vf --remove-destination";
  else
    echo "==> Installation was not started."
    exit;
  fi
fi

# Linux create directories
echo "==> Create possibly missing directories.";
$mkdir $homeDir/Scripts/;
$mkdir $homeDir/.SpaceVim.d/;
$mkdir $homeDir/.config/kitty/;
$mkdir $homeDir/.config/nano/;
$mkdir $homeDir/.config/Code/User/;
$mkdir $homeDir/.config/pop-shell/;

# Linux create custom script symlinks
echo "==> Install user script files.";
$ln $scriptDir/scripts/rofi-shutdown.sh $homeDir/Scripts/rofi-shutdown.sh;
$ln $scriptDir/scripts/rofi-workspaces.sh $homeDir/Scripts/rofi-workspaces.sh;
$ln $scriptDir/scripts/x-adjust-brightness.sh $homeDir/Scripts/x-adjust-brightness.sh;
$ln $scriptDir/scripts/x-display-settings.sh $homeDir/Scripts/x-display-settings.sh;
$ln $scriptDir/scripts/x-pointer-settings.sh $homeDir/Scripts/x-pointer-settings.sh;
$ln $scriptDir/scripts/pop-shell-keybindings.sh $homeDir/Scripts/pop-shell-keybindings.sh;

# Linux create dotfile symlinks
echo "==> Install user configuration files.";
$ln $scriptDir/bashrc $homeDir/.bashrc;
$ln $scriptDir/bash_profile $homeDir/.bash_profile;
$ln $scriptDir/bash_aliases $homeDir/.bash_aliases;
$ln $scriptDir/bash_env $homeDir/.bash_env;
$ln $scriptDir/bash_theme $homeDir/.bash_theme;
$ln $scriptDir/Xresources $homeDir/.Xresources;
$ln $scriptDir/gitconfig $homeDir/.gitconfig;
$ln $scriptDir/gitexcludes $homeDir/.gitexcludes;
$ln $scriptDir/spacevim.toml $homeDir/.SpaceVim.d/init.toml;
$ln $scriptDir/nanorc $homeDir/.config/nano/nanorc;
$ln $scriptDir/vscode_settings.json $homeDir/.config/Code/User/settings.json;
$ln $scriptDir/vscode_keybindings.json $homeDir/.config/Code/User/keybindings.json;
$ln $scriptDir/vscode_extensions.lst $homeDir/.config/Code/User/extensions.lst;
$ln $scriptDir/kitty.conf $homeDir/.config/kitty/kitty.conf;
$ln $scriptDir/pop-shell_settings.json $homeDir/.config/pop-shell/config.json;

# Linux create system symlinks
echo "==> Install system configuration files.";
sudo $ln /usr/bin/firefox /etc/alternatives/x-www-browser;
sudo $ln /usr/bin/kitty /etc/alternatives/x-terminal-emulator;
sudo $ln /usr/share/nano /usr/local/share/nano;

# Print info that execution finished
echo "==> Installation finished."
