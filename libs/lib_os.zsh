ZSH_OSES=$ZDIR/os
RE_CASE_MATCH=$options[case_match]
unsetopt CASE_MATCH

if [[ $OSTYPE =~ ".*darwin.*" ]]; then
  export ZSH_OS="mac"
  export ZSH_OS_DIR=$ZSH_OSES/mac

elif [[ $OSTYPE =~ ".*linux.*" ]]; then
  export ZSH_OS="linux"
  export ZSH_OS_DIR=$ZSH_OSES/linux

elif [[ $OSTYPE =~ ".*BSD.*" ]]; then
  export ZSH_OS_PLUGIN=bsd
  export ZSH_OS_DIR=$ZSH_OSES/bsd

fi

if [[ RE_CASE_MATCH == on ]]; then
  setopt CASE_MATCH
fi
