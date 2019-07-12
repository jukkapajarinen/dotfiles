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

# Create cross-platform symlinks
ln -s $scriptDir/bash/.bash_profile $homeDir/.bash_profile;
ln -s $scriptDir/git/.gitconfig $homeDir/.gitconfig;

# Create MacOS-only symlinks
[ $macos == true ] && mkdir -p $homeDir/Library/Application\ Support/Code/User/;
[ $macos == true ] && ln -s $scriptDir/vscode/settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
[ $macos == true ] && ln -s $scriptDir/vscode/keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
#TODO: add alacritty config symlink for macos

# Create Linux-only symlinks
[ $macos == false ] && mkdir -p $homeDir/.config/i3;
[ $macos == false ] && mkdir -p $homeDir/.config/rofi;
[ $macos == false ] && mkdir -p $homeDir/.config/polybar;
[ $macos == false ] && mkdir -p $homeDir/.config/alacritty;
[ $macos == false ] && mkdir -p $homeDir/.config/Code/User/;
[ $macos == false ] && ln -s $scriptDir/i3/config $homeDir/.config/i3/config;
[ $macos == false ] && ln -s $scriptDir/rofi/config $homeDir/.config/rofi/config;
[ $macos == false ] && ln -s $scriptDir/polybar/config $homeDir/.config/polybar/config;
[ $macos == false ] && ln -s $scriptDir/alacritty/alacritty.yml $homeDir/.config/alacritty/alacritty.yml;
[ $macos == false ] && ln -s $scriptDir/keyboard/apple_keyboard_fi /etc/default/keyboard;
[ $macos == false ] && ln -s $scriptDir/keyboard/apple_keyboard_fi.xkbmap $homeDir/.xkbmap;
[ $macos == false ] && ln -s $scriptDir/xorg/Xresources $homeDir/.Xresources;
[ $macos == false ] && ln -s $scriptDir/xorg/Xsession $homeDir/.Xsession;
[ $macos == false ] && ln -s $scriptDir/vscode/settings.json $homeDir/.config/Code/User/settings.json;
[ $macos == false ] && ln -s $scriptDir/vscode/keybindings.json $homeDir/.config/Code/User/keybindings.json;
[ $macos == false ] && ln -s $scriptDir/apt/sources.list /etc/apt/sources.list;
[ $macos == false ] && ln -s $scriptDir/apt/preferences /etc/apt/preferences;
[ $macos == false ] && ln -s /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
[ $macos == false ] && ln -s /usr/bin/i3 /etc/alternatives/x-window-manager;
[ $macos == false ] && ln -s /usr/bin/alacritty /etc/alternatives/x-terminal-emulator;

# Print info that execution finished
echo "Script execution ended."
