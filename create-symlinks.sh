#!/bin/bash

# Check if we run MacOS
[[ $(uname -s) == "Darwin" ]] && macos=true;

# Determine the script and home directories
scriptDir=$(cd "$(dirname $0)" && pwd);
homeDir=${scriptDir///dotfiles/};

# Print the directory paths
echo "Host operating system is: $([ $macos ] && echo MacOS || echo Linux)";
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

# Create Linux-only symlinks
[ !$macos ] && mkdir -p $homeDir/.config/i3;
[ !$macos ] && mkdir -p $homeDir/.config/rofi;
[ !$macos ] && ln -s $scriptDir/i3/config $homeDir/.config/i3/config;
[ !$macos ] && ln -s $scriptDir/rofi/config $homeDir/.config/rofi/config;
[ !$macos ] && ln -s $scriptDir/xorg/Xresources $homeDir/.Xresources;
[ !$macos ] && ln -s $scriptDir/xorg/xsessionrc $homeDir/.xsessionrc;
[ !$macos ] && ln -s $scriptDir/xorg/Xmodmap $homeDir/.Xmodmap;
[ !$macos ] && ln -s $scriptDir/xdm/Xresources /etc/X11/xdm/Xresources;
[ !$macos ] && ln -s $scriptDir/apt/sources.list /etc/apt/sources.list;
[ !$macos ] && ln -s $scriptDir/apt/preferences /etc/apt/preferences;
