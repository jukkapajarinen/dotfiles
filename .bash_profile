#!/bin/bash

# ##############################################################################
# Bash profile configurations
# ##############################################################################

# Check platform
[[ "$(uname -s)" == "Darwin" ]] && macos="true" || linux="true";

# Custom colors
COL_RESET="\033[0;0m";
COL_GRAY="\033[0;37m";
COL_RED="\033[0;91m";
COL_GREEN="\033[0;92m";
COL_YELLOW="\033[0;93m";
COL_BLUE="\033[0;94m";
COL_MAGENTA="\033[0;95m";

# Bash prompt functions
git_branch() { git status &> /dev/null && (git branch 2> /dev/null | grep \* | awk '{print " ("$2")"}'); }
git_status() { git status &> /dev/null && ([[ "$(git status -s)" == "" ]] && echo -e "\[${COL_GREEN}\] [✓]" || echo -e "\[${COL_RED}\] [x]"); }
git_user() { git status &> /dev/null && git config --get user.email| awk '{print " ("$1")"}'; }

# Common environment variables
export PROMPT_COMMAND='PS1="\[${COL_RED}\]\u\[${COL_GRAY}\] @ \[${COL_YELLOW}\]\h\[${COL_GRAY}\] / \[${COL_BLUE}\]\W\[${COL_GRAY}\]\[${COL_GREEN}\]$(git_branch)\[${COL_GRAY}\]$(git_status)\[${COL_MAGENTA}\]$(git_user)\[${COL_GRAY}\] $ \[${COL_RESET}\]"';
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

# OS specific environment variables
[[ "$macos" == "true" ]] && export BASH_SILENCE_DEPRECATION_WARNING=1;
[[ "$macos" == "true" ]] && export GEM_HOME="$HOME/.gem";
[[ "$macos" == "true" ]] && export ANDROID_HOME=/usr/local/Caskroom/android-sdk/4333796;
[[ "$macos" == "true" ]] && export ANDROID_SDK_ROOT=$ANDROID_HOME;
[[ "$macos" == "true" ]] && export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin";
[[ "$macos" == "true" ]] && export PATH="$PATH:$ANDROID_HOME/platform-tools/";
[[ "$macos" == "true" ]] && export PATH="$PATH:$ANDROID_HOME/emulator/";
[[ "$linux" == "true" ]] && export QT_QPA_PLATFORMTHEME=gtk2

# Customized experience
ls ~/.bash_aliases &> /dev/null && source ~/.bash_aliases;
ls ~/.bash_aliases_extra &> /dev/null && source ~/.bash_aliases_extra;
ls /usr/share/bash-completion/bash_completion &> /dev/null && source /usr/share/bash-completion/bash_completion;
ls /usr/local/etc/profile.d/bash_completion.sh &> /dev/null && source /usr/local/etc/profile.d/bash_completion.sh;

# Start X for Linux systems
[[ "$linux" == "true" ]] && [[ -z $DISPLAY ]] && which startx > /dev/null && startx &> /dev/null && logout;
