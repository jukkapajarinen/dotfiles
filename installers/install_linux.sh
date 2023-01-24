#!/bin/bash

# ##############################################################################
# Linux installation script for Jukka's dotfiles
# ##############################################################################

# Declare common variables
arrow="\033[32m==>\033[0m";
bashDir="$(dirname "${BASH_SOURCE[0]}")";
scriptDir="$(cd "${bashDir//installers/}" >/dev/null 2>&1 && pwd)";
homeDir="/home/$USER";
os="Linux";

# Print the directory paths
echo -e "\033[1mWelcome ${USER}, to Jukka's dotfiles installation script.\033[0m";
echo -e "- Operating system: \033[32m$os\033[0m";
echo -e "- Source directory: \033[34m$scriptDir\033[0m";
echo -e "- Target directory: \033[31m$homeDir\033[0m";

# Read possible --force or -f from the cli args
if [[ $1 == "--force" ]] || [[ $2 == "--force" ]] || [[ $1 == "-f" ]] || [[ $2 == "-f" ]]; then
  read -rp "$(echo -e "$arrow" Are you sure to force installation? \(files will be overwritten\) [y/N]) " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    mkdir="mkdir -vp";
    ln="ln -svfT"; #cp="cp -vf --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
else
  read -rp "$(echo -e "$arrow" Are you sure to start installation? [y/N]) " yn;
  if [[ $yn =~ [yY](es)* ]]; then
    mkdir="mkdir -vp";
    ln="ln -isvT"; #cp="cp -iv --remove-destination";
  else
    echo -e "$arrow Installation was not started."
    exit;
  fi
fi

# Linux create directories
echo -e "$arrow Create possibly missing directories.";
$mkdir "$homeDir/Scripts/";
$mkdir "$homeDir/.config/autostart/";
$mkdir "$homeDir/.config/nvim";
$mkdir "$homeDir/.config/bspwm/";
$mkdir "$homeDir/.config/sxhkd/";
$mkdir "$homeDir/.config/kitty/";
$mkdir "$homeDir/.config/nano/";
$mkdir "$homeDir/.config/Code/User/";
$mkdir "$homeDir/.config/gtk-3.0/";
$mkdir "$homeDir/.config/gtk-4.0/";
$mkdir "$homeDir/.config/rofi/";
$mkdir "$homeDir/.config/polybar/";

# Linux create custom script symlinks
echo -e "$arrow Install user script files.";
$ln "$scriptDir/rofi-shutdown.sh" "$homeDir/Scripts/rofi-shutdown.sh";
$ln "$scriptDir/rofi-workspaces.sh" "$homeDir/Scripts/rofi-workspaces.sh";
$ln "$scriptDir/x-adjust-brightness.sh" "$homeDir/Scripts/x-adjust-brightness.sh";
$ln "$scriptDir/x-display-settings.sh" "$homeDir/Scripts/x-display-settings.sh";
$ln "$scriptDir/x-pointer-settings.sh" "$homeDir/Scripts/x-pointer-settings.sh";
$ln "$scriptDir/gnome-settings-setup.sh" "$homeDir/Scripts/gnome-settings-setup.sh";
$ln "$scriptDir/gnome-unset-all-keybindings.sh" "$homeDir/Scripts/gnome-unset-all-keybindings.sh";

# Linux create dotfile symlinks
echo -e "$arrow Install user configuration files.";
$ln "$scriptDir/bashrc" "$homeDir/.bashrc";
$ln "$scriptDir/bashrc" "$homeDir/.bash_profile";
$ln "$scriptDir/gitconfig" "$homeDir/.gitconfig";
$ln "$scriptDir/gitexcludes" "$homeDir/.gitexcludes";
$ln "$scriptDir/kitty.conf" "$homeDir/.config/kitty/kitty.conf";
$ln "$scriptDir/starship.toml" "$homeDir/.config/starship.toml";
$ln "$scriptDir/Xresources" "$homeDir/.Xresources";
$ln "$scriptDir/vimrc" "$homeDir/.vimrc";
$ln "$scriptDir/vimrc" "$homeDir/.config/nvim/init.vim";
$ln "$scriptDir/mostrc" "$homeDir/.mostrc";
$ln "$scriptDir/nanorc" "$homeDir/.config/nano/nanorc";
$ln "$scriptDir/gsettings.desktop" "$homeDir/.config/autostart/gsettings.desktop";
$ln "$scriptDir/gtk-settings.ini" "$homeDir/.config/gtk-3.0/settings.ini";
$ln "$scriptDir/gtk-settings.ini" "$homeDir/.config/gtk-4.0/settings.ini";
$ln "$scriptDir/bspwmrc" "$homeDir/.config/bspwm/bspwmrc";
$ln "$scriptDir/sxhkdrc" "$homeDir/.config/sxhkd/sxhkdrc";
$ln "$scriptDir/rofi.rasi" "$homeDir/.config/rofi/config.rasi";
$ln "$scriptDir/polybar.ini" "$homeDir/.config/polybar/config";
$ln "$scriptDir/vscode-settings.json" "$homeDir/.config/Code/User/settings.json";
$ln "$scriptDir/vscode-keybindings.json" "$homeDir/.config/Code/User/keybindings.json";
$ln "$scriptDir/vscode-extensions.txt" "$homeDir/.config/Code/User/extensions.txt";
$ln "$scriptDir/qmk_keymap.json" "$homeDir/.qmk_keymap.json";
$ln "$scriptDir/Xmodmap" "$homeDir/.Xmodmap";

# Linux create helper symlink to dotfiles
echo -e "$arrow Create helper symlink to /dotfiles?";
sudo $ln "$scriptDir" "/dotfiles";

# ```
# apt install git curl exa bat docker.io docker-compose most vim neovim neofetch lolcat fonts-firacode gnome-tweaks geary steam kitty keepassxc vlc;
# ```

# ```
# cd $HOME/Downloads && git clone https://github.com/pop-os/shell.git && cd shell && make local-install;
# sudo cp org.gnome.shell.extensions.pop-shell.gschema.xml /usr/share/glib-2.0/schemas/;
# sudo glib-compile-schemas /usr/share/glib-2.0/schemas/;
# ```
# ```
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
# sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim';
# ```
# ```
# sh -c "$(curl -fsSL https://starship.rs/install.sh)";
# ```
# ```
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash;
# ```

# Print info that execution finished
echo -e "$arrow Installation finished."
