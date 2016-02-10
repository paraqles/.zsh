function check_pid_running {
  pid=$1

  if `kill -0 $pid 2>/dev/null`; then
    return 0
  else
    return 1
  fi
}

