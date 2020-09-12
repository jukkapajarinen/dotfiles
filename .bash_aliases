#!/bin/bash

# ##############################################################################
# Aliases for MacOS and Linux
# ##############################################################################

# Check platform
[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# Common aliases
alias dotfiles='cd "${DOTFILES}"';
alias grep='grep --color=auto';
alias diff='diff --color=auto';
alias dmesg='dmesg --color=auto';
alias mv='mv -i';
alias ll='ls -lah';
alias dockerpoop='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker network rm $(docker network ls -q); docker volume rm $(docker volume ls -q);';
alias dockerpoop2='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images -q); docker network rm $(docker network ls -q); docker volume rm $(docker volume ls -q);';
alias gl='git log --name-status --graph';
alias gs='git status';
alias gitIgnore='git update-index --assume-unchanged';
alias gitUnignore='git update-index --no-assume-unchanged';
alias gitIgnored='git ls-files -v | grep "^[[:lower:]]"';
alias gitYesterday='git log --since=yesterday.midnight --pretty=format:"- %s" --reverse';

# OS specific aliases
[[ "$macos" == "true" ]] && alias ls='ls -G'
[[ "$macos" == "true" ]] && alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock';
[[ "$macos" == "true" ]] && alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock';
[[ "$macos" == "true" ]] && alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock';
[[ "$macos" == "true" ]] && alias disableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores true';
[[ "$macos" == "true" ]] && alias enableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores false';
[[ "$macos" == "true" ]] && alias vscodeExtExport='code --list-extensions > ~/Library/Application\ Support/Code/User/extensions.lst';
[[ "$macos" == "true" ]] && alias vscodeExtImport='cat ~/Library/Application\ Support/Code/User/extensions.lst | xargs -L 1 code --install-extension';
[[ "$linux" == "true" ]] && alias ls='ls --color=auto'
[[ "$linux" == "true" ]] && alias open='xdg-open';
[[ "$linux" == "true" ]] && alias apt-log-installed="cat /var/log/apt/history.log | grep 'Commandline' | grep 'install'";
[[ "$linux" == "true" ]] && alias apt-log-uninstalled="cat /var/log/apt/history.log | grep 'Commandline' | grep 'purge\|remove'";
[[ "$linux" == "true" ]] && alias backupSystem='sudo bash -c "cd / && mkdir -p backups && tar -cvpzf backups/backup_$(date +"%Y-%m-%d_%H-%M").tar.gz --exclude=/backups/*.tar.gz --one-file-system /"';
[[ "$linux" == "true" ]] && alias vscodeExtExport='code --list-extensions > ~/.config/Code/User/extensions.lst';
[[ "$linux" == "true" ]] && alias vscodeExtImport='cat ~/.config/Code/User/extensions.lst | xargs -L 1 code --install-extension';