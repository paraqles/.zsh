ZSH_LIBS_DIR=$ZDIR/libs
ZSH_PLUGINS_DIR=$ZDIR/plugins


ZSHRC_MODULES=(
  lib_utils
  lib_hash
  lib_hook
  lib_options
  lib_prompt
  lib_history
  lib_keybinding
  lib_theme
  lib_completion
  lib_functions
  lib_aliases
  lib_plugins
)

ZSH_MODULES=(
  zsh/pcre
  zsh/regex
  zmv
)

# Load Host specific config
if [[ -z "$HOST" ]]; then
  export HOST=$(hostname)
fi

if [[ ! -r "$ZDIR/hosts/$HOST.zsh" ]]; then
  cp $ZDIR/template_host.zsh $ZDIR/hosts/$HOST.zsh
fi

source $ZDIR/hosts/$HOST.zsh

if [[ `uname` == Linux ]]; then
  ZSH_PLUGINS+=( plg_linux )
elif [[ `uname` == *BSD ]]; then
  ZSH_PLUGINS+=( plg_bsd )
elif [[ `uname` == Darwin ]]; then
  ZSH_PLUGINS+=( plg_mac )
fi

for zsh_mod in $ZSH_MODULES; do
  if [[ $zsh_mod =~ '^zsh/' ]]; then
    zmodload $zsh_mod
  else
    autoload -U $zsh_mod
  fi
done

for zshrc_mod in $ZSHRC_MODULES; do
  source $ZSH_LIBS_DIR/$zshrc_mod.zsh
done

if [ -r $HOME/.zprofile ]; then
  source $HOME/.zprofile
fi

if [ -r $ZDIR/zprofile ]; then
  source $ZDIR/zprofile
fi

if [ -r $HOME/.profile ]; then
  source $HOME/.profile
fi

