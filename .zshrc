source $HOME/.profile

ZSH=$HOME/.zsh

ZSH_PLUGINS=(
plg_git
plg_mercurial
plg_rails
plg_ruby
plg_rvm
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

. $ZSH/main.zsh

EDITOR=gvim
export $EDITOR
