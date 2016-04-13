export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

if [[ -d /etc/profile.d/ ]]; then
  for p in /etc/profile.d/*.sh; do
    [[ -r "$p" ]] && source "$p"
  done
  unset p
fi

[[ -r $HOME/.profile ]] && source $HOME/.profile

ZSH_LIBS_DIR=$ZDIR/libs
ZSH_OSES_DIR=$ZDIR/os
ZSH_EXTENSIONS_DIR=$ZDIR/extensions

ZSH_EXTENSIONS=(
  ext_ssh
  ext_vim
)

#nohashdirs
OPT_SET=(
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
  list_packed
  list_types
  mark_dirs
  multibyte
  nomatch
  notify
)

OPT_USET=(
  flowcontrol
  menu_complete
)

ZSHRC_MODULES=(
  lib_hook
  lib_completion
  lib_utils
  lib_options
  lib_history
  lib_functions
  lib_os
  lib_keybinding
  lib_prompt
  lib_theme
  lib_aliases
  lib_extensions
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

# Check if $HOST or hostname has domain part.
if [[ "$HOST" =~ "\." ]]; then
  export HOST=${HOST%%.*}
fi

# Check for a configuration for the current hostname.
if [[ ! -r "$ZDIR/hosts/$HOST.zsh" ]]; then
  ZSH_FIRST_START=true
  # If not copy the template for to a new config for the current hostname.
  cp $ZDIR/template_host.zsh $ZDIR/hosts/$HOST.zsh
else
  unset ZSH_FIRST_START
fi

# Apply host configuration
source $ZDIR/hosts/$HOST.zsh

ZSH_EXTENSIONS+=(
  ext_zsh-syntax-highlighting
  ext_zsh-history-substring-search
)

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

