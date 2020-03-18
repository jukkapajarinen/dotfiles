#!/bin/bash

# Declare other variables
scriptDir="/home/$USER/dotfiles";
homeDir="/home/$USER";
mkdir="mkdir -p";
ln="ln -sv";
os="Linux";

# Print the directory paths
echo "Host operating system is: $os";
echo "Script executed in: $scriptDir";
echo "Home directory detected as: $homeDir";

# Exit if the dotfiles is not cloned into users home-directory
if ! { [[ $scriptDir == *"home"* ]] || [[ $scriptDir == *"Users"* ]]; }; then
  echo "Error: You must clone dotfiles into your home-directory!";
  exit 1;
fi

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "Are you sure to force installation? (files will be overwritten) [Y/n] " yn;
  [[ $yn =~ [yY](es)* ]] && ln="ln -svf" || exit 0;
fi

# Linux create directories
$mkdir $homeDir/.config/i3;
$mkdir $homeDir/.config/rofi;
$mkdir $homeDir/.config/dunst;
$mkdir $homeDir/.config/gtk-3.0;
$mkdir $homeDir/.config/kitty;
$mkdir $homeDir/.config/Code/User/;

# Linux create symlinks
$ln $scriptDir/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/.nanorc $homeDir/.nanorc;
sudo $ln /usr/share/nano /usr/local/share/nano;
sudo $ln $scriptDir/keyboard/keyboard_apple_fi /etc/default/keyboard;
sudo $ln $scriptDir/packages/.apt_debian.list /etc/apt/sources.list;
sudo $ln $scriptDir/packages/.apt_docker.list /etc/apt/sources.list.d/docker.list;
sudo $ln $scriptDir/packages/.apt_megasync.list /etc/apt/sources.list.d/megasync.list;
sudo $ln $scriptDir/packages/.apt_regolith.list /etc/apt/sources.list.d/regolith.list;
sudo $ln $scriptDir/packages/.apt_spotify.list /etc/apt/sources.list.d/spotify.list;
sudo $ln $scriptDir/packages/.apt_virtualbox.list /etc/apt/sources.list.d/virtualbox.list;
sudo $ln $scriptDir/packages/.apt_vscode.list /etc/apt/sources.list.d/vscode.list;
sudo $ln $scriptDir/packages/.apt_preferences /etc/apt/preferences;
$ln $scriptDir/.i3 $homeDir/.config/i3/config;
$ln $scriptDir/.conkyrc $homeDir/.conkyrc;
$ln $scriptDir/.rofi $homeDir/.config/rofi/config;
$ln $scriptDir/.dunstrc $homeDir/.config/dunst/dunstrc;
$ln $scriptDir/.gtk_2 $homeDir/.gtkrc-2.0;
$ln $scriptDir/.gtk_3 $homeDir/.config/gtk-3.0/settings.ini;
$ln $scriptDir/.mimeapps $homeDir/.config/mimeapps.list;
$ln $scriptDir/keyboard/keyboard_apple_fi.xkbmap $homeDir/.xkbmap;
$ln $scriptDir/.xvkbd $homeDir/.xvkbd;
$ln $scriptDir/.Xresources $homeDir/.Xresources;
$ln $scriptDir/.Xsession $homeDir/.Xsession;
$ln $scriptDir/.vscode_settings.json $homeDir/.config/Code/User/settings.json;
$ln $scriptDir/.vscode_keybindings.json $homeDir/.config/Code/User/keybindings.json;
$ln $scriptDir/.kitty.conf $homeDir/.config/kitty/kitty.conf;
$ln $scriptDir/.alacritty.yml $homeDir/.alacritty.yml;
sudo $ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
sudo $ln /usr/bin/i3 /etc/alternatives/x-window-manager;
sudo $ln /usr/bin/kitty /etc/alternatives/x-terminal-emulator;

# Print info that execution finished
echo "Installation finished."
