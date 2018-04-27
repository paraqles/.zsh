function find_pid {
  pattern=$1

  echo $(ps -u `whoami` -o pid,command | sed -ne "s/\([0-9]\+\) \+$pattern.*/\1/p")
}

