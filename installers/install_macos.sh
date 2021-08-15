#!/bin/bash

# ##############################################################################
# MacOS installation script for Jukka's dotfiles
# ##############################################################################

# Declare other variables
arrow="\033[32m==>\033[0m";
bashDir="$(dirname "${BASH_SOURCE[0]}")";
scriptDir="$(cd "${bashDir//installers/}" >/dev/null 2>&1 && pwd)";
homeDir="/Users/$USER";
os="MacOS";

# Print the directory paths
echo -e "\033[1mWelcome ${USER}, to Jukka's dotfiles installation script.\033[0m";
echo -e "- Operating system: \033[32m$os\033[0m";
echo -e "- Source directory: \033[34m$scriptDir\033[0m";
echo -e "- Target directory: \033[31m$homeDir\033[0m";

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -rp "$(echo -e "$arrow" Are you sure to force installation? \(files will be overwritten\) [y/N]) " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    mkdir="mkdir -vp";
    ln="ln -svf"; #cp="cp -vf --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
else
  read -rp "$(echo -e "$arrow" Are you sure to start installation? [y/N]) " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    mkdir="mkdir -vp";
    ln="ln -isv"; #cp="cp -iv --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
fi

# MacOS create directories
echo -e "$arrow Create possibly missing directories.";
$mkdir "$homeDir/Scripts/";
$mkdir "$homeDir/.SpaceVim.d/";
$mkdir "$homeDir/.config/kitty/";
$mkdir "$homeDir/Library/Application\ Support/Code/User/";

# MacOS create custom script symlinks
#echo -e "$arrow Install user script files.";

# MacOS create symlinks
echo -e "$arrow Install user configuration files.";
$ln "$scriptDir/bashrc" "$homeDir/.bashrc";
$ln "$scriptDir/bash_profile" "$homeDir/.bash_profile";
$ln "$scriptDir/bash_aliases" "$homeDir/.bash_aliases";
$ln "$scriptDir/bash_env" "$homeDir/.bash_env";
$ln "$scriptDir/starship.toml" "$homeDir/.config/starship.toml";
$ln "$scriptDir/gitconfig" "$homeDir/.gitconfig";
$ln "$scriptDir/gitexcludes" "$homeDir/.gitexcludes";
$ln "$scriptDir/spacevim.toml" "$homeDir/.SpaceVim.d/init.toml";
$ln "$scriptDir/mostrc" "$homeDir/.mostrc";
$ln "$scriptDir/nanorc" "$homeDir/.nanorc";
$ln "$scriptDir/yabairc" "$homeDir/.yabairc";
$ln "$scriptDir/skhdrc" "$homeDir/.skhdrc";
$ln "$scriptDir/vscode_settings.json" "$homeDir/Library/Application\ Support/Code/User/settings.json";
$ln "$scriptDir/vscode_keybindings.json" "$homeDir/Library/Application\ Support/Code/User/keybindings.json";
$ln "$scriptDir/vscode_extensions.lst" "$homeDir/Library/Application\ Support/Code/User/extensions.lst";
$ln "$scriptDir/kitty.conf" "$homeDir/.config/kitty/kitty.conf";
$ln "$scriptDir/qmk_keymap.json" "$homeDir/.qmk_keymap.json";

# MacOS create helper symlink to dotfiles
echo -e "$arrow Create helper symlink to /dotfiles?";
sudo $ln "$scriptDir" "/dotfiles";

# Print info that execution finished
echo -e "$arrow Installation finished."
