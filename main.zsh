ZSH_LIBS_DIR=$ZDOTDIR/libs
ZSH_PLUGINS_DIR=$ZDOTDIR/plugins

# Load Host specific config
if [[ -r "$ZDOTDIR/hosts/$HOST.zsh" ]]; then
  source $ZDOTDIR/hosts/$HOST.zsh
else
  ZSH_PLUGINS=(
    plg_ssh
    plg_vim
  )

  if [[ `uname` == Linux ]]; then
    ZSH_PLUGINS[(${#ZSH_PLUGINS})+1]=plg_linux
  elif [[ `uname` == *BSD ]]; then
    ZSH_PLUGINS[(${#ZSH_PLUGINS})+1]=plg_bsd
  fi

  OPT_SET=(
    always_to_end
    appendhistory
    auto_cd
    auto_menu
    auto_remove_slash
    clobber
    complete_in_word
    complete_aliases
    extended_glob
    glob
    glob_complete
    glob_dots
    hist_verify
    list_packed
    list_types
    mark_dirs
    nomatch
    notify
  )

  OPT_USET=(
    beep
    flow_control
  )

  ZSH_THEME='paraqles'
fi

ZSH_MODULES=(
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

for zsh_mod in $ZSH_MODULES; do
  source $ZSH_LIBS_DIR/$zsh_mod.zsh
done

if [ -r /etc/profile ]; then
  source /etc/profile
fi

if [ -r $HOME/.zprofile ]; then
  source $HOME/.zprofile
fi

if [ -r $ZDOTDIR/zprofile ]; then
  source $ZDOTDIR/zprofile
fi

if [ -r $HOME/.profile ]; then
  source $HOME/.profile
fi
