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

# Read possible --yes from the cli args (answer Y to all and overwrite files)
[[ " $* " == *" --yes "* ]] && yes=true;

# Ask a [Y/n] question, or answer Y automatically with --yes
ask() {
  if [[ $yes == true ]]; then
    echo -e "$arrow $1 [Y/n] Y";
    return 0;
  fi
  read -rp "$(echo -e "$arrow" "$1" [Y/n]) " yn;
  [[ ! $yn =~ ^[nN] ]];
}

mkdir="mkdir -vp";
if [[ $yes == true ]]; then
  ln="ln -svfT"; #cp="cp -vf --remove-destination";
else
  ln="ln -isvT"; #cp="cp -iv --remove-destination";
fi

if ! ask "Are you sure to start installation?"; then
  echo -e "$arrow Installation was not started."
  exit;
fi

# Linux create directories
echo -e "$arrow Create possibly missing directories.";
$mkdir "$homeDir/.local/share/gnome-shell/extensions/";
$mkdir "$homeDir/.config/nvim";
$mkdir "$homeDir/.config/kitty/";
$mkdir "$homeDir/.config/Code/User/";

# Linux create dotfile symlinks
echo -e "$arrow Install user configuration files.";
$ln "$scriptDir/bashrc" "$homeDir/.bashrc";
$ln "$scriptDir/bashrc" "$homeDir/.bash_profile";
$ln "$scriptDir/git-config" "$homeDir/.gitconfig";
$ln "$scriptDir/git-excludes" "$homeDir/.gitexcludes";
$ln "$scriptDir/kitty.conf" "$homeDir/.config/kitty/kitty.conf";
$ln "$scriptDir/starship.toml" "$homeDir/.config/starship.toml";
$ln "$scriptDir/vimrc" "$homeDir/.vimrc";
$ln "$scriptDir/vimrc" "$homeDir/.config/nvim/init.vim";
$ln "$scriptDir/gnome-extension" "$homeDir/.local/share/gnome-shell/extensions/dotfiles@jukkapajarinen.com";
$ln "$scriptDir/vscode-settings.json" "$homeDir/.config/Code/User/settings.json";
$ln "$scriptDir/vscode-keybindings.json" "$homeDir/.config/Code/User/keybindings.json";
$ln "$scriptDir/vscode-extensions.txt" "$homeDir/.config/Code/User/extensions.txt";
$ln "$scriptDir/kbd/Xmodmap" "$homeDir/.Xmodmap";
sudo $ln "$scriptDir/kbd/fi_mac_with_euro" "/usr/share/X11/xkb/symbols/fi";

# Linux enable or disable Gnome extension (applies Gnome settings on login)
extension="dotfiles@jukkapajarinen.com";
enabled="$(gsettings get org.gnome.shell enabled-extensions)";
enabled="${enabled#@as }";
if ask "Enable Gnome settings extension?"; then
  echo -e "$arrow Enable Gnome extension and apply its settings to the current session.";
  if ! gnome-extensions enable "$extension" 2>/dev/null && [[ $enabled != *"'$extension'"* ]]; then
    [[ $enabled == "[]" ]] && enabled="['$extension']" || enabled="${enabled%]}, '$extension']";
    gsettings set org.gnome.shell enabled-extensions "$enabled";
  fi
  gjs -m "$scriptDir/gnome-extension/extension.js";
else
  echo -e "$arrow Disable Gnome extension.";
  if ! gnome-extensions disable "$extension" 2>/dev/null; then
    enabled="${enabled//"'$extension', "/}";
    enabled="${enabled//", '$extension'"/}";
    enabled="${enabled//"'$extension'"/}";
    gsettings set org.gnome.shell enabled-extensions "$enabled";
  fi
fi

# Print info that execution finished
echo -e "$arrow Installation finished."
