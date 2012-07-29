source $HOME/.profile

ZSH=$HOME/.zsh

ZSH_MODULES=(lib_ls lib_alias lib_completion lib_options)

OPT_SET=(
always_to_end
appendhistory
autocd
auto_menu
auto_remove_slash
complete_in_word
complete_aliases
extended_glob
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

. $ZSH/main.zsh

autoload -Uz compinit
compinit
zmodload -i zsh/complist

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

#machter_lu="m:{[:lower:]}={[:upper:]}"
#matcher_ul="m:{[:upper:}}={[:lower:]}"
#matcher_luul="m:{[:lower:][:upper:]}={[:upper:][:lower:]}"
#matcher_ullu="m:{[:upper:][:lower:]}={[:lower:][:upper:]}"
#matcher_wwrap="r:|[._-\ ]=** r:|=** l:|=*"

#matcher_list_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_olist_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_expand_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_complete_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_ignored_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_match_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_correct_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"
#matcher_approximate_param="$matcher_lu $matcher_ul $matcher_luul $matcher_ullu $matcher_wwrap"

#zstyle ':completion:*' matcher-list "$matcher_list_param $matcher_olist_param $matcher_expand_param $matcher_complete_param $matcher_ignored_param $matcher_match_param $matcher_correct_param $matcher_approximate_param"

zstyle ':completion:*:descriptions' format 'Candidates for %B%d%B:'
zstyle ':completion:*' list-seperator '#'

zstyle :compinstall filename '/home/paraqles/.zshrc'

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -v
bindkey '[1~'		beginning-of-line
bindkey '[4~'		end-of-line
bindkey '[3~'		delete-char
bindkey '[1;5C'	forward-word
bindkey '[1;5D'	backward-word

function precmd {
  local TERMWIDTH
  (( TERMWIDTH = ${COLUMNS} - 1))

  # Truncate the path if it's too long.
  PR_FILLBAR=""
  PR_PWDLEN=""

  local promptsize=${#${(%):---(%n@%m:%l)---()--}}
  (( promptsize = ${promptsize} ))
  local pwdsize=${#${(%):-%~}}

  if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
    (( PR_PWDLEN = $TERMWIDTH - $promptsize ))
  else
    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
  fi
}

setopt extended_glob
preexec () {
  if [[ "$TERM" == "screen" ]]; then
    local CMD=${1[(wr)^(*=*|sudo|-*)]}
    echo -ne "\ek$CMD\e\\"
  fi
}

setprompt () {
  # Need this so the prompt will work.
  setopt prompt_subst

  autoload colors zsh/terminfo
  if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
  fi
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
  done
  PR_NO_COLOUR="%{$terminfo[sgr0]%}"

  # See if we can use extended characters to look nicer.
  typeset -A altchar
  set -A altchar ${(s..)terminfo[acsc]}
  PR_SET_CHARSET="%{$terminfo[enacs]%}"
  PR_SHIFT_IN="%{$terminfo[smacs]%}"
  PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
  PR_HBAR=${altchar[q]:--}
  PR_ULCORNER=${altchar[l]:--}
  PR_LLCORNER=${altchar[m]:--}
  PR_LRCORNER=${altchar[j]:--}
  PR_URCORNER=${altchar[k]:--}

  # Decide if we need to set titlebar text.
  case $TERM in
    xterm*)
      PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
    ;;
    screen)
      PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
    ;;
    *)
      PR_TITLEBAR=''
    ;;
  esac
  # Decide whether to set a screen title
  if [[ "$TERM" == "screen" ]]; then
    PR_STITLE=$'%{\ek%m:zsh\e\\%}'
  else
    PR_STITLE=''
  fi

  # Finally, the prompt.
  PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT
$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_BLUE:)\
${(e)PR_APM}$PR_YELLOW%D{%H:%M}\
$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR '

  RPROMPT=' $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%a,%b%d}$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

  PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

precmd
setprompt
