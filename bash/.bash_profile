# My Custom Colors
export PS1='\[\e[35;40m\]\u\[\e[37;40m\]@\[\e[33;40m\]\h\[\e[37;40m\]:\[\e[34;40m\]\w\[\e[37;40m\]\$\[\e[00m\] '
alias ls='ls -G' #*BSD/MacOS version
#alias ls='ls --color=auto' #GNU/Linux version
alias grep='grep --color=auto'
export LESS_TERMCAP_mb=$(printf '\e[01;34m')
export LESS_TERMCAP_md=$(printf '\e[01;35m')
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')    
export LESS_TERMCAP_so=$(printf '\e[01;34m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_us=$(printf '\e[04;33m')

# Aliases
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias resetLaunchPad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias disableDock='defaults write com.apple.dock tilesize -int 1; defaults write com.apple.dock autohide-time-modifier -float 9999999999; killall Dock'
alias enableDock='defaults delete com.apple.dock tilesize; defaults delete com.apple.dock autohide-time-modifier; killall Dock'

# Environment variables
export PATH="/usr/local/sbin:$PATH"
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="$PATH":"~/.pub-cache/bin"
export PATH=$HOME/Devtools/flutter/bin:$PATH
export HEROKU_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/bash_setup

# Execute stuff
source $HEROKU_AC_BASH_SETUP_PATH
#echo "Current time: $(date '+%D %T')"

# Google Cloud SDK
if [ -f '/Users/jukka/Devtools/google-cloud-sdk/path.bash.inc' ]; then source '/Users/jukka/Devtools/google-cloud-sdk/path.bash.inc'; fi
if [ -f '/Users/jukka/Devtools/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/jukka/Devtools/google-cloud-sdk/completion.bash.inc'; fi
