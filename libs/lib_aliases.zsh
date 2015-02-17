alias zshrc='source $ZDIR/main.zsh'

source $ZSH_OS_DIR/aliases.zsh

for al in `ls $ZDIR/aliases/aliases.*.zsh`; do
  source $al
done

for zsh_ext in $ZSH_EXTENSIONS; do
  if [[ $zsh_ext = ext_* ]]; then
    old_pwd=`pwd`
    cd $ZSH_EXTENSIONS_DIR/${zsh_ext[5,-1]}
    source aliases.zsh
    cd $old_pwd

  fi
  unset old_pwd

done

