#!/bin/bash

[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# ##############################################################################
# Bash environment variables for MacOS and Linux
# ##############################################################################

export LANG="en_IE.UTF-8";
export LANGUAGE="en_IE.UTF-8";
export LC_ALL="en_IE.UTF-8";
export PAGER="less";
export MANPAGER="most";
export GREP_COLOR=always;
export CLICOLOR_FORCE=true;

export DOTFILES="$HOME/dotfiles";
export NVM_DIR="$HOME/.nvm";
export GEM_HOME="$HOME/.gem/";
export PATH="$PATH:/usr/local/sbin";
export PATH="$PATH:/usr/local/bin";
export PATH="$PATH:/usr/bin";
export PATH="$PATH:/usr/sbin";
export PATH="$PATH:/bin";
export PATH="$PATH:/sbin";
export PATH="$PATH:$GEM_HOME/bin";
export PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin";
export PATH="$PATH:$HOME/.config/composer/vendor/bin";
export PATH="$PATH:$HOME/.local/bin";

[[ "$macos" == "true" ]] && export BASH_SILENCE_DEPRECATION_WARNING=1;
[[ "$macos" == "true" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";

# ##############################################################################
# Bash aliases for MacOS and Linux
# ##############################################################################

alias dotfiles='cd "${DOTFILES}"';
alias less='less -R';
alias grep='grep --color=auto';
alias diff='diff --color=auto';
alias dmesg='dmesg --color=auto';
alias ip='ip --color=auto';
alias mv='mv -i';
which exa &> /dev/null && alias ls='exa';
which exa &> /dev/null && alias ll='exa -la';
which batcat &> /dev/null && alias bat='batcat';
which batcat &> /dev/null && alias cat='bat -p';
alias dockerprune='docker system prune -a --volumes';
alias dockerpruneSudo='sudo docker system prune -a --volumes';
alias gl='git log --name-status --graph';
alias gs='git status';
alias ga='git add . && git status';
alias gitIgnore='git update-index --assume-unchanged';
alias gitUnignore='git update-index --no-assume-unchanged';
alias gitIgnored='git ls-files -v | grep "^[[:lower:]]"';
alias gitYesterday='git log --since=yesterday.midnight --pretty=format:"- %s" --reverse';
alias k='kubectl';
alias python=python3;
alias deit='docker exec -it';
function _findFiles() { folder="${2:-.}"; sudo find "$folder" -type f -iname "*$1*" -print0 | xargs -0 -I{} echo -e "\033[36m{}\033[0m"; }; 
alias findfiles='_findFiles';
function _findFolders() { folder="${2:-.}"; sudo find "$folder" -type d -iname "*$1*" -print0 | xargs -0 -I{} echo -e "\033[36m{}\033[0m"; }; 
alias findfolders='_findFolders';
function _grepFiles() { folder="${2:-.}"; sudo sh -c "grep --color=auto -rl '$1' '$folder'";  };
alias grepfiles='_grepFiles';
alias findRepos='find / -type d -name ".git" -exec dirname {} \; 2>/dev/null';

[[ "$macos" == "true" ]] && alias ls='ls -G'
[[ "$macos" == "true" ]] && alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock';
[[ "$macos" == "true" ]] && alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock';
[[ "$macos" == "true" ]] && alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock';
[[ "$macos" == "true" ]] && alias disableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores true';
[[ "$macos" == "true" ]] && alias enableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores false';
[[ "$macos" == "true" ]] && alias vscodeExport='code --list-extensions > ~/Library/Application Support/Code/User/extensions.txt';
[[ "$macos" == "true" ]] && alias vscodeImport='cat ~/Library/Application Support/Code/User/extensions.txt | xargs -L 1 code --install-extension';
[[ "$macos" == "true" ]] && alias vscodiumExport='code --list-extensions > ~/Library/Application\ Support/VSCodium/User/extensions.txt';
[[ "$macos" == "true" ]] && alias vscodiumImport='cat ~/Library/Application\ Support/VSCodium/User/extensions.txt | xargs -L 1 codium --install-extension';
[[ "$linux" == "true" ]] && alias ls='ls --color=auto'
[[ "$linux" == "true" ]] && alias open='xdg-open';
[[ "$linux" == "true" ]] && alias apt-log-installed="cat /var/log/apt/history.log | grep 'Commandline' | grep 'install'";
[[ "$linux" == "true" ]] && alias apt-log-uninstalled="cat /var/log/apt/history.log | grep 'Commandline' | grep 'purge\|remove'";
[[ "$linux" == "true" ]] && alias backupSystem='sudo bash -c "cd / && mkdir -p backups && tar -cvpzf backups/backup_$(date +"%Y-%m-%d_%H-%M").tar.gz --exclude=/backups/*.tar.gz --one-file-system /"';
[[ "$linux" == "true" ]] && alias vscodeExport='code --list-extensions > ~/.config/Code/User/extensions.txt';
[[ "$linux" == "true" ]] && alias vscodeImport='cat ~/.config/Code/User/extensions.txt | xargs -L 1 code --install-extension';
[[ "$linux" == "true" ]] && alias vscodiumExport='code --list-extensions > ~/.config/Code/User/extensions.txt';
[[ "$linux" == "true" ]] && alias vscodiumImport='cat ~/.config/Code/User/extensions.txt | xargs -L 1 codium --install-extension';
[[ "$linux" == "true" ]] && alias nvim='~/Applications/nvim.appimage';

# ##############################################################################
# Bash sources and launches
# ##############################################################################

source /usr/share/bash-completion/bash_completion &> /dev/null;
source /usr/local/etc/profile.d/bash_completion.sh &> /dev/null;
source "$NVM_DIR/nvm.sh" &> /dev/null;

eval "$(starship init bash)";