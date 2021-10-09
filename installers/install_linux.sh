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

# Linux create directories
echo -e "$arrow Create possibly missing directories.";
$mkdir "$homeDir/Scripts/";
$mkdir "$homeDir/.config/nvim";
$mkdir "$homeDir/.config/bspwm/";
$mkdir "$homeDir/.config/sxhkd/";
$mkdir "$homeDir/.config/kitty/";
$mkdir "$homeDir/.config/nano/";
$mkdir "$homeDir/.config/Code/User/";
$mkdir "$homeDir/.config/gtk-3.0/";
$mkdir "$homeDir/.config/gtk-4.0/";
$mkdir "$homeDir/.config/rofi/";
$mkdir "$homeDir/.config/polybar/";

# Linux create custom script symlinks
echo -e "$arrow Install user script files.";
$ln "$scriptDir/scripts/rofi-shutdown.sh" "$homeDir/Scripts/rofi-shutdown.sh";
$ln "$scriptDir/scripts/rofi-workspaces.sh" "$homeDir/Scripts/rofi-workspaces.sh";
$ln "$scriptDir/scripts/x-adjust-brightness.sh" "$homeDir/Scripts/x-adjust-brightness.sh";
$ln "$scriptDir/scripts/x-display-settings.sh" "$homeDir/Scripts/x-display-settings.sh";
$ln "$scriptDir/scripts/x-pointer-settings.sh" "$homeDir/Scripts/x-pointer-settings.sh";
$ln "$scriptDir/scripts/gnome-settings-setup.sh" "$homeDir/Scripts/gnome-settings-setup.sh";
$ln "$scriptDir/scripts/gnome-gsd-manual-startup.sh" "$homeDir/Scripts/gnome-gsd-manual-startup.sh";
$ln "$scriptDir/scripts/gnome-unset-all-keybindings.sh" "$homeDir/Scripts/gnome-unset-all-keybindings.sh";

# Linux create dotfile symlinks
echo -e "$arrow Install user configuration files.";
$ln "$scriptDir/bashrc" "$homeDir/.bashrc";
$ln "$scriptDir/bash_profile" "$homeDir/.bash_profile";
$ln "$scriptDir/bash_aliases" "$homeDir/.bash_aliases";
$ln "$scriptDir/bash_env" "$homeDir/.bash_env";
$ln "$scriptDir/starship.toml" "$homeDir/.config/starship.toml";
$ln "$scriptDir/bash_theme" "$homeDir/.bash_theme";
$ln "$scriptDir/Xresources" "$homeDir/.Xresources";
$ln "$scriptDir/gitconfig" "$homeDir/.gitconfig";
$ln "$scriptDir/gitexcludes" "$homeDir/.gitexcludes";
$ln "$scriptDir/init.vim" "$homeDir/.config/nvim/init.vim";
$ln "$scriptDir/mostrc" "$homeDir/.mostrc";
$ln "$scriptDir/nanorc" "$homeDir/.config/nano/nanorc";
$ln "$scriptDir/bspwm/bspwmrc" "$homeDir/.config/bspwm/bspwmrc";
$ln "$scriptDir/bspwm/sxhkdrc" "$homeDir/.config/sxhkd/sxhkdrc";
$ln "$scriptDir/vscode/settings.json" "$homeDir/.config/Code/User/settings.json";
$ln "$scriptDir/vscode/keybindings.json" "$homeDir/.config/Code/User/keybindings.json";
$ln "$scriptDir/vscode/extensions.txt" "$homeDir/.config/Code/User/extensions.txt";
$ln "$scriptDir/kitty.conf" "$homeDir/.config/kitty/kitty.conf";
$ln "$scriptDir/qmk_keymap.json" "$homeDir/.qmk_keymap.json";
$ln "$scriptDir/gtk-settings.ini" "$homeDir/.config/gtk-3.0/settings.ini";
$ln "$scriptDir/gtk-settings.ini" "$homeDir/.config/gtk-4.0/settings.ini";
$ln "$scriptDir/bspwm/rofi.rasi" "$homeDir/.config/rofi/config.rasi";
$ln "$scriptDir/bspwm/polybar.ini" "$homeDir/.config/polybar/config";
$ln "$scriptDir/Xmodmap" "$homeDir/.Xmodmap";

# Linux create helper symlink to dotfiles
echo -e "$arrow Create helper symlink to /dotfiles?";
sudo $ln "$scriptDir" "/dotfiles";

# Print info that execution finished
echo -e "$arrow Installation finished."
