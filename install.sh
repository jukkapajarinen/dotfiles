#!/bin/bash

# Check if we run MacOS
[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# Declare other variables
scriptDir=$(cd "$(dirname $0)" && pwd);
homeDir=${scriptDir///dotfiles/};
mkdir="mkdir -p";
ln="ln -sv";
cliOnly="false";

# Print the directory paths
echo "Host operating system is: $([[ "$macos" == "true" ]] && echo MacOS || echo Linux)";
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
  cliOnly="true";
fi

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -p "Are you sure to force installation? (files will be overwritten) [Y/n] " yn;
  [[ $yn =~ [yY](es)* ]] && ln="ln -svf" || exit 0;
fi

# MacOS create directories
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && $mkdir $homeDir/Library/Application\ Support/Code/User/;
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && $mkdir $homeDir/Library/Application\ Support/Spectacle/;

# Linux create directories
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $mkdir $homeDir/.config/i3;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $mkdir $homeDir/.config/rofi;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $mkdir $homeDir/.config/dunst;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $mkdir $homeDir/.config/gtk-3.0;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $mkdir $homeDir/.config/Code/User/;

# Common create symlinks
$ln $scriptDir/bash_profile $homeDir/.bash_profile;
$ln $scriptDir/git_config $homeDir/.gitconfig;
$ln $scriptDir/nano_config $homeDir/.nanorc;

# MacOS create symlinks
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && $ln $scriptDir/vscode_settings.json $homeDir/Library/Application\ Support/Code/User/settings.json;
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && $ln $scriptDir/vscode_keybindings.json $homeDir/Library/Application\ Support/Code/User/keybindings.json;
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && $ln $scriptDir/spectacle_shortcuts.json $homeDir/Library/Application\ Support/Spectacle/Shortcuts.json;

# Linux create symlinks
[[ "$linux" == "true" ]] && $ln /usr/share/nano /usr/local/share/nano;
[[ "$linux" == "true" ]] && $ln $scriptDir/keyboard/apple_keyboard_fi /etc/default/keyboard;
[[ "$linux" == "true" ]] && $ln $scriptDir/apt_sources /etc/apt/sources.list;
[[ "$linux" == "true" ]] && $ln $scriptDir/apt_preferences /etc/apt/preferences;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/i3_config $homeDir/.config/i3/config;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/conky_config $homeDir/.conkyrc;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/rofi_config $homeDir/.config/rofi/config;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/dunst_config $homeDir/.config/dunst/dunstrc;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/gtk_2 $homeDir/.gtkrc-2.0;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/gtk_3 $homeDir/.config/gtk-3.0/settings.ini;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/mimeapps $homeDir/.config/mimeapps.list;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/keyboard/apple_keyboard_fi.xkbmap $homeDir/.xkbmap;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/x_xvkbd $homeDir/.xvkbd;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/x_resources $homeDir/.Xresources;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/x_session $homeDir/.Xsession;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/vscode_settings.json $homeDir/.config/Code/User/settings.json;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln $scriptDir/vscode_keybindings.json $homeDir/.config/Code/User/keybindings.json;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln /usr/bin/firefox-dev /etc/alternatives/x-www-browser;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln /usr/bin/i3 /etc/alternatives/x-window-manager;
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && $ln /usr/bin/urxvt /etc/alternatives/x-terminal-emulator;

# Install additional things
[[ "$cliOnly" == "false" ]] && [[ "$macos" == "true" ]] && vscodeDataDir="$homeDir/Library/Application\ Support/Code/";
[[ "$cliOnly" == "false" ]] && [[ "$linux" == "true" ]] && vscodeDataDir="$homeDir/.config/Code/";
[[ "$cliOnly" == "false" ]] && cat $scriptDir/vscode_extensions | xargs -L 1 code --user-data-dir=$vscodeDataDir --install-extension;

# Print info that execution finished
echo "Installation finished."
