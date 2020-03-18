#!/bin/bash

# Declare other variables
scriptDir="/Users/$USER/dotfiles";
homeDir="/Users/$USER";
mkdir="mkdir -p";
ln="ln -sv";
os="MacOS";

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

# MacOS create directories
$mkdir $homeDir/.config/kitty;
$mkdir $homeDir/Library/Application\ Support/Code/User/;

# MacOS create symlinks
$ln $scriptDir/.bash_profile $homeDir/.bash_profile;
$ln $scriptDir/.gitconfig $homeDir/.gitconfig;
$ln $scriptDir/.nanorc $homeDir/.nanorc;
$ln $scriptDir/.vscode_settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
$ln $scriptDir/.vscode_keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
$ln $scriptDir/.yabairc $homeDir/.yabairc;
$ln $scriptDir/.skhdrc $homeDir/.skhdrc;
$ln $scriptDir/.alacritty.yml $homeDir/.alacritty.yml;
$ln $scriptDir/.kitty.conf $homeDir/.config/kitty/kitty.conf;

# Print info that execution finished
echo "Installation finished."
