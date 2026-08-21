#!/bin/bash

# ##############################################################################
# Bash environment variables for Linux
# ##############################################################################
export LANG="en_IE.UTF-8";
export LANGUAGE="en_IE.UTF-8";
export LC_ALL="en_IE.UTF-8";
export PAGER="less";
export MANPAGER="less";
export GREP_COLOR=always;
export CLICOLOR_FORCE=true;
export NVM_DIR="$HOME/.nvm";
export GEM_HOME="$HOME/.gem/";
export PATH="$PATH:/usr/local/sbin";
export PATH="$PATH:/usr/local/bin";
export PATH="$PATH:/usr/bin";
export PATH="$PATH:/usr/sbin";
export PATH="$PATH:/bin";
export PATH="$PATH:/sbin";
export PATH="$PATH:$HOME/.config/composer/vendor/bin";
export PATH="$PATH:$HOME/.local/bin";

# ##############################################################################
# Bash aliases for Linux
# ##############################################################################
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
alias gl='git log --name-status --graph';
alias gitIgnore='git update-index --assume-unchanged';
alias gitUnignore='git update-index --no-assume-unchanged';
alias gitIgnored='git ls-files -v | grep "^[[:lower:]]"';
alias gitYesterday='git log --since=yesterday.midnight --pretty=format:"- %s" --reverse';
alias k='kubectl';
alias python=python3;
alias ls='ls --color=auto';
alias open='xdg-open';
alias backup='sudo bash -c "cd / && mkdir -p backups && tar -cvpzf backups/backup_$(date +"%Y-%m-%d_%H-%M").tar.gz --exclude=/backups/*.tar.gz --one-file-system /"';
alias vscodeExport='code --list-extensions > ~/.config/Code/User/extensions.txt';
alias vscodeImport='cat ~/.config/Code/User/extensions.txt | xargs -L 1 code --install-extension';
alias nvim='~/Applications/nvim.appimage';

# ##############################################################################
# Bash sources and launches
# ##############################################################################
source "/usr/share/bash-completion/bash_completion" &> /dev/null;
source "/usr/local/etc/profile.d/bash_completion.sh" &> /dev/null;
source "$NVM_DIR/nvm.sh" &> /dev/null;
eval "$(starship init bash)";
