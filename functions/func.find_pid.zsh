function find_pid {
  pattern=$1

  if [[ -x $(which pgrep) ]]; then
    echo $(pgrep -u `whoami` $pattern)
  else
    echo $(ps -u `whoami` -o pid,command | sed -ne "s/\([0-9]\+\) \+$pattern.*/\1/p")
  fi
}

