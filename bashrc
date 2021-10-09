#!/bin/bash

# ##############################################################################
# Bash shell configurations
# ##############################################################################

# Source environment variables
ls ~/.bash_env &> /dev/null && source ~/.bash_env;
ls ~/.bash_env_extra &> /dev/null && source ~/.bash_env_extra;

# Source shell aliases
ls ~/.bash_aliases &> /dev/null && source ~/.bash_aliases;
ls ~/.bash_aliases_extra &> /dev/null && source ~/.bash_aliases_extra;

# Source bash auto-completions
ls /usr/share/bash-completion/bash_completion &> /dev/null && source /usr/share/bash-completion/bash_completion;
ls /usr/local/etc/profile.d/bash_completion.sh &> /dev/null && source /usr/local/etc/profile.d/bash_completion.sh;
ls "$NVM_DIR/nvm.sh" &> /dev/null && source "$NVM_DIR/nvm.sh";
ls "$NVM_DIR/bash_completion" &> /dev/null && source "$NVM_DIR/bash_completion";
complete -C /usr/local/bin/terraform terraform;

# Starship prompt
eval "$(starship init bash)";
