typeset -A zsh_hooks

hook_add() {
  if [ $# -le 2 ]; then
    return -1
  fi

  if [ -z $zsh_hooks[$1] ]; then
    typeset -A $zsh_hooks[$1]
  fi
  return 1
}

hook_register() {
  if [[ $# -lt 2 ]]; then
    return -1
  fi

  hook=$1
  callback=$2

  if [[ ! -z zsh_hooks[$hook] ]]; then
    typeset -A zsh_hooks[$hook]
  else
    zsh_hooks[$hook][${#zsh_hooks[$hook]}+1] = callback
  fi
}

function hook_unregister() {
  hook=$1
  callback=$2
  if [[ -z hook[$hook] ]]; then
    hook_opt_set[${#hook_opt_set}+1]=$callback
  elif [[ $hook == 'opt_unset' ]]; then
    hook_opt_unset[${#hook_opt_unset}+1]=$callback
  elif [[ $hook == 'prompt' ]]; then
    hook_prompt[${#prompt}+1]=$callback
  fi
}

function hook_run() {
  hook=$1
  argv=$2
  callbacks=()
  if [[ hook == 'opt_set' ]]; then
    callbacks=$hook_opt_set
  elif [[ hook == 'opt_unset' ]]; then
    callbacks=$hook_opt_unset
  elif [[ hook == 'opt_set' ]]; then
    callbacks=$hook_prompt
  fi
  for callback in $callbacks; do
    $callback $argv
  done
}

