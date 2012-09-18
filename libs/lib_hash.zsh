hash_include() {
  if [ $# -le 3 ]; then
    return -1
  fi

  cont $1
  elem $2

  if [ ! -z $cont[$elem] ]; then
    return 1
  fi
  return 0
}
hash_index() {
  if [ $# -le 3 ]; then
    return -1
  fi

  cont=$1
  elem=$2

  index =-1
  for el in $cont; do
    index=$index+1
    if [ $el = $elem ]; then
      return $index
    fi
  done
  return $index
}

hash_delete() {
  if [ $# -le 3 ]; then
    return -1
  fi

  cont=$1
  elem=$2

  if [ ! -z $cont[$elem] ]; then
    unset $cont[$elem]
    return 1
  fi
  return 0
}
