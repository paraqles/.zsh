[[ -r /etc/profile ]] && source /etc/profile

[[ -r $HOME/.profile ]] && source $HOME/.profile

ZSH_LIBS_DIR=$ZDIR/libs
ZSH_PLUGINS_DIR=$ZDIR/plugins

ZSH_PLUGINS=(
  plg_ssh
  plg_vim
  plg_zsh-syntax-highlighting
  plg_zsh-history-substring-search
)

OPT_SET=(
  nohashdirs
  always_to_end
  appendhistory
  auto_cd
  auto_menu
  auto_param_slash
  auto_remove_slash
  clobber
  complete_in_word
  complete_aliases
  extended_glob
  glob
  glob_complete
  glob_dots
  hist_verify
  hist_ignore_dups
  hist_save_no_dups
  hist_verify
  list_packed
  list_types
  mark_dirs
  multibyte
  nomatch
  notify
)

OPT_USET=(
)

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

# Check for a configuration for the current hostname.
if [[ ! -r "$ZDIR/hosts/$HOST.zsh" ]]; then
  # If not copy the template for to a new config for the current hostname.
  cp $ZDIR/template_host.zsh $ZDIR/hosts/$HOST.zsh
fi

# Apply host configuration
source $ZDIR/hosts/$HOST.zsh

if [[ `uname` == Linux ]]; then
  ZSH_PLUGINS+=( plg_linux )
elif [[ `uname` == *BSD ]]; then
  ZSH_PLUGINS+=( plg_bsd )
elif [[ `uname` == Darwin ]]; then
  ZSH_PLUGINS+=( plg_mac )
fi

for zsh_mod in $ZSH_MODULES; do
  if [[ "$zsh_mod" =~ '^zsh/' ]]; then
    zmodload $zsh_mod
  else
    autoload -U $zsh_mod
  fi
done

for zshrc_mod in $ZSHRC_MODULES; do
  source $ZSH_LIBS_DIR/$zshrc_mod.zsh
done

