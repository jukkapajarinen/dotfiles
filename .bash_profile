#!/bin/bash

# Check if we run MacOS
[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# Custom colors
RESET_COLOR="\033[0;0m";
FG_GRAY="\033[0;37m";
FG_RED="\033[0;91m";
FG_GREEN="\033[0;92m";
FG_YELLOW="\033[0;93m";
FG_BLUE="\033[0;94m";
FG_MAGENTA="\033[0;95m";

# Custom functions
git_branch() { git status &> /dev/null && (git branch 2> /dev/null | grep \* | awk '{print " ("$2")"}'); }
git_status() { git status &> /dev/null && ([[ "$(git status -s)" == "" ]] && echo -e "\[${FG_GREEN}\] [✓]" || echo -e "\[${FG_RED}\] [x]"); }
git_user() { git status &> /dev/null && git config --get user.email| awk '{print " ("$1")"}'; }
date_now() { date '+%a %d.%m.%Y %H:%M:%S'; }
tty_name() { tty | sed -e "s:/dev/::"; }

# Message of the day
clear; echo -e "${FG_RED}$(date_now)${FG_GRAY} | ${FG_YELLOW}$(tty_name)${FG_GRAY} | ${FG_BLUE}Be awesome today! 🚀${RESET_COLOR}";

# Common environment variables
export PROMPT_COMMAND='PS1="\[${FG_RED}\]\u\[${FG_GRAY}\] @ \[${FG_YELLOW}\]\h\[${FG_GRAY}\] / \[${FG_BLUE}\]\W\[${FG_GRAY}\]\[${FG_GREEN}\]$(git_branch)\[${FG_GRAY}\]$(git_status)\[${FG_MAGENTA}\]$(git_user)\[${FG_GRAY}\] $ \[${RESET_COLOR}\]"';
export PATH="$PATH:/usr/sbin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/sbin";
export LANG="en_US.UTF-8";
export LANGUAGE="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export LESS_TERMCAP_mb=$(printf "\e[01;34m");
export LESS_TERMCAP_md=$(printf "\e[01;35m");
export LESS_TERMCAP_me=$(printf "\e[0m");
export LESS_TERMCAP_se=$(printf "\e[0m");
export LESS_TERMCAP_so=$(printf "\e[01;34m");
export LESS_TERMCAP_ue=$(printf "\e[0m");
export LESS_TERMCAP_us=$(printf "\e[04;33m");

# MacOS environment variables
[[ "$macos" == "true" ]] && export BASH_SILENCE_DEPRECATION_WARNING=1;
[[ "$macos" == "true" ]] && export GEM_HOME="$HOME/.gem";
[[ "$macos" == "true" ]] && export ANDROID_HOME=/usr/local/Caskroom/android-sdk/4333796;
[[ "$macos" == "true" ]] && export ANDROID_SDK_ROOT=$ANDROID_HOME;
[[ "$macos" == "true" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";
[[ "$macos" == "true" ]] && export PATH="$PATH:$ANDROID_HOME/platform-tools/";
[[ "$macos" == "true" ]] && export PATH="$PATH:$ANDROID_HOME/emulator/";

# Linux environment variables
#[[ "$linux" == "true" ]] && export QT_STYLE_OVERRIDE="Adwaita-Dark";
#[[ "$linux" == "true" ]] && export GTK_THEME="Adwaita:dark";
[[ "$linux" == "true" ]] && export QT_QPA_PLATFORMTHEME=gtk2

# Source aliases
ls ~/.bash_aliases &> /dev/null && source ~/.bash_aliases;
ls ~/.bash_aliases_extra &> /dev/null && source ~/.bash_aliases_extra;

# Bash-completions (Linux and MacOS)
ls /usr/share/bash-completion/bash_completion &> /dev/null && source /usr/share/bash-completion/bash_completion;
ls /usr/local/etc/profile.d/bash_completion.sh &> /dev/null && source /usr/local/etc/profile.d/bash_completion.sh;

# Start X for Linux systems
[[ "$linux" == "true" ]] && [[ -z $DISPLAY ]] && which startx > /dev/null && startx && logout;
