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
export DOTENV_CONFIG_QUIET=true; # silence dotenv's ad banner (e.g. from `tldr`)

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

# ##############################################################################
# Command guidance (tldr cheatsheets)
# ##############################################################################
_tldr_widget() {
    local cmd point saved_stty output tmpfile;
    command -v tldr &>/dev/null || return;
    cmd="${READLINE_LINE%% *}";
    if [[ -n "$cmd" ]]; then
        printf '\r\e[K\e[1;33mTLDR\e[0m  \e[2m%s\e[0m' "$cmd";
        tmpfile=$(mktemp);
        timeout 3 env FORCE_COLOR=1 tldr "$cmd" >"$tmpfile" 2>/dev/null;
        output=$(<"$tmpfile");
        rm -f "$tmpfile";
        printf '\r\e[K';
        if [[ -n "$output" ]]; then
            point=$READLINE_POINT;
            saved_stty=$(stty -g);
            { printf '\e[1;33mTLDR\e[0m  \e[2m%s\e[0m\n\n' "$READLINE_LINE"; printf '%s\n' "$output"; } | less -R --quit-on-intr;
            stty "$saved_stty";
            READLINE_POINT=$point;
        fi
    fi
}
bind -x '"§": _tldr_widget';   # VS Code integrated terminal forwards Ctrl+Space as this
bind -x '"\C-@": _tldr_widget';   # native terminals (kitty, etc.) send raw NUL for Ctrl+Space


# ##############################################################################
# Bash sources and launches
# ##############################################################################
source "/usr/share/bash-completion/bash_completion" &> /dev/null;
source "/usr/local/etc/profile.d/bash_completion.sh" &> /dev/null;
source "$NVM_DIR/nvm.sh" &> /dev/null;
eval "$(starship init bash)";