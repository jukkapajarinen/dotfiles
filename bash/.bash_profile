
# My Custom functions
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }
date_now() { date '+%a%e %b %H.%M.%S'; }
tty_name() { tty | sed -e "s:/dev/::"; }

# My PS1
export PROMPT_COMMAND='PS1="\[\033[0;35m\]\u\[\033[0;37m\] @ \[\033[0;33m\]\h\[\033[0;37m\] / \[\033[0;34m\]\w\[\033[0;37m\]\[\033[0;32m\]$(parse_git_branch)\[\033[0;37m\] \$ \[\033[0;0m\]"'

# My Message of the Day
echo -e "\033[0;35m$(date_now)\033[0;0m | \033[0;33m$(tty_name)\033[0;0m | \033[0;34mBe awesome today!\033[0;0m 😎"

# My Custom Colors
#alias ls='ls -G' #*BSD/MacOS version
alias ls='ls --color=auto' #GNU/Linux version
alias grep='grep --color=auto'
export LESS_TERMCAP_mb=$(printf '\e[01;34m')
export LESS_TERMCAP_md=$(printf '\e[01;35m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_so=$(printf '\e[01;34m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;33m')

# My aliases
#alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
#alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
#alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
#alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock'
#alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock'

# My environment variables
export PATH=$PATH:/usr/sbin
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# My executable things
#bash ~/dotfiles/scripts/display-settings.sh home
