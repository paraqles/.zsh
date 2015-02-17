for zsh_ext in $ZSH_EXTENSIONS; do
  old_pwd=`pwd`

  if [[ $zsh_ext = lib_* ]]; then
    cd $ZSH_LIBS_DIR
    source $zsh_ext.zsh
    cd $old_pwd

  elif [[ $zsh_ext = ext_* ]]; then
    cd $ZSH_EXTENSIONS_DIR/${zsh_ext[5,-1]}
    source ${zsh_ext[5,-1]}.zsh
    cd $old_pwd

  fi
  unset old_pwd
done

zsh_update_extensions() {
  old_pwd=`pwd`
  cd $ZDIR
  git submodule foreach "git checkout master; git pull"
  cd $old_pwd
}

