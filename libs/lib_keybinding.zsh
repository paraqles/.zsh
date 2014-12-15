bindkey -v

typeset -A key

key[home]=${terminfo[khome]}
key[end]=${terminfo[kend]}

key[insert]=${terminfo[kich1]}
key[delete]=${terminfo[kdch1]}
key[backspace]=${terminfo[kbs]}

key[up]=${terminfo[kcuu1]}
key[down]=${terminfo[kcud1]}
key[left]=${terminfo[kcub1]}
key[right]=${terminfo[kcuf1]}

key[page-up]=${terminfo[kpp]}
key[page-down]=${terminfo[knp]}

if [[ $TERM =~ ".*xterm.*" ]]; then
  key[ctrl-left]='^[[1;5D'
  key[ctrl-right]='^[[1;5C'
  key[ctrl-backspace]=''
  key[ctrl-delete]=''
fi
