#!/bin/bash

# Check if we run MacOS
[ "$(uname -s)" == "Darwin" ] && macos=true || macos=false;

# Determine the script and home directories
scriptDir=$(cd "$(dirname $0)" && pwd);
homeDir=${scriptDir///dotfiles/};

# Print the directory paths
echo "Host operating system is: $([ $macos == true ] && echo MacOS || echo Linux)";
echo "Script executed in: $scriptDir";
echo "Home directory detected as: $homeDir";

# Exit if the dotfiles is not cloned into users home-directory
if ! { [[ $scriptDir == *"home"* ]] || [[ $scriptDir == *"Users"* ]]; }; then
  echo "Error: You must clone dotfiles into your home-directory!";
  exit 1;
fi

# Declare installation commands
mkdir="mkdir -p";
ln="ln -sv";

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $1 == "-f" ]]; then
  read -p "Are you sure to force installation? (files will be overwritten) [Y/n] " yn;
  [[ $yn =~ [yY](es)* ]] && ln="ln -svf" || exit 0;
fi

# Create cross-platform symlinks
$mkdir $homeDir/.config/alacritty;
$ln $scriptDir/bash/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/git/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/nano/nanorc $homeDir/.nanorc;
$ln $scriptDir/alacritty/alacritty.yml $homeDir/.config/alacritty/alacritty.yml;

# Create MacOS-only symlinks
[ $macos == true ] && $mkdir $homeDir/Library/Application\ Support/Code/User/;
[ $macos == true ] && $mkdir $homeDir/Library/Application\ Support/Spectacle/;
[ $macos == true ] && $ln $scriptDir/vscode/settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
[ $macos == true ] && $ln $scriptDir/vscode/keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
[ $macos == true ] && $ln $scriptDir/spectacle.app/Shortcuts.json $homeDir/Library/Application\ Support/Spectacle/Shortcuts.json;

# Create Linux-only symlinks
[ $macos == false ] && $mkdir $homeDir/.config/i3;
[ $macos == false ] && $mkdir $homeDir/.config/rofi;
[ $macos == false ] && $mkdir $homeDir/.config/polybar;
[ $macos == false ] && $mkdir $homeDir/.config/Code/User/;
[ $macos == false ] && $ln $scriptDir/i3/config $homeDir/.config/i3/config;
[ $macos == false ] && $ln $scriptDir/rofi/config $homeDir/.config/rofi/config;
[ $macos == false ] && $ln $scriptDir/polybar/config $homeDir/.config/polybar/config;
[ $macos == false ] && $ln $scriptDir/keyboard/apple_keyboard_fi /etc/default/keyboard;
[ $macos == false ] && $ln $scriptDir/keyboard/apple_keyboard_fi.xkbmap $homeDir/.xkbmap;
[ $macos == false ] && $ln $scriptDir/xorg/Xresources $homeDir/.Xresources;
[ $macos == false ] && $ln $scriptDir/xorg/Xsession $homeDir/.Xsession;
[ $macos == false ] && $ln $scriptDir/vscode/settings.json $homeDir/.config/Code/User/settings.json;
[ $macos == false ] && $ln $scriptDir/vscode/keybindings.json $homeDir/.config/Code/User/keybindings.json;
[ $macos == false ] && $ln $scriptDir/apt/sources.list /etc/apt/sources.list;
[ $macos == false ] && $ln $scriptDir/apt/preferences /etc/apt/preferences;
[ $macos == false ] && $ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
[ $macos == false ] && $ln /usr/bin/i3 /etc/alternatives/x-window-manager;
[ $macos == false ] && $ln /usr/bin/alacritty /etc/alternatives/x-terminal-emulator;

# Print info that execution finished
echo "Installation finished."
