ZSH_PLUGIN_RVM=$ZSH_PLUGINS/rvm

PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

if [[ -x $HOME/.rvm/scripts/rvm ]]; then
  . $HOME/.rvm/scripts/rvm
fi

. $ZSH_PLUGIN_RVM/aliases.zsh
