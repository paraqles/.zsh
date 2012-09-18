require() {
  if [ $# -le 2 ]; then
    return -1
  fi

  if [ ${1:0:3} = "lib" ]; then
    source $ZSH_LIBS/$1
  else
    source $ZSH/$1
  fi
  return 1
}
