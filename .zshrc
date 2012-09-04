source $HOME/.profile

ZSH=$HOME/.zsh

ZSH_MODULES=(
plg_git
plg_mercurial
plg_rvm
plg_vim
)

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
