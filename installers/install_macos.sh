#!/bin/bash

# ##############################################################################
# MacOS installation script for Jukka's dotfiles
# ##############################################################################

# Declare other variables
bashDir="$(dirname ${BASH_SOURCE[0]})";
scriptDir="$(cd ${bashDir//installers/} >/dev/null 2>&1 && pwd)";
homeDir="/Users/$USER";
mkdir="mkdir -vp";
ln="ln -isv";
cp="cp -iv --remove-destination";
os="MacOS";

# Print the directory paths
echo "Welcome ${USER}, to Jukka's dotfiles installation script.";
echo "- Operating system: $os";
echo "- Source directory: $scriptDir";
echo "- Target directory: $homeDir";

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "==> Are you sure to force installation? (files will be overwritten) [Y/n] " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    ln="ln -svf";
    cp="cp -vf --remove-destination";
  else
    echo "==> Installation was not started."
    exit;
  fi
fi

# MacOS create directories
echo "==> Create possibly missing directories.";
$mkdir $homeDir/Scripts/;
$mkdir $homeDir/.SpaceVim.d/;
$mkdir $homeDir/.config/kitty/;
$mkdir $homeDir/Library/Application\ Support/Code/User/;

# Linux create custom script symlinks
#echo "==> Install user script files.";

# MacOS create symlinks
echo "==> Install user configuration files.";
$ln $scriptDir/bashrc $homeDir/.bashrc;
$ln $scriptDir/bash_profile $homeDir/.bash_profile;
$ln $scriptDir/bash_aliases $homeDir/.bash_aliases;
$ln $scriptDir/bash_env $homeDir/.bash_env;
$ln $scriptDir/starship.toml $homeDir/.config/starship.toml;
$ln $scriptDir/gitconfig $homeDir/.gitconfig;
$ln $scriptDir/gitexcludes $homeDir/.gitexcludes;
$ln $scriptDir/spacevim $homeDir/.SpaceVim.d/init.toml;
$ln $scriptDir/nanorc $homeDir/.nanorc;
$ln $scriptDir/yabairc $homeDir/.yabairc;
$ln $scriptDir/skhdrc $homeDir/.skhdrc;
$ln $scriptDir/vscode_settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
$ln $scriptDir/vscode_keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
$ln $scriptDir/vscode_extensions.lst $homeDir/Library/Application\ Support/Code/User/extensions.lst;
$ln $scriptDir/kitty.conf $homeDir/.config/kitty/kitty.conf;

# Print info that execution finished
echo "==> Installation finished."
