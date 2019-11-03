# Check if we run MacOS
[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# Custom colors
RESET_COLOR="\033[0;0m";
BG_YELLOW="\033[0;30;103m";
FG_GRAY="\033[0;37m";
FG_RED="\033[0;91m";
FG_GREEN="\033[0;92m";
FG_YELLOW="\033[0;93m";
FG_BLUE="\033[0;94m";
FG_MAGENTA="\033[0;95m";
FG_CYAN="\033[0;96m";
FG_WHITE="\033[0;97m";
export LESS_TERMCAP_mb=$(printf '\e[01;34m');
export LESS_TERMCAP_md=$(printf '\e[01;35m');
export LESS_TERMCAP_me=$(printf '\e[0m');
export LESS_TERMCAP_se=$(printf '\e[0m');
export LESS_TERMCAP_so=$(printf '\e[01;34m');
export LESS_TERMCAP_ue=$(printf '\e[0m');
export LESS_TERMCAP_us=$(printf '\e[04;33m');

# Custom functions
git_branch() { git status &> /dev/null && (git branch 2> /dev/null | grep \* | awk '{print " ("$2")"}'); }
git_status() { git status &> /dev/null && ([[ "$(git status -s)" == "" ]] && echo -e "\[${FG_GREEN}\] [✓]" || echo -e "\[${FG_RED}\] [x]"); }
git_user() { git status &> /dev/null && git config --get user.email| awk '{print " ("$1")"}'; }
date_now() { date '+%a %d.%m.%Y %H:%M:%S'; }
tty_name() { tty | sed -e "s:/dev/::"; }

# Bash prompt
[[ "$SSH_CONNECTION" == "" ]] && export PROMPT_COMMAND='PS1="\[${FG_RED}\]\u\[${FG_GRAY}\] @ \[${FG_YELLOW}\]\h\[${FG_GRAY}\] / \[${FG_BLUE}\]\W\[${FG_GRAY}\]\[${FG_GREEN}\]$(git_branch)\[${FG_GRAY}\]$(git_status)\[${FG_MAGENTA}\]$(git_user)\[${FG_GRAY}\] $ \[${RESET_COLOR}\]"';
[[ "$SSH_CONNECTION" == "" ]] || export PROMPT_COMMAND='PS1="\[${FG_RED}\]\u\[${FG_GRAY}\] @ \[${BG_YELLOW}\]\h\[${FG_GRAY}\] / \[${FG_BLUE}\]\W\[${FG_GRAY}\]\[${FG_GREEN}\]$(git_branch)\[${FG_GRAY}\]$(git_status)\[${FG_MAGENTA}\]$(git_user)\[${FG_GRAY}\] $ \[${RESET_COLOR}\]"';
clear; echo -e "${FG_RED}$(date_now)${FG_GRAY} | ${FG_YELLOW}$(tty_name)${FG_GRAY} | ${FG_BLUE}Be awesome today! 🚀${RESET_COLOR}";

# Common environment variables
export PATH="$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/sbin";
export LANG="en_US.UTF-8";
export LANGUAGE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# MacOS environment variables
[[ "$macos" == "true" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";
[[ "$macos" == "true" ]] && export BASH_SILENCE_DEPRECATION_WARNING=1;
[[ "$macos" == "true" ]] && export ANDROID_HOME=/usr/local/Caskroom/android-sdk/4333796;
[[ "$macos" == "true" ]] && export PATH="$PATH:$ANDROID_HOME/platform-tools/";

# Linux environment variables
[[ "$linux" == "true" ]] && export QT_STYLE_OVERRIDE="Adwaita-Dark";
[[ "$linux" == "true" ]] && export GTK_THEME="Adwaita:dark";

# Common aliases
alias grep='grep --color=auto';
alias diff='diff --color=auto';
alias dmesg='dmesg --color=auto';
alias dockerpoop='docker stop $(docker ps -a -q); docker rm $(docker ps -a -q); docker rmi -f $(docker images -q); docker network rm $(docker network ls -q); docker volume rm $(docker volume ls -q);';
alias vscodeExtExport='code --list-extensions > ~/dotfiles/vscode_extensions';
alias vscodeExtImport='cat ~/dotfiles/vscode_extensions | xargs -L 1 code --install-extension';
alias gl='git log --name-only --graph --oneline';
alias gs='git status -s -b';

# MacOS aliases
[[ "$macos" == "true" ]] && alias ls='ls -G'
[[ "$macos" == "true" ]] && alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app';
[[ "$macos" == "true" ]] && alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock';
[[ "$macos" == "true" ]] && alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock';
[[ "$macos" == "true" ]] && alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock';
[[ "$macos" == "true" ]] && alias disableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores true';
[[ "$macos" == "true" ]] && alias enableDSStore='defaults write com.apple.desktopservices DSDontWriteNetworkStores false';
[[ "$macos" == "true" ]] && alias emu="$ANDROID_HOME/tools/emulator";

# Linux aliases
[[ "$linux" == "true" ]] && alias ls='ls --color=auto'
[[ "$linux" == "true" ]] && alias open='xdg-open';
[[ "$linux" == "true" ]] && alias resetPointers='bash ~/dotfiles/scripts/pointer-settings.sh';
[[ "$linux" == "true" ]] && alias resetKeyboards='bash ~/dotfiles/scripts/keyboard-settings.sh';
[[ "$linux" == "true" ]] && alias resetDisplays='bash -c "~/dotfiles/scripts/display-settings.sh home"';

# Optional extra aliases
ls ~/.bash_aliases_extra &> /dev/null && source ~/.bash_aliases_extra;

# Start X for Linux systems
[[ "$linux" == "true" ]] && [[ -z $DISPLAY ]] && which startx > /dev/null && startx && logout;
