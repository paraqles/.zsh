bindkey -v

typeset -A key

source $ZSH_OS_DIR/keymapping.zsh

bindkey "${key[up]}"              up-line-or-search
bindkey "${key[down]}"            down-line-or-search

bindkey "${key[up]}"              up-line-or-history
bindkey "${key[down]}"            down-line-or-history


bindkey "${key[home]}"            beginning-of-line
bindkey "${key[end]}"             end-of-line

bindkey "${key[delete]}"          delete-char
bindkey "${key[backspace]}"       backward-delete-char

bindkey "${key[ctrl_right]}"      forward-word
bindkey "${key[ctrl_left]}"       backward-word

bindkey "${key[ctrl_delete]}"     backward-kill-word
bindkey "${key[ctrl_backspace]}"  delete-word
