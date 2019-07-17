#!/bin/bash

# Check if we run MacOS
[ "$(uname -s)" == "Darwin" ] && macos=true || macos=false;

# Declare other variables
scriptDir=$(cd "$(dirname $0)" && pwd);
homeDir=${scriptDir///dotfiles/};
mkdir="mkdir -p";
ln="ln -sv";
cliOnly=false;

# Print the directory paths
echo "Host operating system is: $([ $macos == true ] && echo MacOS || echo Linux)";
echo "Script executed in: $scriptDir";
echo "Home directory detected as: $homeDir";

# Exit if the dotfiles is not cloned into users home-directory
if ! { [[ $scriptDir == *"home"* ]] || [[ $scriptDir == *"Users"* ]]; }; then
  echo "Error: You must clone dotfiles into your home-directory!";
  exit 1;
fi

# Read possible --cli-only from the cli args
if [[ $1 == "--cli-only" ]] || [[ $2 == "--cli-only" ]]; then
  echo "Note: Only cli-configurations will be installed.";
  cliOnly=true;
fi

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "Are you sure to force installation? (files will be overwritten) [Y/n] " yn;
  [[ $yn =~ [yY](es)* ]] && ln="ln -svf" || exit 0;
fi

# Create directories
[[ $cliOnly == false ]] && $mkdir $homeDir/.config/alacritty;
[[ $cliOnly == false ]] && [[ $macos == true ]] && $mkdir $homeDir/Library/Application\ Support/Code/User/;
[[ $cliOnly == false ]] && [[ $macos == true ]] && $mkdir $homeDir/Library/Application\ Support/Spectacle/;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $mkdir $homeDir/.config/i3;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $mkdir $homeDir/.config/rofi;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $mkdir $homeDir/.config/polybar;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $mkdir $homeDir/.config/Code/User/;

# Create symlinks
$ln $scriptDir/bash/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/git/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/nano/nanorc $homeDir/.nanorc;
[[ $cliOnly == false ]] && $ln $scriptDir/alacritty/alacritty.yml $homeDir/.config/alacritty/alacritty.yml;
[[ $cliOnly == false ]] && [[ $macos == true ]] && $ln $scriptDir/vscode/settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
[[ $cliOnly == false ]] && [[ $macos == true ]] && $ln $scriptDir/vscode/keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
[[ $cliOnly == false ]] && [[ $macos == true ]] && $ln $scriptDir/spectacle.app/Shortcuts.json $homeDir/Library/Application\ Support/Spectacle/Shortcuts.json;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/i3/config $homeDir/.config/i3/config;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/rofi/config $homeDir/.config/rofi/config;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/polybar/config $homeDir/.config/polybar/config;
[[ $macos == false ]] && $ln $scriptDir/keyboard/apple_keyboard_fi /etc/default/keyboard;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/keyboard/apple_keyboard_fi.xkbmap $homeDir/.xkbmap;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/xorg/Xresources $homeDir/.Xresources;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/xorg/Xsession $homeDir/.Xsession;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/vscode/settings.json $homeDir/.config/Code/User/settings.json;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln $scriptDir/vscode/keybindings.json $homeDir/.config/Code/User/keybindings.json;
[[ $macos == false ]] && $ln $scriptDir/apt/sources.list /etc/apt/sources.list;
[[ $macos == false ]] && $ln $scriptDir/apt/preferences /etc/apt/preferences;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln /usr/bin/i3 /etc/alternatives/x-window-manager;
[[ $cliOnly == false ]] && [[ $macos == false ]] && $ln /usr/bin/alacritty /etc/alternatives/x-terminal-emulator;

# Print info that execution finished
echo "Installation finished."
