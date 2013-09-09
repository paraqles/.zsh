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

if [[ ${OPT_SET[(r)extended_glob]} = ${#OPT_SET} ]]; then
  setopt extended_glob
fi

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

  HBAR="$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT"
  ULCORNER="$PR_SHIFT_IN$PR_ULCORNER$PR_SHIFT_OUT"
  LLCORNER="$PR_SHIFT_IN$PR_LLCORNER$PR_SHIFT_OUT"
  LRCORNER="$PR_SHIFT_IN$PR_LRCORNER$PR_SHIFT_OUT"
  URCORNER="$PR_SHIFT_IN$PR_URCORNER$PR_SHIFT_OUT"
  FILLBAR='$PR_SHIFT_IN${(e)PR_FILLBAR}$PR_SHIFT_OUT'

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

  prompt_parts=()
  prompt_parts[1]=
  prompt_parts[2]='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}'
  prompt_parts[3]='$PR_CYAN$ULCORNER'

  prompt_parts[4]='$PR_BLUE$HBAR('
    prompt_parts[5]='$PR_MAGENTA%$PR_PWDLEN<...<%~%<<'
  prompt_parts[6]='$PR_BLUE)$HBAR'

  prompt_parts[7]="$PR_CYAN$HBAR$FILLBAR"

  prompt_parts[8]='$PR_BLUE$HBAR('
    prompt_parts[9]='$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@'
    if [ "$SSH_CONNECTION" ]; then
      prompt_parts[10]='$PR_RED%m$PR_GREEN:%l'
    else
      prompt_parts[10]='$PR_YELLOW%m$PR_GREEN:%l'
    fi
  prompt_parts[11]='$PR_BLUE)$HBAR'

  prompt_parts[12]='$PR_CYAN$URCORNER
$PR_CYAN$LLCORNER'

  prompt_parts[13]='$PR_BLUE$HBAR('
    prompt_parts[14]='%(?..$PR_LIGHT_RED%?$PR_BLUE:)'
    prompt_parts[15]='${(e)PR_APM}$PR_YELLOW%D{%H:%M}'
    prompt_parts[16]='$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#'
  prompt_parts[17]='$PR_BLUE)$HBAR'

  prompt_parts[18]='$PR_CYAN$HBAR$PR_NO_COLOUR '

  rprompt_parts=()
  rprompt_parts[1]=' $PR_CYAN$HBAR'
  rprompt_parts[2]='$PR_BLUE$HBAR('
    rprompt_parts[3]='$PR_YELLOW%D{%a,%b%d}'
  rprompt_parts[4]='$PR_BLUE)$HBAR'
  rprompt_parts[5]='$PR_CYAN$LRCORNER$PR_NO_COLOUR'

  ps2_parts=()
  ps2_parts[1]='$PR_CYAN$HBAR'
    ps2_parts[2]='$PR_BLUE$HBAR('
    ps2_parts[3]='$PR_LIGHT_GREEN%_'
  ps2_parts[4]='$PR_BLUE)$HBAR'
  ps2_parts[5]='$PR_CYAN$HBAR$PR_NO_COLOUR '

  # Finally, the prompt.
  oIFS=$IFS
  IFS=''

  PROMPT=$prompt_parts
  RPROMPT=$rprompt_parts
  PS2=$ps2_parts

  IFS=$oIFS
}

precmd
setprompt
