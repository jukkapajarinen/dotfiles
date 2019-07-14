# Check if we run MacOS
[ "$(uname -s)" == "Darwin" ] && macos=true || macos=false;

# My custom functions
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }
date_now() { date '+%a %d.%m.%Y %H:%M:%S'; }
tty_name() { tty | sed -e "s:/dev/::"; }

# My custom PS1
export PROMPT_COMMAND='PS1="\[\033[0;91m\]\u\[\033[0;37m\] @ \[\033[0;93m\]\h\[\033[0;37m\] / \[\033[0;94m\]\w\[\033[0;37m\]\[\033[0;92m\]$(parse_git_branch)\[\033[0;37m\] \$ \[\033[0;0m\]"';

# My message of the day
neofetch; echo -e "\033[0;91m$(date_now)\033[0;0m | \033[0;93m$(tty_name)\033[0;0m | \033[0;94mBe awesome today!\033[0;0m 🚀";

# My custom colors
[ $macos == true ] && alias ls='ls -G' # *BSD/MacOS version
[ $macos == false ] && alias ls='ls --color=auto' # GNU/Linux version;
alias grep='grep --color=auto';
alias diff='diff --color=auto';
alias dmesg='dmesg --color=auto';
export LESS_TERMCAP_mb=$(printf '\e[01;34m');
export LESS_TERMCAP_md=$(printf '\e[01;35m');
export LESS_TERMCAP_me=$(printf '\e[0m');
export LESS_TERMCAP_se=$(printf '\e[0m');
export LESS_TERMCAP_so=$(printf '\e[01;34m');
export LESS_TERMCAP_ue=$(printf '\e[0m');
export LESS_TERMCAP_us=$(printf '\e[04;33m');

# My common aliases
alias dockerpoop='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images -q); docker network rm $(docker network ls -q; docker volume rm $(docker volume ls -q);';
alias exportVSCodeExtensions='code --list-extensions > ~/dotfiles/vscode/extensions.list';
alias importVSCodeExtensions='cat ~/dotfiles/vscode/extensions.list | xargs -L 1 code --install-extension';

# My MacOS aliases
[ $macos == true ] && alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app';
[ $macos == true ] && alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app';
[ $macos == true ] && alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock';
[ $macos == true ] && alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock';
[ $macos == true ] && alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock';

# My Linux aliases
[ $macos == false ] && alias open='xdg-open';
[ $macos == false ] && alias resetPointers='bash ~/dotfiles/scripts/pointer-settings.sh';
[ $macos == false ] && alias resetKeyboards='bash ~/dotfiles/scripts/keyboard-settings.sh';
[ $macos == false ] && alias resetDisplays='bash -c "~/dotfiles/scripts/display-settings.sh home"';

# My common environment variables
export PATH="$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin";
export LANG="en_US.UTF-8";
export LANGUAGE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# My MacOS environment variables
[ $macos == true ] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";

# My Linux environment variables
[ $macos == false ] && export QT_STYLE_OVERRIDE="Adwaita";

# Start X for Linux systems
[ $macos == false ] && [[ -z $DISPLAY ]] && startx && logout;
