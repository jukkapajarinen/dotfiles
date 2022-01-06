#!/bin/bash

# ##############################################################################
# Bash configuration
# ##############################################################################

source ~/.bash_env &> /dev/null;
source ~/.bash_env_extra &> /dev/null;
source ~/.bash_aliases &> /dev/null;
source ~/.bash_aliases_extra &> /dev/null;

source /usr/share/bash-completion/bash_completion &> /dev/null;
source /usr/local/etc/profile.d/bash_completion.sh &> /dev/null;
source "$NVM_DIR/nvm.sh" &> /dev/null;
source "$NVM_DIR/bash_completion" &> /dev/null;
source "/usr/share/nvm/init-nvm.sh" &> /dev/null;
source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash" &> /dev/null;

complete -C /usr/local/bin/terraform terraform;
eval "$(starship init bash)";

which neofetch &> /dev/null && which lolcat &> /dev/null && neofetch | lolcat;
