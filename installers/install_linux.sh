#!/bin/bash

# Declare other variables
scriptDir="/home/$USER/dotfiles";
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

# Exit if the dotfiles is not cloned into users home-directory
if ! { [[ $scriptDir == *"home"* ]] || [[ $scriptDir == *"Users"* ]]; }; then
  echo "Error: You must clone dotfiles into your home-directory!";
  exit 1;
fi

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "Are you sure to force installation? (files will be overwritten) [y/N] " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    ln="ln -svf";
    cp="cp -vf --remove-destination";
  else
    echo "==> Installation not started."
    exit;
  fi
fi

# Linux create directories
echo "==> Create possibly missing directories.";
$mkdir $homeDir/.config/i3;
$mkdir $homeDir/.config/rofi;
$mkdir $homeDir/.config/dunst;
$mkdir $homeDir/.config/kitty;
$mkdir $homeDir/.config/Code/User/;

# Linux create dotfile symlinks
echo "==> Install user configuration files.";
$ln $scriptDir/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/.bash_aliases $homeDir/.bash_aliases;
$ln $scriptDir/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/.gitignore_global $homeDir/.gitignore_global;
$ln $scriptDir/.nanorc $homeDir/.nanorc;
$ln $scriptDir/.i3 $homeDir/.config/i3/config;
$ln $scriptDir/.conkyrc $homeDir/.conkyrc;
$ln $scriptDir/.rofi $homeDir/.config/rofi/config;
$ln $scriptDir/.dunstrc $homeDir/.config/dunst/dunstrc;
$ln $scriptDir/.gtk_2 $homeDir/.gtkrc-2.0;
$ln $scriptDir/.mimeapps $homeDir/.config/mimeapps.list;
$ln $scriptDir/keyboard/keyboard_apple_fi.xkbmap $homeDir/.xkbmap;
$ln $scriptDir/.xvkbd $homeDir/.xvkbd;
$ln $scriptDir/.Xresources $homeDir/.Xresources;
$ln $scriptDir/.Xsession $homeDir/.Xsession;
$ln $scriptDir/.vscode_settings.json $homeDir/.config/Code/User/settings.json;
$ln $scriptDir/.vscode_keybindings.json $homeDir/.config/Code/User/keybindings.json;
$ln $scriptDir/.kitty.conf $homeDir/.config/kitty/kitty.conf;
$ln $scriptDir/.alacritty.yml $homeDir/.alacritty.yml;

# Linux create system symlinks
echo "==> Install system configuration files.";
sudo $ln /usr/share/zoneinfo/Europe/Helsinki /etc/localtime;
sudo $ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
sudo $ln /usr/bin/i3 /etc/alternatives/x-window-manager;
sudo $ln /usr/bin/kitty /etc/alternatives/x-terminal-emulator;
sudo $ln /usr/share/nano /usr/local/share/nano;
sudo $cp $scriptDir/keyboard/keyboard_apple_fi /etc/default/keyboard;

# Print info that execution finished
echo "==> Installation finished."
