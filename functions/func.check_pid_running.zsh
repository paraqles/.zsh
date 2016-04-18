function check_pid_running {
  pid=$1

  kill -0 $pid 2>/dev/null

  if [[ "$?" -eq 0 ]]; then
    return 0
  else
    return 1
  fi
}

