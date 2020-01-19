#!/bin/bash

# Declare other variables
scriptDir=$(cd "$(dirname $0)" && pwd);
homeDir=${scriptDir///dotfiles/};
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
$mkdir $homeDir/.config/Code/User/;

# Linux create symlinks
$ln $scriptDir/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/.nanorc $homeDir/.nanorc;
$ln /usr/share/nano /usr/local/share/nano;
$ln $scriptDir/keyboard/keyboard_apple_fi /etc/default/keyboard;
$ln $scriptDir/.apt_sources /etc/apt/sources.list;
$ln $scriptDir/.apt_preferences /etc/apt/preferences;
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
$ln $scriptDir/.alacritty.yml $homeDir/.alacritty.yml;
$ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
$ln /usr/bin/i3 /etc/alternatives/x-window-manager;
$ln /usr/bin/urxvt /etc/alternatives/x-terminal-emulator;

# Install additional things
vscodeDataDir="$homeDir/.config/Code/";
cat $scriptDir/.vscode_extensions.lst | xargs -L 1 code --user-data-dir=$vscodeDataDir --install-extension;

# Print info that execution finished
echo "Installation finished."
