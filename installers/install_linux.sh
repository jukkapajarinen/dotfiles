#!/bin/bash

# ##############################################################################
# Linux installation script for Jukka's dotfiles
# ##############################################################################

# Declare common variables
arrow="\033[32m==>\033[0m";
bashDir="$(dirname "${BASH_SOURCE[0]}")";
scriptDir="$(cd "${bashDir//installers/}" >/dev/null 2>&1 && pwd)";
homeDir="/home/$USER";
os="Linux";

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
    ln="ln -svfT"; #cp="cp -vf --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
else
  read -rp "$(echo -e "$arrow" Are you sure to start installation? [y/N]) " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    mkdir="mkdir -vp";
    ln="ln -isvT"; #cp="cp -iv --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
fi

# Linux create directories
echo -e "$arrow Create possibly missing directories.";
$mkdir "$homeDir/Scripts/";
$mkdir "$homeDir/.config/autostart/";
$mkdir "$homeDir/.config/nvim";
$mkdir "$homeDir/.config/bspwm/";
$mkdir "$homeDir/.config/sxhkd/";
$mkdir "$homeDir/.config/kitty/";
$mkdir "$homeDir/.config/nano/";
$mkdir "$homeDir/.config/Code/User/";
$mkdir "$homeDir/.config/rofi/";
$mkdir "$homeDir/.config/polybar/";

# Linux create dotfile symlinks
echo -e "$arrow Install user configuration files.";
$ln "$scriptDir/bashrc" "$homeDir/.bashrc";
$ln "$scriptDir/bashrc" "$homeDir/.bash_profile";
$ln "$scriptDir/gitconfig" "$homeDir/.gitconfig";
$ln "$scriptDir/gitexcludes" "$homeDir/.gitexcludes";
$ln "$scriptDir/kitty.conf" "$homeDir/.config/kitty/kitty.conf";
$ln "$scriptDir/starship.toml" "$homeDir/.config/starship.toml";
$ln "$scriptDir/vimrc" "$homeDir/.vimrc";
$ln "$scriptDir/vimrc" "$homeDir/.config/nvim/init.vim";
$ln "$scriptDir/mostrc" "$homeDir/.mostrc";
$ln "$scriptDir/gsettings.desktop" "$homeDir/.config/autostart/gsettings.desktop";
$ln "$scriptDir/pop-shell.json" "$homeDir/.config/pop-shell/config.json";
$ln "$scriptDir/wms/bspwmrc" "$homeDir/.config/bspwm/bspwmrc";
$ln "$scriptDir/wms/sxhkdrc" "$homeDir/.config/sxhkd/sxhkdrc";
$ln "$scriptDir/wms/rofi.rasi" "$homeDir/.config/rofi/config.rasi";
$ln "$scriptDir/wms/polybar.ini" "$homeDir/.config/polybar/config";
$ln "$scriptDir/vscode-settings.json" "$homeDir/.config/Code/User/settings.json";
$ln "$scriptDir/vscode-keybindings.json" "$homeDir/.config/Code/User/keybindings.json";
$ln "$scriptDir/vscode-extensions.txt" "$homeDir/.config/Code/User/extensions.txt";
$ln "$scriptDir/vscode-settings.json" "$homeDir/.config/VSCodium/User/settings.json";
$ln "$scriptDir/vscode-keybindings.json" "$homeDir/.config/VSCodium/User/keybindings.json";
$ln "$scriptDir/vscode-extensions.txt" "$homeDir/.config/VSCodium/User/extensions.txt";
$ln "$scriptDir/kbd/qmk-keymap.json" "$homeDir/.qmk-keymap.json";
$ln "$scriptDir/kbd/Xmodmap" "$homeDir/.Xmodmap";
sudo $ln "$scriptDir/kbd/fi_mac_with_euro" "/usr/share/X11/xkb/symbols/fi";

# Print info that execution finished
echo -e "$arrow Installation finished."
